<cfinclude template="header.cfm">
<cfoutput>


		<div class="row">
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-paste fa-fw"></i> Implementation Status
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

					<cfif ((isUserinRole('review activity') and getPlugin("SessionStorage").getVar("curUserAuth.programID") is rc.proposal.programid) or isUserinRole('set implementation status all proposals')) >

					<form method="post" action="#event.buildLink('proposal.saveImpStatus')#">
						<input type="hidden" name="activityID" value="#rc.activityID#">
							<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
						<input type="hidden" name="sysUserID" value="#rc.sysUserID#">
							<div class="form-group">
								<label>Period of Performance Start</label>
								<input type="date" class="form-control" id="startDate" name="startDate" value="#dateFormat(rc.proposal.StartDate,'yyyy-mm-dd')#" required="true" />
							</div>
							<div class="form-group">
							<label>Period of Performance End</label>
							<input type="date" class="form-control" id="endDate" name="endDate" value="#dateFormat(rc.proposal.EndDate,'yyyy-mm-dd')#" required="true"  />
							</div>
							<div class="form-group">
							<label>Implementation Status</label>
									<select class="form-control" name="implementationStatus" >
										<option value="" <cfif (rc.proposal.implementationStatus EQ "")>selected</cfif>>Select</option>
										<option value="Pre-Implementation" <cfif (rc.proposal.implementationStatus EQ "Pre-Implementation")>selected</cfif>>Pre-Implementation</option>
										<cfif rc.proposal.activityStatusCode GTE 600 >
											<option value="Active" <cfif (rc.proposal.implementationStatus EQ "Active" or rc.proposal.implementationStatus NEQ "CN Re-notification" or rc.proposal.implementationStatus NEQ "MOU Modification")>selected</cfif>>Active</option>
											<option value="Completed" <cfif (rc.proposal.implementationStatus EQ "Completed")>selected</cfif>>Completed</option>
										</cfif>
										<option value="On Hold" <cfif (rc.proposal.implementationStatus EQ "On Hold")>selected</cfif>>On Hold</option>

									</select>
								</div>
							<cfif rc.proposal.activityStatusCode GTE 400 >
							<div class="form-group">
								<label>Modifications</label>
									<select class="form-control" name="modStatus" >
										<option value="" <cfif (rc.proposal.implementationStatus NEQ "CN Re-notification" and rc.proposal.implementationStatus NEQ "MOU Modification")>selected</cfif>>Select</option>
										<!--- <option value="CN Partial Hold" <cfif (rc.proposal.implementationStatus EQ "CN Partial Hold")>selected</cfif>>CN Partial Hold</option> --->
										<option value="CN Re-notification" <cfif (rc.proposal.implementationStatus EQ "CN Re-notification")>selected</cfif>>CN Re-notification</option>
										<cfif rc.proposal.activityStatusCode GTE 500 >
											<option value="MOU Modification" <cfif (rc.proposal.implementationStatus EQ "MOU Modification")>selected</cfif>>MOU Modification</option>
										</cfif>
									</select>
								</div>
							<cfelse>
								<input type="hidden" name="modStatus" value="">
							</cfif><br>
								<input type="submit" name="saveImpStatus" value="Set Implementation Status" class="btn btn-primary btn-xs pull-right" /><br><br>
								<p class="text-error">Note: Period of performance dates should match implementation status. <br>Set to "On Hold" if project is inactive and dates are unknown.
								<br>Status must be  "Active" for modifications.</p>

					</form>
					<cfelse>
						<table class="table">
							<tr>
								<td>Start Date: </td>
								<td>#dateFormat(rc.proposal.startDate,"dd-mmm-yyyy")# </td>
							</tr>
							<tr>
								<td>End Date: </td>
								<td>#dateFormat(rc.proposal.endDate,"dd-mmm-yyyy")#</td>
							</tr>
							<tr>
								<td>Implementation Status: </td>
								<td>#rc.proposal.implementationStatus#</td>
							</tr>
						</table>

					</cfif>

					</div>
		            <!-- /.panel-body -->
				</div>
			</div>


</cfoutput>


			<div class="col-md-8">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-list-ol fa-fw"></i> Workplan
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

						<table class="table table-striped table-hover">
							<thead>
							<tr>
								<th>Start Date
								</th>
								<th>End Date
								</th>
								<th>Completed
								</th>
								<th>Item
								</th>
								<th>Description
								</th>
								<cfif IsUserInRole("edit workplan") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
									<th class="span1">
										<button type="button" class="btn btn-default btn-xs pull-right"   data-toggle="modal" data-target="#wpModal"><i class="fa fa-plus-circle fa-fw"  data-toggle="tooltip" title="Add Workplan Item"></i></button>
									</th>
									</cfif>
							</tr>
						</thead>
						<cfif rc.workplan.recordcount gt 0>
		 					<cfoutput query="rc.workplan">
								<tr
									<cfif len(enddate) and enddate lt now() and not len(completedate)>
										class="error"
									<cfelseif  len(enddate) and enddate lt DateAdd('d', +7, now()) and enddate gt now() and not len(completedate)>
										class="warning"
									<cfelseif len(completedate)>
										class="success"
									<cfelseif not len(startdate) or not len(enddate)>
										class="info"
									</cfif>>
									<td>#dateformat(startDate,"MM/DD/YYYY")#</td>
									<td>#dateformat(EndDate,"MM/DD/YYYY")#</td>
									<td><cfif len(completedate)>Yes</cfif></td>
									<td>#Name#
									</td>
									<td>#Description#
									</td>
									<cfif IsUserInRole("edit workplan") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
										<td>
										<button type="button" class="btn btn-default btn-xs pull-right" title="Edit Workplan Item" data-toggle="modal" data-target="##wpModaledit" onclick="setwpFormEdit(#workplanID#,'#name#','#dateformat(startDate,"yyyy-mm-dd")#','#dateformat(endDate,"yyyy-mm-dd")#','#dateformat(completeDate,"yyyy-mm-dd")#','#description#');"><i class="fa fa-edit fa-fw"></i></button>
										</td>
									</cfif>
								</tr>

							</cfoutput>
						<cfelse>
								<tr>
									<td colspan="5"><i>No Workplan Items Added</i>

									</td>
									<cfif IsUserInRole("edit workplan") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities"))>
										<td>&nbsp;
										</td>
									</cfif>
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

	<div id="wpModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="wpForm" id="wpForm" class="formular"  method="post" action="#event.buildLink('proposal.saveWorkplan')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
		<input type="hidden" name="workplanID" value="">
	    <h3 id="myModalLabel">Add Workplan Item</h3>
	  </div>
	  <div class="modal-body">
		 <div class="form-group">
		<label>Item Name</label>
	    <input type="text" name="Name"  class="form-control" required value="">
	    </div>

		<div class="form-group">
		<label>Start Date</label>
	    <input type="date" name="startdate"  class="form-control" value="">
	    </div>

		<div class="form-group">
		<label>End Date</label>
	    <input type="date" name="enddate"  class="form-control" value="">
	    </div>

		<div class="form-group">
	    <label>Completed  &nbsp;<input type="checkbox" name="completedate" value="#now()#"></label>
	    </div>

		<div class="form-group">
	    <label>Description</label>
	    <input type="text" name="description" class="form-control" value="">
	    </div>


	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Add Workplan Item</button>
		</form>
	  </div>
	  </div>
  </div>
	</div>

	<div id="wpModaledit" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
    <div class="modal-content">
	  <div class="modal-header">
		<form name="wpFormedit" id="wpForm" class="formular"  method="post" action="#event.buildLink('proposal.saveWorkplan')#">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
		<input type="hidden" name="workplanID" id="workplanid" value="">
	    <h3 id="myModalLabel">Edit Workplan Item</h3>
	  </div>
	  <div class="modal-body">
		  <div class="form-group">
		<label>Item Name</label>
	    <input type="text" name="Name" id="itemname" class="form-control" required value="">
		</div>
		<div class="form-group">
		<label>Start Date</label>
	    <input type="date" name="startdate" id="startdate" class="form-control" value="">
		</div>
		<div class="form-group">
		<label>End Date</label>
	    <input type="date" name="enddate" id="enddate" class="form-control" value="">
		</div>
		<div class="form-group">
	    <label>Completed   &nbsp;<input type="checkbox" name="completedate" id="completedate" value="#now()#"></label>
		</div>
		<div class="form-group">
	    <label>Description</label>
	    <input type="text" name="description" id="description" class="form-control" value="">
	    </div>
	  </div>
	  <div class="modal-footer">
	    <button class="btn btn-default btn-xs" data-dismiss="modal" aria-hidden="true">Cancel</button>
	    <button class="btn btn-primary btn-xs">Edit Workplan Item</button>
		</form>
	  </div>
	   </div>
  </div>
	</div>


</cfif>

	</cfoutput>

<script>
	function setwpFormEdit(workplanID,itemname,startdate,enddate,completedate,description) {
		document.getElementById( "workplanid" ).value = workplanID;
		 document.getElementById( "itemname" ).value = itemname;
		 document.getElementById( "startdate" ).value = startdate;
		 document.getElementById( "enddate" ).value = enddate;
		 //document.getElementById( "completedate" ).value = completedate;
		 document.getElementById( "description" ).value = description;
	}
</script>

