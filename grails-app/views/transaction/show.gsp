
<%@ page import="com.thebooks.domain.Transaction" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="grails" />
        <title>Show Transaction</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Transaction List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Transaction</g:link></span>
        </div>
        <div class="body">
            <h1>Show Transaction</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Clear Date:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'clearDate')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Description:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'description')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Category:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'category')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Commerce Amount:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'commerceAmount')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Commerce Balance:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'commerceBalance')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Usbank Amount:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'usbankAmount')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Usbank Balance:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'usbankBalance')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Balance:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:transactionInstance, field:'balance')}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${transactionInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
