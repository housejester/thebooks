
<%@ page import="com.thebooks.domain.Transaction" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="grails" />
        <title>Transaction List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Transaction</g:link></span>
        </div>
        <div class="body">
            <h1>Transaction List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="clearDate" title="Clear Date" />
                        
                   	        <g:sortableColumn property="description" title="Description" />
                        
                   	        <g:sortableColumn property="category" title="Category" />
                        
                   	        <g:sortableColumn property="commerceAmount" title="Commerce Amount" />
                        
                   	        <g:sortableColumn property="commerceBalance" title="Commerce Balance" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${transactionInstanceList}" status="i" var="transactionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${transactionInstance.id}">${fieldValue(bean:transactionInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:transactionInstance, field:'clearDate')}</td>
                        
                            <td>${fieldValue(bean:transactionInstance, field:'description')}</td>
                        
                            <td>${fieldValue(bean:transactionInstance, field:'category')}</td>
                        
                            <td>${fieldValue(bean:transactionInstance, field:'commerceAmount')}</td>
                        
                            <td>${fieldValue(bean:transactionInstance, field:'commerceBalance')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${Transaction.count()}" />
            </div>
        </div>
    </body>
</html>
