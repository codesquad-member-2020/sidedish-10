package com.codesquad.sidedish10.getter.interceptor;

import com.codesquad.sidedish10.getter.service.JwtService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class HttpInterceptor implements HandlerInterceptor {

  private final JwtService jwtService;

  public HttpInterceptor(JwtService jwtService) {
    this.jwtService = jwtService;
  }

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
    String jwtTokenFromCookie = jwtService.findJwtTokenFromCookie(request);
    return jwtService.isValidJwtToken(jwtTokenFromCookie);
  }
}