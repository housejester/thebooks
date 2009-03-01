<html>
    <head>
        <title>TheBooks: Register</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<h1>Sweet, Sweet, Registration</h1>
		<g:form controller="user" action="register" method="post">
			<g:hasErrors bean="${user}">
				<div class="errors">
					<g:renderErrors bean="${user}" />
				</div>
			</g:hasErrors>
			<label><span>Email:</span><input id="email" name="email" type="text" value="${params.email}"></label>
			<label><span>Password:</span><input id="password" name="password" type="password"></label>
			<label><span>Confirm Password:</span><input id="confirm_password" name="confirm_password" type="password"></label>
			<input id="register" type="submit" value="Register"/>
		</g:form>
		Change your mind? <g:link action="home">Register Later</g:link>.
	</body>
</html>