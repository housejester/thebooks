class UserBrowserController {
	def beforeInterceptor = [action:this.&checkDeveloperAccess,except:['noAccess']]
	
	def checkDeveloperAccess = {
		if(!session.user){
			redirect(controller:'user', action : 'login')
			return false
		}
		if(!session.user.developer){
			redirect(controller:'user',action:'noAccess')
			return false;
		}
	}
	
	def scaffold = com.thebooks.domain.User
}
