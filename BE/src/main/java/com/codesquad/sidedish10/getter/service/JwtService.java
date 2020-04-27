package com.codesquad.sidedish10.getter.service;

import com.codesquad.sidedish10.getter.exception.JwtMissingException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Service
public class JwtService {

  private Logger logger = LoggerFactory.getLogger(JwtService.class);
  private String secretKey = "JinIsTheBest";

  public String makeJwt(String userId, String name, String email) {
    final SignatureAlgorithm SIGNATUREALGORITHM = SignatureAlgorithm.HS256;
    final String USER_ID = "userId";
    final String USER_NAME = "userName";
    final String EMAIL = "EMAIL";
    final String TYP = "typ";
    final String ALG = "HS256";

    Map<String, Object> header = new HashMap<>();
    header.put(TYP, "JWT");
    header.put(ALG, "HS256");

    Map<String, Object> payload = new HashMap<>();
    payload.put(USER_ID, userId);
    payload.put(USER_NAME, name);
    payload.put(EMAIL, email);

    return Jwts.builder()
        .setHeader(header)
        .setClaims(payload)
        .signWith(SIGNATUREALGORITHM, secretKey.getBytes())
        .compact();
  }

  public String findJwtTokenFromCookie(HttpServletRequest request) {
    Cookie[] cookies = request.getCookies();
    if (cookies == null) {
      throw new JwtMissingException();
    }
    logger.info("cookie: {}", cookies);
    for (Cookie cookie : cookies) {
      logger.info("cookie: {}", cookie);
      if (cookie.getName().equals("jwtToken")) {
        return cookie.getValue();
      }
    }

    throw new JwtMissingException();
  }

  public boolean isValidJwtToken(String decodedJwtTokenString) {
    try {
      Claims claims = Jwts.parser()
          .setSigningKey(secretKey.getBytes())
          .parseClaimsJws(decodedJwtTokenString)
          .getBody();
      return true;
    } catch (JwtMissingException e) {
      return false;
    }
  }
}
