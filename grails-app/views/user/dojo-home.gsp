<html>
    <head>
        <title>TheBooks:  User Home</title>
		<meta name="layout" content="main" />
			<style type="text/css">
				@import "${createLinkTo(dir:'js/dojo-release-1.2.3/dijit/themes/tundra',file:'tundra.css')}";
				@import "${createLinkTo(dir:'js/dojo-release-1.2.3/dojox/grid/resources',file:'Grid.css')}";
				@import "${createLinkTo(dir:'js/dojo-release-1.2.3/dojox/grid/resources',file:'tundraGrid.css')}";
				@import "${createLinkTo(dir:'css/user',file:'dojo-home.css')}";
			</style>
			<script type="text/javascript" src="${createLinkTo(dir:'js/dojo-release-1.2.3/dojo',file:'dojo.js')}" djConfig="isDebug:true"></script>
			<script type="text/javascript">
				dojo.require("dojo.data.ItemFileReadStore");
				dojo.require("dojox.grid.DataGrid");

				var jsonStore = new dojo.data.ItemFileReadStore({ url: "${createLinkTo(dir:'json',file:'gaskets.json')}" });
		        var grid = null;

				dojo.addOnLoad(function(){
					var layout= [
						[
							{ field: "part_num", width: "auto", name: "Date", rowSpan:2},
							{ field: "min_temp", width: "100px", name: "Description", rowSpan:2},
							{ field: "max_temp", width: "100px", name: "Tags", rowSpan:2},
							{ width: "200px", name: "His Checking", colSpan:2 },
							{ width: "200px", name: "Her Checking", colSpan:2 }
						],
						[
							{ field: "type", width: "100px", name: "Amount" },
							{ field: "thick", width: "5em", name: "Balance" },
							{ field: "type", width: "100px", name: "Amount" },
							{ field: "thick", width: "5em", name: "Balance" }
						]
					];

					grid = new dojox.grid.DataGrid({
						query: { part_num: '*' },
						store: jsonStore,
						structure: layout,
						rowsPerPage: 20
					}, 'gridNode');
					grid.startup();
				});
			</script>
		</head>
		<body>
			<h1>Gasket Lookup</h1>
			<div class="partsContainer">
				<div class="gridContainer">
					<div id="gridNode"></div>
				</div>
			</div>
		</body>
</html>