(function (){
	var ENV = {};
	var DELAYED = [];
	function define(){
		var config = parseArguments(arguments);
		if(typeof config.name !== 'string'){
			return _using(config);
		}
		var origModule = config.module;
		var module = function(deps, config){
			config.module = origModule;
			var provided = config.module(deps, config);
			add(config.name, provided);
			runDelayed();
		}
		config.module = module;
		_using(config);
	}
	function using(requires, module){
		_using({requires:requires, module:module});
	}
	function _using(){
		var config = parseArguments(arguments);
		var deps = {};
		if(!config.requires || resolveRequires(config.requires, deps)){
			resolveAliases(config.alias, deps);
			config.module(deps, config);
		}else{
			DELAYED.push(config);
		}
	}
	function resolveAliases(aliases, deps){
		if(!aliases || typeof aliases !== 'object'){
			return;
		}
		for(var key in aliases){
			if(typeof key === 'string'){
				if( typeof aliases[key] === 'function'){
					deps[key] = aliases[key];
				}else if(typeof aliases[key] === 'string'){
					var names = aliases[key].split('.');
					var obj = deps;
					deps[key] = resolveAlias(obj, names, aliases[key]);
				}
			}
		}
	}
	function resolveAlias(obj, names, value){
		var firstName = names[0];
		obj = obj[firstName] || window[firstName] || {};
		for(var i=1;i<names.length-1;i++){
			obj = obj[names[i]] || {};
		}
		var lastName = names[names.length-1];
		var fn = obj[lastName] || function(){};
		return bind(obj, fn, value);
	}
	function bind(obj, fn, value){
		return function(){
			try{
				return fn.apply(obj, Array.prototype.slice.call(arguments));
			}catch(e){
				/* IE6 does not support apply/call on native functions */
				var str = value+'("'+Array.prototype.slice.call(arguments).join('","')+'")';
				alert('evaling...['+str+']');
				return eval(str);
			}
		}
	}
	function runDelayed(){
		var delayed = DELAYED;
		DELAYED = [];
		for(var i=0;i<delayed.length;i++){
			_using(delayed[i]);
		}
	}
	function resolveRequires(requires, env){
		if(!requires || typeof requires.length !== 'number'){
			return true;
		}
		for(var i=0; i<requires.length;i++){
			var req = requires[i];
			if(typeof ENV[req] === 'undefined'){
				return false;
			}
			env[req] = ENV[req];
			var topName = req.split('.')[0];
			env[topName] = ENV[topName];
		}
		return true;
	}
	function add(name, obj){
		ENV[name] = obj;
		var names = name.split('.');
		var node = ENV;
		var topName = names[0];
		if(!ENV[topName] && window[topName]){
			ENV[topName] = window[topName];
		}
		for(var i=0; i<names.length-1;i++){
			var name = names[i];
			var next = node[name];
			if(!next){
				node[name] = {};
			}
			node = node[name];
		}
		node[names[names.length-1]] = obj;
		window[topName] = ENV[topName];
	}
	function parseArguments(args){
		var config = args[0];
		if(typeof config !== 'object'){
			config = {
				name : args[0]
			}
			if(typeof args[1] === 'function'){
				config.module = args[1];
			}else{
				config.requires = args[1];
				config.module = args[2];
			}
		}
		return config;
	}
	define({
		name : "oasis",
		module : function(){
			var oasis = {
				define : define,
				using  : using
			}
			return oasis;
		}
	});
	function bootstrap(){
		var allMeta = document.getElementsByTagName('meta');
		for(var i=0;i<allMeta.length;i++){
			if(allMeta[i].name == 'page-controller'){
				var cName = allMeta[i].content;
				oasis.using([cName], function(env){
					env[cName]();
				})
			}
		}
	}
	setTimeout(bootstrap, 2000);
})();
window.define = window.define || oasis.define;
