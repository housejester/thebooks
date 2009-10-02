package com.thebooks.controllers
import com.thebooks.domain.Transaction

class UserController {
	def beforeInterceptor = [action:this.&checkLoggedIn,except:['login','logout','register','noAccess']]

	def user = null
    List transactions
    Integer pastUnreconciledCount
    Transaction lastReconciled

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
    def addTransaction = {
      if(!params.usbankAmount){
        params.usbankAmount = 0;
      }
      if(!params.commerceAmount){
        params.commerceAmount = 0;
      }
        def tx = new Transaction(params);
        def date = new Date();
        date.month = tx.clearDate.month;
        date.date = tx.clearDate.date;
        tx.setClearDate(date);
        if(!tx.save()){
           tx.errors.each {
                println it
           }
          redirect(controller:'user', action:'home', params:[error:'error'])
        }else{
          redirect(controller:'user', action:'home')
        }
    }
	def home = {
		if(!user.setupComplete){
			render(view : 'homeNotSetupYet')
			return;
		}
        def lastRec = Transaction.withCriteria{
          eq("reconciled", true)
          maxResults(1)
          order("clearDate","desc")
          order("id", "desc")
        }
        if(lastRec.size() == 0){
          lastReconciled = new Transaction();
          pastUnreconciledCount = 0
          transactions = Transaction.withCriteria{
            maxResults(20)
            order("clearDate","desc")
            order("id", "desc")
          }
        }else{
          lastReconciled = lastRec.get(0)
          transactions = Transaction.withCriteria{
              ge("clearDate", lastReconciled.clearDate)
              maxResults(20)
              order("clearDate","desc")
              order("id", "desc")
          }
          pastUnreconciledCount = Transaction.countByClearDateLessThanAndReconciled(lastReconciled.clearDate, 0)
        }
	}
	def dojo = {
		render(view:'dojo-home')
	}
	def oasis = {
		render(view:'oasis-home')
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
