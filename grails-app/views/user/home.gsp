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
						"account" : { "$ref" : "/accounts/010142" }
					},
					{
						"date" : "2009-03-16",
						"description" : "His Paycheck",
						"tags" : [ "pay",'his' ],
						"amount" : 192139,
						"account" : { "$ref" : "/accounts/010142" }
					},
					{
						"date" : "2009-03-01",
						"description" : "Rent",
						"tags" : [ "bill", "housing" ],
						"amount" : -125000,
						"account" : { "$ref" : "/accounts/010122" }
					}
				]
			}
		</script>
    </head>
    <body>
		<h1>Cash-Burn for March</h1>
		<table id="cash-burn" class="grid">
			<colgroup span="2" class="tx-info"></colgroup>
			<colgroup class="account-info">
				<col></col>
				<col></col>
			</colgroup>
			<colgroup class="account-info">
				<col></col>
				<col></col>
			</colgroup>
			<thead>
				<tr>
					<th colspan="2">
						&nbsp;
					</th>
					<th colspan="2">
						His Checking
					</th>
					<th colspan="2">
						Her Checking
					</th>
				</tr>
				<tr>
					<th>Date</th>
					<th>Description/Tags</th>
					<th class="amt">Amount</th>
					<th class="amt">Balance</th>
					<th class="amt">Amount</th>
					<th class="amt">Balance</th>
				</tr>
			</thead>
			<tbody>
				<tr class="even">
					<td>Mar 01</td>
					<td class="stacked"><a href="#">Carry-Over Balance</a></td>
					<td class="amt">&nbsp;</td>
					<td class="amt pos">1,332.31</td>
					<td class="amt pos">&nbsp;</td>
					<td class="amt pos">12.11</td>
				</tr>
				<tr class="odd">
					<td>Mar 01</td>
					<td class="stacked">
						<div class="top"><a href="#">Rent</a></div>
						<div class="bottom">[<a href="#">bill</a>, <a href="#">housing</a>]</div>
					</td>
					<td class="amt neg">1,250.00</td>
					<td class="amt pos">82.31</td>
					<td class="amt pos">&nbsp;</td>
					<td class="amt pos">12.11</td>
				</tr>
				<tr class="even">
					<td>Mar 14</td>
					<td class="stacked">
						<div class="top"><a href="#">Taco Bell</a></div>
						<div class="bottom">[<a href="#">restaurant</a>, <a href="#">hers</a>, <a href="#">fun fund</a>]</div>
					</td>
					<td class="amt pos">&nbsp;</td>
					<td class="amt pos">82.31</td>
					<td class="amt neg">7.47</td>
					<td class="amt pos">4.62</td>
				</tr>
				<tr class="odd">
					<td>Mar 16</td>
					<td class="stacked">
						<div class="top"><a href="#">His Paycheck</a></div>
						<div class="bottom">[<a href="#">pay</a>, <a href="#">his</a>]</div>
					</td>
					<td class="amt pos">1,921.39</td>
					<td class="amt pos">2,003.70</td>
					<td class="amt pos">&nbsp;</td>
					<td class="amt pos">4.62</td>
				</tr>
				<tr class="even">
					<td>Mar 18</td>
					<td class="stacked">
						<div class="top"><a href="#">Costco</a></div>
						<div class="bottom">[<a href="#">food</a>]</div>
					</td>
					<td class="amt neg">213.40</td>
					<td class="amt pos">1,790.30</td>
					<td class="amt pos">&nbsp;</td>
					<td class="amt pos">4.62</td>
				</tr>
			</tbody>
		</table>
		
	</body>
</html>