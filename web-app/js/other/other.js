Modules.add({
	name : "other",
	module : function(){
		return {
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
		};
	}
})