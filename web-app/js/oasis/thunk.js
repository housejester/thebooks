Modules.add({
	name : "oasis.thunk",
	requires : ["oasis.ModuleContainer"],
	module : function(env){
		return env['oasis.ModuleContainer'].thunk;
	}
});