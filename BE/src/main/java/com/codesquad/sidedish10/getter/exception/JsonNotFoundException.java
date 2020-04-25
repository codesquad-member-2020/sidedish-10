package com.codesquad.sidedish10.getter.exception;

public class JsonNotFoundException extends RudimentaryException {

  public JsonNotFoundException() {
    super("JSON Not Found. Check your client id and client secret.");
  }
}
