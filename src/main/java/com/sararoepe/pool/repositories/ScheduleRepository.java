package com.sararoepe.pool.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.sararoepe.pool.models.Schedule;

@Repository
public interface ScheduleRepository extends CrudRepository<Schedule, Long> {
	List<Schedule> findAll();
	
	@Query(value="SELECT * FROM pool.schedules ORDER BY start ASC, days", nativeQuery=true)
	List<Schedule> allSchedulesByStartTime();
	
	@Query(value="SELECT * FROM pool.schedules where TIME(now()) BETWEEN start AND end AND (day1 = dayname(now()) OR day2 = dayname(now()) or day3 = dayname(now()) or day4 = dayname(now()) or day5 = dayname(now()) or day6 = dayname(now()) or day7 = dayname(now())) AND (DATE(now()) BETWEEN schedule_start AND schedule_end)", nativeQuery=true)
    List<Schedule> findSchedulesByDayAndTime();
	
}
