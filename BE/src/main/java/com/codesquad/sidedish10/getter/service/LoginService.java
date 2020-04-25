package com.codesquad.sidedish10.getter.service;

import com.codesquad.sidedish10.getter.domain.GitHubToken;
import com.codesquad.sidedish10.getter.domain.User;
import com.codesquad.sidedish10.getter.domain.UserRepository;
import com.codesquad.sidedish10.getter.exception.JsonNotFoundException;
import com.codesquad.sidedish10.getter.exception.RudimentaryException;
import com.codesquad.sidedish10.getter.exception.UserNotFoundException;
import com.codesquad.sidedish10.getter.utils.OAuth2SecurityInfo;
import com.google.gson.JsonObject;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
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
    //TODO 이거 캐스팅되는 거 원리 공부하자.
    GitHubToken token = (GitHubToken) response.getBody();

    return token;
  }

  public User getUserInfo(GitHubToken token) {
    HttpHeaders headers = new HttpHeaders();
    headers.set(HttpHeaders.AUTHORIZATION, token.getAccess_token());

    HttpEntity<?> request = new HttpEntity<>(headers);

    ResponseEntity<JsonObject> responseObject = new RestTemplate()
        .exchange(OAuth2SecurityInfo.USER_INFO_REQUEST_URL, HttpMethod.GET, request,
            JsonObject.class);

    JsonObject jsonObject = Optional.ofNullable(responseObject.getBody())
        .orElseThrow(() -> new JsonNotFoundException());

    String userId = Objects.requireNonNull(jsonObject).getAsJsonObject("login").toString();
    String name = Objects.requireNonNull(jsonObject).getAsJsonObject("name").toString();
    String email = Objects.requireNonNull(jsonObject).getAsJsonObject("email").toString();

    if (userRepository.findUserExistenceByUserId(userId) == OAuth2SecurityInfo.USER_NOT_EXISTS) {
      return saveNewUser(userId, name, email);
    }
    if (userRepository.findUserExistenceByUserId(userId) == OAuth2SecurityInfo.USER_EXISTS) {
      return userRepository.findUserByUserId(userId);
    }
    throw new UserNotFoundException();
  }

  public User saveNewUser(String userId, String name, String email) {
    User newUser = User.create(userId, name, email);
    userRepository.save(newUser);

    return newUser;
  }
}
