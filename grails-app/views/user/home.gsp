<html>
    <head>
        <title>TheBooks:  User Home</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<div id="container" class="user-home">
			<h1>Great, you're in.  Here is what we have so far:</h1>
		    <ul>
		      <g:each var="c" in="${grailsApplication.controllerClasses}">
		            <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
		      </g:each>
		    </ul>
		</div>
		<g:link action="logout">Logout</g:link>
	</body>
</html>