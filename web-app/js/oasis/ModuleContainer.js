if(typeof Modules === 'undefined'){
	var Modules = {
		add : function(config){
			Modules = config.moduleContainer();
			Modules.add.apply(Modules, arguments);
		}
	};
}

Modules.add({
	name : "oasis.ModuleContainer",
	module : function(){
		var ModuleContainer = function(){
			this._MODULES = {};
		}
		ModuleContainer.prototype = {
			add : function(moduleConfig){
				this._MODULES[moduleConfig.name] = moduleConfig;
				var module = moduleConfig.module;
				moduleConfig.module = function(){
					var result = module.apply(moduleConfig, arguments);
					moduleConfig.module = function(){
						return result;
					}
				}
			},
			using : function(reqs, fn){
				
			},
			lookup : function(name){
				return this._MODULES[name];
			}
		}
		return ModuleContainer;
	},
	moduleContainer : function(){
		var ModuleContainer = this.module();
		this.module = function(){
			return ModuleContainer;
		}
		return new ModuleContainer();
	}
});

