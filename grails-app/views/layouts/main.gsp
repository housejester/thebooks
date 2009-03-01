<html>
    <head>
        <title><g:layoutTitle default="TheBooks" /></title>
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'thebooks.css')}" />
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
    </head>
    <body>
		<div id="container">
	        <div id="spinner" class="spinner" style="display:none;">
	            <img src="${createLinkTo(dir:'images',file:'spinner.gif')}" alt="Spinner" />
	        </div>	
	        <div class="logo"><img src="${createLinkTo(dir:'images',file:'thebooks_logo2.jpg')}" alt="TheBooks" /></div>	
			<g:if test="${session.user}">
				<div id="nav" class="links">
					<ul>
						<li><g:link controller="user" action="logout">Logout</g:link></li>
					</ul>
				</div>
			</g:if>
			
	        <g:layoutBody />		
		</div>
    </body>	
</html>