<ol class="breadcrumb">
  <li>Charts</li>
  <li class="active">Region Chart</li>
</ol>

<script type="text/javascript" src="FusionCharts/FusionCharts.js"></script>
<script type="text/javascript" src="FusionCharts/FusionChartsExportComponent.js"></script>

<cfset start = Year(Now())+3>
<cfset rc.regionchartquerystring = getPlugin("SessionStorage").setVar("regionchartquerystring",CGI.QUERY_STRING)>

<div class="row">
	<div class="col-md-12">

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-filter fa-fw"></i> Apply Filters
				<div class="pull-right">
					<a href="<cfoutput>#event.buildLink("reports/filteredchartbyregion")#</cfoutput>" class="btn btn-default btn-xs">Clear Filters</a>
				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">

			<form>

		<select id="program" name="program" multiple="true" style="visibility: hidden;">
			<cfloop query="rc.programs">
        	<cfoutput><option value="#name#" <cfif listfind(rc.program,rc.programs.name)>selected</cfif>>#name#</option></cfoutput>
			</cfloop>
        </select>

		<select id="themeID" name="themeID" multiple="true" style="visibility: visible;">
												<cfoutput query="rc.themes">
													<option value="#categoryID#" <cfif listfind(rc.themeID,rc.themes.categoryID)>selected</cfif>>#name#</option>
												</cfoutput>
									</select>

		<select id="fy" name="fy" multiple="true" style="visibility: hidden;">
			<cfloop from="#start#" to="#start-10#" step="-1" index="thisyear">
        	<cfoutput><option <cfif listfind(rc.fy,thisyear)>selected</cfif>>#thisYear#</option></cfoutput>
			</cfloop>
        </select>

		<!--- <select name="statusID">
			<option value="" <cfif (rc.ActivityStatuses.categoryID EQ 0)>selected</cfif>>Status (all active)</option>
				<cfloop query="rc.ActivityStatuses">
					<cfoutput><option value="#categoryID#" <cfif (rc.ActivityStatuses.categoryID EQ rc.statusID)>selected</cfif>>#name#</option></cfoutput>
				</cfloop>
			</select> --->

		<select name="charttype" id="charttype" style="visibility: hidden;">
			<option value="bar" <cfif rc.charttype is "bar"> selected</cfif>>Bar Chart</option>
			<option value="pie" <cfif rc.charttype is "pie"> selected</cfif>>Pie Chart</option>
		</select>
		<button type="submit" class="btn btn-primary btn-sm" name="submit" value="Go"><i class="icon-filter icon-white"></i> Go</button>
		</form>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> Region Chart <span class="text-muted"> (click on chart to access region profiles)</span>
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body" id="chartcontainer">

	<cfif rc.charttype is "pie">
		<cfset chartFile = "Pie3D.swf">
	<cfelse>
		<cfset chartFile = "Column3D.swf">
	</cfif>
	<cfif cgi.SERVER_NAME is '127.0.0.1'>
		<cfset pathString = "/ct-pams/FusionCharts/">
	<cfelse>
		<cfset pathString = "/FusionCharts/">
	</cfif>

	<div id="chartdiv" align="center">
        Chart
	</div>
	<div id="fcexpDiv" align="center">FusionCharts Export Handler Component</div>

	</div>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

</div>

	<script language="JavaScript">
			var chartWidth = $('#chartcontainer').width() -40;
			var chartHeight = 640;
			//FusionCharts.setCurrentRenderer('javascript');
			var myChart = new FusionCharts("<cfoutput>#pathString##chartfile#</cfoutput>","myChartId", chartWidth, chartHeight, "0", "1" );
			myChart.setXMLUrl("<cfoutput>#event.buildLink(URLEncodedFormat('reports/filteredchartbyregionxml?fy=#rc.fy#&program=#rc.program#&statusID=#rc.statusID#&themeID=#rc.themeID#'))#</cfoutput>");
			myChart.render("chartdiv");
			var myExportComponent = new FusionChartsExportObject("fcExporter1", "FusionCharts/FCExporter.swf");
			myExportComponent.Render("fcexpDiv");

			$(document).ready(function() {

	 $('#program').multiselect({
    	buttonWidth: '200px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Program (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Program: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

     $('#themeID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Theme (all) <b class="caret"></b>';
        }
        else if (options.length > 1) {
          return 'Theme: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

	 $('#fy').multiselect({
    	buttonWidth: '200px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Fiscal Year (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Fiscal Year: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

			    $('#charttype').multiselect({
			    	buttonWidth: '200px',
			    });
		    });



	</script>