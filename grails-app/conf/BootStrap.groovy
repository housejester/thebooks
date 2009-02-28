class BootStrap {

     def init = { servletContext ->
			new com.thebooks.domain.User(email:"admin@test.com",password:"Password").save()
     }
     def destroy = {
     }
} 