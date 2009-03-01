package com.thebooks.domain

class User {
	Long id 
	Long version 
	String email 
	String password 
	Boolean setupComplete = false
	Boolean developer = false
	String toString() { "$email" } 

	def static constraints = 
	{ 
        email(email:true) 
        password(blank:false, password:true) 
        setupComplete() 
        developer() 
	}
}
