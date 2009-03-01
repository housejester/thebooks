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
        email(blank:false,email:true,unique:true) 
        password(blank:false, size:5..15, password:true) 
        setupComplete() 
        developer() 
	}
}
