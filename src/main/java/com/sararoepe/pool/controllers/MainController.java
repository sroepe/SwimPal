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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sararoepe.pool.models.Pool;
import com.sararoepe.pool.models.Schedule;
import com.sararoepe.pool.models.User;
import com.sararoepe.pool.services.MainService;

@Controller
@SessionAttributes("sessionAttribute")
public class MainController {
	@ModelAttribute("sessionAttribute")
    public String getSessionAttribute(){
        return "noLoggedUser";
    }
	
	private final MainService mainService;
	
	public MainController(MainService mainService) {
		this.mainService = mainService;
	}
	
	@RequestMapping("/")
	public String landing(@ModelAttribute("pool") Pool pool, @ModelAttribute("schedule") Schedule schedule, @ModelAttribute("user") User user, @ModelAttribute("sessionAttribute") String sessionAttribute, @ModelAttribute("errors") String errors, Model model) {
		System.out.println(sessionAttribute);
		if(sessionAttribute != "noLoggedUser") {  //if user is logged in, will return different landing page (no login and reg on screen)//
			List<Pool> pools = mainService.allPools();
			List<Schedule> schedulesNow = mainService.allSchedulesByCurrentDayAndTime();
			model.addAttribute("pools", pools);
			model.addAttribute("schedulesNow", schedulesNow);
			return "mainLogged.jsp";
		} else {  //all non logged users will see this landing page with ability to login and register//
			List<Pool> pools = mainService.allPools();
			List<Schedule> schedulesNow = mainService.allSchedulesByCurrentDayAndTime();
			model.addAttribute("pools", pools);
			model.addAttribute("schedulesNow", schedulesNow);
			return "main.jsp";
		}
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
	
	@RequestMapping("/pools")  //displays all pools from db//
	public String poolList(@ModelAttribute("pool") Pool pool, @ModelAttribute("user") User user, @ModelAttribute("sessionAttribute") String sessionAttribute, Model model) {
		List<Pool> pools = mainService.allPools();
		model.addAttribute("pools", pools);
		return "pools.jsp";
	}
	
	@RequestMapping("/pools/{pool.id}") //displays one pool's information and schedule linked from "/pools" or infowindow on map//
	public String poolDetail(@PathVariable("pool.id") Long poolId, @ModelAttribute("schedule") Schedule schedule, @ModelAttribute("sessionAttribute") String sessionAttribute, HttpSession session, Model model) {	
		Pool pool = mainService.findPoolById(poolId);
		List<Schedule> timeOrderedSchedules = mainService.allSchedulesByStartTime();
		model.addAttribute("pool", pool);
		model.addAttribute("timeOrderedSchedules", timeOrderedSchedules);
		
		if(sessionAttribute != "noLoggedUser") { //if user is logged in, will display option to delete swim from mySwims or add depending on current schedules in mySwims//
			Long sessionId = Long.parseLong(sessionAttribute);
			User user = mainService.findUserById(sessionId);
			List<Schedule> mySchedules = user.getMySchedules();
			model.addAttribute("mySchedules", mySchedules);
			System.out.println(mySchedules);
		}
				
		return "showPool.jsp";
	}
	
	@RequestMapping("/mySwims") //user is redirected here after login; displays any swims the user has added and option to delete// 
	public String mySwims(@ModelAttribute("pool") Pool pool, @ModelAttribute("schedule") Schedule schedule, @ModelAttribute("sessionAttribute") String sessionAttribute, @ModelAttribute("sessionAttribute.firstName") String sessionFName, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		System.out.println("sessionAttribute");
		if(sessionAttribute == "noLoggedUser") {
			return "redirect:/";
		} else {
			Long sessionId = Long.parseLong(sessionAttribute);
			User user = mainService.findUserById(sessionId);
			System.out.println(sessionId);
			List<Pool> pools = mainService.allPools();
			List<Schedule> mySchedules = user.getMySchedules();
			model.addAttribute("user", user);
			model.addAttribute("pools", pools);
			model.addAttribute("mySchedules", mySchedules);		
			System.out.println(mySchedules);
			return "mySwims.jsp";
		}
		
	}
	
	@RequestMapping("addSwim/{schedule.id}")  //adds a scheduled swim to a logged user's mySwims//
	public String addSwim(@PathVariable("schedule.id") Long scheduleId, @ModelAttribute("sessionAttribute") Long sessionAttribute, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Schedule schedule = mainService.findScheduleById(scheduleId);
		User user = mainService.findUserById(sessionAttribute);
		List<User> schedulesUsers = schedule.getSchedulesUsers();
		if(!schedulesUsers.contains(user)) {
			schedulesUsers.add(user);
		}
		schedule.setSchedulesUsers(schedulesUsers);
		mainService.updateSchedules(schedulesUsers);
		return "redirect:/mySwims";
	}
	
	@RequestMapping("/deleteSwim/{schedule.id}")  //removes scheduled swim from logged user's mySwims//
	public String deleteSwim(@PathVariable("schedule.id") Long scheduleId, @ModelAttribute("sessionAttribute") Long sessionAttribute, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
		Schedule schedule = mainService.findScheduleById(scheduleId);
		User user = mainService.findUserById(sessionAttribute);
		List<User> schedulesUsers = schedule.getSchedulesUsers();
		if(schedulesUsers.contains(user)) {
			schedulesUsers.remove(user);
		}
		schedule.setSchedulesUsers(schedulesUsers);
		mainService.updateSchedules(schedulesUsers);
		
		return "redirect:/mySwims";
	}
	
	@RequestMapping("/about")  //SwimPal information and credits//
	public String about(@ModelAttribute("sessionAttribute") String sessionAttribute, @ModelAttribute("sessionAttribute.firstName") String sessionFName, HttpSession session, Model model) {
		getSessionAttribute();
		return "about.jsp";
	}
}
