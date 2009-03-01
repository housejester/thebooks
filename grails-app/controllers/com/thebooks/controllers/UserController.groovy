package com.thebooks.controllers

class UserController {
	def login = { 
		def user = com.thebooks.domain.User.findByEmail(params['email']) 
		session.user = user 
	    if (user) 
	     	redirect(controller:'user', action:'home') 
	  	else 
			render(view:'login')
	 }
	def home = {
		def user = session.user
		if(!user){
			render(view : 'login')
		}
		if(!user.setupComplete){
			render(view : 'homeNotSetupYet')
		}
	}
	def logout = {
		session.invalidate();
		redirect(uri:'/');
	}
	
	def accountList = {
		/* eventually, move this to an AccountController */
	}
	
	def letMeIn = {
		session.user.setupComplete = true
		session.user.save();
		redirect(action:'home')
	}
}
