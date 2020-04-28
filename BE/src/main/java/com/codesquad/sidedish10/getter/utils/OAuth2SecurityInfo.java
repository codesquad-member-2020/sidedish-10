package com.codesquad.sidedish10.getter.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class OAuth2SecurityInfo {

//  @Value("${client.client_id}")
//  public String client_id_properties;
//
//  public static String CLIENT_ID;
//
//  @Value("${client.client_id}")
//  public void setClientId(String client_id_properties) {
//    CLIENT_ID = client_id_properties;
//  }

  public static String URL = "https://github.com/login/oauth/access_token";
  public static String CLIENT_ID = "6c72dbbb9ff995db580a";
  public static String CLIENT_SECRET = "9d46e295a1ca5777ec7a7f18c458b55a0b242a9d";
  public static String REDIRECT_URI = "http://13.125.179.178:8080/login/github/request";
  public static String TEMP_CODE_REQUEST_URL = "https://github.com/login/oauth/authorize?client_id=" + CLIENT_ID + "&redirect_uri=" + REDIRECT_URI;
  //public static String TEMP_CODE_REQUEST_URL = "https://github.com/login/oauth/authorize?client_id=6c72dbbb9ff995db580a&redirect_uri=http://13.125.179.178:8080/login/github/request";
  public static String USER_INFO_REQUEST_URL = "https://api.github.com/user";
  public static String LOGIN_AFTER_REDIRECT_URL = "http://13.125.179.178/";
  public static int USER_NOT_EXISTS = 0;
  public static int USER_EXISTS = 1;

}
