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
		<h1>Cash-Burn for March (today is March 19, 2009)</h1>
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
				</tr>
				<tr>
					<th>Date</th>
					<th>Description/Tags</th>
					<th class="sep amt">Amount</th>
					<th class="amt">Balance</th>
					<th class="sep amt">Amount</th>
					<th class="amt">Balance</th>
				</tr>
			</thead>
			<tbody>
				<tr class="even">
					<td class="date">Mar 01</td>
					<td class="stacked"><a href="#">Carry-Over Balance</a></td>
					<td class="sep amt">&nbsp;</td>
					<td class="amt pos">1,332.31</td>
					<td class="sep amt pos">&nbsp;</td>
					<td class="amt pos">12.11</td>
				</tr>
				<tr class="odd reconciled">
					<td class="date">Mar 01</td>
					<td class="stacked">
						<div class="top description"><a href="#">Rent</a></div>
						<div class="bottom">[<a href="#">bill</a>, <a href="#">housing</a>]</div>
					</td>
					<td class="sep amt neg">1,250.00</td>
					<td class="amt pos">82.31</td>
					<td class="sep amt pos">&nbsp;</td>
					<td class="amt pos">12.11</td>
				</tr>
				<tr class="even reconciled">
					<td class="date">Mar 14</td>
					<td class="stacked">
						<div class="top description"><a href="#">Taco Bell</a></div>
						<div class="bottom">[<a href="#">restaurant</a>, <a href="#">hers</a>, <a href="#">fun fund</a>]</div>
					</td>
					<td class="sep amt pos">&nbsp;</td>
					<td class="amt pos">82.31</td>
					<td class="sep amt neg">7.47</td>
					<td class="amt pos">4.62</td>
				</tr>
				<tr class="odd">
					<td class="date">Mar 16</td>
					<td class="stacked">
						<div class="top description"><a href="#">His Paycheck</a></div>
						<div class="bottom">[<a href="#">pay</a>, <a href="#">his</a>]</div>
					</td>
					<td class="sep amt pos">1,921.39</td>
					<td class="amt pos">2,003.70</td>
					<td class="sep amt pos">&nbsp;</td>
					<td class="amt pos">4.62</td>
				</tr>
				<tr class="even">
					<td class="date">Mar 18</td>
					<td class="stacked">
						<div class="top description"><a href="#">Costco</a></div>
						<div class="bottom">[<a href="#">food</a>]</div>
					</td>
					<td class="sep amt neg">213.40</td>
					<td class="amt pos">1,790.30</td>
					<td class="sep amt pos">&nbsp;</td>
					<td class="amt pos">4.62</td>
				</tr>
				<tr class="odd next-scheduled">
					<td class="date">Mar 19</td>
					<td class="stacked">
						<div class="top description"><a href="#">Her Paycheck</a></div>
						<div class="bottom">[<a href="#">pay</a>,<a href="#">hers</a>]</div>
					</td>
					<td class="sep amt">&nbsp;</td>
					<td class="amt pos">1,790.30</td>
					<td class="sep amt pos">1,501.27</td>
					<td class="amt pos">1,505.89</td>
				</tr>
				<tr class="even future">
					<td class="date">Mar 22</td>
					<td class="stacked">
						<div class="top description"><a href="#">Comcast</a></div>
						<div class="bottom">[<a href="#">bill</a>,<a href="#">utility</a>]</div>
					</td>
					<td class="sep amt">&nbsp;</td>
					<td class="amt pos">1,790.30</td>
					<td class="sep amt neg">38.81</td>
					<td class="amt pos">1,467.08</td>
				</tr>
				<tr class="odd future">
					<td class="date">Mar 23</td>
					<td class="stacked">
						<div class="top description"><a href="#">T-Mobile</a></div>
						<div class="bottom">[<a href="#">bill</a>,<a href="#">utility</a>]</div>
					</td>
					<td class="sep amt">&nbsp;</td>
					<td class="amt pos">1,790.30</td>
					<td class="sep amt neg">68.32</td>
					<td class="amt pos">1,398.76</td>
				</tr>
				<tr class="even future">
					<td class="date">Mar 23</td>
					<td class="stacked">
						<div class="top description"><a href="#">Chase</a></div>
						<div class="bottom">[<a href="#">bill</a>,<a href="#">credit</a>]</div>
					</td>
					<td class="sep amt neg">150.00</td>
					<td class="amt pos">1,640.30</td>
					<td class="sep amt">&nbsp;</td>
					<td class="amt pos">1,398.76</td>
				</tr>
			</tbody>
		</table>
		
	</body>
</html>