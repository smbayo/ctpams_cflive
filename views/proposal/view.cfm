<cfset event.paramValue('jumpTo','') />


<br><br>

<cfoutput>
<div class="row">
	<div class="col-md-12">
	<!--- start panel --->
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-edit fa-fw"></i> <cfif cgi.PATH_INFO contains "/new">New Proposal<cfelse>Edit Proposal: #rc.proposal.proposalnumber#</cfif>
						<div class="pull-right">
							<cfif len(rc.proposal.activityid)>
									<a href="#event.buildLink("proposal.print.activityID." & rc.proposal.ActivityID)#" class="btn btn-success btn-xs pull-right">Export</a>
							</cfif>
						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">





	<p class="text-muted"><strong>Note:</strong>
	<ol class="text-muted">
		<li>You should <strong>Save</strong> periodically as you work on the proposal. After saving, you can log out and log back in to continue working.</li>
					<li>Scroll over question mark icons below to view tips</li>
					<li>Once you have saved a title, you will be able to export this form to Word</li>
	</ol>
	</p>



	<cfif ((isUserInRole('create activity') or isUserInRole('edit activity')) and getPlugin('SessionStorage').getVar('curUserAuth.programid') is rc.programid )  or listfind(getPlugin('SessionStorage').getVar('curUserAuth.submittedProposals'),rc.proposal.ActivityID) OR isUserInRole('edit all activities') OR isUserInRole('create activity all programs')>
	<cfset QCount = 0>

		<form  name="proposalForm" id="proposalForm" class="formular"  method="post" action="#event.buildLink('proposal.saveProposal')#" enctype="multipart/form-data">


		<input type="hidden" name="proposalNumber" value="#rc.proposal.proposalNumber#">
		<input type="hidden" name="activityID" value="#rc.proposal.ActivityID#">
		<input type="hidden" name="cnId" value="#rc.proposal.cnId#">
		<input type="hidden" name="cnTitle" value="#rc.proposal.cnTitle#">

		<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
		<input type="hidden" name="proposalSubmitDate" value="#rc.proposal.proposalSubmitDate#">
		<input type="hidden" name="clearedPrelegalDate" value="#rc.proposal.clearedPrelegalDate#">
		<input type="hidden" name="proposalApprovedDate" value="#rc.proposal.proposalApprovedDate#">
		<input type="hidden" name="AMCNBudgetSubmitDate" value="#rc.proposal.AMCNBudgetSubmitDate#">
		<input type="hidden" name="AMCNCongressSubmitDate" value="#rc.proposal.AMCNCongressSubmitDate#">
		<input type="hidden" name="AMCNApprovedDate" value="#rc.proposal.AMCNApprovedDate#">
		<input type="hidden" name="FundApprovedDate" value="#rc.proposal.FundApprovedDate#">
		<input type="hidden" name="BudgetFundRequestDate" value="#rc.proposal.BudgetFundRequestDate#">
		<input type="hidden" name="BudgetFundApprovalDate" value="#rc.proposal.BudgetFundApprovalDate#">
		<input type="hidden" name="amcnnumber" value="#rc.proposal.amcnnumber#">

		<input type="hidden" name="reprogramFunds" value="#rc.proposal.reprogramFunds#">
		<input type="hidden" name="ctex" value="#rc.proposal.ctex#">
		<input type="hidden" name="reprogramComments" value="#rc.proposal.reprogramComments#">


		<input type="hidden" name="roleName" value="#rc.roleName#">
		<input type="hidden" name="isNewProposal" value="#rc.isNewProposal#">
		<input type="hidden" name="pagetitle" value="#rc.pagetitle#">
		<input type="hidden" name="sysUserID" value="#getPlugin('SessionStorage').getVar('curUserAuth.sysUserID')#">
		<input type="hidden" name="programID" value="#rc.programID#">

				<!--- 2 --->
				<cfset QCount = QCount + 1>

				<div class="form-group">
					<label><strong>#QCount#</strong>. Project Title <i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 255."></i></label>
					<input type="text" name="projectTitle" id="projectTitle" value="#rc.projectTitle#" required maxlength="255" class="form-control">
				</div>
				<!--- 1 --->
				<cfset QCount = QCount + 1>
				<cfset o = 0>

				<div class="row">
					<div class="col-md-12">
					<label><strong>#QCount#</strong>. Project Owner(s) <span data-toggle="tooltip" title="Project Owner is the individual who will receive email notifications regarding the proposal approvals process – typically this is the person submitting the proposal. You may enter additional Project Owners."><i class="fa fa-question-circle fa-fw"></i></span></label>
						<cfloop query="rc.owners">
							<cfset o = o + 1>
								<div class="row">
									<div class="col-md-1 form-group">
										<cfif o GT 1>
										<label>Del</label><br><input type="Checkbox" name="ownerDelete_#o#" value="1"  />
										</cfif>

									</div>

									<div class="col-md-2 form-group">
									<label>First Name</label>
									<input type="text" name="ownerfirstname_#o#" value="#rc.owners.firstName#" class="form-control">
									</div>

									<div class="col-md-2 form-group">
									<label>Last Name</label>
									<input type="text" name="ownerlastname_#o#" value="#rc.owners.lastName#"  class="form-control">
									</div>

									<div class="col-md-2 form-group">
									<label>Email</label>
									<input type="email" name="owneremail_#o#" size="25" value="#rc.owners.email#"  class="form-control">

									</div>

									<div class="col-md-2 form-group">
									<label>Phone</label>
									<input type="text" name="ownerphone_#o#" size="13" value="#rc.owners.phone#"  class="form-control">
									</div>

									<div class="col-md-2 form-group">
									<label>Agency/Office</label>
									<input type="text" name="owneroffice_#o#" size="13" value="#rc.owners.office#"  class="form-control">
									</div>
									<div class="col-md-1 form-group">
										<cfif structKeyExists(rc.owners,"isSystemUser")>
										<label>PAMS</label><br>
										<cfif rc.owners.isSystemUser is 1><span data-toggle="tooltip" data-placement="top" title="#rc.owners.email# is in PAMS"><i class="fa fa-check-circle fa-fw"></i></span><cfelse><span data-toggle="tooltip" data-placement="top" title="#rc.owners.email# is not in PAMS"><i class="fa fa-times-circle fa-fw"></i></span></cfif>
										</cfif>
									</div>
								</div>
									<input type="hidden" name="ActivityPersonID_#o#" value="#rc.owners.activityPersonID#">

							</cfloop>
							<input type="hidden" name="ocnt" value="#o#">


							<button type="submit" name="btnAddRow"  class="btn btn-default btn-xs pull-right" value="Add Additional Project Owner">Add Additional Project Owner</button>
						</div>
					</div>
				<!--- 3 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>.
						Project Purpose/Summary
					<span data-toggle="tooltip" title="Character maximum 1000. The Project Purpose should include a brief project summary that is descriptive and specific to the project in question."><i class="fa fa-question-circle fa-fw"></i></span>
					<span class="muted pull-right counter" id="objectiveLenContainer"><span name="objectiveLen" id="objectiveLen">1000</span> Characters Remaining</span>
					</label>

					<textarea name="projectobjective" id="projectobjective" rows="4" onclick="textCounter(this, 'objectiveLen', 1000);$('##objectiveLenContainer').show();" onkeyup="textCounter(this, 'objectiveLen', 1000);" onkeydown="textCounter(this, document.proposalForm.objectiveLen, 1000);" maxlength="1000" class="form-control">#rc.proposal.ProjectObjective#</textarea>
				</div>

				<!--- 4 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>.
						Description of Project Proposed
						<span data-toggle="tooltip" title="Character minimum 300, maximum 4000. Provide a detailed description of activities and include a work plan which describes what will be done in what sequence, over what period of time."><i class="fa fa-question-circle fa-fw"></i></span>
						<span class="muted pull-right counter" id="descriptionLenContainer"><span name="descriptionLen" id="descriptionLen">4000</span> Characters Remaining</span>
					</label>

					<textarea name="Description" id="Description"  rows="7" onclick="textCounter(this, 'descriptionLen', 4000);$('##descriptionLenContainer').show();" onkeyup="textCounter(this, 'descriptionLen', 4000);" onkeydown="textCounter(this, document.proposalForm.descriptionLen, 4000);" maxlength="4000" class="form-control">#rc.proposal.Description#</textarea>
				</div>

				<!--- 5 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>.
					Specify explicitly how this proposal advances US national security and foreign policy interests (CVE: Project Context/Rationale)
					<span data-toggle="tooltip" title="Character maximum 1000.(CVE: Describe the violent extremism problem or challenge – including: drivers of radicalization/recruitment, geographic areas of concern, and target population/audience that the project seeks to address.  For Posts/USG agencies: How would this project support U.S. national-security or foreign-policy goals?)"><i class="fa fa-question-circle fa-fw"></i></span>
					<span class="muted pull-right counter" id="interestLenContainer"><span name="interestLen" id="interestLen">1000</span> Characters Remaining</span>

					</label>

					<textarea name="interestSpecification" id="interestSpecification" rows="5" onclick="textCounter(this, 'interestLen', 1000);$('##interestLenContainer').show();" onkeyup="textCounter(this, 'interestLen', 1000);" onkeydown="textCounter(this, document.proposalForm.interestLen, 1000);" maxlength="1000" class="form-control">#rc.proposal.InterestSpecification#</textarea>
				</div>



				<!--- 6 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>.
					Specify explicitly how this activity supports law enforcement's ability to counter terrorism or efforts to counter terrorist financing  (CVE: Law Enforcement Nexus - NADR funding only)
					<span data-toggle="tooltip" title="Character maximum 1000. (CTF:  Please include any previous work and describe the future sequencing that this proposal may imply.)"><i class="fa fa-question-circle fa-fw"></i></span>
					<span class="muted pull-right counter" id="lawLenContainer"><span name="lawLen" id="lawLen">1000</span> Characters Remaining</span>
					</label>

					<textarea name="lawEnforcementSpecification" id="lawEnforcementSpecification" rows="5" onclick="textCounter(this, 'lawLen', 1000);$('##lawLenContainer').show();" onkeyup="textCounter(this, 'lawLen', 1000);" onkeydown="textCounter(this, document.proposalForm.lawLen, 1000);" maxlength="1000" class="form-control">#rc.proposal.LawEnforcementSpecification#</textarea>

				</div>

				<!--- 7 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>.
					What have the sponsors of the  project done to coordinate this program with this interagency or multilateral partners? (CVE: Coordination)
					<span data-toggle="tooltip" title="Character maximum 4000. What offices/agencies have been consulted? How did you ensure this is not duplicative? (CVE: Are other USG entities, donor governments, host government(s), or non-governmental entities implementing similar programming? Briefly describe the relevant donor landscape.  How would this project complement ongoing programming?  Project proposals that reflect specific lessons learned are especially welcome.)"><i class="fa fa-question-circle fa-fw"></i></span>
					<span class="muted pull-right counter" id="coordLenContainer"><span name="coordLen" id="coordLen">4000</span> Characters Remaining</span>
					</label>

					<textarea name="coordinationSpecification" id="coordinationSpecification" rows="7" onclick="textCounter(this, 'coordLen', 4000);$('##coordLenContainer').show();"  onkeyup="textCounter(this, 'coordLen', 4000);" onkeydown="textCounter(this, document.proposalForm.coordLen, 4000);" maxlength="4000" class="form-control">#rc.proposal.CoordinationSpecification#</textarea>
				</div>


				<!--- 7 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>.
						Project Monitoring (CVE: Measuring Impact and Effectiveness)
					<span data-toggle="tooltip" title="Character maximum 4000. Explain in 3-5 sentences how you expect to regularly monitor the work undertaken in the project in terms of performance and results. (CVE: Based on project objectives, what results, indicators, and methods would be used to measure project effectiveness and impact? (Methods include baseline assessments with focus-group discussion with project beneficiaries; post-activity surveys of participants; etc.) What is the plan to evaluate the project at the conclusion of implementation?)"><i class="fa fa-question-circle fa-fw"></i></span>
					<span class="muted pull-right counter" id="lesLenContainer"><span name="lesLen" id="lesLen">4000</span> Characters Remaining</span>
					</label>

					<textarea name="lessonslearned" id="lessonslearned"  rows="7" onclick="textCounter(this, 'lesLen', 4000);$('##lesLenContainer').show();" onkeyup="textCounter(this, 'lesLen', 4000);" onkeydown="textCounter(this, document.proposalForm.lesLen, 4000);" maxlength="4000" class="form-control">#rc.proposal.lessonsLearned#</textarea>
				</div>

				<!--- 7 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>.
						Sustainability (if applicable)
					<span data-toggle="tooltip" title="Character maximum 4000. Briefly, what is the sustainability plan for this project (one paragraph)?"><i class="fa fa-question-circle fa-fw"></i></span>
					<span class="muted pull-right counter" id="susLenContainer"><span name="susLen" id="susLen">4000</span> Characters Remaining</span>
					</label>

					<textarea name="sustainability" id="sustainability"  rows="7" onclick="textCounter(this, 'susLen', 4000);$('##susLenContainer').show();" onkeyup="textCounter(this, 'susLen', 4000);" onkeydown="textCounter(this, document.proposalForm.susLen, 4000);" maxlength="4000" class="form-control">#rc.proposal.sustainability#</textarea>
				</div>

				<!--- 2 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>. Neighborhood, City or Province (if applicable)
					<span data-toggle="tooltip" title="Character maximum 255."><i class="fa fa-question-circle fa-fw"></i></span>
					</label>

					<input type="text" name="cityProvince" id="cityProvince" value="#rc.proposal.cityProvince#" maxlength="255" class="form-control">
				</div>


			<div class="form-group">
							<cfset QCount = QCount + 1>
					<label><strong>#QCount#</strong>.
						Related Projects
					<span data-toggle="tooltip" title="Character maximum 4000. List in this space any project IDs that are related to this project. Leave explanatory note as needed. This is unrelated to CN linkages."><i class="fa fa-question-circle fa-fw"></i></span>
					<span class="muted pull-right counter" id="relProjContainer"><span name="relProj" id="relProj">4000</span> Characters Remaining</span>
					</label>

					<textarea name="relatedProjects" id="relatedProjects"  rows="7" onclick="textCounter(this, 'relProj', 4000);$('##relProjContainer').show();" onkeyup="textCounter(this, 'relProj', 4000);" onkeydown="textCounter(this, document.proposalForm.relProj, 4000);" maxlength="4000" class="form-control">#rc.proposal.relatedProjects#</textarea>
				</div>

				<!--- 8 --->

				<cfset QCount = QCount + 1>
				<div class="row">
						<div class="col-md-12">
						<label><strong>#QCount#</strong>. Period of Performance</label>
					<div class="row">
						<div class="form-group col-md-6">
						<label for="startDate">From</label>
						<input type="text" id="startDate" name="startDate" value="#dateFormat(rc.proposal.StartDate,'mm/dd/yyyy')#" class="form-control" />
						</div>
						<div class="form-group col-md-6">
						<label for="endDate">To</label>
						<input type="text" id="endDate" name="endDate" value="#dateFormat(rc.proposal.EndDate,'mm/dd/yyyy')#" class="form-control"  />
						</div>
					</div>
					</div>
				</div>

				<!--- 9 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">

						<label><strong>#QCount#</strong>. Countries Engaged
						<span data-toggle="tooltip" title="Choose all that apply. If the project is not country-specific, leave unselected."><i class="fa fa-question-circle fa-fw"></i></span>
						</label>

						<select name="projectCountries" id="countryID" multiple="multiple" style="width:100%;">
							<cfloop query="rc.countriesAll">
								<option value="#CategoryID#" <cfif listfind(rc.projectcountryIDs, rc.countriesAll.categoryID)> selected</cfif> class="form-control">#Name#</option>
							</cfloop>
						</select>

				</div>


			<cfif rc.programid is 2>

				<!--- 9 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">

						<label><strong>#QCount#</strong>. Organizations Engaged
						<span data-toggle="tooltip" title="Choose all that apply."><i class="fa fa-question-circle fa-fw"></i></span>
						</label>

								<select name="projectOrganizations" id="orgID" multiple="multiple" style="width:100%;">
									<cfloop query="rc.allOrganizations">
										<option value="#CategoryID#" <cfif listfind(rc.projectorgIDs, rc.allOrganizations.categoryID)> selected</cfif> class="form-control">#Name#</option>
									</cfloop>
								</select>
				</div>


			</cfif>

			<div class="row">
						<div class="col-md-12">
					<cfset QCount = QCount + 1>
					<label><strong>#QCount#</strong>. Implementing Partner
					<span data-toggle="tooltip" title="Select the organization implementing the proposal. Details field must be filled in if 'NGO', 'Other' or 'Post Implemented' are selected, and be sure to look for your specific implementer in the list before selecting these.  Please write in full implementer name without abbreviations."><i class="fa fa-question-circle fa-fw"></i></span>
					</label>

								<div class="row">
									<div class="col-md-2 form-group">
									<label>Organization</label>
									<select name="implementingPartner"  class="form-control">
										<option value="" <cfif (rc.proposal.implementingPartner EQ "")>selected</cfif>>None</option>
										<cfloop query="rc.ctfPartners">
											<option value="#categoryID#" <cfif (rc.ctfPartners.categoryID EQ rc.proposal.implementingPartner)>selected</cfif>>#name#</option>
										</cfloop>
									</select>
									</div>

									<div class="col-md-2 form-group">
									<label>Details <span data-toggle="tooltip" title="Optional field that must be filled in if 'Post Implemented', NGO' or 'Other' are selected.  Please write in full implementer name without abbreviations."><i class="icon-exclamation-sign"></i></span></label>
									<input type="text" name="implementingpartner_1" value="#rc.implementer.implementingpartner#"  class="form-control">
									</div>

									<div class="col-md-2 form-group">
									<label>POC First Name</label>
									<input type="text" name="implementerpocfirstname_1" value="#rc.implementer.pocFirstName#"  class="form-control">
									</div>

									<div class="col-md-2 form-group">
									<label>POC Last Name</label>
									<input type="text" name="implementerpoclastname_1" value="#rc.implementer.pocLastName#"   class="form-control">
									</div>

									<div class="col-md-2 form-group">
									<label>POC Email</label>
									<input type="email" name="implementerpocemail_1" value="#rc.implementer.pocEmail#"   class="form-control">
									</div>

									<div class="col-md-2 form-group">
									<label>POC Phone</label>
									<input type="text" name="implementerpocphone_1" value="#rc.implementer.pocPhone#"   class="form-control">
									</div>
								</div>

					 <input type="hidden" name="implementingorganization_1" value="n/a">
					<input type="hidden" name="icnt" value="1">


					</div>
				</div>

				<!--- 11 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
					<label><strong>#QCount#</strong>. Program Audience
					<span data-toggle="tooltip" title="Character maximum 255."><i class="fa fa-question-circle fa-fw"></i></span>
					</label>
				    <input type="text" name="programaudience" value="#rc.proposal.ProgramAudience#" class="form-control">
				</div>

				<!--- 12 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">
				<label><strong>#QCount#</strong>. Funding Amount Requested
				</label>
					<div class="input-group" style="width:250px">
						<span class="input-group-addon">$</span>
						<input type="text"  name="BudgetCeilingAmount" value="#rc.proposal.BudgetCeilingAmount#" class="form-control">
						<span class="input-group-addon">.00</span>
					</div>

				</div>

				<!--- 13 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">

					<label><strong>#QCount#</strong>. Funding Breakdown
					<span data-toggle="tooltip" title="List a budget breakdown by country or organization. If services are engaged or experts are employed, attribute funds to the country/organization receiving such services. Any countries listed in budget breakdown should also be selected in the Countries Engaged section."><i class="fa fa-question-circle fa-fw"></i></span>
					</label>


							<cfset b = 0>
							<cfloop query="rc.projectFunding">
								<cfset b = b + 1>
								<div class="row">
									<div class="col-md-1 form-group">
										<cfif b GT 1>
										<label>Del</label><br><input type="Checkbox" name="fundingDelete_#b#" value="1" />
										</cfif>
									</div>

									<div class="col-md-5 form-group">
									<label>Country/Organization</label>
									<select name="budgetcountry_#b#" class="form-control">
											<option value="">Select Country or Organization</option>
											<cfloop query="rc.regionCountryAll">
												<option value="#categoryID#" <cfif rc.regionCountryAll.CategoryID EQ rc.projectFunding.CountryID>selected</cfif>>#Name#</option>
											</cfloop>
												<cfloop query="rc.allOrganizations">
													<option value="#CategoryID#" <cfif rc.allOrganizations.CategoryID EQ rc.projectFunding.CountryID>selected</cfif>>#Name#</option>
												</cfloop>
										</select>
									</div>

									<div class="col-md-3 form-group">
									<label>Budget Item</label>
									<input type="text" name="budgetitem_#b#" value="#rc.projectFunding.BudgetItem#" class="form-control">

									</div>

									<div class="col-md-3 form-group">
									<label>Amount</label>
									<div class="input-group">
										<span class="input-group-addon">$</span>
										<input type="text"  name="budgetamount_#b#" value="#rc.projectFunding.BudgetAmount#" class="form-control">
										<span class="input-group-addon">.00</span>
									</div>
									</div>
								</div>


							</cfloop>

						<input type="hidden" name="bcnt" value="#b#">

					<button type="submit" name="btnAddRow"  class="btn btn-default btn-xs pull-right"  value="Add Additional Budget Item">Add Additional Budget Item</button>

				</div>

				<!--- 14 --->
				<cfset QCount = QCount + 1>
				<div class="form-group">

				<label><strong>#QCount#</strong>. Funding Mechanism Type
				</label>

					<select name="fundImpMechanismID" id="fundMech" class="form-control"   style="width:240px">
						<option value="" <cfif (rc.proposal.fundImpMechanismID EQ "")>selected</cfif>>Select Funding Mechanism</option>
						<cfloop query="rc.FundMechTypes">
							<option value="#categoryID#" <cfif (rc.proposal.fundImpMechanismID EQ categoryID)>selected</cfif>>#name#</option>
						</cfloop>
					</select>
				</div>
					<!--- </cfif> --->

			<cfif IsUserInRole("add activity objectives and funding")>

				<cfset QCount = QCount + 1>
				<div class="form-group">

					<label><strong>#QCount#</strong>. Primary Program Result
					<span data-toggle="tooltip" title="Choose the objective that is most applicable to your activity."><i class="fa fa-question-circle fa-fw"></i></span>
					</label>
					<select name="resultsFrameworkelementID" id="primaryResult" class="form-control">
						<option value="" >Select Primary Program Result</option>
						<cfloop query="rc.programresults">
							<option value="#resultsframeworkelementID#" <cfif (rc.resultsFrameworkElementID EQ rc.programresults.resultsframeworkelementID)> selected</cfif> class="form-control"><cfif rc.programid is 5>#program# - </cfif>#name#</option>
						</cfloop>
					</select>
					 <input type="hidden" name="isPrimary" value="1">
				</div>


				<cfset QCount = QCount + 1>
				<div class="form-group">

					<label><strong>#QCount#</strong>. Secondary Program Results
					<span data-toggle="tooltip" title="It is not mandatory to choose a secondary objective."><i class="fa fa-question-circle fa-fw"></i></span>
					</label>
					<select name="SecondaryResultsList" id="secondaryResults" multiple="true" class="form-control">
						<cfloop query="rc.programresults">
							<option value="#resultsframeworkelementID#" <cfif listFind(rc.secondaryResultsList,rc.programresults.resultsFrameworkElementID) is not 0> selected</cfif>><cfif rc.programid is 5>#program# - </cfif>#name#</option>
						</cfloop>
					</select>

					<input type="hidden" name="oicnt" value="0">
				</div>

				<cfset QCount = QCount + 1>
				<div class="form-group">
				<label><strong>#QCount#</strong>. Funding Sources
				</label>
						<select name="projectFundingSources" id="fundingSources" multiple="multiple"  class="form-control" style="width:240px">
							<cfloop query="rc.fundingSourcesAll">
								<option value="#rc.fundingSourcesAll.CategoryID#" <cfif listfind(rc.fundingSourceIDs, rc.fundingSourcesAll.categoryID)> selected</cfif>>#rc.fundingSourcesAll.name#</option>
							</cfloop>
						</select>
				</div>



				<cfset QCount = QCount + 1>
				<div class="form-group">
				<label><strong>#QCount#</strong>. Fiscal Year
				</label>
						<cfparam name="rc.fiscalyear" default="">

					<select name="FiscalYear" style="width:90px" class="form-control">
							<option value="2008" <cfif rc.proposal.fiscalyear is 2008 or rc.fiscalyear is 2008> selected</cfif>>2008</option>
							<option value="2009" <cfif rc.proposal.fiscalyear is 2009 or rc.fiscalyear is 2009> selected</cfif>>2009</option>
							<option value="2010" <cfif rc.proposal.fiscalyear is 2010 or rc.fiscalyear is 2010> selected</cfif>>2010</option>
							<option value="2011" <cfif rc.proposal.fiscalyear is 2011 or rc.fiscalyear is 2011> selected</cfif>>2011</option>
							<option value="2012" <cfif rc.proposal.fiscalyear is 2012 or rc.fiscalyear is 2012> selected</cfif>>2012</option>
							<option value="2013" <cfif rc.proposal.fiscalyear is 2013 or rc.fiscalyear is 2013> selected</cfif>>2013</option>
							<option value="2014" <cfif rc.proposal.fiscalyear is 2014 or rc.fiscalyear is 2014> selected</cfif>>2014</option>
							<option value="2015" <cfif rc.proposal.fiscalyear is 2015 or rc.fiscalyear is 2015> selected</cfif>>2015</option>
							<option value="2016" <cfif rc.proposal.fiscalyear is 2016 or rc.fiscalyear is 2016> selected</cfif>>2016</option>
					</select>
				</div>

			<cfelse>
				<input type="hidden" name="fiscalYear" value="#rc.proposal.fiscalyear#">
				<input type="hidden" name="oicnt" value="0">
			</cfif>


				<input type="hidden" name="skipAMCN">




				<!--- 17 --->
				<cfset QCount = QCount + 1>
			<div class="row">
						<div class="col-md-12">
		<label><strong>#QCount#</strong>. Attach Documents <span class="text-danger">(Unclassified only - No SBU)</span>

		</label>


				<cfset f = 0>
				<cfloop query="rc.attachedFiles">

					<cfset f = f + 1>
						<cfif len(trim(rc.attachedFiles.AttachedFileName))>
						<div class="row">
						<div class="col-md-6">

							#f#. <a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.attachedFiles.AttachedFileID)# data-toggle="tooltip" title="#rc.attachedFiles.UploadedFileName#" data-placement="right"><cfif len(rc.attachedFiles.Name)>#rc.attachedFiles.Name#<cfelse>#rc.attachedFiles.UploadedFileName#</cfif></a>
						</div>
						<div class="col-md-4">
						<input type="Checkbox" name="deleteFile" value="#f#">
							(<i>delete</i>)

						<input type="hidden" name="AttachedFileID_#f#" value="#rc.attachedFiles.AttachedFileID#">
						<input type="hidden" name="AttachedFileName_#f#" value="#rc.attachedFiles.AttachedFileName#">
						<input type="hidden" name="UploadedFileName_#f#" value="#rc.attachedFiles.UploadedFileName#">
						<input type="hidden" name="AttachedFileDate_#f#" value="#rc.attachedFiles.AttachedFileDate#">
						<input type="hidden" name="Name_#f#" value="#rc.attachedFiles.Name#">

					</div>
					</div>
					<cfelse>
						<div class="row">
						<div class="col-md-4">
						<label>Title <span data-toggle="tooltip" title="A brief description that uniquely identifies the document."><i class="fa fa-question-circle fa-fw"></i></span></label> <input type="text" name="filenotes_#f#">
						</div>
						<div class="col-md-6">
						<label>File</label> <input type="file" name="attachment_#f#" class="form-control">
						</div>
						</div>
					</cfif>
				</cfloop>
				<input type="hidden" name="fcnt" value="#f#">
				<button type="submit" name="btnAddRow"  class="btn btn-default btn-xs pull-right"  value="Add Document"><i class="icon-plus-sign"></i> Add Document</button>
				</div>
				</div>


 			<cfif len(trim(rc.proposal.ActivityID)) and (StructKeyExists(rc,"recommendations") AND rc.recommendations.recordCount) >
				<div class="row">
					<div class="col-md-12">
						<fieldset>
				        <legend>Review</legend>
							<cfloop query="rc.recommendations">
								<p><strong>Comments by #uCase(rc.recommendations.sender)# #dateFormat(rc.recommendations.commentDate,'mm/dd/yyyy')#:</strong> #rc.recommendations.comments#</p>
							</cfloop>
					</fieldset>
					</div>
				</div>
				</cfif>

		<div class="row">
					<div class="col-md-12"><hr>

					<cfif  isUserLoggedIn()>
						<input type="submit" name="saveProposalForm" value="Save" class="btn btn-primary" />
					</cfif>
					<cfif not StructKeyExists(rc.proposal,"proposalSubmitDate") or NOT len(rc.proposal.proposalSubmitDate)>
						<button type="submit" class="btn btn-success" name="submitProposalForm" value="Submit Proposal for Review"><i class="icon-ok icon-white"></i> Submit Proposal for Review</button>
						<cfif len(rc.proposal.activityid)>
							<span data-toggle="tooltip" title="The Clone button allows you to create a new proposal with the same information contained in this proposal draft. Proposals can only be cloned if they have not yet been submitted for review."><button onClick="if(confirm('An identical copy of this proposal with a new proposal number will be created. Do you want to continue?')) return true; else return false;" type="submit" class="btn btn-default" name="saveClone" value="Clone Proposal"><i class="icon-retweet"></i> Clone Proposal</button></span>&nbsp;
						</cfif>
					</cfif>


				<cfif IsUserInRole("delete activity") and len(rc.proposal.activityid)>
					<button onClick="if(confirm('Are you sure you want to delete this proposal?\n Proposal will be removed from your workload summary \n and the system once deleted.')) return true; else return false;" type="submit" class="btn btn-danger" name="btnDeleteProposal" value="Delete Proposal"><i class="icon-ban-circle icon-white"></i> Delete Proposal</button>
				</cfif>
			</div>
		</div>




	</form>
	<cfelse>
		<h4>Your user profile permissions do not allow you to view this page</h4>
	</cfif>
</cfoutput>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>


<script type="text/javascript">

$(function() {
    $( "#startDate" ).datepicker();
  });

  $(function() {
    $( "#endDate" ).datepicker();
  });


		function textCounter(field,cntfield,maxlimit) {
		  if (field.value.length > maxlimit) {// if too long...trim it!
		    alert('Text exceeded ' + maxlimit + '. Excess characters were removed.');
		    field.value = field.value.substring(0, maxlimit);
		  }
		  else {// otherwise, update 'characters left' counter
		    document.getElementById(cntfield).innerHTML = maxlimit - field.value.length;
		  }
		}



		/* Wait for the document to be loaded in order to activate dynamic form */
		$(document).ready(function(){

			$(".counter").hide();

			$('#countryID').multiselect({
		    	buttonWidth: '100%',
		    	includeSelectAllOption: true,
		    	maxHeight: 340,
		    	enableFiltering: true,
		      buttonText: function(options) {
		        if (options.length == 0) {
		          return 'Select Countries <b class="caret"></b>';
		        }
		        else if (options.length > 5) {
		          return 'Countries: ' +  options.length + ' selected  <b class="caret"></b>';
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

		    $('#fundingSources').multiselect({
		    	buttonWidth: '100%',
		    	includeSelectAllOption: true,
		    	maxHeight: 340,
		      buttonText: function(options) {
		        if (options.length == 0) {
		          return 'Select Funding Sources <b class="caret"></b>';
		        }
		        else if (options.length > 8) {
		          return 'Funding Sources: ' +  options.length + ' selected  <b class="caret"></b>';
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
		    	buttonWidth: '100%',
		    	includeSelectAllOption: true,
		    	maxHeight: 340,
		    	enableFiltering: true,
		      buttonText: function(options) {
		        if (options.length == 0) {
		          return 'Select Organizations <b class="caret"></b>';
		        }
		        else if (options.length > 3) {
		          return 'Organizations: ' +  options.length + ' selected  <b class="caret"></b>';
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

		    $('#secondaryResults').multiselect({
		    	buttonWidth: '100%',
		    	maxHeight: 340,
		      buttonText: function(options) {
		        if (options.length == 0) {
		          return 'Select Secondary Program Results <b class="caret"></b>';
		        }
		        else if (options.length > 1) {
		          return 'Secondary Objectives: ' +  options.length + ' selected  <b class="caret"></b>';
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

		    $('#primaryResult').multiselect({
		    	buttonWidth: '100%'
		    });

		});


		<cfoutput>
			var #toScript((10*60000),"sTimeout")#
		</cfoutput>
		setTimeout('sessionWarning()', sTimeout);

		function sessionWarning() {
		    alert('Save your work now and often in order to prevent losing data entered in this form if your session expires.');
		}

	</script>