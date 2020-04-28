package com.codesquad.sidedish10.getter.service;

import com.codesquad.sidedish10.getter.domain.GitHubToken;
import com.codesquad.sidedish10.getter.domain.User;
import com.codesquad.sidedish10.getter.repository.UserRepository;
import com.codesquad.sidedish10.getter.exception.UserNotFoundException;
import com.codesquad.sidedish10.getter.utils.OAuth2SecurityInfo;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import java.util.HashMap;
import java.util.Map;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class LoginService {

  private final UserRepository userRepository;

  private String url = OAuth2SecurityInfo.URL;
  private String client_id = OAuth2SecurityInfo.CLIENT_ID;
  private String client_secret = OAuth2SecurityInfo.CLIENT_SECRET;

  public LoginService(UserRepository userRepository) {
    this.userRepository = userRepository;
  }

  public GitHubToken getAccessToken(String code) {

    HttpHeaders headers = new HttpHeaders();
    headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_VALUE);

    MultiValueMap<String, String> requestPayloads = new LinkedMultiValueMap<>();
    Map<String, String> requestPayload = new HashMap<>();
    requestPayload.put("client_id", client_id);
    requestPayload.put("client_secret", client_secret);
    requestPayload.put("code", code);
    requestPayloads.setAll(requestPayload);

    HttpEntity<?> request = new HttpEntity<>(requestPayloads, headers);
    ResponseEntity<?> response = new RestTemplate().postForEntity(url, request, GitHubToken.class);
    return (GitHubToken) response.getBody();
  }

  public User getUserInfo(GitHubToken token) {
    HttpHeaders headers = new HttpHeaders();
    headers.set(HttpHeaders.AUTHORIZATION, token.getToken_Response());

    HttpEntity<?> request = new HttpEntity<>(headers);

    ResponseEntity<Object> responseObject = new RestTemplate()
        .exchange(OAuth2SecurityInfo.USER_INFO_REQUEST_URL, HttpMethod.GET, request,
            Object.class);

    String jsonString = new Gson().toJson(responseObject.getBody(), Map.class);
    JsonElement jsonObject = new Gson().fromJson(jsonString, JsonElement.class);

    String user_id = jsonObject.getAsJsonObject().get("login").toString().replaceAll("\"", "");
    String name = jsonObject.getAsJsonObject().get("name").toString().replaceAll("\"", "");
    String email = jsonObject.getAsJsonObject().get("email").toString().replaceAll("\"", "");

    if (userRepository.findUserExistenceByUserId(user_id) == OAuth2SecurityInfo.USER_NOT_EXISTS) {
      return saveNewUser(user_id, name, email);
    }
    if (userRepository.findUserExistenceByUserId(user_id) == OAuth2SecurityInfo.USER_EXISTS) {
      return userRepository.findUserByUserId(user_id);
    }
    throw new UserNotFoundException();
  }

  public User saveNewUser(String user_id, String name, String email) {
    User newUser = User.create(user_id, name, email);
    userRepository.save(newUser);
    return newUser;
  }
}
