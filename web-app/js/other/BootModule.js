if(typeof Modules === 'undefined'){
	var Modules = {
		add : function(config){
			Modules = new (config.module())();
			Modules.add(config);
		}
	};
}

Modules.add({
	name : "other.BootModule",
	module: function (){
		var BootModule = function(){
		}
		BootModule.prototype = {
			added : {},
			add : function(config){
				this.added[config.name] = config;
			},
			get : function(name){
				return this.added[name];
			},
			using : function(reqs, fn){
				var containerConfig = this.added[this.getContainerName()];
				if(!containerConfig){
					throw new Error("Container Module '"+this.getContainerName()+"' not found.");
				}
				Modules = containerConfig.bootstrap(this.added);
				Modules.using(reqs, fn);
			},
			getContainerName : function(){
				var meta = document.getElementsByName('Modules:ContainerName');
				return meta.length > 0 ? meta[0].content : 'other.ModuleContainer';
			}
		}
		return BootModule;
	}
});
