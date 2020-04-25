package com.codesquad.sidedish10.getter.controller;

import com.codesquad.sidedish10.getter.domain.GitHubToken;
import com.codesquad.sidedish10.parser.service.LoginService;
import com.codesquad.sidedish10.parser.utils.OAuth2SecurityInfo;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

@RestController
public class LoginController {

  private final LoginService loginService;

  public LoginController(LoginService loginService) {
    this.loginService = loginService;
  }

  @GetMapping("/login/github/request")
  public ResponseEntity<String> GitHubLogin(@RequestParam("code") String code, HttpServletResponse response) {
    GitHubToken accessToken = loginService.getAccessToken(code);
    response.setStatus(HttpStatus.OK.value());
    // response.setHeader("Authorization", accessToken.getToken_Response());

    return ResponseEntity.ok("logged in.");
  }

  @GetMapping("/login/github")
  public RedirectView redirectToGitHubPage() {
    return new RedirectView(OAuth2SecurityInfo.TEMP_CODE_REQUEST_URL);
  }
}
