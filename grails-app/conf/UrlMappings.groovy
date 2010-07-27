class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/user/home/$year?/$month?/$day?"(controller:"user", action:"home")
	  "500"(view:'/error')
	}
}
