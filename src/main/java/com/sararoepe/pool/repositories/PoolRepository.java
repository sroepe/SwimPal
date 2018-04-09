package com.sararoepe.pool.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.sararoepe.pool.models.Pool;

@Repository
public interface PoolRepository extends CrudRepository<Pool, Long>{
	List<Pool> findAll();
	Pool findOne(Long id);
}
