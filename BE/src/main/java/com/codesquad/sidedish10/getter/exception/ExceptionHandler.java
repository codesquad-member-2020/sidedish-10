package com.codesquad.sidedish10.getter.exception;

import com.codesquad.sidedish10.getter.response.ApiResponse;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class ExceptionHandler {

  @org.springframework.web.bind.annotation.ExceptionHandler(JwtMissingException.class)
  @ResponseStatus(HttpStatus.FORBIDDEN)
  @ResponseBody
  public ApiResponse jwtNotFoundError(JwtMissingException exception) {
    ApiResponse response = exception.returnErrorMessage();
    //TODO: 아래의 내용을 exception 자체에서 super 메소드를 활용하여 리팩토링하기
    response.setStatusCode(ErrorCodes.FORBIDDEN);
    response.setBody("쿠키에 JWT 넣어서 보내주세요!!");
    return response;
  }

  @org.springframework.web.bind.annotation.ExceptionHandler(UserNotFoundException.class)
  @ResponseStatus(HttpStatus.NOT_FOUND)
  @ResponseBody
  public ApiResponse userNotFoundError(UserNotFoundException exception) {
    ApiResponse response = exception.returnErrorMessage();
    response.setStatusCode(ErrorCodes.NOT_FOUND);
    response.setBody("No User Found.");
    return response;
  }

  @org.springframework.web.bind.annotation.ExceptionHandler(JsonNotFoundException.class)
  @ResponseStatus(HttpStatus.UNAUTHORIZED)
  @ResponseBody
  public ApiResponse jsonNotFoundError(JsonNotFoundException exception) {
    ApiResponse response = exception.returnErrorMessage();
    response.setStatusCode(ErrorCodes.UNAUTHORIZED);
    response.setBody("JSON Not Found. Check your client id and client secret.");
    return response;
  }
}
