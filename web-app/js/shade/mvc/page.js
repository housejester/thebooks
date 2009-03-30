env.on('env.domready', function(){
	var meta = document.getElementsByName('shade.mvc:Page');
	if(meta.length > 0){
		var name = meta[0].content;
		env.using([name], function(dep){
			new dep[name]();
		})
	}
});
