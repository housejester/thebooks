<html>
    <head>
        <title>TheBooks</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<div id="body" class="welcome">
        	<h1>The Books:  We help you keep 'em straight.</h1>
        	<p>
				The Books help you to plan your finances...kind of a home-budget app.  The aim is to help you
				plan your finances proactively, rather than reactively.  It allows you to look ahead 
				into next month and see when things might be getting tight, or just make it easier to
				see which checking account a bill should be paid from.  It will also help you see which
				credit card needs attention first and visually see your debt "burn down" chart. 
			</p>
			
			<g:if test="${session.user}">
		        <div class="dialog">
					<h1>Great, you're in.  Lets hit <g:link controller="user" action="home">the books</g:link>!</h1>
		        </div>
			</g:if>
			<g:else>
				<div id="login-box">
					<h1>Let's Get Started</h1>
					<g:form controller="user" action="login" method="post">
						<label><span>Email:</span><input id="email" name="email" type="text" value="${user?.email}"></label>
						<label><span>Password:</span><input id="password" name="password" type="password"></label>
						<input id="login" type="submit" value="Login"/>
					</g:form>
				</div>
			</g:else>
		</div>
    </body>
</html>