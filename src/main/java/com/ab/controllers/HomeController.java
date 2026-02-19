package com.ab.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/api/vi")	
public class HomeController {
	
	@GetMapping("/")
	public String home() {
		return "home";
	}
	
	

}
