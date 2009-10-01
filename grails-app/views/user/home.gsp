<html>
    <head>
        <title>TheBooks:  User Home</title>
		<meta name="layout" content="main" />
       	<g:javascript library="home" />		
		<link id="cash-burn-data-uri" rel="json" href="/thebooks/user/101010/burn-down.json">
		<script type="text/json" id="cash-burn-data">
			{
				"total" : 3,
				"items" : [
					{
						"date" : "2009-03-18",
						"description" : "Costco",
						"tags" : [ "food" ],
						"amount" : -21340,
						"account" : "/accounts/010142"
					},
					{
						"date" : "2009-03-16",
						"description" : "His Paycheck",
						"tags" : [ "pay",'his' ],
						"amount" : 192139,
						"account" : "/accounts/010142" 
					},
					{
						"date" : "2009-03-01",
						"description" : "Rent",
						"tags" : [ "bill", "housing" ],
						"amount" : -125000,
						"account" : "/accounts/010122" 
					}
				]
			}
		</script>
    </head>
    <body>
		<h1>Cash-Burn for March (today is March 19, 2009) ${transactions.size()}</h1>

		<table id="cash-burn" class="grid">
			<thead>
				<tr class="head1">
					<th colspan="2">
						&nbsp;
					</th>
					<th class="sep" colspan="2">
						His Checking
					</th>
					<th class="sep" colspan="2">
						Her Checking
					</th>
                    <th class="sep">
                        Combined
                    </th>
				</tr>
				<tr>
					<th>Date</th>
					<th>Description/Tags</th>
					<th class="sep amt">Amount</th>
					<th class="amt">Balance</th>
					<th class="sep amt">Amount</th>
					<th class="amt">Balance</th>
                    <th class="sep amt">Balance</th>
				</tr>
			</thead>
			<tbody>
            <g:each in="${transactions}" var="tx" status="i">
              <tr class="${ (i % 2) == 0 ? 'even' : 'odd'} reconciled">
                <td class="date"><g:formatDate format="MMM dd" date="${tx.clearDate}" /></td>
                <td class="stacked">
                    <div class="top description"><a href="#">${tx.description}</a></div>
                    <div class="bottom">
                      <g:if test="${tx.category}">
                        [<a href="#">${tx.category}</a>]
                      </g:if>
                    </div>
                </td>

                <g:if test="${tx.commerceAmount < 0}">
                  <g:set var="amtCls" value="neg"/>
                </g:if>
                <g:else>
                  <g:set var="amtCls" value="pos"/>
                </g:else>
                <td class="sep amt ${amtCls}">
                  <g:if test="${tx.commerceAmount != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.commerceAmount/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>

                <g:if test="${tx.commerceBalance < 0}">
                  <g:set var="amtCls" value="neg"/>
                </g:if>
                <g:else>
                  <g:set var="amtCls" value="pos"/>
                </g:else>
                <td class="amt ${amtCls}">
                  <g:if test="${tx.commerceBalance != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.commerceBalance/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>

                <g:if test="${tx.usbankAmount < 0}">
                  <g:set var="amtCls" value="neg"/>
                </g:if>
                <g:else>
                  <g:set var="amtCls" value="pos"/>
                </g:else>
                <td class="sep amt ${amtCls}">
                  <g:if test="${tx.usbankAmount != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.usbankAmount/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>

                <g:if test="${tx.usbankBalance < 0}">
                  <g:set var="amtCls" value="neg"/>
                </g:if>
                <g:else>
                  <g:set var="amtCls" value="pos"/>
                </g:else>
                <td class="amt ${amtCls}">
                  <g:if test="${tx.usbankBalance != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.usbankBalance/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>

                <g:if test="${tx.balance < 0}">
                  <g:set var="amtCls" value="neg"/>
                </g:if>
                <g:else>
                  <g:set var="amtCls" value="pos"/>
                </g:else>
                <td class="sep amt ${amtCls}">
                  <g:if test="${tx.balance != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.balance/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>
            </tr>
            </g:each>
			</tbody>
		</table>
		
	</body>
</html>