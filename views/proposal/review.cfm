<cfinclude template="header.cfm">
		<cfoutput>


<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-list-alt fa-fw"></i> Project Details
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">


	<cfif not len(rc.proposal.proposalApprovedDate)>
	<p><strong>Instructions:</strong> </p>
	<ol>
		<li>Please Review the following document.</li>
		<li>Be sure to review Legal's comments, edit the document, or sign off. </li>
	</ol>
	</cfif>


		<cfset QCount = 0>

			<table class="table table-striped table-hover">
			<tr>
					<!--- 2 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>. Project Title</label></td>
					<td>#rc.projectTitle#</td>
				</tr>
				<tr>
					<td>
						<!--- 1 --->
						<cfset QCount = QCount + 1>
						<label> <strong>#QCount#</strong>. Project Owner(s)</label></td>
						<td>
						<table class="table table-bordered table-striped table-condensed table-hover">
							<thead>
								<tr>
									<!--- <th>First Name</th> --->
									<th>Name</th><!--- Last  --->
									<th>Email</th>
									<th>Phone</th>
									<th>Office</th>
								</tr>
							</thead>
							<tbody>

							<cfloop query="rc.owners">

								<tr>
									<!--- <td>#rc.owners.firstName#</td> --->
									<td>#rc.owners.firstName# #rc.owners.lastName#</td>
									<td>#rc.owners.email# <cfif rc.owners.isSystemUser is 1><span data-toggle="tooltip" data-placement="top" title="#rc.owners.email# is in PAMS"><i class="fa fa-check-circle fa-fw"></i></span><cfelse><span data-toggle="tooltip" data-placement="top" title="#rc.owners.email# is not in PAMS"><i class="fa fa-times-circle fa-fw"></i></span></cfif></td>
									<td>#rc.owners.phone#</td>
									<td>#rc.owners.office#</td>
								</tr>
							</cfloop>
							</tbody>
						</table>
					</td>
				</tr>

				<tr>
					<!--- 3 --->
					<cfset QCount = QCount + 1>
					<td width="30%"><label> <strong>#QCount#</strong>.

					Project Purpose/Summary

					</label></td>
					<td>#rc.proposal.ProjectObjective#</td>
				</tr>
				<tr>
					<!--- 4 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>. Description of Project Proposed</label></td>
					<td>#rc.proposal.Description#</td>
				</tr>
				<tr>
					<!--- 16 --->
					<cfset QCount = QCount + 1>
					<td >
						<label><strong>#QCount#</strong>. Themes</label></td>
						<td>

									<ul class="list-unstyled">
										<cfif rc.themes.recordCount EQ 0>
											<li>None Selected</li>
										<cfelse>
											<cfloop query="rc.themes">
											<li>#rc.themes.Name#</li>
											</cfloop>
										</cfif>
									</ul>


					</td>
				</tr>
				<tr>
					<!--- 5 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>.
					<cfif rc.proposal.programID is 4>
						Project Context/Rationale
					<cfelse>
						Specify explicitly how this proposal advances US national security and foreign policy interests (CVE: Project Context/Rationale)
					</cfif>
					</label></td>
					<td>#rc.proposal.InterestSpecification#</td>
				</tr>
				<tr>
					<!--- 6 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>.
					Specify explicitly how this activity supports law enforcement's ability to counter terrorism or efforts to counter terrorist financing  (CVE: Law Enforcement Nexus - NADR funding only)
					</label></td>
					<td>#rc.proposal.LawEnforcementSpecification#</td>
				</tr>
				<tr>
					<!--- 7 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>.
					What have the sponsors of the  project done to coordinate this program with this interagency or multilateral partners? (CVE: Coordination)
					</label></td>
					<td>#rc.proposal.CoordinationSpecification#</td>
				</tr>
					<tr>
						<!--- 6 --->
						<cfset QCount = QCount + 1>
						<td><label> <strong>#QCount#</strong>.
						Project Monitoring (CVE: Measuring Impact and Effectiveness)
						</label></td>
						<td>#rc.proposal.lessonsLearned#</td>
					</tr>
					<tr>
						<!--- 7 --->
						<cfset QCount = QCount + 1>
						<td><label> <strong>#QCount#</strong>.
						Sustainability
						</label></td>
						<td>#rc.proposal.sustainability#</td>
					</tr>
					<tr>
						<!--- 7 --->
						<cfset QCount = QCount + 1>
						<td><label> <strong>#QCount#</strong>.
						 Neighborhood, City or Province
						</label></td>
						<td>#rc.proposal.cityProvince#</td>
					</tr>


					<tr>
						<!--- 6 --->
						<cfset QCount = QCount + 1>
						<td><label> <strong>#QCount#</strong>.
						Related Projects - Reprograms
						</label></td>
						<td><cfif len(rc.proposal.relatedprojects) gt 0>#rc.proposal.relatedProjects#<cfelse>None entered</cfif></td>
					</tr>

				<tr>
					<!--- 8 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>. Period of Performance</label></td>
					<td>
						<b>From:</b>&nbsp;#dateformat(rc.proposal.StartDate,"MM/DD/YYYY")#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<b>To:</b>&nbsp;#dateformat(rc.proposal.EndDate,"MM/DD/YYYY")#
					</td>
				</tr>
				<tr>
					<!--- 9 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>. Countries Engaged</label></td>
					<td>

						<ul class="list-inline">
							<cfif rc.proposal.placeOfImplementation EQ "Country" or rc.proposal.placeOfImplementation EQ "">
								<cfloop query="rc.projectCountries">
									<li>#Name#</li>
								</cfloop>

							<cfelseif rc.proposal.placeOfImplementation EQ "Region">
								<cfloop query="rc.projectRegions">
									<li>#Name#</li>
								</cfloop>
							<cfelseif rc.proposal.placeOfImplementation EQ "None">
								<li>Not Country/Region Specific</li>
							</cfif>
						</ul>

					</td>
				</tr>
				<cfif getPlugin("SessionStorage").getVar("curUserAuth.programID") is 2>
				<tr>
					<!--- 9 --->
					<cfset QCount = QCount + 1>
					<td><label> <strong>#QCount#</strong>. Organizations Engaged</label></td>
					<td>
						<ul class="list-unstyled">

								<cfloop query="rc.projectOrganizations">
									<li>#Name#</li>
								</cfloop>

						</ul>
					</td>
				</tr>
				</cfif>

				<tr>
					<!--- 11 --->
					<cfset QCount = QCount + 1>
					<td><label><strong> #QCount#</strong>. Implementing Partner</label> &nbsp;</td>

					<td>

						 <table class="table table-bordered table-striped table-condensed table-hover">
			              <thead>
			                <tr>
								  <th>Implementing Partner</th>
								  <cfif len(rc.implementer.implementingPartner)>
									  <th>Details</th>
								  </cfif>
				                  <th>POC Name</th>
				                  <th>Email</th>
				                  <th>Phone</th>
				                  <!--- <th>Actions</th> --->
				                </tr>
				              </thead>
				              <tbody>
								<cfset i = 0>
					                <tr class="noOne">
									  <td>
										  <cfif len(rc.proposal.implementingPartner)>
											  <cfloop query="rc.ctfPartners">
													<cfif (rc.ctfPartners.categoryID EQ rc.proposal.implementingPartner)>#name#</cfif>
												</cfloop>
											<cfelse>
												#rc.implementer.implementingPartner#
											</cfif>
													</td>
										<cfif len(rc.implementer.implementingPartner)>
									 	 <td>#rc.implementer.implementingPartner#</td>
								 	 </cfif>
									  <td> #rc.implementer.pocFirstName# #rc.implementer.pocLastName#</td>
									  <td> #rc.implementer.pocEmail#</td>
									  <td> #rc.implementer.pocPhone#</td>
					                </tr>
				              </tbody>
				            </table>
						</td>
				</tr>

				<tr>
					<!--- 11 --->
					<cfset QCount = QCount + 1>
					<!--- <td colspan="2"> --->
					<td>
						<label> <strong>#QCount#</strong>. Program Audience</label>
					</td>
					<td>
						#rc.proposal.ProgramAudience#
					</td>
				</tr>
				<tr>
					<!--- 12 --->
					<cfset QCount = QCount + 1>
					<!--- <td colspan="2"> --->
					<td>
						<label> <strong>#QCount#</strong>. Funding Amount Requested</label>
					</td>
					<td>
						#dollarFormat(rc.proposal.BudgetCeilingAmount)#
						&nbsp;<!---  --->
					</td>
				</tr>
				<tr>
					<!--- 13 --->
					<cfset QCount = QCount + 1>
					<td>
						<label><strong>#QCount#</strong>. Funding Breakdown</label></td>
						<td>
						<table class="table table-bordered table-striped table-condensed table-hover">
							<thead>
							<tr>
								<th>Country/Organization</th>
								<th>Budget Item</th>
								<th>Amount</th>
							</tr>
							</thead>
							<tbody>
							<cfloop query="rc.projectFunding">
								<tr>
									<td>#rc.projectFunding.Country#</td>
									<td>#rc.projectFunding.BudgetItem#</td>
									<td align="right">#dollarFormat(rc.projectFunding.BudgetAmount)#</td>
								</tr>
							</cfloop>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<!--- 14 --->
					<cfset QCount = QCount + 1>
					<td><!---  --->
						<label> <strong>#QCount#</strong>. Funding Mechanism</label></td>
						<td>

									<ul class="list-unstyled">
									<cfif rc.proposal.fundImpMechanismID EQ "">
										<li>None</li>
									<cfelse>
										<cfloop query="rc.FundMechTypes">
											<cfif rc.proposal.fundImpMechanismID EQ rc.FundMechTypes.CategoryID>
												<li>#rc.FundMechTypes.name#</li>
											</cfif>
										</cfloop>
									</cfif>
									</ul>

						<!--- </fieldset> --->
					</td>
				</tr>
				<tr>
					<!--- 15 --->
					<cfset QCount = QCount + 1>
					<td>
					<label> <strong>#QCount#</strong>. Results Framework</label></td>
					<td>


						<dl>
							<dt>Primary Program Results</dt>

                                <cfif rc.primaryResult.recordcount gt 0>
                                	<cfloop query="rc.primaryResult">
	                            	<dd>#rc.primaryResult.resultName#</dd>
                                	</cfloop>
                                <cfelse>
                                    <dd>No primary Result selected</dd>
                                </cfif>


                                <dt>Secondary Program Results</dt>

                                 <cfif rc.secondaryResult.recordcount gt 0>

                                <cfloop query="rc.secondaryResult">

	                            	<dd>#rc.secondaryResult.resultName#</dd>
                               </cfloop>

                                <cfelse>
                                   <dd> No primary Result selected</dd>
                                </cfif>
                        </dl>

					</td>
				</tr>
				<tr>
					<!--- 16 --->
					<cfset QCount = QCount + 1>
					<td >
						<label><strong>#QCount#</strong>. Funding Sources</label></td>
						<td>

									<ul class="list-unstyled">
										<cfif rc.projectFundingSources.recordCount EQ 0>
											<li>None Selected</li>
										<cfelse>
											<cfloop query="rc.projectFundingSources">
											<li>#rc.projectFundingSources.Name#</li>
											</cfloop>
										</cfif>
									</ul>


					</td>
				</tr>
				<tr>
					<!--- 17 --->
					<cfset QCount = QCount + 1>
					<!--- <td colspan="2"> --->
					<td>
						<label> <strong>#QCount#</strong>. Fiscal Year</label>
					</td>
					<td style="background: rgba(255, 255, 255, .6);padding-left:20px;">
						#rc.proposal.fiscalyear#
					</td>
				</tr>
				<tr>
					<!--- 17 --->
					<cfset QCount = QCount + 1>
					<td>
						<label><strong>#QCount#</strong>. Attached Documents</label>
					</td>
					<td style="background: rgba(255, 255, 255, .6);padding-left:20px;">

						<ul class="list-unstyled">
							<cfloop query="rc.attachedFiles">

									<li><a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.attachedFiles.AttachedFileID)# title="#rc.attachedFiles.UploadedFileName# uploaded: #dateformat(rc.attachedFiles.AttachedFileDate, 'mm/dd/yyyy')#" data-toggle="tooltip" data-placement="top"><i class="fa fa-file-text-o"></i> <cfif len(rc.attachedFiles.Name)>#rc.attachedFiles.Name#<cfelse>#rc.attachedFiles.UploadedFileName#</cfif></a><li>

							</cfloop>
						</ul>
						<!--- </fieldset> --->
					</td>
				</tr>

			</table>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

		<cfif IsUserInRole("post review comments")>
		<form name="legalForm" id="legalForm" class="formular"  method="post" action="#event.buildLink('proposal.saveReviewComment')#" enctype="multipart/form-data">
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments-o fa-fw"></i> Comments
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">




					<input type="hidden" name="activityID" value="#rc.activityID#">
					<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
					<input type="hidden" name="sender" value="#rc.roleName#">
					<input type="hidden" name="fundingSourceCnt" value="#rc.projectFundingSources.recordCount#">
					<input type="hidden" name="sysUserID" value="#rc.sysUserID#">


				        <dl>
						<cfif StructKeyExists(rc,"recommendations") AND rc.recommendations.recordCount>

							<cfloop query="rc.recommendations">
								<dt>#dateFormat(rc.recommendations.commentDate,'mm/dd/yyyy')# - #uCase(rc.recommendations.sender)#</dt>
								<dd>#rc.recommendations.comments#</dd>
							</cfloop>
						</cfif>
						<cfif len(trim(rc.proposal.clearedPrelegalDate))>
							<dt>#dateFormat(rc.proposal.clearedPrelegalDate,'mm/dd/yyyy')# - Legal signed off </dt>
						</cfif>
						</dl>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>

	<div class="col-md-6">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comment-o fa-fw"></i> Add Comments
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
									<span class="text-muted pull-right counter" id="lesLenContainer"><span name="lesLen" id="lesLen">2000</span> Characters Remaining</span>
							    	<textarea name="prelegalComment" rows="5" class="form-control" required="true"  onclick="textCounter(this, 'lesLen', 2000);$('##lesLenContainer').show();" onkeyup="textCounter(this, 'lesLen', 2000);" onkeydown="textCounter(this, document.proposalForm.lesLen, 2000);" maxlength="2000"></textarea>
							    	<br>
							    	<div class="navbar">
							    	<cfif rc.themes.recordCount EQ 0 and IsUserInRole("review activity") and len(trim(rc.proposal.clearedPrelegalDate)) and not len(trim(rc.proposal.proposalApprovedDate)) and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or IsUserInRole("edit all activities"))>
							    		<div class="navbar-inner text-center">
								    		<span class="text-danger">Edit proposal and add Themes/Tags to approve.</span><br><br>
							    		</div>
									</cfif>
					<div class="navbar-inner text-center">

							<button type="submit" class="btn btn-info pull-right btn-xs" name="addComment" value="Add Comment"><i class="icon-bullhorn icon-white"></i> Add Comment</button>
							<cfif (rc.proposal.activityStatusCode IS 210 or rc.proposal.activityStatusCode IS 220) and ((IsUserInRole("review activity") and rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid')) or IsUserInRole("reactivate all proposals"))>
								<button type="submit" class="btn btn-default btn-xs" name="reviewComplete" value="Re-activate Proposal">Re-activate Proposal</button>
							<cfelse>
								<cfif IsUserInRole("pre-legal review activity") and (rc.proposal.activityStatusCode IS 201 or rc.proposal.activityStatusCode IS 202)>
										<input type="hidden" name="setStatusID" value="270">
										<input type="hidden" name="setLogNote" value="legal made recommendation">
										<button type="submit" class="btn btn-warning btn-xs" name="saveComment" value="Send to Program"><i class="icon-repeat icon-white"></i> Send to Program</button>
										<button type="submit" class="btn btn-success btn-xs" name="prelegalClear" value="Pre-Clear Proposal"><i class="icon-ok icon-white"></i> Pre-Clear Proposal</button>
								<cfelseif IsUserInRole("review activity") and not len(trim(rc.proposal.clearedPrelegalDate)) and not len(trim(rc.proposal.proposalApprovedDate)) and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or IsUserInRole("edit all activities"))>
										<input type="hidden" name="setStatusID" value="269">
										<input type="hidden" name="setLogNote" value="program made comment to legal">
										<button type="submit" class="btn btn-success btn-xs" name="saveComment" value="Send to Legal"><i class="icon-ok icon-white"></i> Send to Legal</button>
								<cfelseif rc.themes.recordCount GT 0 and IsUserInRole("review activity") and len(trim(rc.proposal.clearedPrelegalDate)) and not len(trim(rc.proposal.proposalApprovedDate)) and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or IsUserInRole("edit all activities"))>
										<button type="submit" class="btn btn-success btn-xs" name="reviewComplete" value="Approve Proposal"><i class="icon-ok icon-white"></i> Approve Proposal</button>
								<cfelseif IsUserInRole("regional review") and (rc.proposal.activityStatusCode IS 180 or rc.proposal.activityStatusCode IS 181) and (listfind(rc.userRegionlist,rc.regionList) or listfind(rc.userRegionlist,rc.rsiRegionList))>
										<input type="hidden" name="setStatusID" value="268">
										<input type="hidden" name="setLogNote" value="regional review made comment to program">
										<button type="submit" class="btn btn-success btn-xs" name="saveComment" value="Send to Program"><i class="icon-ok icon-white"></i> Send to Program</button>
								</cfif>
								<cfif IsUserInRole("hold proposal") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or IsUserInRole("edit all activities"))>
									<button type="submit" class="btn btn-warning btn-xs" name="reviewComplete" value="Hold Proposal"><i class="icon-time icon-white"></i> Hold Proposal</button>
								</cfif>
								<cfif IsUserInRole("return proposal") and not len(trim(rc.proposal.proposalApprovedDate)) and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or IsUserInRole("edit all activities"))>
									<button onClick="if(confirm('Are you sure you want to send this proposal back?')) return true; else return false;"  type="submit" class="btn btn-warning btn-xs" name="btnReturnProposal" value="Send Proposal Back"><i class="icon-repeat icon-white"></i> Send Proposal Back</button>
								</cfif>
								<cfif IsUserInRole("deny proposal") and (rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid') or IsUserInRole("edit all activities"))>
									<button onClick="if(confirm('WARNING: No further action can be taken on this proposal once denied. Do you want to continue?')) return true; else return false;" type="submit" class="btn btn-danger btn-xs" name="reviewComplete" value="Deny Proposal"><i class="icon-ban-circle icon-white"></i> Deny Proposal</button>
								</cfif>

								<cfif (IsUserInRole("edit activity") and rc.proposal.programid is getPlugin('SessionStorage').getVar('curUserAuth.programid')) or listfind(getPlugin('SessionStorage').getVar('curUserAuth.editableProposals'),rc.proposal.activityid) or IsUserInRole("edit all activities") or IsUserInRole("edit project budget")>
										<a href="#event.buildLink("proposal.editproject.activityID." & rc.proposal.ActivityID)#" class="btn btn-primary btn-xs"><i class="icon-edit icon-white"></i> Edit Proposal</a>
								</cfif>
							</cfif>

						</div>
					</div>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>
		</form>
	<cfelseif listfind(rc.ownedprojectList,rc.proposal.activityid)>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments-o fa-fw"></i> Comments
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
				        <dl>
						<cfif StructKeyExists(rc,"recommendations") AND rc.recommendations.recordCount>

							<cfloop query="rc.recommendations">
								<dt>#dateFormat(rc.recommendations.commentDate,'mm/dd/yyyy')# - #uCase(rc.recommendations.sender)#</dt>
								<dd>#rc.recommendations.comments#</dd>
							</cfloop>
						</cfif>
						<cfif len(trim(rc.proposal.clearedPrelegalDate))>
							<dt>Legal signed off #dateFormat(rc.proposal.clearedPrelegalDate,'mm/dd/yyyy')#</dt>
						</cfif>
						</dl>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

	</cfif>
	<cfif (not IsUserInRole("edit activity") and not IsUserInRole("edit all activities") and not IsUserInRole("post review comments")) and IsUserInRole("edit project budget")>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">

            <!-- /.panel-heading -->
			<div class="panel-body">
		<a href="#event.buildLink("proposal.editproject.activityID." & rc.proposal.ActivityID)#" class="btn btn-primary btn-xs"><i class="icon-edit icon-white"></i> Edit Project Budget</a>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

	</cfif>


</cfoutput>
<!-- InstanceEndEditable -->

<script type="text/javascript">

		function textCounter(field,cntfield,maxlimit) {
		  if (field.value.length > maxlimit) {// if too long...trim it!
		    alert('Text exceeded ' + maxlimit + '. Excess characters were removed.');
		    field.value = field.value.substring(0, maxlimit);
		  }
		  else {// otherwise, update 'characters left' counter
		    document.getElementById(cntfield).innerHTML = maxlimit - field.value.length;
		  }
		}
</script>