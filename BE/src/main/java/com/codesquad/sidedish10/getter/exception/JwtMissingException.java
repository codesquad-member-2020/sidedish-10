package com.codesquad.sidedish10.getter.exception;

public class JwtMissingException extends RudimentaryException {

  public JwtMissingException() {
    super("JWT 넣어서 보내주세요!!");
  }
}
