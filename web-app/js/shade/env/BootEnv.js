if(typeof env === 'undefined'){
	var env = {
		add : function(config){
			env = new (config.module())(this);
			env.add(config);
			env.on('env.domready', function(){env.isReady=true;})
		},
		resolve : function(){
			env.resolver = this._getResolver();
			env.resolver.resolve.apply(env.resolver, arguments);
		},
		_getResolver : function(){
			var resolverConfig = env.get(this._getResolverTypeName());
			if(!resolverConfig){
				throw new Error("Resolver Type '"+this._getResolverTypeName()+"' not found.");
			}
			return new (resolverConfig.module())(env);
		},
		_getResolverTypeName : function(){
			var meta = document.getElementsByName('env:ResolverTypeName');
			return meta.length > 0 ? meta[0].content : 'shade.env.LocalResolver';
		}
	};
}

env.add({
	name : "shade.env.BootEnv",
	module: function (){
		var BootEnv = function(resolver){
			this.added = {};
			this.resolver = resolver;
			this._listeners = {};
		}
		BootEnv.prototype = {
			add : function(config){
				this.added[config.name] = config;
			},
			get : function(name){
				return this.added[name];
			},
			using : function(reqs, fn, immediate){
				if(this.isReady || immediate){
					this.resolver.resolve(reqs, fn);
				}else{
					this.on('env.domready', this.using, this, arguments);
				}
			},
			fire : function(name){
				var listeners = this._listeners[name] || [];
				for(var i=0;i<listeners.length;i++){
					var l = listeners[i];
					l.fn.apply(l.scope, l.args || []);
				}
			},
			on : function(name, fn, scope, args){
				var listeners = this._listeners[name] || [];
				this._listeners[name] = listeners;
				listeners.push({fn:fn,scope:scope,args:args});
			}
		}
		return BootEnv;
	}
});

