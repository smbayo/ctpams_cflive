<cfif cgi.SERVER_NAME is '127.0.0.1'>
	<cfset pathString = "/ctprograms/FusionCharts/MSStackedColumn2D.swf">
<cfelse>
	<cfset pathString = "/FusionCharts/MSStackedColumn2D.swf">
</cfif> 

<h1>Funds by Region by Program by Fiscal Year</h1>

	<div id="chartdiv" align="center"> 
        Chart
	</div>
	<div id="fcexpDiv" align="center">FusionCharts Export Handler Component</div>
	
	<script language="JavaScript">					

			var myChart = new FusionCharts("<cfoutput>#pathString#</cfoutput>","myChartId", "960", "1200", "0", "1" ); 
			myChart.setXMLUrl("<cfoutput>#event.buildLink(URLEncodedFormat('reports/multistackedchartxml'))#</cfoutput>");
			myChart.render("chartdiv");
			var myExportComponent = new FusionChartsExportObject("fcExporter1", "FusionCharts/FCExporter.swf");  
			myExportComponent.Render("fcexpDiv");
			
			

	</script>