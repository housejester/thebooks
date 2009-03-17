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
	name : "oasis.Modules",
	module: function (){
		var ADDED = {};
		var DELAYED_USING = [];
		var interval = null;
		var valueFn = function(value){
			return function(){
				return value;
			}
		}
		var Modules = function(){
		}
		Modules.prototype = {
			add : function(module) {
				ADDED[module.name] = module;
			},
			lookup : function(name){
				return ADDED[name];
			},
			using : function(){
				DELAYED_USING.push(arguments);
				if(!interval && !this._tryUsing()){
					this._createTryUsingInterval();
				}
			},
			_createTryUsingInterval : function(){
				var self = this;
				interval = setInterval(function(){
					console.log('try...');
					self._tryUsing();
				}, 30);
				setTimeout(function(){
					self._cancelTryUsingInterval(
						"It seems to be taking too long to find a container.  Make sure that "+
						"a container provider (e.g. oasis.Container) is loaded ASAP after Modules.js"
					);
				}, 2000);
			},
			_cancelTryUsingInterval : function(errMsg){
				if(interval){
					clearInterval(interval);
					interval = null;
					if(errMsg){
						throw new Error(errMsg);
					}
				}
			},
			_tryUsing : function(){
				var config = ADDED[this._getModuleContainerName()];
				if(config){
					this._cancelTryUsingInterval();
					var ModuleContainer = config.module();
					var container = new ModuleContainer();
					Modules = container;
					this._drainAddedModules();
					this._drainDelayedUsing();
					return true;
				}
				return false;
			},
			_drainAddedModules : function(){
				for(var key in ADDED){
					if(typeof ADDED[key] === 'object'){
						Modules.add(ADDED[key]);
					}
				}
				ADDED = null;
			},
			_drainDelayedUsing : function(){
				for(var i=0;i<DELAYED_USING.length;i++){
					Modules.using.apply(Modules, DELAYED_USING[i]);
				}
				DELAYED_USING = null;
			},
			_getModuleContainerName : function(){
				var name = 'oasis.ModuleContainer';
				var meta = document.getElementsByName("modules:ModuleContainer");
				if(meta.length > 0){
					name = meta[0].content;
				}else if(!document.body){
					return null;
				}
				this._getModuleContainerName = valueFn(name);
				console.log('name is '+name);
				return name;
			}
		}
		return Modules;
	}
});
