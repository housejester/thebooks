if(typeof Modules === 'undefined'){
	var Modules = (function(){
		var DELAYED_ADD = [];
		var DELAYED_USING = [];
		var _Modules = {
			add : function(module) {
				if(module && typeof module === 'object' && typeof module.moduleContainer === "function"){
					Modules = module.moduleContainer();
					Modules.add.apply(Modules, arguments);
					this._applyAll(Modules.add, DELAYED_ADD);
					this._applyAll(Modules.using, DELAYED_USING);
					DELAYED_ADD = DELAYED_USING = null;
				}else{
					DELAYED_ADD.push(arguments);
				}
			},
			using : function(){
				DELAYED_USING.push(arguments);
			},
			_applyAll : function(fn, delayed){
				for(var i=0; i<delayed.length; i++){
					fn.apply(Modules, delayed[i]);
				}
			}
		};
		setTimeout(function(){
			if(Modules === _Modules){
				throw new Error("It seems to be taking too long to find a container.  Make sure that "+
				"a container provider (e.g. oasis.Container) is loaded ASAP after bootstrap.js");
			}
		}, 1000);
		return _Modules;
	})();	
}
