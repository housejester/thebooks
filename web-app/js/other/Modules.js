if(typeof Modules === 'undefined'){
	var Modules = {
		added : {},
		add : function(config){
			this.containerConfig = config;
			this.add = this._simpleAdd;
			this.add(config);
		},
		_simpleAdd : function(config){
			this.added[config.name] = config;
		},
		get : function(name){
			return this.added[name];
		},
		using : function(reqs, fn){
			Modules = this.containerConfig.bootstrap(this.added, this.setModuleContainer);
			Modules.using(reqs, fn);
		},
		setModuleContainer : function(container){
			Modules = container;
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
	name : "other.Modules",
	requires : {
		"other" : "other"
	},
	module: function (env, modules){
		var other = env.other;
		var resolveDeps = this.resolveDeps;
		var errors = this.errors;
		var interval = null;

		var ADDED = modules || {};
		var DELAYED_USING = [];
		var CONTAINER_NAME = other.readMeta('Modules:ContainerName', 'other.ModuleContainer');
		var BOOT_TIMEOUT = other.readMeta('Modules:BootTimeout', 2000);
		
		var BootModules = function(onContainerLoaded){
			this.onContainerLoaded = onContainerLoaded;
		}
		BootModules.prototype = {
			add : function(module) {
				ADDED[module.name] = module;
				if(!this.container && CONTAINER_NAME === module.name){
					this._initModuleContainer(module);
				}
			},
			getModuleContainer:function(){
				if(!this.container){
					var module = ADDED[CONTAINER_NAME];
					if(module){
						this.container = this._initModuleContainer(module);
					}
				}
				if(this.container){
					this.getModuleContainer = other.valueFn(this.container);
					return this.container;
				}
				return this;
			},
			_initModuleContainer : function(module){
				var deps = resolveDeps(module.requires, ADDED, {});
				if(deps.notFound){
					return null;
				}
				clearTimeout(interval);
				var ModuleContainer = module.module(deps.found);
				var container = new ModuleContainer(this);
				this.onContainerLoaded(container);
				other.forEach(DELAYED_USING, container.using, container, 'apply');
				DELAYED_USING = null;
				this._initModuleContainer = other.valueFn(container);
				return container;
			},
			get : function(name){
				return ADDED[name];
			},
			using : function(){
				DELAYED_USING.push(arguments);
				interval = interval || other.die(errors.timedOut, BOOT_TIMEOUT);
			}
		}

		return BootModules;
	},
	bootstrap : function( modules, callback ){
		var deps = this.resolveDeps(this.requires, modules, {});
		if(deps.notFound){
			throw new Error(this.errors.bootDependencyMissing.replace('{0}', deps.notFound.join(',')));
		}
		var BootModules = this.module(deps.found, modules);
		return (new BootModules(callback)).getModuleContainer();
	},
	resolveDeps : function(reqs, all, resolved){
		var deps = {found:{}};
		if(!reqs){
			return deps;
		}
		
		for(var key in reqs){
			if(typeof reqs[key] === 'string'){
				var req = reqs[key];
				var mod = all[req];
				if(mod){
					deps.found[key] = resolved[req] = resolved[req] || mod.module(arguments.callee.call(this, mod.requires).found);
				}else{
					deps.notFound = deps.notFound || [];
					deps.notFound.push(req);
				}
			}
		}
		return deps;
	},
	errors : {
		timedOut : "It seems to be taking too long to find a container.  Make sure that a container provider (e.g. oasis.Container) is loaded ASAP after Modules.js",
		bootDependencyMissing : 'The following dependencies are required to get things going: {0}'
	}
});
