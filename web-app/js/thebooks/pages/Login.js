env.add({
	name : "thebooks.pages.Login",
	module : function(){
		var Login = function(){
			console.log('hotness...');
			document.getElementById('login').innerHTML = 'HOT login!!!!';
		}
		return Login;
	}
});
