/*
env.add(function(){
	var Component = env.require("Ext.Component");
	env.provide("oasis.grid.Grid", Grid);
	function Grid(){
	}
	Grid.isA();
	Grid.has({
		width : 100,
		add : function(){
		},
		foo : {},
		bar : function(){
		}
	});
});
*/
/*
 oasis 2.2 and oasis 3

	would need a bootstrap of sorts to do (up front):
	<script src="/ext-2.2/ext-all-debug.js"></script>
	<script type="text/javascript">
		env.provide("Ext", Ext);
		Ext = null;
	</script>
	
*/

(function(env){
	var Component = env["Ext.Component"];
	var $ = env["jQuery"];
	function Grid(){
	}
	return Grid;
})
.requires(
	"Ext.Component",
	"Ext.Ajax",
	"jQuery",
	"YAHOO.widgets.Slider"
)
();

oasis.using(
	"Component"
).run(function(env){
	var Component = env.Component;
	var Grid = function(){
	}
	oasis.provide("oasis.grid.Grid", Grid);
});

oasis.define(
	"oasis.Grid",
	["Ext.Component"],
	function(env){
		var Component = env["Ext.Component"];
	}
);
oasis.using(
	["Component"],
	function(env){
		var Component = env.Component;
		var Grid = function(){
		}
		oasis.provide("oasis.grid.Grid", Grid);
	}
);
oasis.using(
	["Component"],
	function(env){
		env.namespace("oasis.grid");
		var Component = env.Component;
		var Grid = function(){
		}
		env.provide("Grid", Grid);
	}
);

Function.using
Function.provide
module.using("foo", "bar");
module.provide("oasis.grid.Grid");
module.using("Foo", "bar").provide("oasis.grid.Grid");


(function(env){
	var Component = env.Component;
	var Grid = function(){
	}
	oasis.provide("oasis.grid.Grid", Grid);
}).callUsing("Component");

(function(env){
	var Component = env.Component;
	var Grid = function(){
	}
	return Grid;
})
.uses("Component")
.provides("oasis.grid.Grid");



(function(env){
	var Component = env.Component;
	var Grid = function(){
	}
	return Grid;
})
.requires("Component")
.provides("oasis.grid.Grid");

(function(){
	var Component = arguments.callee['Component'];
	var Grid = function(){
	}
	Grid.requires("Foo");// ???
	return Grid;
})
.requires("Component")
.provides("oasis.grid.Grid");




so, i think i like:
oasis.using(
	["Component"],
	function(env){
		var Component = env.Component;
		var Grid = function(){
		}
		env.provide("oasis.grid.Grid", Grid);
	}
);
oasis.define(
	"oasis.grid.Grid",
	function(env){
	}
);
//env.provide would be 'standard'.  oasis might have an oasis.provide, but that'd be
//loader implementation specific.  I suppose that means, the following would be the
//'standard' way to push in a 'class' from external:  (function(){return Ext;}).provide('Ext');
//or (function(env){env.provide('Ext', Ext)}).using(); //should there be a 'load' for this case?
//load could be used for cases with using's but no provides too.
and
(function(env){
	var Component = env.Component;
	var Grid = function(){
	}
	return Grid; //can also env.provide(...) in here
})
.using("Component")  //optional...could just provide(...) if no deps
.provide("oasis.grid.Grid");
maybe:
(function(env){
	var Grid = function(){
	}
	env.provide("oasis.grid.Grid"); //convenience for (function(){return Grid;}).provide('oasis.grid.Grid');
})
.load();
which is slightly simpler than:
(function(env){
	var Grid = function(){
	}
	(function(){return Grid;}).provide('oasis.grid.Grid');
})()

and
(function(env){
	var Component = env['Component'];
	var Grid = function(){
	}
	env.provide("oasis.grid.Grid");
})
.using("Component") //or should a using also trigger an implicit 'load'?  provide does...
.load();

if you prefer the "requires" list and class name at the top, then you can wrap another scope "module"
around the defining module:

(function(){
	module.provide("oasis.grid.Grid");
	module.using("Component");
	function module(env){
		var Component = env.Component;
		var Grid = function(){
		}
		return Grid; //can also env.provide(...) in here
	}
})();
which is pretty similar to:
oasis.define(
	"oasis.grid.Grid",
	["Component"],
	function(env){
		var Component = env.Component;
		var Grid = function(){
		}
		return Grid; //can also env.provide(...) in here
	}
);
and that calls:
oasis.using(
	["Component"],
	fn
);
//uber-verbose:
oasis.define({
	name 		: "oasis.grid.Grid",
	version 	: "1.2",
	requires 	: ["Ext.ui.Component"],
	module 		: function(env){
		var Component = env.Ext.ui.Component;
		var Grid = function(){
		}
		return Grid; //can also env.provide(...) in here
	}
});
hmmm....
oasis.define({
	name 	: "Ext",
	version : "2.2",
	paths : ["/js/lib/ext-2.2/ext-all-debug.js", "/js/lib/ext-2.2/adapters/ext-core.js"],
	key : "Ext"
}

//maybe we can default the name to be provided by the loader...it'd be implied by the initial 
//"requires" or "using" that triggered the loader to do the loading
//but then pack/compress wouldn't know wtf to do...ah well...looks good though.
oasis.define({
	requires 	: ["Ext.ui.Component"],
	module 		: function(env){
		var Component = env.Ext.ui.Component;
		var Grid = function(){
		}
		return Grid; //can also env.provide(...) in here
	}
});
//so a defaulted module with no deps:
oasis.define({
	module 		: function(env){
		var Grid = function(){
		}
		return Grid; //can also env.provide(...) in here
	}
});

module as standard?
module(
	"oasis.grid.Grid",
	["Component"],
	function(env){
		var Component = env.Component;
		var Grid = function(){
		}
		return Grid; //can also env.provide(...) in here
	}
);
and/or
module({
	name 		: "oasis.grid.Grid",
	requires 	: ["Ext.ui.Component"],
	module 		: function(env){
		var Component = env.Ext.ui.Component;
		var Grid = function(){
		}
		return Grid; //can also env.provide(...) in here
	}
});

----
<link rel="oasis-lib" href="/js/oasis-lib.json"/>

 {
	"Ext" : ["js/lib/ext-2.2/ext-all-debug.js", "js/lib/ext-2.2/adapters/ext-core.js"],
	"YAHOO" : {
		"path" : "js/lib/YAHOO/v3.0"
		"core" : "YAHOO.js"
	},
	"oasis" : {
		"path" : "js/lib/oasis",
		"core" : "oasis.js"
	},
	"jQuery" : [
		{
			"version" : "1.1",
			"core" : "js/lib/jQuery-1.1/jQuery.js",
			"sandbox" : true
		},
		{
			"version" : "1.5",
			"core" : "js/lib/jQuery-1.5/jQuery.js",
			"sandbox" : true
		}
	],
	"*" : {
		"path" : "js"
	}

}

<meta name="page-controller" content="thebooks.pages.Login"/>
<meta name="modules-base" content="js"/>
<script type="text/javascript" src="js/oasis/oasis.js"></script>
