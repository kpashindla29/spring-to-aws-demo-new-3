package com.ab.controllers;

import org.springframework.stereotype.RestController;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
public class HomeController {
	
	@GetMapping
	public String home() {
		return "Welcome";
	}
	
	

}
