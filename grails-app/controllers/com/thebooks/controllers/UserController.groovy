package com.thebooks.controllers

class UserController {
	def login = { 
		def user = null
		if(request.method == 'POST')
		 	user = com.thebooks.domain.User.findByEmail(params['email']) 
		session.user = user 
	    if (user) 
	     	redirect(controller:'user', action:'home') 
	  	else 
			render(view:'login')
	 }
	def home = {
		def user = session.user
		if(!user){
			redirect(controller:'user', action : 'login')
			return;
		}
		if(!user.setupComplete){
			render(view : 'homeNotSetupYet')
			return;
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
