if(typeof Modules === 'undefined'){
	var Modules = {
		add : function(config){
			Modules = new (config.module())();
			Modules.add(config);
		}
	};
	(function(){
		var interval = setInterval(
			function(){
				if(Modules.using){
					var meta = document.getElementsByName('Modules:Page');
					if(meta.length > 0){
						clearInterval(interval);
						var name = meta[0].content;
						Modules.using([name], function(env){
							new env[name]();
						})
						return;
					}
				}
				if(document.body){
					clearInterval(interval);
				}
			},
			100 //need a real dom ready
		);
	})();
}

Modules.add({
	name : "other.BootModule",
	module: function (){
		var BootModule = function(){
			this.added = {};
		}
		BootModule.prototype = {
			add : function(config){
				this.added[config.name] = config;
			},
			get : function(name){
				return this.added[name];
			},
			using : function(reqs, fn, immediate){
				var containerConfig = this.added[this.getContainerName()];
				if(!containerConfig){
					throw new Error("Container Module '"+this.getContainerName()+"' not found.");
				}
				Modules = containerConfig.bootstrap(this.added);
				Modules.using(reqs, fn, immediate);
			},
			getContainerName : function(){
				var meta = document.getElementsByName('Modules:ContainerName');
				return meta.length > 0 ? meta[0].content : 'other.ModuleContainer';
			}
		}
		return BootModule;
	}
});
