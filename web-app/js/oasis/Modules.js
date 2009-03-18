if(typeof Modules === 'undefined'){
	var Modules = {
		add : function(config){ 
			var ModuleContainer = config.module();
			Modules = new ModuleContainer();
			Modules.add(config);
		}
	};
}
/**
 @class oasis.Modules Provides a bootstrapping mechanism to load up a real
		ModuleContainer instance.  This guy's sole purpose is to delay all
		modules until it can resolve a ModuleContainer module to take
		over the "Modules" management duties.
*/
Modules.add({
	name : "oasis.Modules",
	module: function (){
		var utils = this.utils();
		var errors = this.errors;
		var interval = null;

		var ADDED = {};
		var DELAYED_USING = [];
		var CONTAINER_NAME = utils.readMeta('Modules:ContainerName', 'oasis.ModuleContainer');
		var BOOT_TIMEOUT = utils.readMeta('Modules:BootTimeout', 2000);
		
		var BootModules = function(parent){
			this.parent = parent || {get:utils.valueFn()};
		}
		BootModules.prototype = {
			add : function(module) {
				ADDED[module.name] = module;
				if(CONTAINER_NAME === module.name){
					clearTimeout(interval);
					var ModuleContainer = module.module();
					Modules = new ModuleContainer(this);
					utils.forEach(DELAYED_USING, Modules.using, Modules, 'apply');
					DELAYED_USING = null;
				}
			},
			get : function(name){
				return ADDED[name] || this.parent.get(name);
			},
			using : function(){
				DELAYED_USING.push(arguments);
				interval = interval || utils.die(errors.timedOut, BOOT_TIMEOUT);
			}
		}

		return BootModules;
	},
	utils : function(){
		var utils = {
			readMeta : function(name, defaultValue){
				var meta = document.getElementsByName(name);
				return meta.length > 0 ? meta[0].content : defaultValue;
			},
			valueFn : function(value){
				return function(){
					return value;
				}
			},
			forEach : function(coll, fn, scope, callType){
				var callType = callType || 'call';
				if(!coll || typeof coll !== 'object'){
					return;
				}
				if(coll instanceof Array){
					for(var i=0;i<coll.length; i++){
						fn[callType](scope, coll[i]);
					}
				}else{
					for(var key in coll){
						if(typeof coll[key] !== 'function'){
							fn[callType](scope, coll[key]);
						}
					}
				}
			},
			die : function(message, delay){
				if(delay < 0){
					return;
				}
				if(!delay){
					throw new Error(message);
				}
				return setTimeout(function(){
					throw new Error(message);
				}, delay);
			}		
		}
		this.utils = utils.valueFn(utils);
		return utils;
	},
	errors : {
		timedOut : "It seems to be taking too long to find a container.  Make sure that a container provider (e.g. oasis.Container) is loaded ASAP after Modules.js"
	}
});
