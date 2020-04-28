package com.codesquad.sidedish10.getter.controller;

import com.codesquad.sidedish10.getter.domain.GitHubToken;
import com.codesquad.sidedish10.getter.domain.User;
import com.codesquad.sidedish10.getter.service.JwtService;
import com.codesquad.sidedish10.getter.service.LoginService;
import com.codesquad.sidedish10.getter.response.ApiResponse;
import com.codesquad.sidedish10.getter.utils.OAuth2SecurityInfo;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

@RestController
public class LoginController {

  private final LoginService loginService;
  private final JwtService jwtService;

  public LoginController(LoginService loginService,
      JwtService jwtService) {
    this.loginService = loginService;
    this.jwtService = jwtService;
  }

  @GetMapping("/login/github/request")
  public void GitHubLogin(@RequestParam("code") String code, HttpServletResponse res) {

    GitHubToken token = loginService.getAccessToken(code);
    User nowUser = loginService.getUserInfo(token);
    String jwtToken = jwtService.makeJwt(nowUser.getUserId(), nowUser.getName(), nowUser.getEmail());

    Cookie cookie = new Cookie("jwtToken", jwtToken);
    res.addCookie(cookie);
    res.setStatus(HttpStatus.SEE_OTHER.value());
    res.setHeader("Location", "http://13.125.179.178");
  }

  @CrossOrigin("/**")
  @GetMapping("/login/github")
  public RedirectView redirectToGitHubPage() {
    return new RedirectView(OAuth2SecurityInfo.TEMP_CODE_REQUEST_URL);
  }
}
