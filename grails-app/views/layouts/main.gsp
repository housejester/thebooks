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
				<div id="nav">
					<ul class="in-line">
						<li><g:link controller="user" action="logout">Logout</g:link></li>
					</ul>
				</div>
			</g:if>
			
	        <g:layoutBody />

			<g:if test="${session.user && session.user.developer}">
				<h1>(Developers) Here is what we have so far:</h1>
			    <ul>
			      <g:each var="c" in="${grailsApplication.controllerClasses}">
			            <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
			      </g:each>
			    </ul>
			</g:if>
		</div>
    </body>	
</html>