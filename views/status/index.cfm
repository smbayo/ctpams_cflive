<ol class="breadcrumb">
  <li class="active">Status</li>
</ol>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-archive fa-fw"></i> Review Stage
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">


	<div class="row">
		<div class="col-md-12">

		<!--- customize summary to role --->
		<cfif structKeyExists(rc,"review")  AND rc.review.recordCount>
		<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			 <cfoutput query="rc.review" group="progress_status">
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="heading#rc.review.activityStatusCode#">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="##accordion" href="##collapse#rc.review.activityStatusCode#" aria-expanded="false" aria-controls="collapse#rc.review.activityStatusCode#">
				           #progress_status#
				        </a>
				      </h4>
				    </div>
				    <div id="collapse#rc.review.activityStatusCode#" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading#rc.review.activityStatusCode#">
				      <div class="panel-body">
					     <table class="table table-striped table-hover" id="#rc.review.activityStatusCode#review">

					<thead>
						<tr>
							<th>ID</th>
							<th>Title</th>
							<th>Amount</th>
							<th>L Pre-Cleared</th>
							<th>FY</th>
							<th>Day(s)</th>
						</tr>
					</thead>
					<tbody>
						<cfoutput>

						<tr class="sectionReview first">
							<td><a href=#event.buildLink("proposal.review.activityID." & rc.review.ActivityID)# title="Fund Mech: #fundMechName#<br>Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#" data-toggle="tooltip" data-placement="right">#uCase(proposalNumber)#</a></td>
							<td><a href=#event.buildLink("proposal.review.activityID." & rc.review.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a></td>
							<td>#dollarFormat(projectAmount)#</td>

							<td>#dateFormat(clearedPrelegalDate,"dd-mmm-yyyy")#</td>
							<td>#fiscalyear#</td>
							<td><span data-toggle="tooltip" data-placement="right" title="Submitted: #dateFormat(proposalSubmitDate,"mm/dd/yyyy")#">#age#</span></td>
						</tr>

						</cfoutput>

					</tbody>
				</table>

				      </div>
				    </div>
				  </div>



			</cfoutput>
			</div>
		<cfelse>
			<!--- no records --->
					<h5>There are no items to display at this time.</h5>
		</cfif>
		</div>
	</div>

				</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-archive fa-fw"></i> CN Stage
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
<!---            start accordion                 --->
	<div class="row">
		<div class="col-md-12">
			<div class="panel-group" id="accordioncn" role="tablist" aria-multiselectable="true">
		<cfif structKeyExists(rc,"cnworkloadsummary")  AND rc.cnworkloadSummary.recordCount>
			<div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingOne">
			      <h4 class="panel-title">
			        <a data-toggle="collapse" data-parent="#accordioncn" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
			          CN Clearance Pending
			        </a>
			      </h4>
			    </div>
			    <div id="collapseOne" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="headingOne">
			      <div class="panel-body">
								<table class="table table-striped table-hover" id="cnws">
									<thead>
										<tr>
											<th>CN Title</th>
											<th>CN ##</div></th>
											<th>CN-Budget Submitted</th>
											<th>CN Transmitted</th>
											<!--- <th>FY</th> --->

											 <th scope="col"><div class="wide50">Questions</div></th>
										</tr>
									</thead>
									<tbody>
									<cfoutput query="rc.cnworkloadSummary" group="cnid">
										<tr  <cfif len(CongressSubmitDate) gt 0 and (now()-CongressSubmitDate) gt 15>class="success"<cfelse> class="warning"</cfif>>
											<cfif len(rc.cnworkloadSummary.cntitle) is 0>
												<cfset thecntitle = "CN Title Not Set">
											<cfelse>
												<cfset thecntitle = rc.cnworkloadSummary.cntitle>
											</cfif>
											<td><a href=#event.buildLink("proposal.cn.activityID." & rc.cnworkloadSummary.activityID)#>#thecntitle#</a></td>
											<td>#CNnumber#</td>
											<td>#dateFormat(BudgetSubmitDate,"dd-mmm-yyyy")#</td>
											<td>#dateFormat(CongressSubmitDate,"dd-mmm-yyyy")#</td>
											<!--- <td> #fiscalyear# </td> --->

											 <td>
												<cfif questions is 1>
													For Program
												<cfelseif questions is 2>
													For Budget
												<cfelseif questions is 3>
													For Program & Budget
												<cfelse>
													None
												</cfif>

											</td>
										</tr>
										<cfoutput>
										<tr>
												<td>&nbsp;</td><td colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<a href=#event.buildLink("proposal.cn.activityID." & rc.cnworkloadSummary.ActivityID)# title="" data-toggle="tooltip" data-placement="right">#proposalNumber#</a> -
													<a href=#event.buildLink("proposal.cn.activityID." & rc.cnworkloadSummary.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a>
												</td>
										</tr>
										</cfoutput>
									</cfoutput>
									</tbody>
								</table>
			      </div>
			    </div>
			  </div>

				</cfif>


				<cfif structKeyExists(rc,"cncongressworkloadsummary")  AND rc.cncongressworkloadsummary.recordCount>
				<div class="panel panel-default">
			    <div class="panel-heading" role="tab" id="headingTwo">
			      <h4 class="panel-title">
			        <a class="collapsed" data-toggle="collapse" data-parent="#accordioncn" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			          CN Congressional Approval Pending
			        </a>
			      </h4>
			    </div>
			    <div id="collapseTwo" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="headingTwo">
			      <div class="panel-body">
								<table class="table table-striped table-hover" id="cncongressws">
									<thead>
										<tr>
											<th>CN Title</th>
											<th>CN ##</div></th>
											<th>CN-Budget Submitted</th>
											<th>CN Transmitted</th>

											 <th scope="col"><div class="wide50">Questions</div></th>
										</tr>
									</thead>
									<tbody>
									<cfoutput query="rc.cncongressworkloadsummary" group="cnid">
										<tr  <cfif len(CongressSubmitDate) gt 0 and (now()-CongressSubmitDate) gt 15>class="success"<cfelse> class="warning"</cfif>>
											<cfif len(rc.cncongressworkloadsummary.cntitle) is 0>
												<cfset thecntitle = "CN Title Not Set">
											<cfelse>
												<cfset thecntitle = rc.cncongressworkloadsummary.cntitle>
											</cfif>
											<td><a href=#event.buildLink("proposal.cn.activityID." & rc.cncongressworkloadsummary.activityID)#>#thecntitle#</a></td>
											<td>#CNnumber#</td>
											<td>#dateFormat(BudgetSubmitDate,"dd-mmm-yyyy")#</td>
											<td>#dateFormat(CongressSubmitDate,"dd-mmm-yyyy")#</td>

											 <td>
												<cfif questions is 1>
													For Program
												<cfelseif questions is 2>
													For Budget
												<cfelseif questions is 3>
													For Program & Budget
												<cfelse>
													None
												</cfif>

											</td>
										</tr>
										<cfoutput>
										<tr>
												<td>&nbsp;</td><td colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<a href=#event.buildLink("proposal.cn.activityID." & rc.cncongressworkloadsummary.ActivityID)# title="" data-toggle="tooltip" data-placement="right">#proposalNumber#</a> -
													<a href=#event.buildLink("proposal.cn.activityID." & rc.cncongressworkloadsummary.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a>
												</td>
										</tr>
										</cfoutput>
									</cfoutput>
									</tbody>
								</table>
			      </div>
			    </div>
			  </div>
				</cfif>

				<cfif structKeyExists(rc,"cnholdwithdrawnworkloadsummary")  AND rc.cnholdwithdrawnworkloadsummary.recordCount>
			<div class="panel panel-default">
		    <div class="panel-heading" role="tab" id="headingThree">
		      <h4 class="panel-title">
		        <a class="collapsed" data-toggle="collapse" data-parent="#accordioncn" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		          CN On-Hold or Withdrawn
		        </a>
		      </h4>
		    </div>
		    <div id="collapseThree" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="headingThree">
		      <div class="panel-body">
								<table class="table table-striped table-hover" id="cnohwws">
									<thead>
										<tr>
											<th>CN Title</th>
											<th>CN ##</div></th>
											<th>CN-Budget Submitted</th>
											<th>CN Transmitted</th>

											 <th scope="col"><div class="wide50">Questions</div></th>
										</tr>
									</thead>
									<tbody>
									<cfoutput query="rc.cnholdwithdrawnworkloadsummary" group="cnid">
										<tr  <cfif len(CongressSubmitDate) gt 0 and (now()-CongressSubmitDate) gt 15>class="success"<cfelse> class="warning"</cfif>>
											<cfif len(rc.cnholdwithdrawnworkloadsummary.cntitle) is 0>
												<cfset thecntitle = "CN Title Not Set">
											<cfelse>
												<cfset thecntitle = rc.cnholdwithdrawnworkloadsummary.cntitle>
											</cfif>
											<td><a href=#event.buildLink("proposal.cn.activityID." & rc.cnholdwithdrawnworkloadsummary.activityID)#>#thecntitle#</a></td>
											<td>#CNnumber#</td>
											<td>#dateFormat(BudgetSubmitDate,"dd-mmm-yyyy")#</td>
											<td>#dateFormat(CongressSubmitDate,"dd-mmm-yyyy")#</td>
											<!--- <td> #fiscalyear# </td> --->

											 <td>
												<cfif questions is 1>
													For Program
												<cfelseif questions is 2>
													For Budget
												<cfelseif questions is 3>
													For Program & Budget
												<cfelse>
													None
												</cfif>

											</td>
										</tr>
										<cfoutput>
										<tr>
												<td>&nbsp;</td><td colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<a href=#event.buildLink("proposal.cn.activityID." & rc.cnholdwithdrawnworkloadsummary.ActivityID)# title="" data-toggle="tooltip" data-placement="right">#proposalNumber#</a> -
													<a href=#event.buildLink("proposal.cn.activityID." & rc.cnholdwithdrawnworkloadsummary.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a>
												</td>
										</tr>
										</cfoutput>
									</cfoutput>
									</tbody>
								</table>
		      </div>
		    </div>
		  </div>
				</cfif>

	</div>
</div>
</div>
<!---            end accordion                               --->
				</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-archive fa-fw"></i> Funding Stage
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
<!---            start accordion                               --->
	<div class="row">
		<div class="col-md-12">
		<cfset moucount = 0>
		<cfif structKeyExists(rc,"mechanism") AND rc.mechanism.recordCount >
		<div class="panel-group" id="accordionfun" role="tablist" aria-multiselectable="true">

			<cfoutput query="rc.mechanism" group="progress_status">
				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="heading#rc.mechanism.activityStatusCode#fun">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="##accordionfun" href="##collapse#rc.mechanism.activityStatusCode#fun" aria-expanded="false" aria-controls="collapse#rc.mechanism.activityStatusCode#fun">
				           #progress_status#
				        </a>
				      </h4>
				    </div>
				    <div id="collapse#rc.mechanism.activityStatusCode#fun" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading#rc.mechanism.activityStatusCode#fun">
				      <div class="panel-body">
				<table class="table table-striped table-hover" id="#rc.mechanism.activityStatusCode#fund">

					<thead>
						<tr>
							<th>ID</th>

							<th>Title</th>
							<th>CN ##</th>
							<th>Amount</th>
							<th>CN Approved</th>
							<th>FY</th>
						</tr>
					</thead>
					<tbody>
						<cfoutput>
							<cfif implementationstatus is "MOU Modification">
								<cfset moucount=1>
							</cfif>
						<tr>
							<td><a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.mechanism.ActivityID)# title="Fund Mech: #fundMechName#<br>Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#" data-toggle="tooltip" data-placement="right">#uCase(proposalNumber)#</a></td>

							<td><a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.mechanism.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a></td>
							<td>#AMCNnumber#</td>
							<td>#dollarFormat(projectAmount)#</td>
							<td>#dateFormat(AMCNApprovedDate,"dd-mmm-yyyy")#</td>
							<td>#fiscalyear#</td>

						</tr>

						</cfoutput>

					</tbody>
				</table>
						</div>
				    </div>
				  </div>

			</cfoutput>
		</cfif>

		<cfif moucount gt 0>

				<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="headingMOU">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="#accordionfun" href="#collapseMOU" aria-expanded="false" aria-controls="collapseMOU">
				           MOU Modification
				        </a>
				      </h4>
				    </div>
				    <div id="collapseMOU" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="headingMOU">
				      <div class="panel-body">
				<table class="table table-striped table-hover" id="moulistfund">

					<thead>
						<tr>
							<th>ID</th>
							<th>Title</th>
							<th>CN ##</th>
							<th>Amount</th>
							<th>CN Approved</th>
							<th>FY</th>
						</tr>
					</thead>
					<tbody>
						<cfoutput query="rc.mechanism">
							<cfif implementationstatus is "MOU Modification">
								<tr>
									<td><a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.mechanism.ActivityID)# title="Fund Mech: #fundMechName#<br>Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#" data-toggle="tooltip" data-placement="right">#uCase(proposalNumber)#</a></td>

									<td><a href=#event.buildLink("proposal.fundimpmechanism.activityID." & rc.mechanism.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a></td>
									<td>#AMCNnumber#</td>
									<td>#dollarFormat(projectAmount)#</td>
									<td>#dateFormat(AMCNApprovedDate,"dd-mmm-yyyy")#</td>
									<td>#fiscalyear#</td>

								</tr>
							</cfif>
						</cfoutput>

					</tbody>
				</table>
				</div>
				    </div>
				  </div>


		</cfif>
		</div>
	</div>
	</div>
<!---            end accordion                               --->

				</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-archive fa-fw"></i> Obligation Stage/Complete
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
	<div class="row">
		<div class="col-md-12">

	<cfif structKeyExists(rc,"obstatus") AND rc.obstatus.recordCount >
	<div class="panel-group" id="accordionob" role="tablist" aria-multiselectable="true">

		<cfoutput query="rc.obstatus" group="progress_status">
			<div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="heading#rc.obstatus.activityStatusCode#ob">
				      <h4 class="panel-title">
				        <a class="collapsed" data-toggle="collapse" data-parent="##accordionob" href="##collapse#rc.obstatus.activityStatusCode#ob" aria-expanded="false" aria-controls="collapse#rc.obstatus.activityStatusCode#ob">
				           #progress_status#
				        </a>
				      </h4>
				    </div>
				    <div id="collapse#rc.obstatus.activityStatusCode#ob" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading#rc.obstatus.activityStatusCode#ob">
				      <div class="panel-body">
				<table class="table table-striped table-hover" id="#rc.obstatus.activityStatusCode#ob">
				<thead>
					<tr>
						<th>ID</th>

						<th>Title</th>
						<th>CN ##</th>
						<th>Amount Requested</th>
						<th>Obligated</th>
						<th>FY</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput>
					<tr>
						<td><a href=#event.buildLink("proposal.obstatus.activityID." & rc.obstatus.ActivityID)# title="Fund Mech: #fundMechName#<br>Start Date: #dateFormat(startDate,"mm/dd/yyyy")#<br>End Date: #dateFormat(endDate,"mm/dd/yyyy")#" data-toggle="tooltip" data-placement="right">#uCase(proposalNumber)#</a></td>

						<td><a href=#event.buildLink("proposal.obstatus.activityID." & rc.obstatus.ActivityID)# title="#projectTitle#" data-toggle="tooltip" data-placement="right">#left(projectTitle,50)#<cfif len(projectTitle) gt 50>...</cfif></a></td>
						<td>#AMCNnumber#</td>
						<td>#dollarFormat(projectAmount)#</td>
						<td>#dollarFormat(obAmount)#</td>
						<td>#fiscalyear#</td>

					</tr>

					</cfoutput>

				</tbody>
			</table>
			 </div>
				    </div>
				  </div>
		</cfoutput>
		</div>
	<cfelse>
		<!--- no records --->
			<h5>There are no items to display at this time.</h5>
	</cfif>

	</div>
	</div>

				</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

