<html>
    <head>
        <title>TheBooks: Login</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<h1>Please Login</h1>
		<g:form controller="user" action="login" method="post">
			<label><span>Email:</span><input id="email" name="email" type="text" value="${params.email}"></label>
			<label><span>Password:</span><input id="password" name="password" type="password"></label>
			<input id="login" type="submit" value="Login"/>
		</g:form>
		Not a user?  <g:link action="register">Register</g:link>.
	</body>
</html>