Modules.using(["oasis.test.Test", "oasis.test.Mock"],function(env){
	var Test = env.oasis.test.Test;
	Test.create({
		name:"Calling define",
		worlds : {
			"Foo" : function(){
				return {};
			}
		},
		scenario : function(world){
			var oasis = world.oasis;
			oasis.define({
				name : "funky",
				dependencies : ["foo", "bar"],
				module : function(env){
					
				}
			})
		},
		beforeAll : function(world){
			
		},
		beforeEach : function(world){
			
		},
		specs: {
			"should add module to module list" : function(world){
				
			},
			"should not immediately call the module function" : function(){
				
			}
		}
	})
})
