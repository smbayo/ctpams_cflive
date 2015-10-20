<ol class="breadcrumb">
  <li>Workload</li>
  <li class="active">My Projects</li>
</ol>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-folder-open-o fa-fw"></i> My Projects
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">


				<div class="row">
						<div class="col-md-12">
								<p class="text-muted">This page displays all projects currently in PAMS that are owned by you.
											 </p>
						</div>
					</div>
					<div class="row">
				     <div class="col-md-12">
						<cfif structKeyExists(rc,"ownedprojectsummary")  AND rc.ownedprojectsummary.recordCount>
							<table class="table table-striped table-hover" id="ownedprojects">
													<thead>
														<tr>
															<th>ID</th>
															<th>Title</th>
															<th>Start Date</th>
															<th>End Date</th>
															<th>FY</th>
															<th>Approval Status</th>
															<th>$ Req</th>
															<th>Implementation</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput query="rc.ownedprojectsummary">

														<tr>
															<td>
																<cfif statusname is "proposal draft" or statusname is "proposal in progress">
																	<a href=#event.buildLink("proposal.editproject.activityID." & rc.ownedprojectsummary.ActivityID)# title="Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#" data-toggle="tooltip" data-placement="right">#proposalNumber#</a>
																<cfelse>
																	<a href=#event.buildLink("proposal.review.activityID." & rc.ownedprojectsummary.ActivityID)# title="Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#" data-toggle="tooltip" data-placement="right">#proposalNumber#</a>
																</cfif>
															</td>
															<td>
																<cfif statusname is "proposal draft" or statusname is "proposal in progress">
																	<a href=#event.buildLink("proposal.editproject.activityID." & rc.ownedprojectsummary.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a>
																<cfelse>
																	<a href=#event.buildLink("proposal.review.activityID." & rc.ownedprojectsummary.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a>
																</cfif>
															</td>
															<td>#dateFormat(startDate,"dd-mmm-yyyy")#</td>
															<td>#dateFormat(endDate,"dd-mmm-yyyy")#</td>
															<td>#fiscalyear#</td>
															<td>#statusname#</td>
															<td>#dollarformat(projectamount)#</td>
															<td><cfif len(implementationStatus)>
																	#implementationStatus#
																<cfelse>
																	Not Set
																</cfif>
															</td>
														</tr>
													</cfoutput>
													</tbody>
												</table>
						</cfif>
					</div>
					</div>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>