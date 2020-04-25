package com.codesquad.sidedish10.parser.service;

import com.codesquad.sidedish10.getter.domain.GitHubToken;
import com.codesquad.sidedish10.parser.utils.OAuth2SecurityInfo;
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

  private String url = OAuth2SecurityInfo.URL;
  private String client_id = OAuth2SecurityInfo.CLIENT_ID;
  private String client_secret = OAuth2SecurityInfo.CLIENT_SECRET;

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
}
