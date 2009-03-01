<html>
    <head>
        <title>TheBooks:  Account List</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<div id="body" class="user-accountList">
			<div class="errors">
				<ul><li>
					Accounts not ready yet...go with the "just let me in!" option for now ;)
				</li></ul>
				<g:form controller="user" action="letMeIn" method="post">
					<input type="submit" value="Just let me in!"/>
				</g:form>
			</div>
		</div>
	</body>
</html>
