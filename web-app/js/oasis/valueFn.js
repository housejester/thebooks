Modules.add({
	name : "oasis.valueFn",
	requires : ["oasis.ModuleContainer"],
	module : function(env){
		return env['oasis.ModuleContainer'].valueFn;
	}
});