package com.sararoepe.pool.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sararoepe.pool.services.MainService;

//separate controller for logout function to prevent confusion regarding session in main controller//
@Controller
public class LogoutController {
	public final MainService mainService;
	
	public LogoutController(MainService mainService) {
		this.mainService = mainService;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session, @ModelAttribute("sessionAttribute") String sessionAttribute) {
		
		session.invalidate();
		return "redirect:/";
	}

}
