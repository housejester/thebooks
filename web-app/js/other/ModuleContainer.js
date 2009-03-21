Modules.add({
	name : "other.ModuleContainer",
	requires : {
		"other" : "other"
	},
	module: function (env){
		var resolve = this.resolveDeps;
		var ModuleContainer = function(modules){
			this.added = modules || {};
			this.resolved = {};
		}
		ModuleContainer.prototype = {
			add : function(module) {
				this.added[module.name] = module;
			},
			get : function(name){
				return this.added[name];
			},
			using : function(reqs, fn){
				if(reqs instanceof Array){
					var reqsHash = {};
					for(var i=0;i<reqs.length;i++){
						reqsHash[reqs[i]] = reqs[i];
					}
					reqs = reqsHash;
				}
				console.log("in mc.using: ", reqs, env);
				var deps =  resolve(reqs, this, this.resolved);
				if(deps.notFound){
					throw new Error("Could not resolve: "+deps.notFound.join());
				}
				fn.call(this,deps.found);
			}
		}

		return ModuleContainer;
	},
	bootstrap : function( modules ){
		var container = {
			get : function(name){
				return modules[name];
			}
		}
		var deps = this.resolveDeps(this.requires, container, {});
		if(deps.notFound){
			throw new Error('The following dependencies are required to get things going: ' + deps.notFound.join());
		}
		var ModuleContainer = this.module(deps.found, modules);
		return new ModuleContainer(modules);
	},
	resolveDeps : function(reqs, container, resolved){
		var deps = {found:{}};
		if(!reqs){
			return deps;
		}
		
		for(var key in reqs){
			if(typeof reqs[key] === 'string'){
				var req = reqs[key];
				console.log('resolving: ', key, req);
				var mod = container.get(req);
				if(mod){
					var dep = resolved[req];
					if(!dep){
						dep = mod.module(arguments.callee.call(this, mod.requires, container, resolved).found);
						resolved[req] = dep;
					}
					deps.found[key] = resolved[req];
				}else{
					deps.notFound = deps.notFound || [];
					deps.notFound.push(req);
				}
			}
		}
		console.log(deps, resolved);
		return deps;
	}
});