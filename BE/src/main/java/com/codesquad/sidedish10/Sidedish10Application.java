package com.codesquad.sidedish10;

import com.codesquad.sidedish10.parser.service.ParseService;
import java.text.ParseException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class Sidedish10Application extends SpringBootServletInitializer {

	public static void main(String[] args) throws ParseException {
		SpringApplication.run(Sidedish10Application.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(Sidedish10Application.class);
	}


}