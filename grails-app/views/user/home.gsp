<html>
    <head>
        <title>TheBooks:  User Home</title>
		<meta name="layout" content="main" />
       	<g:javascript library="home" />
        <g:javascript library="prototype/prototype" />
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
		<h1>Cash-Burn for <g:formatDate format="${rangePattern}" date="${rangeStart}" />
        (today is <g:formatDate format="MMMM dd, yyyy" date="${new Date()}" />)</h1>

    <g:if test="${pastUnreconciledCount > 0}">
      <div class="warning">
        Warning!  There are ${pastUnreconciledCount} things that haven't cleared that prolly should have.
      </div>
    </g:if>
    <div class="nextPrev">
      <a class="prev" href="/thebooks/user/home/${lastMonth.format("yyyy/MMM")}">&laquo;${lastMonth.format("MMMM")}</a>
      <a class="next" href="/thebooks/user/home/${nextMonth.format("yyyy/MMM")}">${nextMonth.format("MMMM")}&raquo;</a>
    </div>
    <form action="/thebooks/user/addTransaction" name="addTransaction" method="POST">

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
              <tr class="odd add-tx">
                <input name="reconciled" value="false" type="hidden"/>
                <input name="paid" value="false" type="hidden"/>
                <g:set var="today"><g:formatDate format="MMM dd" date="${new Date()}"/></g:set>
                <td class="date input"><input name="clearDate" value="${today}"/></td>
                <td class="stacked input">
                    <div class="top description"><input name="description"/></div>
                    <div class="bottom">
                      <input name="category"/>
                    </div>
                </td>
                <td class="sep amt input"><input name="commerceAmount" onkeypress="return submitFormOnEnter(this, event);"/></td>
                <td class="amt ${ lastReconciled.commerceBalance < 0 ? 'neg' : 'pos'}">
                  <g:formatNumber format="#,###,###.00" number="${lastReconciled.commerceBalance/100}" />
                </td>
                <td class="sep amt input"><input name="usbankAmount" onkeypress="return submitFormOnEnter(this, event);"/></td>
                <td class="amt ${ lastReconciled.usbankBalance < 0 ? 'neg' : 'pos'}">
                  <g:formatNumber format="#,###,###.00" number="${lastReconciled.usbankBalance/100}" />
                </td>
                <td class="sep amt ${ lastReconciled.balance < 0 ? 'neg' : 'pos'}">
                  <g:formatNumber format="#,###,###.00" number="${lastReconciled.balance/100}" />
                </td>
              </tr>
            <g:set var="firstFuture" value="true"/>
            <g:each in="${transactions}" var="tx" status="i">
              <g:set var="futureCls" value="past"/>
              <g:if test="${tx.clearDate.after(new Date())}">
                <g:set var="futureCls" value="future"/>
                <g:if test="${firstFuture == 'true'}">
                  <g:set var="futureCls" value="future first-future"/>
                  <g:set var="firstFuture" value="false"/>
                </g:if>
              </g:if>
              <tr class="${ (i % 2) == 0 ? 'even' : 'odd'} ${ tx.reconciled ? 'reconciled' : 'pending'}  ${ tx.paid ? 'paid' : 'unpaid'} ${futureCls}" >
                <td class="date" onclick="onDateClicked(this.parentNode, event, ${tx.id}, ${tx.version});" ondblclick="reconcile(this.parentNode, ${tx.id}, ${tx.reconciled});"><g:formatDate format="MMM dd" date="${tx.clearDate}" /></td>
                <td class="stacked" ondblclick="markPaid(this.parentNode, ${tx.id}, ${tx.paid});">
                    <div class="top description"><a href="#">${tx.description}</a></div>
                    <div class="bottom">
                      <g:if test="${tx.category}">
                        [<a href="#">${tx.category}</a>]
                      </g:if>
                    </div>
                </td>
                <td class="sep amt ${ tx.commerceAmount < 0 ? 'neg' : 'pos'}">
                  <g:if test="${tx.commerceAmount != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.commerceAmount/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>
                <td class="amt ${ tx.commerceBalance < 0 ? 'neg' : 'pos'}">
                  <g:if test="${tx.commerceBalance != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.commerceBalance/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>
                <td class="sep amt ${ tx.usbankAmount < 0 ? 'neg' : 'pos'}">
                  <g:if test="${tx.usbankAmount != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.usbankAmount/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>
                <td class="amt ${ tx.usbankBalance < 0 ? 'neg' : 'pos'}">
                  <g:if test="${tx.usbankBalance != 0}">
                    <g:formatNumber format="#,###,###.00" number="${tx.usbankBalance/100}" />
                  </g:if>
                  <g:else>
                    &nbsp;
                  </g:else>
                </td>
                <td class="sep amt ${ tx.balance < 0 ? 'neg' : 'pos'}">
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
    </form>
    <div class="nextPrev">
      <a class="prev" href="/thebooks/user/home/${lastMonth.format("yyyy/MMM")}">&laquo;${lastMonth.format("MMMM")}</a>
      <a class="next" href="/thebooks/user/home/${nextMonth.format("yyyy/MMM")}">${nextMonth.format("MMMM")}&raquo;</a>
    </div>
    
    <g:formRemote id="reconcileForm" name="reconcileForm" method="POST" url="[ controller: 'user', action: 'reconcile']">
      <input name="txId" type="hidden" />
      <input name="reconciled" type="hidden" />
    </g:formRemote>
    <g:formRemote id="paidForm" name="paidForm" method="POST" url="[ controller: 'user', action: 'markPaid']">
      <input name="txId" type="hidden" />
      <input name="paid" type="hidden" />
    </g:formRemote>
    <form action="/thebooks/user/updateTransaction" name="updateTransaction" id="updateTransaction" method="POST">
      <input name="id" type="hidden"/>
      <input name="version" type="hidden"/>
      <input name="reconciled" value="false" type="hidden"/>
      <input name="paid" value="false" type="hidden"/>
      <input name="clearDate" type="hidden"/>
        <input name="description" type="hidden"/>
        <input name="category" type="hidden"/>
        <input name="commerceAmount" type="hidden" value="0"/>
        <input name="usbankAmount" type="hidden" value="0"/>
    </form>

	</body>
</html>