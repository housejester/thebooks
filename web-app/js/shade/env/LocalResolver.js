env.add({
	name : "shade.env.LocalResolver",
	module: function (){
		var LocalResolver = function(container){
			this.resolved = {};
			this.container = container || env;
		}
		LocalResolver.prototype = {
			resolve : function(reqs, foundCallback){
				var deps = this._doResolve(reqs);
				if(deps.notFound){
					throw new Error("Could not resolve:  "+deps.notFound.join());
				}
				foundCallback(deps.found);
			},
			_doResolve : function(reqs){
				var deps = {found:{}};
				if(reqs instanceof Array){
					var reqsHash = {};
					for(var i=0;i<reqs.length;i++){
						reqsHash[reqs[i]] = reqs[i];
					}
					reqs = reqsHash;
				}

				for(var key in reqs){
					if(typeof reqs[key] === 'string'){
						var req = reqs[key];
						var mod = this.container.get(req);
						if(mod){
							var dep = this.resolved[req];
							if(!dep){
								dep = mod.module(arguments.callee.call(this, mod.requires).found);
								this.resolved[req] = dep;
							}
							deps.found[key] = this.resolved[req];
						}else{
							deps.notFound = deps.notFound || [];
							deps.notFound.push(req);
						}
					}
				}
				return deps;				
			}
		}

		return LocalResolver;
	}
});