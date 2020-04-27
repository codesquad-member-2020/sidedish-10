package com.codesquad.sidedish10.getter.utils;

public class ApiResponse {
  private int statusCode;
  private Object body;

  public int getStatusCode() {
    return statusCode;
  }

  public void setStatusCode(int statusCode) {
    this.statusCode = statusCode;
  }

  public Object getBody() {
    return body;
  }

  public void setBody(Object body) {
    this.body = body;
  }
}
