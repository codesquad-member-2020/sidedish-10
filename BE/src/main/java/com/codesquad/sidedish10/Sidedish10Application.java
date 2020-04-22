package com.codesquad.sidedish10;

import com.codesquad.sidedish10.parser.service.ParseService;
import java.text.ParseException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Sidedish10Application {

	public static void main(String[] args) throws ParseException {
		SpringApplication.run(Sidedish10Application.class, args);
	}

}