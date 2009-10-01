
<%@ page import="com.thebooks.domain.Transaction" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="grails" />
        <title>Create Transaction</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Transaction List</g:link></span>
        </div>
        <div class="body">
            <h1>Create Transaction</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${transactionInstance}">
            <div class="errors">
                <g:renderErrors bean="${transactionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="clearDate">Clear Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'clearDate','errors')}">
                                    <g:datePicker name="clearDate" value="${transactionInstance?.clearDate}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">Description:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'description','errors')}">
                                    <input type="text" id="description" name="description" value="${fieldValue(bean:transactionInstance,field:'description')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category">Category:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'category','errors')}">
                                    <input type="text" id="category" name="category" value="${fieldValue(bean:transactionInstance,field:'category')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="commerceAmount">Commerce Amount:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'commerceAmount','errors')}">
                                    <input type="text" id="commerceAmount" name="commerceAmount" value="${fieldValue(bean:transactionInstance,field:'commerceAmount')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="commerceBalance">Commerce Balance:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'commerceBalance','errors')}">
                                    <input type="text" id="commerceBalance" name="commerceBalance" value="${fieldValue(bean:transactionInstance,field:'commerceBalance')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="usbankAmount">Usbank Amount:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'usbankAmount','errors')}">
                                    <input type="text" id="usbankAmount" name="usbankAmount" value="${fieldValue(bean:transactionInstance,field:'usbankAmount')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="usbankBalance">Usbank Balance:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'usbankBalance','errors')}">
                                    <input type="text" id="usbankBalance" name="usbankBalance" value="${fieldValue(bean:transactionInstance,field:'usbankBalance')}" />
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="balance">Balance:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:transactionInstance,field:'balance','errors')}">
                                    <input type="text" id="balance" name="balance" value="${fieldValue(bean:transactionInstance,field:'balance')}" />
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
