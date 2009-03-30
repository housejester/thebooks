env.using(["oasis.test.Test", "oasis.test.Mock"],function(dep){
	var Test = dep.oasis.test.Test;
	Test.create({
		name:"Calling define",
		worlds : {
			"Foo" : function(){
				return {};
			}
		},
		scenario : function(world){
			var oasis = world.oasis;
			env.addType({
				name : "funky",
				dependencies : ["foo", "bar"],
				module : function(dep){
					
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
