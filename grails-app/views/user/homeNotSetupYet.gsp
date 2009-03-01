<html>
    <head>
        <title>TheBooks:  User Home</title>
		<meta name="layout" content="main" />
    </head>
    <body>
		<div id="body" class="user-home">
			<h1>Great, you're in! Now what?</h1>
			<div class="messages">
				<div class="message">
					<p>
						Normally, you'd see the cash burn log here, but we don't know enough about you yet.  So, how about starting
						with what accounts you pay your bills from.  Don't worry, we won't be getting account numbers or any identifying
						information...that's scary shit.  We just what raw numbers so we can help you see where things are pretty easily.
					</p>
					<g:form controller="user" action="accountList" method="get">
						<input type="submit" value="Sure"/>
					</g:form>
				</div>
				<div class="message">
					<p>
						Or, I guess you can just jump right in and be a pocket-cash only dude.  You can always tell us more info when 
						you eventually remember it ;)
					</p>
					<g:form controller="user" action="letMeIn" method="post">
						<input type="submit" value="Just let me in!"/>
					</g:form>
				</div>
			</div>
		</div>
	</body>
</html>