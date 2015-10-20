<cfinclude template="header.cfm">




		<div class="row">
			<div class="col-md-8">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-sitemap fa-fw"></i> Program-Level Results
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

						<table class="table table-striped table-hover">
							<thead>
							<tr>
								<th>Primary
									<cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
										<button type="button" class="btn btn-default btn-xs pull-right"  data-toggle="modal" data-target="#primaryModal"><i class="fa fa-edit fa-fw" data-toggle="tooltip" title="Set Primary Results"></i></button>
									</cfif>
								</th>
							</tr>
						</thead>
						<cfif rc.primaryResult.recordcount gt 0>
		 					<cfoutput query="rc.primaryResult">
								<tr>
									<td>#resultName#

									</td>
								</tr>

							</cfoutput>
						<cfelse>
								<tr>
									<td><i>No Primary Result Selected</i>

									</td>
								</tr>
						</cfif>
						</table>





						<table class="table table-striped table-hover">
							<thead>
							<tr>
								<th>Secondary
									<cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
										<button type="button" class="btn btn-default btn-xs pull-right" data-toggle="modal" data-target="#secondaryModal"><i class="fa fa-edit fa-fw" data-toggle="tooltip" title="Set Secondary Results"></i></button>
									</cfif>
								</th>
							</tr>
						</thead>
						<cfif rc.secondaryResult.recordcount gt 0>
		 					<cfoutput query="rc.secondaryResult">
								<tr>
									<td>#resultName#

									</td>
								</tr>

							</cfoutput>
						<cfelse>
								<tr>
									<td><i>No Secondary Results Selected</i>

									</td>
								</tr>

						</cfif>
						</table>

					</div>
		            <!-- /.panel-body -->
				</div>
			<cfif rc.indicators.recordcount gt 0>

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-sort-numeric-asc fa-fw"></i> Project Monitoring Measurements
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

					<cfif rc.measurements.recordcount gt 0>

						<cfoutput query="rc.measurements" group="startdate">
								<strong>Reporting Period:</strong> #dateformat(StartDate,"MM/DD/YYYY")# - #dateformat(endDate,"MM/DD/YYYY")#
							<ul class="list-unstyled">
							<cfoutput group="objective">
								<li>&nbsp;&nbsp;&nbsp;<strong>Objective:</strong> #objective#
								<ul class="list-unstyled">
								<cfoutput group="indicatorname">
									<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Indicator:</strong> #indicatorname#<br>
									<table class="table table-condensed">
										<tr>
											<th>Disaggregation</th>
											<th>Actual</th>
											<th>Target</th>
											<th></th>
										</tr>
									<cfoutput>
										<tr>
											<td>
												<cfif not len(disaggid)>
													<cfset disaggtype = 'Total'>
												<cfelse>
													<cfset disaggtype = #disaggsetname# & ' - ' & #disaggname#>
												</cfif>
												#disaggType#
											</td>
											<td>#actual#</td>
											<td>#target#</td>
											<td>
												<cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
													<span class="pull-right"><button type="button" class="btn btn-default btn-xs"  data-toggle="modal" data-target="##measurementModal" onclick="setMeasurementEdit('#indicatorname#',#indicatorID#,'#measurementid#','#actual#','#target#','#dateformat(StartDate,"MM/DD/YYYY")#','#dateformat(EndDate,"MM/DD/YYYY")#','#disaggid#','#disaggType#');"><i class="fa fa-edit fa-fw" data-toggle="tooltip" title="Edit Measurement"></i></button></span>
												</cfif>
											</td>
										</tr>
									</cfoutput>
									</table>
									</li>
								</cfoutput>
								</ul></li>
							</cfoutput>
							</ul>
						</cfoutput>
						<cfoutput>
						<cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities")) and len(rc.proposal.EndDate) and len(rc.proposal.startDate)>
							<form name="objForm" method="post" action="#event.buildLink('proposal.setActivityReporting')#">
									<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
									<input type="hidden" name="measurementid" value="0">
									<input type="hidden" name="startdate" value="#dateformat(rc.proposal.StartDate,"MM/DD/YYYY")#">
									<input type="hidden" name="enddate" value="#dateformat(rc.proposal.EndDate,"MM/DD/YYYY")#">

									 <span class="pull-right"><div class="input-prepend">
										<button onClick="if(confirm('You are about to irretrievably delete all previously enetered measurements and regenerate the schedule based on the project start and end dates. Are you sure you wish to proceed?')) return true; else return false;"   class="btn btn-danger" name="deleteall" value="Reset Reporting Schedule" type="submit">Reset Reporting Schedule</button>
										<select name="period" class="span2">
											<option value="3">Quarterly</option>
											<option value="1">Monthly</option>
											<option value="12">Yearly</option>
										</select>
									</div></span>
									<cfif rc.measurements.enddate - rc.measurements.startdate lt 32>
										<input type="hidden" name="reconcileperiod" value="1">
									<cfelseif rc.measurements.enddate - rc.measurements.startdate lt 100>
										<input type="hidden" name="reconcileperiod" value="3">
									<cfelse>
										<input type="hidden" name="reconcileperiod" value="12">
									</cfif>
									<span class="pull-right"><button onClick="if(confirm('You are about to reconcile measurements with the project start and end dates.  If the dates have been changed, any previously entered measurements falling outside of the date range will be lost. Are you sure you wish to proceed?')) return true; else return false;"   class="btn btn-warning" name="reconcile" value="Reconcile Reporting Schedule" type="submit">Reconcile Reporting Schedule</button>&nbsp;&nbsp;&nbsp;</span>
							</form>
						</cfif>
						</cfoutput>

					<cfelseif len(rc.proposal.EndDate) and len(rc.proposal.startDate)>
						<cfoutput>
						Reporting has not yet been activated for this project.<br><br>
						The following indicators are available for reporting:
						<ul>
							<cfloop query="rc.indicators">
								<li> 	#ProjectResultsIndicator#	</li>
							</cfloop>
						</ul>
						Reporting periods will be added for the following timeframe: #dateformat(rc.proposal.StartDate,"MM/DD/YYYY")# to #dateformat(rc.proposal.EndDate,"MM/DD/YYYY")#<br><br>
						Once you have verified the indicators and period of performance to be reported on, click the button below to add measurement reporting periods for each indicator.<br><br>

						<form name="objForm" method="post" action="#event.buildLink('proposal.setActivityReporting')#">
							<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
							<input type="hidden" name="measurementid" value="0">
							<input type="hidden" name="startdate" value="#dateformat(rc.proposal.StartDate,'MM/DD/YYYY')#">
							<input type="hidden" name="enddate" value="#dateformat(rc.proposal.EndDate,'MM/DD/YYYY')#">
						    <div class="input-group"  style="width:250px">

								<select name="period"  class="form-control input-sm">
									<option value="3">Quarterly</option>
									<option value="1">Monthly</option>
									<option value="12">Yearly</option>
								</select>
								<span class="input-group-btn">
								<button class="btn btn-primary btn-sm">Set Reporting Schedule</button>
								</span>
							</div>

						</form>
						</cfoutput>
					<cfelse>
					Project start and end dates are required to set reporting schedule.
					</cfif>


					</div>
		            <!-- /.panel-body -->
				</div>

	</cfif>

			</div>

			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-cubes fa-fw"></i> Project-Level Objectives and Indicators
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

					<table class="table table-striped table-hover">
						<thead>
						<tr>
							<th>
								<cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
									<button type="button" class="btn btn-default btn-xs pull-right"  data-toggle="modal" data-target="#objModal"><i class="fa fa-plus-circle fa-fw" data-toggle="tooltip" title="Add Objective"></i></button>
								</cfif>
							</th>
						</tr>
					</thead>
					<cfif rc.rmp.recordcount gt 0>
	 					<cfoutput query="rc.rmp" group="ResultsFrameworkElementID">
							<tr>
								<td><strong>#ProjectResultsObjective# </strong>
									<cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
										<span class="pull-right">
											<button type="button" class="btn btn-default btn-xs"  data-toggle="modal" data-target="##objModaledit" onclick="setObjectiveFormEdit('#ProjectResultsObjective#',#ResultsFrameworkElementID#);"><i class="fa fa-edit fa-fw" data-toggle="tooltip" title="Edit Objective: #ProjectResultsObjective#"></i></button>
										<button type="button" class="btn btn-default btn-xs"  data-toggle="modal" data-target="##indModal" onclick="setObjective('#ProjectResultsObjective#',#ResultsFrameworkElementID#);"><i class="fa fa-plus-circle fa-fw" data-toggle="tooltip" title="Add Indicator for Objective: #ProjectResultsObjective#"></i></button>
										&nbsp;<a href=#event.buildLink("proposal.deleteObjective.ResultsFrameworkElementID." & rc.rmp.ResultsFrameworkElementID & ".activityID." & rc.proposal.activityid)# onClick="if(confirm('WARNING: Objective and associated indicators will be permanently deleted.  Proceed?')) return true; else return false;" role="button" class="close" title="Delete Objective: #ProjectResultsObjective#" data-placement="right">x</a>
										</span>
									</cfif>

									<cfif len(ProjectResultsIndicator) gt 0>
										<br><br><ul class="list-unstyled">
										<cfoutput>
											<li>#ProjectResultsIndicator#
											<cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
												<span class="pull-right">
													<button type="button" class="btn btn-default btn-xs"  data-toggle="modal" data-target="##indModaledit" onclick="setIndicatorFormEdit('#ProjectResultsIndicator#',#indicatorID#,'#unitofmeasure#','#datasource#','#collectionmethod#','#dataFreq#','#definition#','#actual#','#target#',#measurementID#,#ResultsFrameworkElementID#);"><i class="fa fa-edit fa-fw" data-toggle="tooltip" title="Edit Indicator: #rc.rmp.ProjectResultsIndicator#"></i></button>
												&nbsp;<a href=#event.buildLink("proposal.deleteIndicator.indicatorID." & rc.rmp.indicatorID & ".activityID." & rc.proposal.activityid)# role="button" class="close"  title="Delete Indicator: #ProjectResultsIndicator#" data-placement="right">x</a>
												</span>
											</cfif>
											<small><br>&nbsp;&nbsp;&nbsp;&nbsp;Unit of Measure: #unitofmeasure#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Data Source: #datasource#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Collection Method: #collectionmethod#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Data Frequency: #datafreq#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Definition: #definition#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Baseline Actual: #actual#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Baseline Target: #target#
											</small>
											</li>
										</cfoutput>
										</ul>
									</cfif>
								</td>
							</tr>

						</cfoutput>
					<cfelse>
								<tr>
									<td><i>No Objectives or Indicators Entered</i>

									</td>
								</tr>
					</cfif>
					</table>

					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>





	<cfoutput>

 <cfif IsUserInRole("edit rmp") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
<!-- Modal -->
	<div id="objModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="objForm" id="objForm" class="formular"  method="post" action="#event.buildLink('proposal.saveObjective')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
		<input type="hidden" name="programid" value="#rc.proposal.programid#">
			<input type="hidden" name="parent" value="71">


		<input type="hidden" name="resultsframeworkelementid"  value="">
	    <h3 id="myModalLabel">Add Project Objective</h3>
	  </div>
	  <div class="modal-body">
		  <div class="form-group">
		<label>Objective</label>
	    <input type="text" name="Name" class="form-control" required value="">
	    </div>
	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Add Objective</button>
		</form>
	  </div>
	 </div>
	 </div>
	</div>

	<div id="objModaledit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="objForm" id="objForm" class="formular"  method="post" action="#event.buildLink('proposal.saveObjective')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="resultsframeworkelementid" id="ObjectiveFormResultsID" value="">
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
	    <h3 id="myModalLabel">Edit Project Objective</h3>
	  </div>
	  <div class="modal-body">
		  <div class="form-group">
		<label>Objective</label>
	    <input type="text" name="Name" id="ObjectiveFormName" class="form-control" required value="">
	    </div>
	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Edit Objective</button>
		</form>
	  </div>
	 </div>
	 </div>
	</div>

	<div id="indModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="objForm" id="objForm" class="formular"  method="post" action="#event.buildLink('proposal.saveIndicator')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
		<input type="hidden" name="resultsFrameworkElementID" id="objectiveID" value="">
		<input type="hidden" name="indicatorID"  value="0">
		<input type="hidden" name="MeasurementID"  value="0">
		<input type="hidden" name="isBaseline"  value="1">
	    <h3 id="myModalLabel">Add Indicator</h3> (Objective: <span id="objectiveName"></span>)
	  </div>
	  <div class="modal-body">
		  <div class="form-group">
		<label>Indicator</label>
	    <input type="text" name="Name" class="form-control" required value="">
		</div>
		<div class="form-group">
		<label>Unit of Measure</label>
	    <input type="text" name="UnitofMeasure" class="form-control" value="">
		</div>
		<div class="form-group">
		<label>Data Source</label>
	    <input type="text" name="dataSource" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Collection Method</label>
	    <input type="text" name="collectionMethod" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Data Frequency</label>
	    <input type="text" name="dataFreq" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Definition</label>
	    <input type="text" name="definition" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Baseline Actual</label>
	    <input type="number" name="actual" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Baseline Target</label>
	    <input type="number" name="target" class="form-control" value="">
	    </div>
	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Add Indicator</button>
		</form>
	  </div>
	 </div>
	 </div>
	</div>

	<div id="indModaledit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="objForm" id="objForm" class="formular"  method="post" action="#event.buildLink('proposal.saveIndicator')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
		<input type="hidden" name="indicatorID" id="indicatorID" value="">
		<input type="hidden" name="MeasurementID" id="measurementID" value="">
		<input type="hidden" name="resultsFrameworkElementID" id="objectiveIDedit" value="">
		<input type="hidden" name="isBaseline"  value="1">
	    <h3 id="myModalLabel">Edit Indicator</h3>
	  </div>
	  <div class="modal-body">
		  <div class="form-group">
		<label>Indicator</label>
	    <input type="text" name="Name" class="form-control" id="indicatorname" required value="">
		</div>
		<div class="form-group">
		<label>Unit of Measure</label>
	    <input type="text" name="UnitofMeasure" id="indicatorum" class="form-control" value="">
		</div>
		<div class="form-group">
		<label>Data Source</label>
	    <input type="text" name="dataSource" id="indicatords" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Collection Method</label>
	    <input type="text" name="collectionMethod" id="indicatorcm" class="form-control" value="">
		</div>
		<div class="form-group">
		<label>Data Frequency</label>
	    <input type="text" name="dataFreq" id="indicatordf" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Definition</label>
	    <input type="text" name="definition" id="indicatordef" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Baseline Actual</label>
	    <input type="number" name="actual" class="form-control" id="indicatora" value="">
		</div>
		<div class="form-group">
	    <label>Baseline Target</label>
	    <input type="number" name="target" class="form-control" id="indicatort" value="">
	    </div>
	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Edit Indicator</button>
		</form>
	  </div>
	 </div>
	 </div>
	</div>



	<div id="primaryModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="objForm" id="objForm" class="formular"  method="post" action="#event.buildLink('proposal.savePrimaryResult')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
	    <h3 id="myModalLabel">Set Primary Result</h3>
	  </div>
	  <div class="modal-body">
		 <div class="form-group">
		<label>Primary Result</label>
	    <select name="resultsFrameworkelementID" id="primaryResult" class="form-control">
			<cfloop query="rc.programresults">
				<option value="#resultsframeworkelementID#" <cfif (rc.resultsFrameworkElementID EQ rc.programresults.resultsframeworkelementID)> selected</cfif>><cfif rc.proposal.programid is 5>#program# - </cfif>#name#</option>
			</cfloop>
		</select>
		</div>
		<input type="hidden" name="isPrimary" value="1">
	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Set Primary Result</button>
		</form>
	  </div>
	 </div>
	 </div>
	</div>


	<div id="secondaryModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="objForm" id="objForm" class="formular"  method="post" action="#event.buildLink('proposal.saveSecondaryResults')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
	    <h3 id="myModalLabel">Set Secondary Results</h3>
	  </div>
	  <div class="modal-body">
		  <div class="form-group">
		<label>Secondry Results</label>
	    <select name="SecondaryResultsList" id="secondaryResults" multiple="true" class="form-control">
			<cfloop query="rc.programresults">
				<option value="#resultsframeworkelementID#" <cfif listFind(rc.secondaryResultsList,rc.programresults.resultsFrameworkElementID) is not 0> selected</cfif>><cfif rc.proposal.programid is 5>#program# - </cfif>#name#</option>
			</cfloop>
		</select>
		</div>
		<input type="hidden" name="isPrimary" value="1">
	  </div>
	  <div class="modal-footer">

	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Set Secondary Results</button><br><br>
	    <span class="text-muted">Hold down the "ctrl" key to select multiple</span>
		</form>
	  </div>
	 <div>
	</div>
	</div>

	<div id="measurementModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="objForm" id="objForm" class="formular"  method="post" action="#event.buildLink('proposal.saveMeasurement')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
		<input type="hidden" name="indicatorID" id="MindicatorID" value="">
		<input type="hidden" name="MeasurementID" id="MmeasurementID" value="">
		<input type="hidden" name="disaggID" id="disaggID" value="">
		<input type="hidden" name="startdate" id="startdate" value="">
		<input type="hidden" name="enddate" id="enddate" value="">
	    <h3 id="myModalLabel">Edit Measurement</h3>
	  </div>
	  <div class="modal-body">

		<div class="form-group">
		<label>Indicator</label>
		<input type="text" name="indicatorname" id="Mindicatorname" value="" disabled="true" class="form-control">
		</div>
		<div class="form-group">
		<label>Disaggregation</label>
		<input type="text" name="disaggName" id="disaggName" value="" disabled="true" class="form-control">
		</div>
		<div class="form-group">
	    <label>Start</label>
	    <input type="text" name="startdisplay" id="startdisplay" value="" disabled="true" class="form-control">
		</div>
		<div class="form-group">
	    <label>End</label>
	    <input type="text" name="enddisplay" id="enddisplay" value="" disabled="true" class="form-control">
		</div>
		<div class="form-group">
	    <label>Actual</label>
	    <input type="number" name="actual" id="Mindicatora" value="" class="form-control">
		</div>
		<div class="form-group">
	    <label>Target</label>
	    <input type="number" name="target" id="Mindicatort" value="" class="form-control">
	    </div>
	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Edit Measurement</button>
		</form>
	  </div>
	</div>
	</div>
	</div>

</cfif>

	</cfoutput>

<script>

	function setObjective(objName,objID) {
		 document.getElementById( "objectiveName" ).innerHTML = objName;
		 document.getElementById( "objectiveID" ).value = objID;
	}

	function setIndicatorFormEdit(indName,indID,indUM,indDS,indCM,indDF,indDEF,indA,indT,indM,objID) {
		 document.getElementById( "indicatorname" ).value = indName;
		 document.getElementById( "indicatorID" ).value = indID;
		 document.getElementById( "indicatorum" ).value = indUM;
		 document.getElementById( "indicatords" ).value = indDS;
		 document.getElementById( "indicatorcm" ).value = indCM;
		 document.getElementById( "indicatordf" ).value = indDF;
		 document.getElementById( "indicatordef" ).value = indDEF;
		 document.getElementById( "indicatora" ).value = indA;
		 document.getElementById( "indicatort" ).value = indT;
		 document.getElementById( "measurementID" ).value = indM;
		 document.getElementById( "objectiveIDedit" ).value = objID;

	}

	function setObjectiveFormEdit(objName,objID) {
		 document.getElementById( "ObjectiveFormResultsID" ).value = objID;
		 document.getElementById( "ObjectiveFormName" ).value = objName;
	}

	function setMeasurementEdit(indName,indID,meaID,indA,indT,sDate,eDate,disID,disName) {
		 document.getElementById( "Mindicatorname" ).value = indName;
		 document.getElementById( "MindicatorID" ).value = indID;
		 document.getElementById( "MmeasurementID" ).value = meaID;
		 document.getElementById( "Mindicatora" ).value = indA;
		 document.getElementById( "Mindicatort" ).value = indT;
		 document.getElementById( "startdate" ).value = sDate;
		 document.getElementById( "enddate" ).value = eDate;
		 document.getElementById( "startdisplay" ).value = sDate;
		 document.getElementById( "enddisplay" ).value = eDate;
		 document.getElementById( "disaggID" ).value = disID;
		 document.getElementById( "disaggName" ).value = disName;

	}






</script>