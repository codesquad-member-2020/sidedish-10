package com.codesquad.sidedish10.getter.exception;

import com.codesquad.sidedish10.getter.utils.ApiResponse;

public class RudimentaryException extends RuntimeException {
  private String errorMessage;

  public RudimentaryException(String errorMessage) {
    this.errorMessage = errorMessage;
  }

  public ApiResponse returnErrorMessage() {
    return new ApiResponse();
  }
}