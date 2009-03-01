<html>
    <head>
        <title>TheBooks:  User Home</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<div id="body" class="user-home">
			<h1>Your latest cash-burn:</h1>
			<div id="grid">
				...show the grid...
			</div>
			<g:link action="logout">Logout</g:link>
		
			<h1>(Developers) Here is what we have so far:</h1>
		    <ul>
		      <g:each var="c" in="${grailsApplication.controllerClasses}">
		            <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
		      </g:each>
		    </ul>
		</div>
	</body>
</html>