package com.codesquad.sidedish10.getter.config;

import com.codesquad.sidedish10.getter.service.JwtService;
import com.codesquad.sidedish10.getter.interceptor.HttpInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@Configuration
public class WebMvcConfigurerImpl implements WebMvcConfigurer {

  private final JwtService jwtService;

  public WebMvcConfigurerImpl(JwtService jwtService) {
    this.jwtService = jwtService;
  }

  @Override
  public void addCorsMappings(CorsRegistry registry) {
    registry.addMapping("/**")
        .allowedOrigins("*")
        .allowedHeaders("*")
        .allowCredentials(true)
        .allowedMethods("GET", "POST", "OPTION", "HEADER", "PUT", "DELETE");
  }

  @Override
  public void addInterceptors(InterceptorRegistry registry) {
    registry.addInterceptor(new HttpInterceptor(jwtService))
  //      .addPathPatterns("/develop/**")
        .excludePathPatterns("/**");
  }
}