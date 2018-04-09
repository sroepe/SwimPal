package com.sararoepe.pool.services;

import java.util.List;

import org.springframework.security.crypto.bcrypt.*;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sararoepe.pool.models.Pool;
import com.sararoepe.pool.models.Schedule;
import com.sararoepe.pool.models.User;
import com.sararoepe.pool.repositories.PoolRepository;
import com.sararoepe.pool.repositories.ScheduleRepository;
import com.sararoepe.pool.repositories.UserRepository;

@Service
public class MainService {
	public PoolRepository poolRepository;
	public ScheduleRepository scheduleRepository;
	public UserRepository userRepository;
	public MainService(PoolRepository poolRepository, ScheduleRepository scheduleRepository, UserRepository userRepository) {
		this.poolRepository = poolRepository;
		this.scheduleRepository = scheduleRepository;
		this.userRepository = userRepository;
	}
	
	public Object addUser(User user, String confirmPassword, RedirectAttributes redirectAttributes) {
		boolean userExists = false;
		if(userRepository.findByEmail(user.getEmail()) instanceof User) {
			userExists = true;
			redirectAttributes.addFlashAttribute("reg", "Email already exists.");
		}
		if(confirmPassword.equals(user.getPassword()) && !userExists) {
			user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(10)));
			redirectAttributes.addFlashAttribute("reg", "Thank you for registering.  Please login.");
			return userRepository.save(user);
		}else {
			redirectAttributes.addFlashAttribute("reg", "Password and Confirmation do not match.");
			return "errors";
		}
	}
	
	public Object loginUser(String email, String password) {
		User user = userRepository.findByEmail(email);
		if(user == null) {
			return "Email does not exist";
			
		} else {
			if (BCrypt.checkpw(password, user.getPassword())) {
				return user;
			}else {
				return "Incorrect password. Please try again.";
			}
					
		}
		
	}	
	
	public User findUserById(Long id) {
		return userRepository.findOne(id);
	}
	
	public User findByEmail(String email) {
		return userRepository.findByEmail(email);
	}
	
	public User findByAlias(String alias) {
		return userRepository.findByAlias(alias);
	}
	
	public List<User> allUsers(){
		return userRepository.findAll();
	}
	
	public List<Pool> allPools(){
		return (List<Pool>) poolRepository.findAll();
	}
	
	public Pool findPoolById(Long id) {
		return poolRepository.findOne(id);
	}
	
	public List<Schedule> allSchedules(){
		return (List<Schedule>) scheduleRepository.findAll();
	}
	
	public List<Schedule> allSchedulesByStartTime(){
		return (List<Schedule>) scheduleRepository.allSchedulesByStartTime();
	}
	 
	public List<Schedule> allSchedulesByCurrentDayAndTime(){
		return (List<Schedule>) scheduleRepository.findSchedulesByDayAndTime();
	}
	
}
