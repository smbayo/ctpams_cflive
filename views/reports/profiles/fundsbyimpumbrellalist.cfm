<ol class="breadcrumb">
  <li>Charts</li>
  <li><cfoutput><a href="#event.buildLink("reports/filteredchartbyimplementer")#"></cfoutput>Implementer Chart</a></li>
<li class="active">Implementer Overview</li>
</ol>

<script type="text/javascript" src="FusionCharts/FusionCharts.js"></script>
<script type="text/javascript" src="FusionCharts/FusionChartsExportComponent.js"></script>

<div class="row">
	<div class="col-md-12">

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-filter fa-fw"></i> Apply Filters
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">

		<cfoutput>
		<form>

		<select id="program" name="program" multiple="true" style="visibility: hidden;">
			<cfloop query="rc.programs">
        	  <option value="#name#" <cfif listfind(rc.program,rc.programs.name)>selected</cfif>>#name#</option>
			</cfloop>

        </select>

		<select id="region" name="region" multiple="true" style="visibility: hidden;">
			<cfloop query="rc.regions">
        	  <option value="#name#" <cfif listfind(rc.region,rc.regions.name)>selected</cfif>>#name#</option>
			</cfloop>

        </select>

		<select id="umbrella" name="umbrella" style="visibility: hidden;">
			<cfloop query="rc.umbrellas">
        	  <option value="#name#" <cfif rc.umbrella is '#name#'>selected</cfif>>#name#</option>
			</cfloop>
        </select>

		<cfset start = Year(Now())+3>

		<select id="fy" name="fy" multiple="true" style="visibility: hidden;">
			<cfloop from="#start#" to="#start-10#" step="-1" index="thisyear">
        	<cfoutput><option <cfif listfind(rc.fy,thisyear)>selected</cfif>>#thisYear#</option></cfoutput>
			</cfloop>
        </select>

		<select name="statusID" id="status" style="visibility: hidden;">
			<option value="" <cfif (rc.ActivityStatuses.categoryID EQ 0)>selected</cfif>>Status (all active)</option>
				<cfloop query="rc.ActivityStatuses">
					<cfoutput><option value="#categoryID#" <cfif (rc.ActivityStatuses.categoryID EQ rc.statusID)>selected</cfif>>#name#</option></cfoutput>
				</cfloop>
			</select>
			&nbsp;


		<button type="submit" class="btn btn-primary btn-sm" name="submit" value="Go"><i class="icon-filter icon-white"></i> Go</button>
		</form>


		</cfoutput>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> <cfoutput>#rc.umbrella#</cfoutput> - Implementer Overview  <span class="text-muted"> (click on chart to access implementer profiles)</span>
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body" id="chartcontainer">



		<cfif structKeyExists(rc,"byImplementer")  AND rc.byImplementer.recordCount>

			<cfif cgi.SERVER_NAME is '127.0.0.1'>
				<cfset pathStringPie = "/ct-pams/FusionCharts/Pie3D.swf">
				<cfset pathStringCol = "/ct-pams/FusionCharts/Column3D.swf">
				<cfset expPath = "/ct-pams/FusionCharts/">
			<cfelse>
				<cfset pathStringPie = "/FusionCharts/Pie3D.swf">
				<cfset pathStringCol = "/FusionCharts/Column3D.swf">
				<cfset expPath = "/FusionCharts/">
			</cfif>

					<div    id="chartdiv"></div>
					<div id="fcexpDiv" align="center">FusionCharts Export Handler Component</div>
				</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>



			<script language="JavaScript">
			var chartWidth = $('#chartcontainer').width() -40;
			var chartHeight = 640;

					var myChart = new FusionCharts("<cfoutput>#pathStringCol#</cfoutput>","myChartId", chartWidth, chartHeight, "0", "1" );
					myChart.setXMLUrl("<cfoutput>#event.buildLink(URLEncodedFormat('reports/filteredchartbyimplementerxml?fy=#rc.fy#&program=#rc.program#&umbrella=#rc.umbrella#&region=#rc.region#&statusID=#rc.statusID#'))#</cfoutput>");
					myChart.render("chartdiv");



			</script>



			<script language="JavaScript">
					var myExportComponent = new FusionChartsExportObject("fcExporter1", "<cfoutput>#expPath#</cfoutput>FCExporter.swf");
					myExportComponent.Render("fcexpDiv");

			</script>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-eye fa-fw"></i> <cfoutput>#rc.umbrella#</cfoutput> - Projects
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">

					<table class="table table-striped table-hover" id="filteredreport">

						<thead>
							<tr>
								<th>ID</th>
								<th>Title</th>
								<th><span data-toggle="tooltip" title="Requested Amount">Total <i class="icon-question-sign"></i> </th>
								<th>Status</th>
								<th>Countries Engaged</th>
								<th>FY</th>


							</tr>
						</thead>

						<tbody>

							<!--- <cfoutput> --->
							<cfset reqTotal = 0>
							<cfoutput query="rc.byimplementer">
								<cfif budgetceilingamount gt 0>
									<cfset reqTotal = reqTotal + budgetceilingamount>
								</cfif>
							<tr>
								<td>
										<a href=#event.buildLink("proposal.review.activityID." & rc.byimplementer.ActivityID)# title="#proposalname#" data-toggle="tooltip" data-placement="right">#uCase(proposalNumber)#</a>

								</td>
								<td>
										<a href=#event.buildLink("proposal.review.activityID." & rc.byimplementer.ActivityID)# title="#proposalname#" data-toggle="tooltip" data-placement="right">#left(proposalname,50)#<cfif len(proposalname) gt 50>...</cfif></a>

								</td>

								<td>#dollarFormat(budgetceilingamount)#</td>
								<td>#activitystatus#</td>

								<td><Cfif ListLen(countries) gt 3><span data-toggle="tooltip" title="#countries#">#ListLen(countries)# Countries <i class="icon-list"></i></span><cfelse>#countries# </cfif></td>
								<td>#fy#</td>

							</tr>
						</cfoutput>
						<cfoutput>

						</cfoutput>
					</tbody>
					<!--- </cfoutput> --->
				</table>
				<div class="text-center"><b>Total Requested: <cfoutput>#dollarFormat(reqTotal)#</cfoutput></b></div>

			<cfelse>
				<!--- no records --->
				<h4>There are no records at this time.</h4>
			</cfif>
				</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

</div>
</div>

<script language="JavaScript">

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
     $('#umbrella').multiselect({
	    	buttonWidth: '200px',
	    });
	    $('#country').multiselect({
	    	buttonWidth: '200px',
	    });
	    $('#status').multiselect({
	    	buttonWidth: '200px',
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


    $('#region').multiselect({
    	buttonWidth: '200px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'DOS Region (all) <b class="caret"></b>';
        }
        else if (options.length > 2) {
          return 'DOS Region: ' +  options.length + ' selected  <b class="caret"></b>';
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



	});





</script>


