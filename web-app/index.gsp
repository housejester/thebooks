<html>
    <head>
        <title>TheBooks</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<div id="container" class="welcome">
        	<h1>The Books:  We help you keep 'em straight.</h1>
        	<p>
				The Books help you to plan your finances...kind of a home-budget app.  The aim is to help you
				plan your finances proactively, rather than reactively.  It allows you to look ahead 
				into next month and see when things might be getting tight, or just make it easier to
				see which checking account a bill should be paid from.  It will also help you see which
				credit card needs attention first and visually see your debt "burn down" chart. 
			</p>
	        <div class="dialog">
	            <ul>
	              <g:each var="c" in="${grailsApplication.controllerClasses}">
	                    <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
	              </g:each>
	            </ul>
	        </div>
		</div>
    </body>
</html>