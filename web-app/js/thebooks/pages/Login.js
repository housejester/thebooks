Modules.add({
	name : "thebooks.pages.Login",
	requires : ["$", "log"],
	module : function(env){	with(env){
		var Login = function(){
			log('hotness...');
			$("login").innerHTML = "HOT login page!!!";
		}
		return Login;
	}}
});

/* silly examples of modules/services. order doesn't matter. */
Modules.add({
	name : "console",
	module: function(){
		return window.console || {
			log : function(val){
				alert(val)
			}
		};
	}
});

Modules.add({
	name : "$",
	module : function(){
		return function(id){
			return document.getElementById(id);
		}
	}
});

Modules.add({
	name : "log",
	requires : ["console"],
	module : function(env){
		return function(message){
			env.console.log(message);
		}
	}
});
