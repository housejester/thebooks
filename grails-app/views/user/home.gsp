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
		<g:if test="${session.user.setupComplete}">
			<div id="grid">
				...show the grid...
			</div>
		</g:if>
		<g:else>
			<div id="tell-us-more">
				<div>
					<p>
						Normally, you'd see the cash burn log here, but we don't know enough about you yet.  So, how about starting
						with what accounts you pay your bills from.  Don't worry, we won't be getting account numbers or any identifying
						information...that's scary shit.  We just what raw numbers so we can help you see where things are pretty easily.
					</p>
					<g:form controller="user" action="accountList" method="get">
						<input type="submit" value="Sure"/>
					</g:form>
				</div>
				<div>
					<p>
						Or, I guess you can just jump right in and be a pocket-cash only dude.  You can always tell us more info when 
						you eventually remember it ;)
						<g:form controller="user" action="letMeIn" method="post">
							<input type="submit" value="Just let me in!"/>
						</g:form>
					</p>
				</div>
			</div>
		</g:else>
		
			<g:link action="logout">Logout</g:link>
		</div>
	</body>
</html>