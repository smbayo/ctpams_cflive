<ol class="breadcrumb">
  <li>Charts</li>
  <li><cfoutput><a href="#event.buildLink("reports/filteredchartbyorg")#?#getPlugin('SessionStorage').getVar('orgchartquerystring')#"></cfoutput>Organization Chart</a></li>
<li class="active">Organization Profile</li>
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
			<cfif IsUserInRole("export reports")>
			<form action="<cfoutput>#event.buildLink('reports/fundsbyorglistword?fy=#rc.fy#&programname=#rc.program#&organization=#rc.organization#&statusID=#rc.statusID#&program=#rc.program#')#</cfoutput>" method="post">
			&nbsp; <button name="type" value="pdf" class="btn btn-xs btn-success">.pdf</button>
			<cfif IsUserInRole("export to word")>
			&nbsp; <button name="type" value="word" class="btn btn-xs btn-success" onClick="alert('REMINDER: Most newer versions of Microsoft Word will maintain a link to document images saved on the server, so you must be logged in to PAMS for exported images to be visible. You may choose to save images locally from Microsoft Word.')">Word</button>
			&nbsp; <span data-toggle="tooltip" title="You must be online and logged in to PAMS for generated chart images to appear in Word Export."><i class="icon-exclamation-sign"></i>
			</cfif>
			<input type="hidden" name="sortby" id="sortby" value="">
			</form>
			</cfif>
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
		<select id="organization" name="organization" style="visibility: hidden;">
			<cfloop query="rc.organizations">
        	  <option value="#name#" <cfif rc.organization is '#name#'>selected</cfif>>#name#</option>
			</cfloop>
        </select>
		<cfset start = Year(Now())+3>

		<select id="fy" name="fy" multiple="true" style="visibility: hidden;">
			<cfloop from="#start#" to="#start-10#" step="-1" index="thisyear">
        	<option <cfif listfind(rc.fy,thisyear)>selected</cfif>>#thisYear#</option>
			</cfloop>
        </select>

		<select name="statusID" id="status" style="visibility: hidden;">
			<option value="" <cfif (rc.ActivityStatuses.categoryID EQ 0)>selected</cfif>>Status (all active)</option>
				<cfloop query="rc.ActivityStatuses">
					<cfoutput><option value="#categoryID#" <cfif (rc.ActivityStatuses.categoryID EQ rc.statusID)>selected</cfif>>#name#</option></cfoutput>
				</cfloop>
			</select>

		<input type="hidden" name="origin" value="#rc.origin#">
		<input type="hidden" name="program" value="#rc.program#">

		<button type="submit" class="btn btn-primary btn-sm" name="submit" value="Go"><i class="icon-filter icon-white"></i> Go</button>
		</form>


		</cfoutput>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

		<cfif structKeyExists(rc,"byCountry")  AND rc.byCountry.recordCount>

			<cfif cgi.SERVER_NAME is '127.0.0.1'>
				<cfset pathStringPie = "/ct-pams/FusionCharts/Pie3D.swf">
				<cfset pathStringCol = "/ct-pams/FusionCharts/Column3D.swf">
				<cfset expPath = "/ct-pams/FusionCharts/">
			<cfelse>
				<cfset pathStringPie = "/FusionCharts/Pie3D.swf">
				<cfset pathStringCol = "/FusionCharts/Column3D.swf">
				<cfset expPath = "/FusionCharts/">
			</cfif>

<div class="row">
	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> <cfoutput>#rc.organization#</cfoutput> - Activity Expenditures
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
					<div    id="fydiv">
					</div>

				</div>
            <!-- /.panel-body -->
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-pie-chart fa-fw"></i> <cfoutput>#rc.organization#</cfoutput> - Program Budget Breakdown
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
					<div    id="programdiv">
					</div>
				</div>
            <!-- /.panel-body -->
		</div>
	</div>
	<div id="fcexpDiv" align="center">FusionCharts Export Handler Component</div>
</div>


			<script language="JavaScript">
				var chartWidth = $('#fydiv').width() -40;
				var chartHeight = 420;
					var myChart = new FusionCharts("<cfoutput>#pathStringPie#</cfoutput>","myChartId", chartWidth, chartHeight, "0", "1" );
					myChart.setXMLUrl("<cfoutput>#event.buildLink(URLEncodedFormat('reports/filteredorgchartxml?fy=#rc.fy#&organization=#rc.organization#&program=#rc.program#&statusID=#rc.statusID#'))#</cfoutput>");
					myChart.render("programdiv");

					var myChart2 = new FusionCharts("<cfoutput>#pathStringCol#</cfoutput>","myChartId", chartWidth, chartHeight, "0", "1" );
					myChart2.setXMLUrl("<cfoutput>#event.buildLink(URLEncodedFormat('reports/filteredorgexpenditurechartxml?fy=#rc.fy#&organization=#rc.organization#&program=#rc.program#&statusID=#rc.statusID#'))#</cfoutput>");
					myChart2.render("fydiv");

			</script>



			<script language="JavaScript">
					var myExportComponent = new FusionChartsExportObject("fcExporter1", "<cfoutput>#expPath#</cfoutput>FCExporter.swf");
					myExportComponent.Render("fcexpDiv");

			</script>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-eye fa-fw"></i> <cfoutput>#rc.organization#</cfoutput> - Projects
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">

					<table class="table table-striped table-hover"id="filteredreport">

						<thead>
							<tr>
								<th style="width:90px">ID</th>
								<th>Title</th>
								<th><span data-toggle="tooltip" title="Requested Amount">Total <i class="icon-question-sign"></i> </th>
								<th>Status</th>
								<th>Organization</th>
								<th><span data-toggle="tooltip" title="Estimated Funds for <cfoutput>#rc.organization#</cfoutput> specifically from project">Project <i class="icon-question-sign"></i> </th>
								<th style="width:40px">FY</th>

							</tr>
						</thead>

						<tbody>


							<cfset reqTotal = 0>
							<cfset budTotal = 0>
							<cfoutput query="rc.byCountry">
								<cfif budgetceilingamount gt 0>
									<cfset reqTotal = reqTotal + budgetceilingamount>
								</cfif>
								<cfif budgetamount gt 0>
									<cfset budTotal = budTotal + budgetamount>
								</cfif>
							<tr class="sectionReview first">
								<td>
										<a href=#event.buildLink("proposal.review.activityID." & rc.byCountry.ActivityID)# title="#name#" data-toggle="tooltip" data-placement="right">#uCase(proposalNumber)#</a>

								</td>
								<td>
										<a href=#event.buildLink("proposal.review.activityID." & rc.byCountry.ActivityID)# title="#name#" data-toggle="tooltip" data-placement="right">#name#</a>

								</td>

								<!--- <td align="left">#rc.byCountry.projectObjective#</td> --->
								<td>#dollarFormat(budgetceilingamount)#</td>
								<td>#activitystatus#</td>
								<!--- <td align="left">#budgetitem#</td> --->
								<td>#organization#</td>
								<td>#dollarFormat(budgetamount)#</td>
								<td>#fy#</td>

								<!--- <td align="left">&nbsp;</td> --->
							</tr>
						</cfoutput>
						<!--- <cfoutput>
						<tr>
							<td colspan="2"></td>
							<td><b>#dollarFormat(reqTotal)#</b></td>
							<td colspan="2"></td>
							<td><b>#dollarFormat(budTotal)#</b></td>
							<td></td>
						</tr>
						</cfoutput> --->
					</tbody>
					<!--- </cfoutput> --->
				</table>
				<div class="text-center"><b>Total Requested: <cfoutput>#dollarFormat(reqTotal)#</cfoutput></b><br><b>Total Project Funds: <cfoutput>#dollarFormat(budTotal)#</cfoutput></b></div>
				</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>
			<cfelse>
				<!--- no records --->
				<h4>There are no records at this time.</h4>
			</cfif>

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
	    $('#organization').multiselect({
	    	buttonWidth: '200px',
	    });
	    $('#status').multiselect({
	    	buttonWidth: '200px',
	    });




	});



</script>

