Modules.add({
	name : "oasis.ModuleContainer",
	module : function(){
		var utils = this.utils();
		var ModuleContainer = function(parent){
			this.parent = parent || {get:utils.valueFn()};
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
		this.module = utils.valueFn(ModuleContainer);
		return ModuleContainer;
	},
	utils : function(){
		var utils = {
			thunk : function(obj, method){
				return function(){
					var value = obj[method].apply(obj, arguments);
					obj[method] = ModuleContainer.valueFn(value);
					return value;
				}
			},
			valueFn : function(value){
				return function(){
					return value;
				}
			}
		}
		this.utils = utils.valueFn(utils);
		return utils;
	}
});
