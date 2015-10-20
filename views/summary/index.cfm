<ol class="breadcrumb">
  <li>Workload</li>
  <li class="active">Summary</li>
</ol>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-tasks fa-fw"></i> Projects
				<div class="pull-right">
					<cfif IsUserInRole("create activity") or IsUserInRole("create activity all programs") >
						<cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
									<button type="button" class="btn btn-primary  btn-xs" data-toggle="modal" data-target="#addModal"><i class="icon-plus-sign icon-white"></i> New Proposal</button>
						</cfif>
					</cfif>
				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
				<cfif IsUserInRole("create activity") or IsUserInRole("create activity all programs") >
					<cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0">
						<div class="row">
							<div class="col-md-12">
							<form action="<cfoutput>#event.buildLink("proposal.new")#</cfoutput>" method="post">

										<cfif IsUserInRole("create activity all programs")>
										<div class="input-group pull-right">
											<span class="input-group-btn">
											<button type="submit" class="btn btn-primary">New Proposal</button>
											</span>
											<select name="programID" class="form-control"  style="width:80px">
												<option value="5">CT</option>
												<option value="1">ATA</option>
												<option value="2">CTE</option>
												<option value="6">TSI</option>
											</select>
										</div>
										<cfelse>
											<button type="submit" class="btn btn-primary"><i class="icon-play icon-white"></i> New Proposal</button>
											<input type="hidden" name="programID" value="<cfoutput>#rc.programID#</cfoutput>">
										</cfif>



							</form><br>
						</div>
					</div>
					</cfif>
				</cfif>

				<div class="row">
					<div class="col-md-12">
							<p class="text-muted">This panel displays all proposals that are relevant to you and/or require action.</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

						  <cfif structKeyExists(rc,"workloadsummary")  AND rc.workloadSummary.recordCount>
							  <cfoutput query="rc.workloadSummary" group="progress_status">
								  <cfif rc.workloadSummary.activityStatusCode lt 300 and rc.workloadSummary.activityStatusCode neq 210 and rc.workloadSummary.activityStatusCode neq 220>
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="heading#rc.workloadSummary.activityStatusCode#">
								      <h4 class="panel-title">
								        <a class="collapsed handpointer" data-toggle="collapse" data-target="##collapse#rc.workloadSummary.activityStatusCode#"  aria-expanded="false" aria-controls="collapse#rc.workloadSummary.activityStatusCode#">
								           #progress_status#<span id="#rc.workloadSummary.activityStatusCode#"></span>
								        </a>
								      </h4>
								    </div>
								    <div id="collapse#rc.workloadSummary.activityStatusCode#" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading#rc.workloadSummary.activityStatusCode#">
								      <div class="panel-body">
									      <table class="table table-striped table-hover" id="#rc.workloadSummary.activityStatusCode#ws">
													<thead>
														<tr>
															<th>ID</th>
															<th>Title</th>
															<th>Funding Mech</th>
															<th>Amount</th>
															<th>FY</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput>
														<cfif rc.workloadSummary.activityStatusCode lt 180>
															<cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0">
																<cfset targetPage = "view">
															<cfelse>
																<cfset targetPage = "editproject">
															</cfif>
														<cfelseif rc.workloadSummary.activityStatusCode gte 180 and rc.workloadSummary.activityStatusCode lt 300>
															<cfset targetPage = "review">
														<cfelse>
															<cfset targetPage = "fundimpmechanism">
														</cfif>

														<tr class="#rc.workloadSummary.activityStatusCode#">
															<td>
																<cfif rc.workloadSummary.reprogramfunds is 1 or rc.workloadSummary.implementationstatus is 'CN Re-notification'><i class="icon-repeat text-error"></i></cfif>
																<a href=#event.buildLink("proposal." & targetPage & ".activityID." & rc.workloadSummary.ActivityID)# title="Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a>
															</td>
															<td>
																<a href=#event.buildLink("proposal." & targetPage & ".activityID." & rc.workloadSummary.ActivityID)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(projectamount)#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a>
															</td>
															<td>#fundMechName#</td>
															<td>#dollarFormat(projectAmount)#</td>
															<td>#fiscalyear#</td>
														</tr>
													</cfoutput>
													</tbody>
												</table>
												<script>
													$("###rc.workloadSummary.activityStatusCode#").html(" - " + $("tr.#rc.workloadSummary.activityStatusCode#").length);
												</script>

								      </div>
								    </div>
								  </div>
								  <cfelseif (rc.workloadSummary.activityStatusCode gte 400 and rc.workloadSummary.activityStatusCode lt 500)>
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="heading#rc.workloadSummary.activityStatusCode#">
								      <h4 class="panel-title">
								        <a class="collapsed handpointer" data-toggle="collapse" data-target="##collapse#rc.workloadSummary.activityStatusCode#"  aria-expanded="false" aria-controls="collapse#rc.workloadSummary.activityStatusCode#">
								           #progress_status#<span id="#rc.workloadSummary.activityStatusCode#"></span>
								        </a>
								      </h4>
								    </div>
								    <div id="collapse#rc.workloadSummary.activityStatusCode#" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading#rc.workloadSummary.activityStatusCode#">
								      <div class="panel-body">
									      <table class="table table-striped table-hover" id="#rc.workloadSummary.activityStatusCode#ws">
													<thead>
														<tr>
															<th>ID</div></th>
															<th>Title</th>
															<th>Amount</th>
															<th>Budget Request Date</th>
															<th>FY</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput>

														<tr class="#rc.workloadSummary.activityStatusCode#">
															<td>
																<cfif rc.workloadSummary.reprogramfunds is 1 or rc.workloadSummary.implementationstatus is 'CN Re-notification'><i class="icon-repeat text-error"></i></cfif>
																<a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.workloadSummary.ActivityID)# title="Fund Mech: #fundMechName#<br>Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a></td>
															<td><a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.workloadSummary.ActivityID)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(projectamount)#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a></td>
															<td>#dollarFormat(projectAmount)#</td>
															<td>#dateFormat(BudgetFundRequestDate,"dd-mmm-yyyy")#</td>
															<td>#fiscalyear#</td>
														</tr>

													</cfoutput>
													</tbody>
												</table>
												<script>
													$("###rc.workloadSummary.activityStatusCode#").html(" - " + $("tr.#rc.workloadSummary.activityStatusCode#").length);
												</script>

								      </div>
								    </div>
								  </div>
								  <cfelseif rc.workloadSummary.activityStatusCode gte 500 and rc.workloadSummary.activityStatusCode lt 600 and rc.workloadSummary.activityStatusCode neq 510>
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="heading#rc.workloadSummary.activityStatusCode#">
								      <h4 class="panel-title">
								        <a class="collapsed handpointer" data-toggle="collapse" data-target="##collapse#rc.workloadSummary.activityStatusCode#"  aria-expanded="false" aria-controls="collapse#rc.workloadSummary.activityStatusCode#">
								           #progress_status#<span id="#rc.workloadSummary.activityStatusCode#"></span>
								        </a>
								      </h4>
								    </div>
								    <div id="collapse#rc.workloadSummary.activityStatusCode#" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading#rc.workloadSummary.activityStatusCode#">
								      <div class="panel-body">
									     <table class="table table-striped table-hover" id="#rc.workloadSummary.activityStatusCode#ws">
													<thead>
														<tr>
															<th>ID</th>
															<th>Title</th>
															<th>Amount Requested</th>
															<th>Obligated</th>
															<th>FY</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput>
														<tr class="#rc.workloadSummary.activityStatusCode#">
															<td>
																<cfif rc.workloadSummary.reprogramfunds is 1 or rc.workloadSummary.implementationstatus is 'CN Re-notification'><i class="icon-repeat text-error"></i></cfif>
																<a href=#event.buildLink("proposal.obstatus.activityID." & rc.workloadSummary.ActivityID)# title="Fund Mech: #fundMechName#<br>Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a></td>
															<td><a href=#event.buildLink("proposal.obstatus.activityID." & rc.workloadSummary.ActivityID)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(projectamount)#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a></td>
															<td>#dollarFormat(projectAmount)#</td>
															<td><span class="ttip" data-placement="right" title="Funding Requested: #dateFormat(BudgetFundRequestDate,"mm/dd/yyyy")#">#dollarFormat(obAmount)#</span></td>
															<td>#fiscalyear#</td>
														</tr>

													</cfoutput>
													</tbody>
												</table>
												<script>
													$("###rc.workloadSummary.activityStatusCode#").html(" - " + $("tr.#rc.workloadSummary.activityStatusCode#").length);
												</script>

								      </div>
								    </div>
								  </div>
								  <cfelseif rc.workloadSummary.activityStatusCode gte 600 and rc.workloadSummary.activityStatusCode lt 700>
								  <cfif isUserInRole('review activity')>
										<cfset sectionHead = "Set Implementation Status">
										<cfset secID = "sis">
									<cfelse>
										<cfset sectionHead = "MOU/IAA Modification Clearance Pending">
										<cfset secID = "mcp">
									</cfif>
								  <div class="panel panel-default">
								    <div class="panel-heading" role="tab" id="heading#rc.workloadSummary.activityStatusCode#">
								      <h4 class="panel-title">
								        <a class="collapsed handpointer" data-toggle="collapse" data-target="##collapse#rc.workloadSummary.activityStatusCode#"  aria-expanded="false" aria-controls="collapse#rc.workloadSummary.activityStatusCode#">
								           #sectionHead#<span id="#secID#"></span>
								        </a>
								      </h4>
								    </div>
								    <div id="collapse#rc.workloadSummary.activityStatusCode#" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading#rc.workloadSummary.activityStatusCode#">
								      <div class="panel-body">
									     <table class="table table-striped table-hover" id="#rc.workloadSummary.activityStatusCode#ws">
													<thead>
														<tr>
															<th>ID</th>
															<th>Title</th>
															<th>Start Date</th>
															<th>End Date</th>
															<th>Implementation</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput>
														<tr class="#secID#">
															<td>
																<cfif rc.workloadSummary.reprogramfunds is 1 or rc.workloadSummary.implementationstatus is 'CN Re-notification'><i class="icon-repeat text-error"></i></cfif>
																<cfif isUserInRole('review activity')>
																	<a href=#event.buildLink("proposal.impstatus.activityID." & rc.workloadSummary.ActivityID)# title="Fund Mech: #fundMechName#<br>Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a>
																<cfelse>
																	<a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.workloadSummary.ActivityID)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(projectamount)#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a>
																</cfif>
															</td>

															<td>
																<cfif isUserInRole('review activity')>
																	<a href=#event.buildLink("proposal.impstatus.activityID." & rc.workloadSummary.ActivityID)# title="#projectTitle#<br>Fund Mech: #fundMechName#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a>
																<cfelse>
																	<a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.workloadSummary.ActivityID)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(projectamount)#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a>
																</cfif>

																</td>
															<td>#dateFormat(startDate,"dd-mmm-yyyy")#</td>
															<td>#dateFormat(endDate,"dd-mmm-yyyy")#</td>
															<td>#implementationStatus#</td>
														</tr>

													</cfoutput>
													</tbody>
												</table>
												<script>
													$("###secID#").html(" - " + $("tr.#secID#").length);
												</script>

								      </div>
								    </div>
								  </div>
								  </cfif>
						  	</cfoutput>
						  </cfif>
						</div>
					</div>
				</div>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

<cfif IsUserInRole("view cn summary") >
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-tasks fa-fw"></i> Congressional Notifications
				<div class="pull-right">
					<cfif isUserInRole('link cn activities')>
							&nbsp;&nbsp;<cfoutput><a href=#event.buildLink("summary.newcnactivitylink")# class="btn btn-primary btn-xs">Create New CN</a></cfoutput>
					</cfif>
				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">


				<div class="row">
					<div class="col-md-12">
							<p class="text-muted">This panel displays all Congressional Notifications that are relevant to you and/or require action.</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
						<cfif structKeyExists(rc,"cnworkloadsummary")  AND rc.cnworkloadSummary.recordCount>
							  <div class="panel panel-default">
							    <div class="panel-heading" role="tab" id="headingOne">
							      <h4 class="panel-title">
							        <a class="collapsed handpointer" data-toggle="collapse" data-target="#collapseOne"  aria-expanded="false" aria-controls="collapseOne">
							          CN Clearance Pending<span id="cnclenum"></span>
							        </a>
							      </h4>
							    </div>
							    <div id="collapseOne" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="headingOne">
							      <div class="panel-body">
							        <table class="table table-striped table-hover" id="cnws">
													<thead>
														<tr>
															<th>CN Title</th>
															<th>CN #</div></th>
															<th>CN-Budget Submitted</th>
															<th>CN Transmitted</th>
															<th>
																<cfif isUserInRole('link cn activities')>
																	Action
																</cfif>
															</th>
															 <th style="width:200px">Pending With</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput query="rc.cnworkloadSummary" group="cnid">
														<tr  <cfif len(CongressSubmitDate) gt 0 and (now()-CongressSubmitDate) gt 15>class="success cncle"<cfelse> class="warning cncle"</cfif>>
															<cfif len(rc.cnworkloadSummary.cntitle) is 0>
																<cfset thecntitle = "CN Title Not Set">
															<cfelse>
																<cfset thecntitle = rc.cnworkloadSummary.cntitle>
															</cfif>
															<td><a href=#event.buildLink("proposal.cn.activityID." & rc.cnworkloadSummary.activityID & ".cnid." & rc.cnworkloadSummary.cnid)#>#thecntitle#</a></td>
															<td>#CNnumber#</td>
															<td>#dateFormat(BudgetSubmitDate,"dd-mmm-yyyy")#</td>
															<td>#dateFormat(CongressSubmitDate,"dd-mmm-yyyy")#</td>
															<td>
																<cfif isUserInRole('link cn activities')>
																	<a href=#event.buildLink("summary.cnactivitylink.cnID." & rc.cnworkloadSummary.cnID)#>Link Activities/Set CN Info</a>
																</cfif>&nbsp;
															</td>
															 <td>

																<cfif questions is 1>
																	Program
																<cfelseif questions is 2>
																	Budget
																<cfelseif questions is 3>
																    Program & Budget
																<cfelse>
																	<cfset pendingWithNames = pendingwith>
																	<cfset pendingWithNames = replace(pendingWithNames, 'AMCN ', '', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'SCT Coordinator', 'CT/EX', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'Legislative Affairs', 'Legislative Affairs Front Office (H/FO)', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'Congressional Affairs', 'Legislative Affairs (H)', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'Legal', 'Legal (L)', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'Management and Budget', 'Management and Budget (OMB)', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'Policy Planning', 'Policy Planning (S/P)', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'FA Front Office', 'FA Front Office (F/FO)', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'Foreign Assist', 'Foreign Assistance (F)', 'All')>
																	<cfset pendingWithNames = replace(pendingWithNames, 'FA Front Office (F/FO)', 'Foreign Assistance Front Office (F/FO)', 'All')>
																	#pendingWithNames#
																</cfif>

															</td>
														</tr>
														<cfoutput>
														<tr>
																<td>&nbsp;</td><td colspan="5">&nbsp;&nbsp;&nbsp;
																	<cfif rc.cnworkloadSummary.reprogramfunds is 1 or rc.cnworkloadSummary.implementationstatus is 'CN Re-notification'><i class="icon-repeat text-error"></i></cfif>
																	<a href=#event.buildLink("proposal.cn.activityID." & rc.cnworkloadSummary.ActivityID & ".cnid." & rc.cnworkloadSummary.cnid)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(budgetceilingamount)#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a> -
																	<a href=#event.buildLink("proposal.cn.activityID." & rc.cnworkloadSummary.ActivityID & ".cnid." & rc.cnworkloadSummary.cnid)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(budgetceilingamount)#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a>
																</td>
														</tr>
														</cfoutput>
													</cfoutput>
													</tbody>
												</table>
												<script>
													$("#cnclenum").html(" - " + $("tr.cncle").length);
												</script>
							      </div>
							    </div>
							  </div>
						  </cfif>
						  <cfif structKeyExists(rc,"cncongressworkloadsummary")  AND rc.cncongressworkloadsummary.recordCount>
							  <div class="panel panel-default">
							    <div class="panel-heading" role="tab" id="headingTwo">
							      <h4 class="panel-title">
							        <a class="collapsed handpointer" data-toggle="collapse" data-target="#collapseTwo"  aria-expanded="false" aria-controls="collapseTwo">
							          CN Congressional Approval Pending<span id="cnconnum"></span>
							        </a>
							      </h4>
							    </div>
							    <div id="collapseTwo" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="headingTwo">
							      <div class="panel-body">
							        <table class="table table-striped table-hover" id="cncongressws">
													<thead>
														<tr>
															<th>CN Title</th>
															<th>CN #</div></th>
															<th>CN-Budget Submitted</th>
															<th>CN Transmitted</th>
															<th>
																<cfif isUserInRole('link cn activities')>
																	Action
																</cfif>
															</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput query="rc.cncongressworkloadsummary" group="cnid">
														<tr  <cfif len(CongressSubmitDate) gt 0 and (now()-CongressSubmitDate) gt 15>class="success cncon"<cfelse> class="warning cncon"</cfif>>
															<cfif len(rc.cncongressworkloadsummary.cntitle) is 0>
																<cfset thecntitle = "CN Title Not Set">
															<cfelse>
																<cfset thecntitle = rc.cncongressworkloadsummary.cntitle>
															</cfif>
															<td><a href=#event.buildLink("proposal.cn.activityID." & rc.cncongressworkloadsummary.activityID & ".cnid." & rc.cncongressworkloadsummary.cnid)#>#thecntitle#</a></td>
															<td>#CNnumber#</td>
															<td>#dateFormat(BudgetSubmitDate,"dd-mmm-yyyy")#</td>
															<td>#dateFormat(CongressSubmitDate,"dd-mmm-yyyy")#</td>
															<td>
																<cfif isUserInRole('link cn activities')>
																	<a href=#event.buildLink("summary.cnactivitylink.cnID." & rc.cncongressworkloadsummary.cnID)#>Link Activities/Set CN Info</a>
																</cfif>&nbsp;
															</td>
														</tr>
														<cfoutput>
														<tr>
																<td>&nbsp;</td><td colspan="4">&nbsp;&nbsp;&nbsp;
																	<cfif rc.cncongressworkloadsummary.reprogramfunds is 1 or rc.cncongressworkloadsummary.implementationstatus is 'CN Re-notification'><i class="icon-repeat text-error"></i></cfif>
																	<a href=#event.buildLink("proposal.cn.activityID." & rc.cncongressworkloadsummary.ActivityID & ".cnid." & rc.cncongressworkloadsummary.cnid)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(budgetceilingamount)#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a> -
																	<a href=#event.buildLink("proposal.cn.activityID." & rc.cncongressworkloadsummary.ActivityID & ".cnid." & rc.cncongressworkloadsummary.cnid)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(budgetceilingamount)#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a>
																</td>
														</tr>
														</cfoutput>
													</cfoutput>
													</tbody>
												</table>
												<script>
													$("#cnconnum").html(" - " + $("tr.cncon").length);
												</script>
							      </div>
							    </div>
							  </div>
						  </cfif>
						  <cfif structKeyExists(rc,"cnholdwithdrawnworkloadsummary")  AND rc.cnholdwithdrawnworkloadsummary.recordCount>
						  <div class="panel panel-default">
						    <div class="panel-heading" role="tab" id="headingThree">
						      <h4 class="panel-title">
						        <a class="collapsed handpointer" data-toggle="collapse" data-target="#collapseThree"  aria-expanded="false" aria-controls="collapseThree">
						          CN On-Hold<span id="cnholnum"></span>
						        </a>
						      </h4>
						    </div>
						    <div id="collapseThree" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="headingThree">
						      <div class="panel-body">
						        <table class="table table-striped table-hover" id="cnohwws">
													<thead>
														<tr>
															<th>CN Title</th>
															<th>CN #</div></th>
															<th>CN-Budget Submitted</th>
															<th>CN Transmitted</th>
															<th>
																<cfif isUserInRole('link cn activities')>
																	Action
																</cfif>
															</th>
														</tr>
													</thead>
													<tbody>
													<cfoutput query="rc.cnholdwithdrawnworkloadsummary" group="cnid">
														<tr  <cfif len(CongressSubmitDate) gt 0 and (now()-CongressSubmitDate) gt 15>class="success cnhol"<cfelse> class="warning cnhol"</cfif>>
															<cfif len(rc.cnholdwithdrawnworkloadsummary.cntitle) is 0>
																<cfset thecntitle = "CN Title Not Set">
															<cfelse>
																<cfset thecntitle = rc.cnholdwithdrawnworkloadsummary.cntitle>
															</cfif>
															<td><a href=#event.buildLink("proposal.cn.activityID." & rc.cnholdwithdrawnworkloadsummary.activityID)#>#thecntitle#</a></td>
															<td>#CNnumber#</td>
															<td>#dateFormat(BudgetSubmitDate,"dd-mmm-yyyy")#</td>
															<td>#dateFormat(CongressSubmitDate,"dd-mmm-yyyy")#</td>
															<td>
																<cfif isUserInRole('link cn activities')>
																	<a href=#event.buildLink("summary.cnactivitylink.cnID." & rc.cnholdwithdrawnworkloadsummary.cnID)#>Link Activities/Set CN Info</a>
																</cfif>&nbsp;
															</td>
														</tr>
														<cfoutput>
														<tr>
																<td>&nbsp;</td><td colspan="4">&nbsp;&nbsp;&nbsp;
																	<cfif rc.cnholdwithdrawnworkloadsummary.reprogramfunds is 1 or rc.cnholdwithdrawnworkloadsummary.implementationstatus is 'CN Re-notification'><i class="icon-repeat text-error"></i></cfif>
																	<a href=#event.buildLink("proposal.cn.activityID." & rc.cnholdwithdrawnworkloadsummary.ActivityID)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(budgetceilingamount)#"  data-toggle="tooltip" data-placement="right">#proposalNumber#</a> -
																	<a href=#event.buildLink("proposal.cn.activityID." & rc.cnholdwithdrawnworkloadsummary.ActivityID)# title="#proposalNumber#<br>#projectTitle#<br>#dollarFormat(budgetceilingamount)#"  data-toggle="tooltip" data-placement="right">#left(projectTitle,70)#<cfif len(projectTitle) gt 70>...</cfif></a>
																</td>
														</tr>
														</cfoutput>
													</cfoutput>
													</tbody>
												</table>
												<script>
													$("#cnholnum").html(" - " + $("tr.cnhol").length);
												</script>
						      </div>
						    </div>
						  </div>
						  </cfif>

						</div>
					</div>
				</div>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>
</cfif>





<cfif IsUserInRole("create activity") or IsUserInRole("create activity all programs") >
	<div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <form name="objForm" id="objForm" class="formular"  method="post" action="<cfoutput>#event.buildLink('proposal.addProposal')#</cfoutput>">
	    		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<input type="hidden" name="sysUserID" value="<cfoutput>#getPlugin('SessionStorage').getVar('curUserAuth.sysUserID')#</cfoutput>">
			    <h3 id="myModalLabel">Add Project</h3>
		      </div>
		      <div class="modal-body">
			     <div class="form-group">
		        <label>Project Title</label>
			    <input type="text" name="Name" class="form-control" required value="">
			    </div>
			    <cfif IsUserInRole("create activity all programs")>
			    <div class="form-group">
				    <label>Program</label>
				    <select name="programID" class="form-control">
						<option value="5">CT</option>
						<option value="1">ATA</option>
						<option value="2">CTE</option>
						<option value="6">TSI</option>
					</select>
				</div>
				<cfelse>
					<input type="hidden" name="programid" value="<cfoutput>#rc.programID#</cfoutput>">
				</cfif>
		      </div>
		      <div class="modal-footer">
		        <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
			    <button class="btn btn-primary">Add Project</button>
				</form>
		      </div>
		    </div>
		  </div>



	</div>
</cfif>



