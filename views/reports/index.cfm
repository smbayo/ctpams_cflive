<ol class="breadcrumb">
  <li class="active">Filtered Search</li>
</ol>

<div class="row">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-9">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<i class="fa fa-filter fa-fw"></i> Apply Filters
								<div class="pull-right">
									<a href="<cfoutput>#event.buildLink("reports/index")#</cfoutput>" class="btn btn-default btn-xs">Clear Filters</a>
								</div>
							</div>
				            <!-- /.panel-heading -->
							<div class="panel-body">
								<form class="form-inline">
								<cfoutput>

								<select id="statusID" name="statusID" multiple="true" style="visibility: visible;">
										<option value="266,267"  <cfif listfind(rc.statusID,"266")>selected</cfif>>Proposal in Progress</option>
										<option value="268,269,270,272,275,308"  <cfif listfind(rc.statusID,"268")>selected</cfif>>Project Review</option>
										<option value="276,277,280,281,283" <cfif listfind(rc.statusID,"276")>selected</cfif>>CN Clearance</option>
										<option value="288,289"  <cfif listfind(rc.statusID,"288")>selected</cfif>>Funding Clearance</option>
										<option value="294"  <cfif listfind(rc.statusID,"294")>selected</cfif>>Obligation Pending</option>
										<option value="297"  <cfif listfind(rc.statusID,"297")>selected</cfif>>Fully Obligated</option>
										<option value="273"  <cfif listfind(rc.statusID,"273")>selected</cfif>>On Hold</option>
										<option value="274"  <cfif listfind(rc.statusID,"274")>selected</cfif>>Denied</option>
									</select>


									<select id="impStatus" name="impStatus" style="visibility: visible;">
										<option value="" <cfif (rc.impstatus EQ "")>selected</cfif>>Implementation (all)</option>
										<option value="Pre-Implementation" <cfif (rc.impstatus EQ "Pre-Implementation")>selected</cfif>>Pre-Implementation</option>
										<option value="Active" <cfif (rc.impstatus EQ "Active")>selected</cfif>>Active</option>
										<option value="Completed" <cfif (rc.impstatus EQ "Completed")>selected</cfif>>Completed</option>
										<option value="Not Set" <cfif (rc.impstatus EQ "Not Set")>selected</cfif>>Not Set</option>

										<option value="On Hold" <cfif (rc.impstatus EQ "On Hold")>selected</cfif>>On Hold</option>

										<option value="MOU Modification" <cfif (rc.impstatus EQ "MOU Modification")>selected</cfif>>MOU Mod</option>
										<option value="CN Re-notification" <cfif (rc.impstatus EQ "CN Re-notification")>selected</cfif>>CN Re-notification</option>
										<option value="CN Partial Hold" <cfif (rc.impstatus EQ "CN Partial Hold")>selected</cfif>>CN Partial Hold</option>
									</select>

									<select id="themeID" name="themeID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.themes">
													<option value="#categoryID#" <cfif listfind(rc.themeID,rc.themes.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select>

									<br>

								<cfset fylist = "2015,2014,2013,2012,2011,2010,2009">
								<select id="fy" name="fy"  multiple="multiple">

									<cfloop list="#fylist#" index="thisyear">
							        	<option <cfif listfind(rc.fy,thisyear)>selected</cfif> value="#thisYear#">#thisYear#</option>
									</cfloop>
						        </select>


						        	<select id="programID" name="programID" multiple="true" style="visibility: visible;">
										<option value="3,4,5" <cfif listfind(rc.programID,"1")>selected</cfif>>CT</option>
										<option value="1" <cfif listfind(rc.programID,"1")>selected</cfif>>ATA</option>
										<option value="2" <cfif listfind(rc.programID,"2")>selected</cfif>>CTE</option>
										<option value="6" <cfif listfind(rc.programID,"6")>selected</cfif>>TSI</option>

									</select>

						        <select id="countryID" name="countryID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.countries">
													<option value="#categoryID#" <cfif listfind(rc.countryID,rc.countries.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select>

									<br>

									<!--- <select id="regionID" name="rsiregionID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.regions">
													<option value="#categoryID#" <cfif listfind(rc.rsiregionID,rc.regions.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select> --->

									<select id="stateregionID" name="stateregionID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.stateregions">
													<option value="#categoryID#" <cfif listfind(rc.stateregionID,rc.stateregions.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select>



									<!--- <select id="programID" name="programID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.programs">
													<option value="#programID#" <cfif listfind(rc.programID,rc.programs.programID)>selected</cfif>>#name#</option>
												</cfloop>
									</select> --->

									<select id="implementerID" name="implementerID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.implementers">
													<option value="#categoryID#" <cfif listfind(rc.implementerID,rc.implementers.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select>

									<select id="orgID" name="orgID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.Organizations">
													<option value="#categoryID#" <cfif listfind(rc.orgID,rc.Organizations.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select>



									<br>



									<select id="fundingsourceID" name="fundingsourceID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.FundingSources">
													<option value="#categoryID#" <cfif listfind(rc.fundingsourceID,rc.FundingSources.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select>

									<select id="fundingmechID" name="fundingmechID" multiple="true" style="visibility: visible;">
												<cfloop query="rc.FundingMechs">
													<option value="#categoryID#" <cfif listfind(rc.fundingmechID,rc.FundingMechs.categoryID)>selected</cfif>>#name#</option>
												</cfloop>
									</select>

									<select id="reprogramFunds" name="reprogramFunds" style="visibility: visible;">
										<option value="" <cfif (rc.reprogramFunds EQ "")>selected</cfif>>Reprogram (all)</option>
										<option value="1" <cfif (rc.reprogramFunds EQ "1")>selected</cfif>>Reprogram - Yes</option>
										<option value="0" <cfif (rc.reprogramFunds EQ "0")>selected</cfif>>Reprogram - No</option>
									</select>





									<br>
									<select id="ctex" name="ctex" style="visibility: visible;">

										<option value="" <cfif (rc.ctex EQ "")>selected</cfif>>Include Archived</option>
										<option value="0" <cfif (rc.ctex EQ "0")>selected</cfif>>Exclude Archived</option>
										<option value="1" <cfif (rc.ctex EQ "1")>selected</cfif>>Only Archived</option>

									</select>
									<input type="text" class="form-control" name="keyword" placeholder="keyword" value="#rc.keyword#" style="width: 180px;">

									<button type="submit" id="reportsubmit" class="btn btn-primary btn-sm" name="submit" value="Go"><i class="icon-filter icon-white"></i> Go</button>
									</div>
									</cfoutput>
									</form>
								</div>
					            <!-- /.panel-body -->
							</div>
						</div>
					</div>

			<div class="col-md-3">
				<cfif structKeyExists(rc,"summary") and rc.summary.recordCount>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<i class="fa fa-plus fa-fw"></i> Additional Fields
								<div class="pull-right">

								</div>
							</div>
				            <!-- /.panel-heading -->
							<div class="panel-body">

					<cfset rc.filtereportquerystring = getPlugin("SessionStorage").setVar("filtereportquerystring",CGI.QUERY_STRING)>
					<form target="_blank">
						<cfoutput>
							<input type="hidden" name="fy" value="#rc.fy#">
							<input type="hidden" name="programID" value="#rc.programID#">
							<input type="hidden" name="fundingsourceID" value="#rc.fundingsourceID#">
							<input type="hidden" name="countryID" value="#rc.countryID#">
							<input type="hidden" name="rsiregionID" value="#rc.rsiregionID#">
							<input type="hidden" name="stateregionID" value="#rc.stateregionID#">
							<input type="hidden" name="orgID" value="#rc.orgID#">
							<input type="hidden" name="statusID" value="#rc.statusID#">
							<input type="hidden" name="fundingmechID" value="#rc.fundingmechID#">
							<input type="hidden" name="themeID" value="#rc.themeID#">
							<input type="hidden" name="reprogramFunds" value="#rc.reprogramFunds#">
							<input type="hidden" name="ctex" value="#rc.ctex#">
							<input type="hidden" name="keyword" value="#rc.keyword#">
							<input type="hidden" name="implementerID" value="#rc.implementerID#">
							<input type="hidden" name="impStatus" value="#rc.impStatus#">

							<cfset columnlist = "Countries,Regions,Implementing Partners,Total Obligated,Obligation Numbers,AMCN Approved Date,Budget Funding Approved Date,Description,Cleared Prelegal Date,Approved Date,AMCN Budget Submit Date,AMCN Congress Submit Date,Funding Mechanism,Program Audience,Period of Performance,Project Purpose,Implementation Status,Results Framework">
							<select id="columns" name="columns" multiple="multiple" style="visibility: visible;">
								<cfloop list="#columnlist#" index="col">
							        <option <cfif listfind(rc.columns,col)>selected</cfif>>#col#</option>
								</cfloop>
							</select>
							<br><br>

							<cfif IsUserInRole("export reports")>
								<button type="submit" class="btn btn-success btn-xs" name="exportObligated" value="Export (excel)"><i class="icon-list-alt icon-white"></i> Export</button>
							</cfif>

							<button type="submit" class="btn btn-success btn-xs" name="submitextended" value="View with Fields"><i class="icon-resize-full icon-white"></i> View</button>
								<!--- or
							<input type="submit" name="exportBudget" value="Export by Budget Item"> &nbsp; --->
							<cfif IsUserInRole("export by budget report")>
								 <hr>
								<button type="submit" class="btn btn-info btn-xs" name="exportBudget" value="Export by Budget Item"><i class="icon-list-alt icon-white"></i> Export by Budget Item</button>
							</cfif>
						</cfoutput>
					</form>
								</div>
					            <!-- /.panel-body -->
							</div>
						</div>
					</div>
				</cfif>
			</div>
		</div>




		<cfif structKeyExists(rc,"summary") and rc.summary.recordCount>
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<i class="fa fa-eye fa-fw"></i> Query Results
								<div class="pull-right">

								</div>
							</div>
				            <!-- /.panel-heading -->
							<div class="panel-body">

					<cfset totalamount = 0>
					<div class="text-center text-muted">shift+click to sort by multiple columns</div>
					<table class="table table-striped table-hover" id="filteredreport">
						<thead>
							<tr>
 								<th style="width:70px">Program</th>
								<th style="width:40px">ID</th>
								<th>Title</th>
								<th style="width:90px">Funding</th>
								<th style="width:40px">CN</th>
								<th style="width:40px">FY</th>
								<th style="width:90px">Requested</th>
								<th>Status</th>

							</tr>
						</thead>
						<tbody>
							<!--- <cfoutput> --->
							<cfoutput query="rc.summary">
							<tr>
								<td>
									<cfif rc.summary.ctex is 1>
										<i class="fa fa-archive text-danger"></i>
									<cfelseif rc.summary.reprogramfunds is 1 or rc.summary.implementationstatus is 'CN Re-notification' or rc.summary.cncount gt 1>
										<i class="fa fa-repeat text-danger"></i>
									</cfif>
								<a href=#event.buildLink("proposal.review.activityID." & rc.summary.ActivityID)# title="#activityid#">#rc.summary.Programname#</a></td>
								<td><a href=#event.buildLink("proposal.review.activityID." & rc.summary.ActivityID)# title="#activityid#">#rc.summary.activityid#</a></td>
								<td><a href=#event.buildLink("proposal.review.activityID." & rc.summary.ActivityID)# title="#trim(projectTitle)#" alt="#projectTitle#" data-toggle="tooltip" data-placement="right">#trim(projectTitle)#</a></td>
								<td>#rc.summary.fundingSources#</td>
								<td>#rc.summary.cnnumbers#</td>
								<td>#rc.summary.fiscalyear#</td>
								<td>#dollarFormat(rc.summary.projectAmount)#</td>
								<cfif rc.summary.projectAmount gt 0>
									<cfset totalamount = totalamount + rc.summary.projectAmount>
								</cfif>
								<td>
									<cfif  rc.summary.ctex is 1>
										<span class="text-danger">Archived - Inactive</span>
									<cfelseif rc.summary.implementationStatus is "MOU Modification" or rc.summary.implementationStatus is "CN Re-notification" or rc.summary.implementationStatus is "CN Partial Hold">
										#rc.summary.implementationStatus#
									<cfelse>
										#rc.summary.statusname#
									</cfif>
								</td>

							</tr>
							</cfoutput>
						</tbody>
					</table>

							<p class="text-center"><b>Total Amount Requested: <cfoutput>#dollarFormat(totalAmount)#</cfoutput></b></p>


								</div>
					            <!-- /.panel-body -->
							</div>
						</div>
					</div>
		<cfelse>
			<!--- no records --->
			<h5>There are no items to display at this time.</h5>
		</cfif>
	</div>
	</div>


<script type="text/javascript">



  $(document).ready(function() {



    $('#fy').multiselect({
    	buttonWidth: '180px',
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

    $('#programID').multiselect({
    	buttonWidth: '180px',
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

    $('#fundingsourceID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Funding Source (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Funding Source: ' +  options.length + ' selected  <b class="caret"></b>';
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

    $('#fundingmechID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Funding Mech (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Funding Mech: ' +  options.length + ' selected  <b class="caret"></b>';
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

    $('#implementerID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
    	enableCaseInsensitiveFiltering: true,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Implementer (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Implementer: ' +  options.length + ' selected  <b class="caret"></b>';
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

    $('#countryID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
    	enableCaseInsensitiveFiltering: true,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Country (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Country: ' +  options.length + ' selected  <b class="caret"></b>';
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

    $('#regionID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'RSI Region (all) <b class="caret"></b>';
        }
        else if (options.length > 2) {
          return 'RSI Region: ' +  options.length + ' selected  <b class="caret"></b>';
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

    $('#stateregionID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Region (all) <b class="caret"></b>';
        }
        else if (options.length > 2) {
          return 'Region: ' +  options.length + ' selected  <b class="caret"></b>';
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

    $('#orgID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
    	enableCaseInsensitiveFiltering: true,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Organization (all) <b class="caret"></b>';
        }
        else if (options.length > 0) {
          return 'Organization: ' +  options.length + ' selected  <b class="caret"></b>';
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

    $('#statusID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Status (all active) <b class="caret"></b>';
        }
        else if (options.length > 1) {
          return 'Status: ' +  options.length + ' selected  <b class="caret"></b>';
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

     $('#reprogramFunds').multiselect({
    	buttonWidth: '180px',

    });

    $('#ctex').multiselect({
    	buttonWidth: '180px',

    });

    $('#impStatus').multiselect({
    	buttonWidth: '180px',

    });

    $('#columns').multiselect({
    	buttonWidth: '160px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Add Fields <b class="caret"></b>';
        }
        else if (options.length > 2) {
          return 'Fields: ' +  options.length + ' selected  <b class="caret"></b>';
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