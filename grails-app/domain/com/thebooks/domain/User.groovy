package com.thebooks.domain

class User {
	Long id 
	Long version 
	String email 
	String password 
	String toString() { "$email" } 

	def static constraints = 
	{ 
        email(email:true) 
        password(blank:false, password:true) 
	}
}
