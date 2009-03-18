if(typeof Modules === 'undefined'){
	var Modules = {
		add : function(config){ 
			var ModuleContainer = config.module();
			Modules = new ModuleContainer();
			Modules.add(config);
		}
	};
}

Modules.add({
	name : "oasis.ModuleContainer",
	module : function(){
		var ModuleContainer = function(parent){
			this.parent = parent || {get:ModuleContainer.valueFn(null)};
			this._MODULES = {};
		}
		ModuleContainer.thunk = function(obj, method){
			return function(){
				var value = obj[method].apply(obj, arguments);
				obj[method] = ModuleContainer.valueFn(value);
				return value;
			}
		}
		ModuleContainer.valueFn = function(value){
			return function(){
				return value;
			}
		}
		ModuleContainer.prototype = {
			add : function(moduleConfig){
				console.log('adding '+moduleConfig.name);
				this._MODULES[moduleConfig.name] = moduleConfig;
				moduleConfig.module = ModuleContainer.thunk(moduleConfig, 'module');
			},
			using : function(reqs, fn){
				console.log('container using '+reqs.join());
			},
			get : function(name){
				return this._MODULES[name] || this.parent.get(name);
			}
		}
		this.module = ModuleContainer.valueFn(ModuleContainer);
		return ModuleContainer;
	}
});
