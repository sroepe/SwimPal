package com.sararoepe.pool.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table (name = "users")
public class User {
	@Id
	@GeneratedValue
	private Long id;
	
	@Size(min = 2, message="Your first name must be 2 or more characters.")
    @Pattern(regexp="^[a-zA-Z'-]+$", message="Please capitalize the first letter of your name. Alpha, hyphen, dash characters only.")
    private String firstName;
    
	@Size(min = 2, message="Your last name must be 2 or more characters.")
    @Pattern(regexp="^[a-zA-Z'-]+$", message="Please capitalize the first letter of your name. Alpha, hyphen, dash characters only.")
    private String lastName;
    
    @Pattern(regexp="^(.+)@(.+)$", message="You must enter a valid email.  Example: abc@abc.com")
    private String email;
       
    @Size(min=8, message="Your password must be 8 or more characters.")
    private String password;
    
    @Column(updatable=false)
    @DateTimeFormat(pattern="MM/dd/yyyy HH:mm:ss")
    private Date createdAt;
    
    @PrePersist
    protected void onCreate() {
    	this.createdAt = new Date();
    }
    
    private Date updatedAt;
    
    @PreUpdate
    protected void onUpdate() {
    	this.updatedAt = new Date();
    }
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
    	name = "poolsUsers",
    	joinColumns = @JoinColumn(name = "user_id"),
    	inverseJoinColumns = @JoinColumn(name = "pool_id")
    )
    private List<Pool> myPools;
    
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
    	name = "schedulesUsers",
    	joinColumns = @JoinColumn(name = "user_id"),
    	inverseJoinColumns = @JoinColumn(name = "schedule_id")
    )
    private List<Schedule> mySchedules;
	
    public User() {
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public List<Pool> getMyPools() {
		return myPools;
	}

	public void setMyPools(List<Pool> myPools) {
		this.myPools = myPools;
	}

	public List<Schedule> getMySchedules() {
		return mySchedules;
	}

	public void setMySchedules(List<Schedule> mySchedules) {
		this.mySchedules = mySchedules;
	}  
	
}
