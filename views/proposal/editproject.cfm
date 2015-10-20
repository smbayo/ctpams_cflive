<cfinclude template="header.cfm">




<cfoutput>
<div class="row">
	<div class="col-md-12">
	<!--- start panel --->
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-edit fa-fw"></i> #uCase(rc.proposal.proposalnumber)#: Edit Project Details
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

		<!--- <div class="text-right"><a href='index.cfm/proposal/view/activityid/#rc.activityid#'>Click here</a> for old form</div> --->
		<form id="proposalform" name="proposalform" method="post" action="#event.buildLink('proposal.submitProposal')#">
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
			<input type="hidden" name="reprogramComments" value="#rc.proposal.reprogramComments#">
			<input type="hidden" name="placeofImplementation" value="#rc.proposal.placeofImplementation#">
			<input type="hidden" name="roleName" value="#rc.roleName#">
			<input type="hidden" name="pagetitle" value="#rc.pagetitle#">
			<input type="hidden" name="sysUserID" value="#getPlugin('SessionStorage').getVar('curUserAuth.sysUserID')#">
			<input type="hidden" name="programID" value="#rc.proposal.programID#">


<!---start tab content --->
<div class="tabbable columns">
    <ul id="myTab" class="nav nav-tabs">
		<cfif IsUserInRole("edit activity") or IsUserInRole("edit all activities")>
	        <li class="active" id="formtab"><a id="n.1" href="##coreinfo" data-toggle="tab">Core Info </a></li>
	        <li class="" id="formtab"><a id="n.2" href="##justification" data-toggle="tab">Justification</a></li>
	        <li class="" id="formtab"> <a id="n.3" href="##results" data-toggle="tab">Results</a></li>
	        <li class="" id="formtab"><a id="n.4" href="##logistics" data-toggle="tab">Logistics</a></li>
			<li id="formtab"><a id="n.5" href="##funding" data-toggle="tab">Funding</a></li>
		<cfelseif IsUserInRole("edit project budget")>
			<li class="active" id="formtab"><a id="n.4" href="##logistics" data-toggle="tab">Logistics</a></li>
			<li id="formtab"><a id="n.5" href="##funding" data-toggle="tab">Funding</a></li>
		</cfif>
    </ul>
    <div id="myTabContent" class="tab-content">
		<cfif IsUserInRole("edit activity") or IsUserInRole("edit all activities")>
        	<div class="tab-pane fade active in" id="coreinfo">
		<cfelseif IsUserInRole("edit project budget")>
			<div class="tab-pane fade" id="coreinfo">
		</cfif><br>

			<div class="form-group">
					<label>Project Title <i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 255."></i></label>
					<input type="text" name="name" id="proposalname" value="#rc.projectTitle#" required maxlength="255" class="form-control">
			</div>
			<div class="form-group">
					<label>
						Project Purpose/Summary
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 1000. The Project Purpose should include a brief project summary that is descriptive and specific to the project in question."></i>

					</label><span class="text-danger pull-right counter" id="objectiveLenContainer"><span name="objectiveLen" id="objectiveLen">1000</span> Characters Remaining</span>

					<textarea name="projectobjective" id="projectobjective" rows="5" onclick="textCounter(this, 'objectiveLen', 1000);$('##objectiveLenContainer').show();" onkeyup="textCounter(this, 'objectiveLen', 1000);"  maxlength="1000" class="form-control">#rc.proposal.ProjectObjective#</textarea>
			</div>

			<div class="form-group">
					<label>
						Description of Project Proposed
						<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character minimum 300, maximum 4000. Provide a detailed description of activities and include a work plan which describes what will be done in what sequence, over what period of time."></i>

					</label><span class="text-danger pull-right counter" id="descriptionLenContainer"><span name="descriptionLen" id="descriptionLen">4000</span> Characters Remaining</span>

					<textarea name="Description" id="Description"  rows="10" onclick="textCounter(this, 'descriptionLen', 4000);$('##descriptionLenContainer').show();" onkeyup="textCounter(this, 'descriptionLen', 4000);"  maxlength="4000" class="form-control">#rc.proposal.Description#</textarea>
			</div>
			<cfif IsUserInRole("set project themes")>
				<div class="form-group">
					<label>Themes
						<a href="##" data-toggle="modal" data-target="##myModal"><i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Click for Theme definitions"></i></a>
					</label>
							<select name="themes" id="themes" multiple="multiple" class="form-control">
								<cfloop query="rc.themesAll">
									<option value="#rc.themesAll.CategoryID#" <cfif listfind(rc.themeIDs, rc.themesAll.categoryID)> selected</cfif>>#rc.themesAll.name#</option>
								</cfloop>
							</select>
				</div>
			</cfif>



			<div class="form-group pull-right">
					<input type="button" onclick="document.getElementById('n.2').click()" value="Next" id="next" class=" btn btn-primary " />
			</div>
        </div>
        <div class="tab-pane fade" id="justification">
			<br>
			<div class="form-group">
					<label>
						Specify explicitly how this proposal advances US national security and foreign policy interests (CVE: Project Context/Rationale)

					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 1000.(CVE: Describe the violent extremism problem or challenge – including: drivers of radicalization/recruitment, geographic areas of concern, and target population/audience that the project seeks to address.  For Posts/USG agencies: How would this project support U.S. national-security or foreign-policy goals?)"></i>


					</label><span class="text-danger pull-right counter" id="interestLenContainer"><span name="interestLen" id="interestLen">1000</span> Characters Remaining</span>

					<textarea name="interestSpecification" id="interestSpecification" rows="5" onclick="textCounter(this, 'interestLen', 1000);$('##interestLenContainer').show();" onkeyup="textCounter(this, 'interestLen', 1000);"  maxlength="1000" class="form-control">#rc.proposal.InterestSpecification#</textarea>
			</div>
			<div class="form-group">
					<label>
						Specify explicitly how this activity supports law enforcement's ability to counter terrorism or efforts to counter terrorist financing  (CVE: Law Enforcement Nexus - NADR funding only)

					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 1000. (CTF:  Please include any previous work and describe the future sequencing that this proposal may imply.)"></i>

					</label><span class="text-danger pull-right counter" id="lawLenContainer"><span name="lawLen" id="lawLen">1000</span> Characters Remaining</span>

					<textarea name="lawEnforcementSpecification" id="lawEnforcementSpecification" rows="5" onclick="textCounter(this, 'lawLen', 1000);$('##lawLenContainer').show();" onkeyup="textCounter(this, 'lawLen', 1000);"  maxlength="1000" class="form-control">#rc.proposal.LawEnforcementSpecification#</textarea>
			</div>
			<div class="form-group">
					<label>
						What have the sponsors of the  project done to coordinate this program with this interagency or multilateral partners? (CVE: Coordination)
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 4000. What offices/agencies have been consulted? How did you ensure this is not duplicative? (CVE: Are other USG entities, donor governments, host government(s), or non-governmental entities implementing similar programming? Briefly describe the relevant donor landscape.  How would this project complement ongoing programming?  Project proposals that reflect specific lessons learned are especially welcome.)"></i>

					</label><span class="text-danger pull-right counter" id="coordLenContainer"><span name="coordLen" id="coordLen">4000</span> Characters Remaining</span>

					<textarea name="coordinationSpecification" id="coordinationSpecification" rows="8" onclick="textCounter(this, 'coordLen', 4000);$('##coordLenContainer').show();"  onkeyup="textCounter(this, 'coordLen', 4000);"  maxlength="4000" class="form-control">#rc.proposal.CoordinationSpecification#</textarea>
			</div>
            <div class="form-group">
					<input type="button" onclick="document.getElementById('n.1').click()" value="Previous" id="previous" class=" btn btn-primary" />
					<input type="button" onclick="document.getElementById('n.3').click()" value="Next" id="next" class=" btn btn-primary pull-right" />
			</div>
        </div>
        <div class="tab-pane fade" id="results">
			<br>
			<div class="form-group">
					<label>Primary Program Result
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Choose the objective that is most applicable to your activity."></i>
					</label>

					<select name="resultsFrameworkelementID" id="primaryResult" class="form-control">
						<option value="" >Select Primary Program Result</option>
						<cfloop query="rc.programresults">
							<option value="#resultsframeworkelementID#" <cfif (rc.resultsFrameworkElementID EQ rc.programresults.resultsframeworkelementID)> selected</cfif>><cfif rc.programid is 5>#program# - </cfif>#name#</option>
						</cfloop>
					</select>
					 <input type="hidden" name="isPrimary" value="1">
			</div>
			<div class="form-group">
					<label>Secondary Program Results
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="It is not mandatory to choose a secondary objective."></i>
					</label>
					<select name="SecondaryResultsList" id="secondaryResults" multiple="true" class="form-control">
						<cfloop query="rc.programresults">
							<option value="#resultsframeworkelementID#" <cfif listFind(rc.secondaryResultsList,rc.programresults.resultsFrameworkElementID) is not 0> selected</cfif>><cfif rc.programid is 5>#program# - </cfif>#name#</option>
						</cfloop>
					</select>

					<input type="hidden" name="oicnt" value="0">
			</div>


			<div class="form-group">
					<label>
						Sustainability (if applicable)
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 4000. Briefly, what is the sustainability plan for this project (one paragraph)?"></i>

					</label><span class="text-danger pull-right counter" id="susLenContainer"><span name="susLen" id="susLen">4000</span> Characters Remaining</span>

					<textarea name="sustainability" id="sustainability"  rows="7" onclick="textCounter(this, 'susLen', 4000);$('##susLenContainer').show();" onkeyup="textCounter(this, 'susLen', 4000);"  maxlength="4000" class="form-control">#rc.proposal.sustainability#</textarea>
			</div>

			<div class="form-group">
					<label>
						Project Monitoring (CVE: Measuring Impact and Effectiveness)
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 4000. Explain in 3-5 sentences how you expect to regularly monitor the work undertaken in the project in terms of performance and results. (CVE: Based on project objectives, what results, indicators, and methods would be used to measure project effectiveness and impact? (Methods include baseline assessments with focus-group discussion with project beneficiaries; post-activity surveys of participants; etc.) What is the plan to evaluate the project at the conclusion of implementation?)"></i>

					</label><span class="text-danger pull-right counter" id="lesLenContainer"><span name="lesLen" id="lesLen">4000</span> Characters Remaining</span>

					<textarea name="lessonslearned" id="lessonslearned"  rows="7" onclick="textCounter(this, 'lesLen', 4000);$('##lesLenContainer').show();" onkeyup="textCounter(this, 'lesLen', 4000);"  maxlength="4000" class="form-control">#rc.proposal.lessonsLearned#</textarea>
			</div>


			<div class="form-group">
				<label>
					Related Projects - Reprograms
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 4000. List in this space any project IDs that are related to this project. Leave explanatory note as needed. Only list projects related by reprogramming."></i>

				</label><span class="text-danger pull-right counter" id="relProjContainer"><span name="relProj" id="relProj">4000</span> Characters Remaining</span>
				<textarea name="relatedProjects" id="relatedProjects"  rows="7" onclick="textCounter(this, 'relProj', 4000);$('##relProjContainer').show();" onkeyup="textCounter(this, 'relProj', 4000);"  maxlength="4000" class="form-control">#rc.proposal.relatedProjects#</textarea>
			</div>
            <div class="form-group">
					<input type="button" onclick="document.getElementById('n.2').click()" value="Previous" id="previous" class=" btn btn-primary" />

					<input type="button" onclick="document.getElementById('n.4').click()" value="Next" id="next" class=" btn btn-primary pull-right" />
			</div>
        </div>
		<cfif IsUserInRole("edit activity") or IsUserInRole("edit all activities")>
        	<div class="tab-pane fade" id="logistics">
		<cfelseif IsUserInRole("edit project budget")>
			<div class="tab-pane fade active in" id="logistics">
		</cfif>

			<br>
            <div class="form-group">
						<label>Period of Performance</label>
				<div class="row">
						<div class="col-md-6">
					<label for="startDate">From</label>
					<input type="text" id="startDate" class="form-control" name="startDate" value="#dateFormat(rc.proposal.StartDate,'mm/dd/yyyy')#" />
					</div>
					<div class="col-md-6">
					<label for="endDate">To</label>
					<input type="text" id="endDate" class="form-control" name="endDate" value="#dateFormat(rc.proposal.EndDate,'mm/dd/yyyy')#"  />
					</div>

				</div>
			</div>
			<div class="form-group">

						<label>Countries Engaged
						<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Choose all that apply. If the project is not country-specific, leave unselected."></i>
						</label>

							<input type="hidden"  name="projectCountries">
						<select name="projectCountries" id="countryID" multiple="multiple" class="form-control">
							<cfloop query="rc.countriesAll">
								<option value="#CategoryID#" <cfif listfind(rc.projectcountryIDs, rc.countriesAll.categoryID)> selected</cfif>>#Name#</option>
							</cfloop>
						</select>
			</div>

			<div class="form-group">
					<label>Neighborhood, City or Province (if applicable)
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 255."></i>
					</label><span class="text-danger pull-right counter" id="cityPContainer"><span name="cityP" id="cityP">255</span> Characters Remaining</span>

					<input type="text" name="cityProvince" id="cityProvince" value="#rc.proposal.cityProvince#"  onclick="textCounter(this, 'cityP', 255);$('##cityPContainer').show();" onkeyup="textCounter(this, 'cityP', 255);"  maxlength="255" class="form-control">
			</div>

			<cfif rc.programid is 2>
			<div class="form-group">
						<label>Organizations Engaged
						<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Choose all that apply."></i>
						</label>
								<select name="projectOrganizations" id="orgID" multiple="multiple" class="form-control">
									<cfloop query="rc.allOrganizations">
										<option value="#CategoryID#" <cfif listfind(rc.projectorgIDs, rc.allOrganizations.categoryID)> selected</cfif>>#Name#</option>
									</cfloop>
								</select>
			</div>
			</cfif>
			<div class="form-group">
					<label>Implementing Partner
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Select the organization implementing the proposal. Details field must be filled in if 'NGO', 'Other' or 'Post Implemented' are selected, and be sure to look for your specific implementer in the list before selecting these.  Please write in full implementer name without abbreviations."></i>
					</label>
								<div class="row">
									<div class="col-md-2">
									<label>Organization</label>
									<select name="implementingPartner"  class="form-control">
										<option value="" <cfif (rc.proposal.implementingPartner EQ "")>selected</cfif>>None</option>
										<cfloop query="rc.ctfPartners">
											<option value="#categoryID#" <cfif (rc.ctfPartners.categoryID EQ rc.proposal.implementingPartner)>selected</cfif>>#name#</option>
										</cfloop>
									</select>
									</div>
									<div class="col-md-2">
									<label>Details <span class="ttip" title="Optional field that must be filled in if 'Post Implemented', NGO' or 'Other' are selected.  Please write in full implementer name without abbreviations."><i class="icon-exclamation-sign"></i></span></label>
									<input type="text" name="implementingpartnerdetails" value="#rc.implementer.implementingpartner#"  class="form-control">
									</div>

									<div class="col-md-2">
									<label>POC First Name</label>
									<input type="text" name="pocfirstname" value="#rc.implementer.pocFirstName#"  class="form-control">
									</div>

									<div class="col-md-2">
									<label>POC Last Name</label>
									<input type="text" name="poclastname" value="#rc.implementer.pocLastName#"   class="form-control">
									</div>

									<div class="col-md-2">
									<label>POC Email</label>
									<input type="email" name="pocemail" value="#rc.implementer.pocEmail#"   class="form-control">
									</div>

									<div class="col-md-2">
									<label>POC Phone</label>
									<input type="text" name="pocphone" value="#rc.implementer.pocPhone#"   class="form-control">
									<input type="hidden" name="orgID" value="#rc.implementer.orgID#">
									</div>
								</div>
			</div>
			<div class="form-group">
					<label>Program Audience
					<i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Character maximum 255."></i>
					</label>
				    <input type="text" name="programaudience" value="#rc.proposal.ProgramAudience#" class="form-control">
			</div><br><br>

			<cfif IsUserInRole("edit activity") or IsUserInRole("edit all activities")>
	        	<div class="form-group">
					<input type="button" onclick="document.getElementById('n.3').click()" value="Previous" id="previous" class=" btn btn-primary" />

					<input type="button" onclick="document.getElementById('n.5').click()" value="Next" id="next" class=" btn btn-primary pull-right" />
				</div>
			<cfelseif IsUserInRole("edit project budget")>
				<div class="form-group">
					<input type="button" onclick="document.getElementById('n.5').click()" value="Next" id="next" class=" btn btn-primary pull-right" />
				</div>
			</cfif>

        </div>
        <div class="tab-pane fade" id="funding">
			<br>
			<div class="form-group">
				<label>Funding Amount Requested
				</label>

					<div class="input-group" style="width:250px">
						<span class="input-group-addon">$</span>
						<input type="number"  name="BudgetCeilingAmount" value="#rc.proposal.BudgetCeilingAmount#" class="form-control">
						<span class="input-group-addon">.00</span>
					</div>
					<cfif IsUserInRole("edit project budget")>
					&nbsp; Archive <input type="checkbox" name="ctex" value="1" <cfif rc.proposal.ctex is 1> checked</cfif>>
					<span  title="Selecting this will give the option to exclude this project from filtered reports, and cause it to not show in profiles." data-toggle="tooltip"><i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title=""></i></span>
					<input type="hidden" name="ctex">
					<cfelse>
					<input type="hidden" name="ctex" value="#rc.proposal.ctex#">

					</cfif>
			</div>
			<div class="form-group">
				<label>Funding Mechanism Type
				</label>

					<select name="fundImpMechanismID" id="fundMech" class="form-control">
						<option value="" <cfif (rc.proposal.fundImpMechanismID EQ "")>selected</cfif>>Select Funding Mechanism</option>
						<cfloop query="rc.FundMechTypes">
							<option value="#categoryID#" <cfif (rc.proposal.fundImpMechanismID EQ categoryID)>selected</cfif>>#name#</option>
						</cfloop>
					</select>
			</div>
			<cfif IsUserInRole("add activity objectives and funding")>
			<div class="form-group">
				<label>Funding Sources
				</label>
						<select name="projectFundingSources" id="fundingSources" multiple="multiple" class="form-control">
							<cfloop query="rc.fundingSourcesAll">
								<option value="#rc.fundingSourcesAll.CategoryID#" <cfif listfind(rc.fundingSourceIDs, rc.fundingSourcesAll.categoryID)> selected</cfif>>#rc.fundingSourcesAll.name#</option>
							</cfloop>
						</select>
			</div>
			<div class="form-group">
				<label>Fiscal Year
				</label>
						<cfparam name="rc.fiscalyear" default="">

					<select name="FiscalYear" class="form-control">
							<option value="2008" <cfif rc.proposal.fiscalyear is 2008 or rc.fiscalyear is 2008> selected</cfif>>2008</option>
							<option value="2009" <cfif rc.proposal.fiscalyear is 2009 or rc.fiscalyear is 2009> selected</cfif>>2009</option>
							<option value="2010" <cfif rc.proposal.fiscalyear is 2010 or rc.fiscalyear is 2010> selected</cfif>>2010</option>
							<option value="2011" <cfif rc.proposal.fiscalyear is 2011 or rc.fiscalyear is 2011> selected</cfif>>2011</option>
							<option value="2012" <cfif rc.proposal.fiscalyear is 2012 or rc.fiscalyear is 2012> selected</cfif>>2012</option>
							<option value="2013" <cfif rc.proposal.fiscalyear is 2013 or rc.fiscalyear is 2013> selected</cfif>>2013</option>
							<option value="2014" <cfif rc.proposal.fiscalyear is 2014 or rc.fiscalyear is 2014> selected</cfif>>2014</option>
							<option value="2015" <cfif rc.proposal.fiscalyear is 2015 or rc.fiscalyear is 2015> selected</cfif>>2015</option>
							<option value="2016" <cfif rc.proposal.fiscalyear is 2016 or rc.fiscalyear is 2016> selected</cfif>>2016</option>
							<option value="2017" <cfif rc.proposal.fiscalyear is 2017 or rc.fiscalyear is 2017> selected</cfif>>2017</option>
					</select>
			</div>
			<cfelse>
				<input type="hidden" name="fiscalYear" value="#rc.proposal.fiscalyear#">
				<input type="hidden" name="oicnt" value="0">

			</cfif>
			<cfif IsUserInRole("review activity")>
				<div class="form-group">
					<label>Skip Proposal Clearance</label>
					<input type="checkbox" name="skipAMCN" value="1">
				</div>
			</cfif>
			</form>
			<div class="form-group">
				<label>Budget Items
				</label>
					<table style="width:100%; background: rgba(255, 255, 255, 1);" class="table table-striped table-hover table-bordered">
						<thead>
							<tr>
								<th>Country/Org</th>
								<th>Budget Item</th>
								<th>Budget Amount</th>
								<th></th>
							</tr>
						</thead>
						<tbody id="budgetbody">
						<cfset budgettotal=0>
						<cfloop query="rc.projectFunding">
								<cfif isnumeric(rc.projectFunding.BudgetAmount)>
									<cfset budgettotal=budgettotal + rc.projectFunding.BudgetAmount>
								</cfif>
								<tr>
									<td>#rc.projectFunding.country#</td>
									<td>#rc.projectFunding.BudgetItem#</td>
									<td>#dollarformat(rc.projectFunding.BudgetAmount)#</td>
									<td id="#rc.projectFunding.ActivityBudgetID#" style="cursor:pointer" class="deletebudget  muted text-center">x</td>
								</tr>
						</cfloop>
						<form  name="budgetForm" id="budgetForm" class="formular" method="POST">
							<input type="hidden" name="activityid" value="#rc.proposal.activityid#">
						<tr id="editbudgetrow">
							<td style="width:200px"><select name="countryid" id="countryid" class="form-control">
															<option value="">Country/Org</option>
															<cfloop query="rc.regionCountryAll">
																<option value="#categoryID#">#Name#</option>
															</cfloop>
																<cfloop query="rc.allOrganizations">
																	<option value="#CategoryID#">#Name#</option>
																</cfloop>
														</select></td>
							<td><input class="form-control" placeholder="Budget Item" type="text" id="budgetitem" name="budgetitem"  /></td>
							<td style="width:200px">

							<div class="input-group">
								<span class="input-group-addon">$</span>
								<input class="form-control" type="number" placeholder="000" name="budgetamount" id="budgetamount">
								<span class="input-group-addon">.00</span>
							</div>
							</td>
							<td style="width:50px"><div class="text-center"><a href="javascript:void(0);" id="addBudget" class="btn btn-info btn-xs">Add</a></div></td>
						</tr>
						</form>
						</tbody>

					</table>

			</div>


            <div class="form-group">
					<input type="button" onclick="document.getElementById('n.4').click()" value="Previous" id="previous" class="btn btn-primary" />

					<span class="pull-right">

					<input type="button" value="Save" id="next" class="btn btn-primary" />&nbsp;

					<cfif not StructKeyExists(rc.proposal,"proposalSubmitDate") or NOT len(rc.proposal.proposalSubmitDate)>
						<button type="submit" class="btn btn-success" name="submitProposalForm" value="Submit Proposal for Review"><i class="icon-ok icon-white"></i> Submit Proposal for Review</button>&nbsp;
					</cfif>
					<cfif IsUserInRole("delete activity") and len(rc.proposal.activityid)>
						<button onClick="if(confirm('Are you sure you want to delete this proposal?\n Proposal will be removed from your workload summary \n and the system once deleted.')) return true; else return false;" type="submit" class="btn btn-danger" name="btnDeleteProposal" value="Delete Proposal"><i class="icon-ban-circle icon-white"></i> Delete Proposal</button>&nbsp;
					</cfif>
					<a href="#event.buildLink("proposal.review.activityID." & rc.proposal.ActivityID)#" class="btn btn-default ">Exit</a>
					</span>

			</div>

        </div>
    </div>
</div>
<!--- end tab content --->
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
		<!--- end panel --->

<cfif IsUserInRole("edit activity") or IsUserInRole("edit all activities")>

		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-user-plus fa-fw"></i> #uCase(rc.proposal.proposalnumber)#: Project Owners
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
					<table class="table table-striped table-condensed table-hover table-bordered" style="background: rgba(255, 255, 255, 1);">
							<thead>
								<tr>
									<!--- <th>First Name</th> --->
									<th>Name</th>
									<th>Last Name</th>
									<th>Email</th>
									<th>Phone</th>
									<th>Office</th>
									<th></th>
								</tr>
							</thead>
							<tbody id="ownersbody">

							<cfloop query="rc.owners">

								<tr>
									<!--- <td>#rc.owners.firstName#</td> --->
									<td>#rc.owners.firstName#</td>
									<td>#rc.owners.lastName#</td>
									<td>#rc.owners.email# <cfif rc.owners.isSystemUser is 1><span class="ttip" title="#rc.owners.email# is in PAMS"><i class="icon-ok-sign"></i></span><cfelse><span class="ttip" title="#rc.owners.email# is not in PAMS"><i class="icon-remove-sign"></i></span></cfif></td>
									<td>#rc.owners.phone#</td>
									<td>#rc.owners.office#</td>
									<td id="#rc.owners.activityPersonID#" style="cursor:pointer" class="deleteowner text-muted text-center">x</td>
								</tr>
							</cfloop>
							<tr>
								 <form  name="ownerForm" id="ownerForm" class="formular" method="POST">
									<input type="hidden" name="activityID" value="#rc.proposal.ActivityID#">
									<td><input class="form-control" placeholder="First Name" type="text" id="firstName" name="firstName" required  /></td>
									<td><input class="form-control" placeholder="Last Name" type="text" id="lastName" name="lastName" required  /></td>
									<td><input class="form-control" placeholder="Email" type="text" id="email" name="email" required  /></td>
									<td><input class="form-control" placeholder="Phone" type="text" id="phone" name="phone"  /></td>
									<td><input class="form-control" placeholder="Office" type="text" id="office" name="office" required  /></td>
									<td><div class="text-center"><a href="javascript:void(0);" id="addOwner" class="btn btn-info btn-xs">Add</a></div></td>
								</tr>
								</form>
							</tbody>
						</table>
						</div>
						</div>
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-files-o fa-fw"></i> #uCase(rc.proposal.proposalnumber)#: Project Documents
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">


					<table class="table table-striped table-condensed table-hover table-bordered" style="width:100%; background: rgba(255, 255, 255, 1);">
											<thead>
											<tr>
												<th>Filename</th>
												<th>Document Name</th>
												<th></th>
											</tr>
											</thead>
											<tbody id="documentbody">
												<cfloop query="rc.attachedFiles">
													<tr>

														<td><a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.attachedFiles.AttachedFileID)#><i class="fa fa-file-text-o"></i> #rc.attachedFiles.UploadedFileName#</a></td>
														<td><a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.attachedFiles.AttachedFileID)#><i class="fa fa-file-text-o"></i> #rc.attachedFiles.Name#</a></td>
														<td id="#rc.attachedFiles.AttachedFileID#" style="cursor:pointer" class="deletedocument muted text-center" >x</td>
													</tr>
												</cfloop>
							<tr>
								 <form  name="documentForm" id="documentForm" class="formular" method="POST" enctype="multipart/form-data">
									<input type="hidden" name="activityID" value="#rc.proposal.ActivityID#"  id="docActivityID">
									<input type="hidden" name="objectTableName" value="Activity">
									<td><input type="file" class="btn btn-default btn-sm" id="documentUpload" name="documentUpload"> </td>
									<td><input class="form-control input-sm" placeholder="Document Name" type="text" id="documentTitle" name="documentTitle" >
														<input type="hidden" name="longDescription" value="" ></td>
									<td style="width:50px"><div class="text-center"><a href="javascript:void(0);" id="addDocument" class="btn btn-info btn-xs">Add</a></div></td>
								</tr>
								</form>
							</tbody>
						</table>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
</cfif>
	</div>
</div>

</cfoutput>

<div id="errorreport"></div>



<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Theme Definitions</h4>
      </div>
      <div class="modal-body">
        <cfinclude template="includes/theme_definitions.cfm">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

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


/* Wait for the document to be loaded in order to activate dynamic form */
$(document).ready(function(){

$(function() {
    $( "#startDate" ).datepicker();
  });

  $(function() {
    $( "#endDate" ).datepicker();
  });



			$(".counter").hide();

			$('#countryID').multiselect({
		    	buttonWidth: '100%',
		    	//includeSelectAllOption: true,
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
		    	//includeSelectAllOption: true,
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

		     $('#themes').multiselect({
		    	buttonWidth: '100%',
		    	//includeSelectAllOption: true,
		    	maxHeight: 340,
		      buttonText: function(options) {
		        if (options.length == 0) {
		          return 'Select Themes <b class="caret"></b>';
		        }
		        else if (options.length > 3) {
		          return 'Themes: ' +  options.length + ' selected  <b class="caret"></b>';
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
		    	//includeSelectAllOption: true,
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



		$( "#next,#previous" ).click(function() {
		if ($('#proposalname').val().length > 0) {
			doFormEvent('proposal.ajaxSaveProposal',document.proposalform).done(saveProposalVerify);
		} else {

			$(document).trigger("add-alerts", [
			    {
			      'message': "Project title is required at all times.",
			      'priority': 'danger'
			    }
			  ]);
		}


	});



	$( "#addOwner" ).click(function() {
		if ($('#firstName').val().length > 0 && $('#lastName').val().length > 0 && $('#email').val().length > 0 && $('#office').val().length > 0) {
			doFormEvent('proposal.ajaxSaveOwner',document.ownerForm,'false').done(addOwnerVerify);
		} else {

			$(document).trigger("add-alerts", [
			    {
			      'message': "Please enter proposal owner first name, last name, email and office.",
			      'priority': 'danger'
			    }
			  ]);

		}
	});



	$( ".deleteowner" ).click(function() {
		deleteOwner(this.id);
	});



	$( "#addBudget" ).click(function() {
		if ($('#countryid').val().length > 0 && $('#budgetitem').val().length > 0 && $('#budgetamount').val().length > 0) {
			doFormEvent('proposal.ajaxSaveBudgetItem',document.budgetForm,'false').done(addBudgetVerify);
		} else {

			$(document).trigger("add-alerts", [
			    {
			      'message': "Please enter budget country/org, budget item and budget amount.",
			      'priority': 'danger'
			    }
			  ]);
		}
	});

	$( ".deletebudget" ).click(function() {
		deleteBudget(this.id);
	});



	$( ".deletedocument" ).click(function() {
		deleteBudget(this.id);

	});


$('#documentUpload').change(function(){
    var file = this.files[0];
    name = file.name;
    size = file.size;
    type = file.type;
    //alert(name.length);

    if(name.length < 6) {
    	alert("too short!");

			$(document).trigger("add-alerts", [
			    {
			      'message': "Filename must be at least 5 characters long.",
			      'priority': 'danger'
			    }
			  ]);
    	$("#documentUpload").val("");
    }
    else if(file.size > 2000000) {

			$(document).trigger("add-alerts", [
			    {
			      'message': "File is too big.",
			      'priority': 'danger'
			    }
			  ]);
        //$("#documentUpload").val("");
    }
    else {
        $('#addDocument').click(function(){
        	//var formElement = document.getElementById("documentForm");
        	var formElement = $('#documentForm')[0];
            var formData = new FormData(formElement);
            formData.append('section', 'general');
            formData.append('thedoc', $('input[type=file]')[0].files[0]);
            var url = 'index.cfm/proposal/ajaxSaveDocument/activityID/'+$('#docActivityID').val();
            $.ajax({
                url: url,  //server script to process data
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: completeHandler = function(data) {
                	$( "#documentbody tr:last").before( "<tr><td><a target='blank' href='index.cfm/attachedFile/index/AttachedFileID/" + data + "'><i class='fa fa-file-text-o'></i> " + $('#documentTitle').val() + "</a></td><td><a target='blank' href='index.cfm/attachedFile/index/AttachedFileID/" + data +  "'><i class='fa fa-file-text-o'></i> " + name + "</a></td><td id='" + data + "' style='cursor:pointer' class='deletedocument muted text-center' onclick='deleteDocument(" + data + ")'>x</td></tr>" );
                    $("#documentUpload").val("");
                    $("#documentTitle").val("");
                    file = "";
                    formData = "";
                    $('#addDocument').unbind()
                   // $("#errorreport").html(data);
                },
                error: errorHandler = function() {

					$(document).trigger("add-alerts", [
					    {
					      'message': "There was a problem. Please reload the page and try again if necessary.",
					      'priority': 'danger'
					    }
					  ]);
                    $("#documentUpload").val("");
                    $('#addDocument').unbind()
                }
            });
        });
    }
});

});

	function deleteBudget(data) {
		doEvent('proposal.ajaxDeleteBudget',{'ActivityBudgetID' : +data},"POST").done(deleteVerify);
	}

	function saveProposalVerify(data /* , textStatus, jqXHR */ ) {
		if (data == 'success') {
			$(document).trigger("add-alerts", [
			    {
			      'message': "Project saved successfully.",
			      'priority': 'success'
			    }
			  ]);
		} else {
			//$("#errorreport").html(data);
			$(document).trigger("add-alerts", [
			    {
			      'message': "There was a problem. Please reload the page and try again if necessary.",
			      'priority': 'danger'
			    }
			  ]);
			}
		}

	function addBudgetVerify (data /* , textStatus, jqXHR */ ) {
		//alert(data);
		if (!isNaN(data)) {
			$( "#budgetbody tr:last" ).before( "<tr><td>" + $("#countryid option:selected").text() +  "</td><td>" + $("#budgetitem").val() + "</td><td>" + $("#budgetamount").val()  + "</td><td id='" + data + "' style='cursor:pointer' class='deletebudget muted text-center' onclick='deleteBudget(" + data + ")'>x</td></tr>" );
			$("#countryid").val("");
			$("#budgetitem").val("");
			$("#budgetamount").val("");
		} else {
			//$("#errorreport").html(data);

			$(document).trigger("add-alerts", [
			    {
			      'message': "There was a problem. Please reload the page and try again if necessary.",
			      'priority': 'danger'
			    }
			  ]);
			}
		}

	function addOwnerVerify (data /* , textStatus, jqXHR */ ) {
		if (!isNaN(data)) {
			$( "#ownersbody tr:last" ).before( "<tr><td>" + $("#firstName").val() + "</td><td>" + $("#lastName").val() + "</td><td>" + $("#email").val() + "</td><td>" + $("#phone").val() + "</td><td>" + $("#office").val() + "</td><td id='" + data + "' style='cursor:pointer' class='deleteowner muted text-center' onclick='deleteOwner(" + data + ")'>x</td></tr>" );
			$("#firstName").val("");
			$("#lastName").val("");
			$("#email").val("");
			$("#phone").val("");
			$("#office").val("");
		} else {
			//alert(data);
			//$("#errorreport").html(data);
			$(document).trigger("add-alerts", [
			    {
			      'message': "There was a problem. Please reload the page and try again if necessary.",
			      'priority': 'danger'
			    }
			  ]);
			}
		}

	function deleteVerify(data /* , textStatus, jqXHR */ ) {
		if ($.isNumeric(data)) {
			$( "#"+data ).parent().remove();
		} else {
			//$("#errorreport").html(data);
			$(document).trigger("add-alerts", [
			    {
			      'message': "There was a problem. Please reload the page and try again if necessary.",
			      'priority': 'danger'
			    }
			  ]);
			}
		}

	function deleteOwner(data) {
		doEvent('proposal.ajaxDeleteOwner',{'ActivityPersonID' : +data},"POST").done(deleteVerify);
	}

	function deleteDocument(data) {
		doEvent('proposal.ajaxDeleteDocument',{'AttachedFileID' : +data},"POST").done(deleteVerify);
	}
</script>

