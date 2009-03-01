package com.thebooks.controllers

class UserController {
	def beforeInterceptor = [action:this.&checkLoggedIn,except:['login','logout','noAccess']]
	
	def checkLoggedIn = {
		if(!session.user){
			redirect(controller:'user', action : 'login')
			return false
		}
	}
	
	def login = { 
		if(request.method == 'POST'){
		 	session.user = com.thebooks.domain.User.findByEmail(params['email']) 
		}
	    if (session.user) 
	     	redirect(controller:'user', action:'home') 
	  	else 
			render(view:'login')
	 }
	def home = {
		def user = session.user
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
	def noAccess = {
	}
}
