Modules.add({
	name : "other.ModuleContainer",
	requires : {
		"other" : "other"
	},
	module : function(env){
		var utils = this.utils(env);
		var ModuleContainer = function(parent){
			this.parent = parent || {get:env.valueFn()};
			this._MODULES = {};
		}
		ModuleContainer.prototype = {
			add : function(moduleConfig){
				console.log('adding '+moduleConfig.name);
				this._MODULES[moduleConfig.name] = moduleConfig;
				moduleConfig.module = utils.thunk(moduleConfig, 'module');
			},
			using : function(reqs, fn){
				console.log('container using '+reqs.join());
			},
			get : function(name){
				return this._MODULES[name] || this.parent.get(name);
			}
		}
		this.module = env.other.valueFn(ModuleContainer);
		return ModuleContainer;
	},
	utils : function(env){
		var utils = {
			thunk : function(obj, method){
				return function(){
					var value = obj[method].apply(obj, arguments);
					obj[method] = env.other.valueFn(value);
					return value;
				}
			}
		}
		this.utils = env.other.valueFn(utils);
		return utils;
	}
});
