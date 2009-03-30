env.add({
	name : "jQuery",
	module : function(){
		console.log('in jq...', $, jQuery);
		return $;
	}
});

env.using(["jQuery"],function(deps){
	deps.jQuery(document).ready(function(){
		env.fire("env.domready");
	})
}, true);