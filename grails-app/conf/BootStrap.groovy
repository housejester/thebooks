import grails.util.GrailsUtil

class BootStrap {

     def init = { servletContext ->
        if(GrailsUtil.environment == "development"){
			new com.thebooks.domain.User(email:"admin@test.com",password:"Password",developer:true).save()
			new com.thebooks.domain.User(email:"user@test.com",password:"Password").save()
        }
     }
     def destroy = {
     }
} 