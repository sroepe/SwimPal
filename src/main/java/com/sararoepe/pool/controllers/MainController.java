package com.sararoepe.pool.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sararoepe.pool.models.Pool;
import com.sararoepe.pool.models.Schedule;
import com.sararoepe.pool.models.User;
import com.sararoepe.pool.services.MainService;

@Controller
public class MainController {
	@ModelAttribute("sessionAttribute")
    public String getSessionAttribute(){
        return "currentUser";
    }
	
	private final MainService mainService;
	
	public MainController(MainService mainService) {
		this.mainService = mainService;
	}
	@RequestMapping("/")
	public String landing(String search, @ModelAttribute("pool") Pool pool, @ModelAttribute("schedule") Schedule schedule, @ModelAttribute("user") User user, @ModelAttribute("errors") String errors, Model model) {
		List<Pool> pools = mainService.allPools();
		List<Schedule> schedules = mainService.allSchedules();
		List<Schedule> schedulesNow = mainService.allSchedulesByCurrentDayAndTime();
		model.addAttribute("pools", pools);
		model.addAttribute("schedules", schedules);
		model.addAttribute("schedulesNow", schedulesNow);

		return "main.jsp";
	}
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("user") User user, BindingResult result, @RequestParam(value="confirmPassword") String confirmPassword, @ModelAttribute("pool") Pool pool, @ModelAttribute("schedule") Schedule schedule, Model model, RedirectAttributes redirectAttributes) {
		if(result.hasErrors()) {
			List<Pool> pools = mainService.allPools();
			List<Schedule> schedules = mainService.allSchedules();
			model.addAttribute("pools", pools);
			model.addAttribute("schedules", schedules);
			return "main.jsp";
		} else {
			mainService.addUser(user, confirmPassword, redirectAttributes);
			return "redirect:/";
		}
	}
	
	@PostMapping("/login")
	public String login(@RequestParam(value="email") String email, @RequestParam(value="password") String password, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Object val = mainService.loginUser(email, password);
		if(val instanceof String) {
			redirectAttributes.addFlashAttribute("log", val);
			return "redirect:/";
		}
        model.addAttribute("sessionAttribute", mainService.findByEmail(email));
		return "redirect:/mySwims";
	}
	
	@RequestMapping("/pools")
	public String poolList(@ModelAttribute("pool") Pool pool, @ModelAttribute("sessionAttribute") String sessionAttribute, Model model) {
		List<Pool> pools = mainService.allPools();
		model.addAttribute("pools", pools);
		
		return "pools.jsp";
	}
	
	@RequestMapping("/mySwims")
	public String mySwims(@ModelAttribute("pool") Pool pool, @ModelAttribute("schedule") Schedule schedule, @ModelAttribute("sessionAttribute") Long sessionAttribute, HttpSession session, Model model) {
		User user = mainService.findUserById(sessionAttribute);
		List<Pool> pools = mainService.allPools();
		List<Schedule> schedules = mainService.allSchedules();
		model.addAttribute("pools", pools);
		model.addAttribute("schedules", schedules);
		model.addAttribute("user", user);
		
		return "mySwims.jsp";
	}
	
	
	@RequestMapping("/pools/{pool.id}")
	public String poolDetail(@PathVariable("pool.id") Long poolId, @ModelAttribute("schedule") Schedule schedule, @ModelAttribute("sessionAttribute") String sessionAttribute, HttpSession session, Model model) {
		Pool pool = mainService.findPoolById(poolId);	
		List<Schedule> timeOrderedSchedules = mainService.allSchedulesByStartTime();
		model.addAttribute("pool", pool);
		model.addAttribute("timeOrderedSchedules", timeOrderedSchedules);
		return "showPool.jsp";
	}
	
	@RequestMapping("/about")
	public String about() {
		return "about.jsp";
	}
}
