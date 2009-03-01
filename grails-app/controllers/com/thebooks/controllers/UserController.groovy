package com.thebooks.controllers

class UserController {
	def beforeInterceptor = [action:this.&checkLoggedIn,except:['login','logout','register','noAccess']]

	def user = null

	def checkLoggedIn = {
		if(!session.user){
			redirect(controller:'user', action : 'login')
			return false
		}
		user = session.user
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
		user.setupComplete = true
		user.merge()
		redirect(action:'home')
	}
	def noAccess = {
	}
	def register = {
		if(request.method == 'POST'){
			user = new com.thebooks.domain.User(params)
			if(params['password'] != params['confirm_password'])
				user.errors.reject("user.confirm_password.match")
			if(!user.hasErrors() && user.save()){
				session.user = user
				redirect(action:'home')
				return;
			}
		}
	}
}
