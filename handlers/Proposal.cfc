<cfcomponent name="proposal" extends="coldbox.system.EventHandler" autowire="true">

	<!--- Inject Dependencies --->
	<cfproperty name="Activity" inject="model" scope="instance" />
	<cfproperty name="ActivityBudget" inject="model" scope="instance" />
	<cfproperty name="ActivityBudgetGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityBudgetService" inject="model" scope="instance" />
	<cfproperty name="ActivityCategoryToCategoryService" inject="model" scope="instance" />
	<cfproperty name="ActivityClearance" inject="model" scope="instance" />
	<cfproperty name="ActivityClearanceDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityClearanceGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityClearanceService" inject="model" scope="instance" />
	<cfproperty name="CNClearanceService" inject="model" scope="instance" />
	<cfproperty name="activityExtendedGrantGateway" inject="model" scope="instance" />
	<cfproperty name="activityGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityIndicatorGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityIndicatorService" inject="model" scope="instance" />
	<cfproperty name="ActivityLegalRecommendation" inject="model" scope="instance" />
	<cfproperty name="ActivityLegalRecommendationGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityLegalRecommendationService" inject="model" scope="instance" />
	<cfproperty name="ActivityObligationGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityObligationService" inject="model" scope="instance" />
	<cfproperty name="ActivityOrgDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityOrgGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityOrgService" inject="model" scope="instance" />
	<cfproperty name="ActivityPersonGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityPersonService" inject="model" scope="instance" />
	<cfproperty name="ActivityService" inject="model" scope="instance" />
	<cfproperty name="ActivityStatusGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityStatusLogService" inject="model" scope="instance" />
	<cfproperty name="ActivityStatusLogGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityStatusService" inject="model" scope="instance" />
	<cfproperty name="AttachedFileGateway" inject="model" scope="instance" />
	<cfproperty name="AttachedFileService" inject="model" scope="instance" />
	<cfproperty name="CategoryGateway" inject="model" scope="instance" />
	<cfproperty name="indicator" inject="model" scope="instance">
	<cfproperty name="indicatorGateway" inject="model" scope="instance" />
	<cfproperty name="indicatorService" inject="model" scope="instance" />
	<cfproperty name="ObjectCategoryService" inject="model" scope="instance" />
	<cfproperty name="Org" inject="model" scope="instance" />
	<cfproperty name="OrgDAO" inject="model" scope="instance" />
	<cfproperty name="OrgGateway" inject="model" scope="instance" />
	<cfproperty name="OrgService" inject="model" scope="instance" />
	<cfproperty name="Workplan" inject="model" scope="instance" />
	<cfproperty name="WorkplanDAO" inject="model" scope="instance" />
	<cfproperty name="WorkplanGateway" inject="model" scope="instance" />
	<cfproperty name="WorkplanService" inject="model" scope="instance" />
	<cfproperty name="programService" inject="model" scope="instance">
	<cfproperty name="ProposalGateway" inject="model" scope="instance" />
	<cfproperty name="ProposalService" inject="model" scope="instance" />
     <cfproperty name="ResultsFrameworkService" inject="model" scope="instance">
	 <cfproperty name="ResultsFrameworkGateway" inject="model" scope="instance">
    <cfproperty name="ResultsFramework" inject="model" scope="instance">
	<cfproperty name="ResultsIndicator" inject="model" scope="instance">
    <cfproperty name="ResultsIndicatorService" inject="model" scope="instance">
	<cfproperty name="measurement" inject="model" scope="instance">
    <cfproperty name="measurementService" inject="model" scope="instance">
	 <cfproperty name="measurementGateway" inject="model" scope="instance">
    <cfproperty name="ResultsFrameworkExternalRelation" inject="model" scope="instance">
    <cfproperty name="ResultsFrameworkExternalRelationService" inject="model" scope="instance">
    <cfproperty name="ActivityResultsFrameworkElementService" inject="model" scope="instance">
	 <cfproperty name="ResultsFrameworkElementGateway" inject="model" scope="instance">


	<cfproperty name="cnGateway" inject="model" scope="instance" />
	<cfproperty name="CNClearanceGateway" inject="model" scope="instance" />


	<cfproperty name="MailService" inject="coldbox:plugin:MailService" scope="instance" />

	<!------------------------------------------- AJAX EVENTS - REVIEW ------------------------------------------>
	<cffunction name="ajaxSaveProposal" displayname="ajax save comment" output="false" returntype="string">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfset oProposal = getModel("Activity").init()>
		<cfset rc.name = URLDecode(rc.name)>
		<cfset rc.projectobjective = URLDecode(rc.projectobjective)>
		<cfset rc.Description = URLDecode(rc.Description)>
		<cfset rc.interestSpecification = URLDecode(rc.interestSpecification)>
		<cfset rc.lawEnforcementSpecification = URLDecode(rc.lawEnforcementSpecification)>
		<cfset rc.coordinationSpecification = URLDecode(rc.coordinationSpecification)>
		<cfset rc.lessonslearned = URLDecode(rc.lessonslearned)>
		<cfset rc.sustainability = URLDecode(rc.sustainability)>
		<cfset rc.relatedProjects = URLDecode(rc.relatedProjects)>
		<cfset rc.startDate = URLDecode(rc.startDate)>
		<cfset rc.endDate = URLDecode(rc.endDate)>
		<cfset rc.cityProvince = URLDecode(rc.cityProvince)>
		<cfset rc.implementingpartnerdetails = URLDecode(rc.implementingpartnerdetails)>
		<cfset rc.pocfirstname = URLDecode(rc.pocfirstname)>
		<cfset rc.poclastname = URLDecode(rc.poclastname)>
		<cfset rc.pocemail = URLDecode(rc.pocemail)>
		<cfset rc.pocphone = URLDecode(rc.pocphone)>
		<cfset rc.programaudience = URLDecode(rc.programaudience)>
		<cfset rc.budgetceilingamount = replace(URLDecode(rc.budgetceilingamount),",", "", "all")>
		<cfset rc.budgetceilingamount = replace(URLDecode(rc.budgetceilingamount),"$", "", "all")>
		<cfset rc.placeOfImplementation = "Country">
		<cfif not len(rc.ctex)>
			<cfset rc.ctex = 0>
		</cfif>


		<cfset populateModel(oProposal)>
		<cfset rc.ActivityID = instance.ActivityService.saveActivity(oProposal)>

		<cfset oImplementer = getModel("Org").init()>
		<cfset populateModel(oImplementer)>
		<cfset oImplementer.setimplementingPartner(rc.implementingpartnerdetails)>
		<cfset rc.OrgID = instance.OrgService.saveOrg(oImplementer)>

		<cfset oActivityOrg = getModel("ActivityOrg").init()>
		<cfset populateModel(oActivityOrg)>
		<cfset rc.ActivityOrgID = instance.ActivityOrgService.saveActivityOrg(oActivityOrg)>

		<cfif StructKeyExists(rc,"resultsFrameworkelementID") AND len(rc.resultsFrameworkelementID)>
			<cfset activityResultsObj = instance.activityResultsFrameworkElementService.new()>
			<cfset populatemodel(activityResultsObj)>
			<cfset retDeleteActivityResults = instance.activityResultsFrameworkElementService.deleteActivityResults(activityID=#rc.activityID#,isPrimary=1)>
			<cfset newActivityResultsSaved = instance.activityResultsFrameworkElementService.saveActivityREsultsFrameworkElement(activityResultsObj)>
		</cfif>

		<cfif StructKeyExists(rc,"SecondaryResultsList") AND len(rc.SecondaryResultsList)>
			<cfset rc.retDeleteActivityResults = instance.activityResultsFrameworkElementService.deleteActivityResults(activityID=rc.ActivityID,isPrimary=0)>
			 <cfloop index="i" list="#rc.SecondaryResultsList#">
				<cfset rc.isPrimary = "0">
				<cfset rc.activityResultsObj = instance.activityResultsFrameworkElementService.new()>
				<cfset rc.resultsFrameworkElementID = #i#>
				<cfset populatemodel(rc.activityResultsObj)>
				<cfset newActivityResultsSaved = instance.activityResultsFrameworkElementService.saveActivityREsultsFrameworkElement(rc.activityResultsObj)>
			</cfloop>
		<cfelse>
			<cfset rc.retDeleteActivityResults = instance.activityResultsFrameworkElementService.deleteActivityResults(activityID=rc.ActivityID,isPrimary=0)>
		</cfif>

		<cfif StructKeyExists(rc,"projectFundingSources")>
			<cfset rc.setFundingSources = instance.ObjectCategoryService.updateObjectCategories(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID,CategoryIDList=rc.projectFundingSources,primary="0")>
		</cfif>

		<cfif StructKeyExists(rc,"themes")>
			<cfset rc.setThemes = instance.ObjectCategoryService.updateObjectCategories(ClassName="Theme",ObjectID=rc.ActivityID,CategoryIDList=rc.themes,primary="0")>
		</cfif>

		<cfif StructKeyExists(rc,"projectOrganizations")>
			<cfset rc.setprojectOrganizations = instance.ObjectCategoryService.updateObjectCategories(ClassName="ActivityOrganization",ObjectID=rc.ActivityID,CategoryIDList=rc.projectOrganizations,primary="0")>
		</cfif>

		<cfset instance.ObjectCategoryService.updateObjectCategories(ClassName="ActivityPlace",ObjectID=rc.ActivityID,CategoryIDList=rc.projectCountries,primary="0")>

		<cfreturn "success" />
	</cffunction>

	<cffunction name="ajaxSaveOwner" displayname="ajax save project owner" output="false" returntype="numeric">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<!--- <cfset oOwner = getModel("ActivityPerson").init()> --->
		<cfset var oOwner = instance.ActivityPersonService.new() />
		<cfset populateModel(oOwner)>
		<cfset rc.ActivityPersonID = instance.ActivityPersonService.saveActivityPerson(oOwner)>

		<cfreturn rc.ActivityPersonID />
	</cffunction>

	<cffunction name="ajaxSaveDocument" displayname="ajax save document" output="false" returntype="string">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		  <cfset attachTemp = getPlugin("FileUtils").uploadFile(fileField="thedoc",destination=expandPath('attachedFiles'),NameConflict="makeunique") />


		 <cfset oAttachedFile = instance.AttachedFileService.new() />
		<cfset oAttachedFile.setAttachedFileName(attachTemp.serverFile) />
		<cfset oAttachedFile.setUploadedFileName(attachTemp.clientFile) />
		<cfset oAttachedFile.setAttachedFileDate(now()) />
		<cfset oAttachedFile.setName(rc.documentTitle) />
		<cfset oAttachedFile.setLongDescription(rc.longDescription) />
		<cfset oAttachedFile.setobjectTableName(rc.objectTableName) />
		<cfset oAttachedFile.setobjectTableID(rc.activityid) />
		<cfset fileid = instance.AttachedFileService.saveAttachedFile(oAttachedFile) />
		 <cfreturn fileid />
	</cffunction>

	<cffunction name="ajaxDeleteOwner" displayname="ajax delete project owner" output="false" returntype="string">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<cfset delete = instance.ActivityPersonGateway.deleteByAttributesQuery(ActivityPersonID=rc.ActivityPersonID)>
		<!--- <cfreturn "success" /> --->
		<cfreturn rc.ActivityPersonID />
	</cffunction>

	<cffunction name="ajaxDeleteDocument" displayname="ajax delete project document" output="false" returntype="string">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<cfset delete = instance.AttachedFileService.deleteAttachedFile(AttachedFileID=rc.AttachedFileID)>
		<cfreturn rc.AttachedFileID />
	</cffunction>

	<cffunction name="ajaxSaveBudgetItem" displayname="ajax save budget item" output="false" returntype="numeric">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<cfset rc.budgetamount = replace(rc.budgetamount,",", "", "all")>
		<cfset rc.budgetamount = replace(rc.budgetamount,"$", "", "all")>

		<cfset var oBudget = instance.ActivityBudgetService.new() />
		<cfset populateModel(oBudget)>
		<cfset rc.ActivityBudgetID = instance.ActivityBudgetService.saveActivityBudget(oBudget)>

		<cfreturn rc.ActivityBudgetID />
	</cffunction>

	<cffunction name="ajaxDeleteBudget" displayname="ajax delete project owner" output="false" returntype="string">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<cfset delete = instance.ActivityBudgetGateway.deleteByAttributesQuery(ActivityBudgetID=rc.ActivityBudgetID)>
		<!--- <cfreturn "success" /> --->
		<cfreturn rc.ActivityBudgetID />
	</cffunction>
	<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="submitProposal" displayname="proposal save" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfscript>
				var rc = event.getCollection();
		</cfscript>

		<cfif structKeyExists(rc,"btnDeleteProposal") and len(rc.btnDeleteProposal)>
			<cfscript>

				updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,isActive=0);
				getPlugin("MessageBox").setMessage("info","Proposal deleted successfully");
				setNextEvent("summary.index");
			</cfscript>
		<cfelse>
		<!--- <cfif ( isUserinRole("create activity") OR isUserinRole("review activity")  )> --->
			<cfscript>

				rc.progressStatus = "Edit Proposal";
				rc.progressAge = 0;

				//capture systimedatestamp
				var logDateTime = now();
				rc.budgetceilingamount = replace(URLDecode(rc.budgetceilingamount),",", "", "all");
				rc.budgetceilingamount = replace(URLDecode(rc.budgetceilingamount),"$", "", "all");


					//--- attempt to save form ---
					//... initialize proposal object ---
					var oProposal = getModel("Activity").init();

					//--- populate object ---
					populateModel(oProposal);
					rc.ActivityID = instance.ActivityService.saveActivity(oProposal);

					////////////////////////////////////////////////////////////////////////////////////////////////
					// --- validate save ---
					////////////////////////////////////////////////////////////////////////////////////////////////
					var errors = arrayNew(1);
					//--- call validation ---
					arrsErrors = oProposal.validate();
					if (ArrayLen(arrsErrors)) {
						for (a=1;a<=arrayLen(arrsErrors);a++) {
							arrayAppend(errors,arrsErrors[a].message);
						}
					}


						ssrrErrors = oProposal.validateSubmit();
						if (ArrayLen(ssrrErrors)) {
							for (a=1;a<=arrayLen(ssrrErrors);a++) {
								arrayAppend(errors,ssrrErrors[a].message);
							}
						}


						rc.projectFunding = instance.ActivityBudgetGateway.getByAttributesQuery(activityid=rc.activityid);
						rc.owners = instance.ActivityPersonGateway.getByAttributesQuery(activityid=rc.activityid);

						if (rc.projectfunding.recordcount is 0) {
							arrayAppend(errors,"Budget items required");
						}

						if (rc.owners.recordcount is 0) {
							arrayAppend(errors,"Project owners required");
						}


					/*///////////////////////////////////////////////////////////////////////////////////////////////
					//!--- so if errors ---
					///////////////////////////////////////////////////////////////////////////////////////////////*/
					if (arraylen(errors)) {
						ArraySort(errors, "textnocase", "asc");

						ArrayPrepend(errors,"Error while submitting proposal for review:");
						getPlugin("MessageBox").error(message="Error while submitting proposal for review: <br />",messageArray=errors);


							//event.setView(name="proposal/view"); /*,layout="Layout.Main"*/
							setNextEvent(event='proposal.editproject',queryString='activityID/#rc.activityID#');


						} else {


							////////////////////////////////////////////////////////////////////////////////////////////////
							//!-- update statuses ---
							//--- prepare to save ---
							//////////////////////////
							//--- log activity ---
							var oActivityStatusLog = instance.ActivityStatusLogService.new();
							oActivityStatusLog.setActivityID(rc.ActivityID);
							oActivityStatusLog.setStatusDate(logDateTime);
							oActivityStatusLog.setSysUserID(rc.SysUserID);
							var activityStatusID = "";

							//////////////////////////
							//--- save draft ---
							if (structKeyExists(rc,"saveProposalForm") and len(rc.saveProposalForm)){
								if ( rc.saveProposalForm EQ 'save' ) {

									if (rc.activitystatusid lt 268) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal in-progress');
										oActivityStatusLog.setActivityStatusID(ActivityStatusID);
									} else {
										ActivityStatusID = rc.activityStatusID;
										oActivityStatusLog.setActivityStatusID(ActivityStatusID);

									}

									oActivityStatusLog.setlogNote('proposal saved');
									//  update status ---
									updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
									instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
									// -- message and next event  ---
									getPlugin("MessageBox").setMessage("info","Proposal saved successfully");
									if (rc.activitystatusid lt 268) {
										setNextEvent(event='proposal.view',queryString='activityID/#rc.activityID#');
									} else {
										setNextEvent(event='proposal.review',queryString='activityID/#rc.activityID#');
									}

								} else if ( rc.saveProposalForm EQ 'Update Proposal' ) {


									ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal updated');

									oActivityStatusLog.setActivityStatusID(ActivityStatusID);
									oActivityStatusLog.setlogNote('proposal updated');
									//  update status ---
									//updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
									instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
									// -- message and next event ---
									getPlugin("MessageBox").setMessage("info","Proposal updated successfully");
									setNextEvent(event='proposal.review',queryString='activityID/#rc.activityID#');

								}
							} else if (structKeyExists(rc,"saveClone") and len(rc.saveClone)) {
									ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal in-progress');
									oActivityStatusLog.setActivityStatusID(ActivityStatusID);

									oActivityStatusLog.setlogNote('proposal cloned');
									//  update status ---
									updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
									instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
									// -- message and next event  ---
									getPlugin("MessageBox").setMessage("info","Proposal cloned successfully");
									setNextEvent(event='proposal.view',queryString='activityID/#rc.activityID#');

							} else if (structKeyExists(rc,"submitProposalForm") and len(rc.submitProposalForm)) {

								var theProposal = getModel("ActivityService").getActivity(rc.activityID);

								projectFundingSources = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID);
								FundingSourceList = ValueList(projectFundingSources.CategoryID);

								themes = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="Theme",ObjectID=rc.ActivityID);
								themeList = ValueList(themes.CategoryID);

								//if (rc.proposal.placeOfImplementation EQ "Country") {
									var projectRegions = instance.ProposalService.getActivityCountryRegions(ActivityID=rc.ActivityID);
								//}
								//else {
								//	var projectRegions = queryNew("categoryID,Name");
								//}


								//if ((structKeyExists(rc,"skipAMCN") and len(rc.skipAMCN)) or getPlugin("SessionStorage").getVar("curUserAuth.programID") is 6){
								if (structKeyExists(rc,"skipAMCN") and len(rc.skipAMCN)){
									ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program fully obligated');
									oActivityStatusLog.setActivityStatusID(activityStatusID);
									oActivityStatusLog.setlogNote('proposal submitted with no amcn required');
									updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime,clearedPrelegalDate=logDateTime,proposalApprovedDate=logDateTime,AMCNBudgetSubmitDate=logDateTime,AMCNCongressSubmitDate=logDateTime,AMCNApprovedDate=logDateTime,FundApprovedDate=logDateTime,BudgetFundRequestDate=logDateTime,BudgetFundApprovalDate=logDateTime);

									oObStatus = instance.ActivityObligationService.new();
									oObStatus.setActivityID(rc.activityID);
									oObStatus.setAmount(rc.BudgetCeilingAmount);
									oObStatus.setObligationDate(logDateTime);
									oObStatus.setObligationFYyearSource(rc.fiscalYear);
									oObStatus.setComments("Fully obligated - no clearance needed");
									oObStatus.setsysUserID(rc.sysUserID);
									saveOb = instance.ActivityObligationService.saveActivityObligation(oObStatus);
								} else {
									//if rsi with only one region, send to regional review; else, send to program review
									if (((projectFundingSources.recordCount gt 0) and (projectRegions.recordcount eq 1) and (listfind(FundingSourceList,305) or listfind(FundingSourceList,306) or listfind(FundingSourceList,307))) or (rc.ProgramID is 5 and (projectRegions.recordcount eq 1))) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('rsi submitted');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted for regional review');
									} else if (rc.ProgramID is 3 or rc.ProgramID is 1 or rc.ProgramID is 6) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal approved');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted with no approval required');

									} else if (rc.ProgramID is 2) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal submitted');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted with no legal pre-clear required');

									} else {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal submitted');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted for review');
									}

									// update status ---
									if (rc.ProgramID is 3 or rc.ProgramID is 1 or rc.ProgramID is 6) {
										updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime,clearedPrelegalDate=logDateTime,proposalApprovedDate=logDateTime);
									} else if (rc.ProgramID is 2) {
										updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime,clearedPrelegalDate=logDateTime);
									} else {
										updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime);
									}
								}

								instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);


								var emailReceps = instance.ProposalService.userEmails(programID=rc.ProgramID,ActivityID=rc.ActivityID);

								//send email ---
								// Create a new mail object ---

								Email = instance.MailService.newMail();
								Email.setTo( emailReceps.reviewerEmails );
								Email.setFrom( "noreply@ctprograms.com" );
								/* if (isUserLoggedIn()) { Email.setCC( emailReceps.submitterEmails ); } */
								Email.setType( "html" );
								Email.setSubject( ucase(theProposal.getproposalNumber()) & " Proposal Submitted" );
								if (((projectFundingSources.recordCount gt 0) and (projectRegions.recordcount gt 1) and (listfind(FundingSourceList,305) or listfind(FundingSourceList,306) or listfind(FundingSourceList,307))) or (rc.ProgramID is 5 and (projectRegions.recordcount gt 1))) {
									Email.setBody( "<p>This is to notify you that a proposal has been SUBMITTED to the management system and assigned ID <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>" & ucase(theProposal.getproposalNumber()) & "</a>. This project covers multiple regions, requiring additional communication with corresponding regional coordinators. Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> to log on to the system and see the proposal's details and text.</p><br /><p>www.ctprograms.com</p>" );
								} else {
									Email.setBody( "<p>This is to notify you that a proposal has been SUBMITTED to the management system and assigned ID <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>" & ucase(theProposal.getproposalNumber()) & "</a>. Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> to log on to the system and see the proposal's details and text.</p><br /><p>www.ctprograms.com</p>" );
								}
								// Send email
								instance.MailService.send( Email );

								/*-- message and next event ---*/
								getPlugin("MessageBox").setMessage("info","Proposal submitted for review successfully");

								setNextEvent("summary.index");


							} else if (structKeyExists(rc,"btnReturnProposal") and len(rc.btnReturnProposal)) {

								ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal draft');
								// --- clear all previos sttuses and dates
								//rProposal = instance.ActivityService.getActivity(rc.ActivityID);
								oProposal.setproposalSubmitDate('');
								oProposal.setclearedPrelegalDate('');
								oProposal.setActivityStatusID(ActivityStatusID);
								// --- save new proposal ---
								rc.ActivityID = instance.ActivityService.saveActivity(oProposal);

								oActivityStatusLog.setActivityStatusID(activityStatusID);
								oActivityStatusLog.setlogNote('proposal returned to submitter');
								instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);

								//get email recipients

								var emailReceps = instance.ProposalService.userEmails(programID=rc.ProgramID,ActivityID=rc.ActivityID);

								//send email ---
								if ( listLen(emailReceps.submitterEmails,",") ) {
									// Create a new mail object ---
									Email = instance.MailService.newMail();
									Email.setTo( emailReceps.submitterEmails );
									Email.setFrom( "noreply@ctprograms.com" );
									//Email.setCC( "emailReceps.reviewerEmails" );
									Email.setType( "html" );
									Email.setSubject( ucase(oProposal.getproposalNumber()) & " Proposal Returned" );
									Email.setBody( "<p>This is to notify you that Proposal <a href=#event.buildLink('proposal.view.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been RETURNED in the management system. Please follow the <a href=#event.buildLink('proposal.view.activityID.' & rc.ActivityID)#>link</a> to log on to the system to see the proposal's details and text.</p><br /><p>www.ctprograms.com</p>" );
								}
								/* Send email */
								instance.MailService.send( Email );



								//update status ---
								getPlugin("MessageBox").setMessage("info","Proposal returned successfully");
								setNextEvent("summary.index");

							} else if (structKeyExists(rc,"btnDeleteProposal") and len(rc.btnDeleteProposal)){

								//-- update isActive ---
								updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,isActive=0);
								getPlugin("MessageBox").setMessage("info","Proposal deleted successfully");
								setNextEvent("summary.index");

							} else if (structKeyExists(rc,"btnDenyProposal") and len(rc.btnDenyProposal)){

								//-- update status ---


								activityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal denied');
								oActivityStatusLog.setActivityStatusID(activityStatusID);
								oActivityStatusLog.setlogNote('program deny proposal');
								updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
								instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
								getPlugin("MessageBox").setMessage("info","Proposal denied successfully");
								setNextEvent("summary.index");

							}


					}



						//event.setView(name="proposal/view"queryString='#rc.contact_hash#/#rc.user_hash#/');//,layout="Layout.Main"
						setNextEvent(event='proposal.editproject',queryString='activityID/#rc.activityID#');



			</cfscript>


		</cfif>
	</cffunction>

	<cffunction name="editproject" displayname="project edit" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<cfset rc.pagetitle = "Edit Project">
		<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID) />
		<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />
		<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
		<cfset rc.regionCountryAll = instance.ProposalService.getRegionCountry() />
		<cfset rc.programid = rc.proposal.programid>
		<cfset rc.projectTitle = rc.proposal.name />
		<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(activityid=rc.activityid,orderby="commentDate")>
		<cfset rc.programs = instance.ProgramService.getProgramsQuery() />
		<cfset rc.getActivityResults = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=1)>
		<cfset rc.getSecondaryResults = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=0)>
		<cfset rc.resultsFrameworkElementID=rc.getActivityResults.resultsFrameworkElementID>
		<cfset rc.secondaryResultsList=valuelist(rc.getSecondaryResults.resultsFrameworkElementID)>
		<cfset rc.projectCountries = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID) />
		<cfset rc.projectCountryIDs = valuelist(rc.projectCountries.categoryID)>
		<cfset rc.countriesAll = instance.ProposalService.getRegionCountry() />
		<cfset rc.projectOrganizations = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityOrganization",ObjectID=rc.ActivityID) />
		<cfset rc.projectOrgIDs = valuelist(rc.projectOrganizations.categoryID)>
		<cfset rc.allOrganizations = instance.ProposalService.getCTEOrganizations() />
		<cfset rc.ctfPartners = instance.ProposalService.getCTFPartners() />
		<cfset rc.fundMechTypes = instance.ProposalService.getFundMechTypes() />
		<cfset rc.projectFundingSources = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID) />
		<cfset rc.projectThemes = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="Theme",ObjectID=rc.ActivityID) />
		<cfset rc.fundingSourcesAll = instance.ProposalService.getSCTAccounts() />
		<cfset rc.themesAll = instance.ProposalService.getThemes() />
		<cfset rc.fundingSourceIDs = valuelist(rc.projectFundingSources.categoryID)>
		<cfset rc.themeIDs = valuelist(rc.projectThemes.categoryID)>
		<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(activityid=rc.activityid,orderby="commentDate desc")>
		<cfset rc.projectFunding = instance.ActivityBudgetGateway.getByAttributesQuery(activityid=rc.activityid) />
		<cfset rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='Activity') />

		<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />
		<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
		<cfset rc.progressAge = rc.progressStatusQ.activityAge>

		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />

		<cfset rc.projectOrgs = instance.ActivityOrgGateway.getByAttributesQuery(ActivityID=rc.activityid) />
		<cfset var getOrgIDList = iif(NOT listLen(valueList(rc.projectOrgs.orgID)),0,DE("#valueList(rc.projectOrgs.orgID)#")) />
		<cfset rc.implementer = instance.OrgGateway.getByAttributesQuery(OrgIDList=getOrgIDList) />
		<cfif rc.implementer.recordCount EQ 0>
			<cfset Temp = QueryAddRow(rc.implementer) />
		</cfif>

		<cfscript>
			if (rc.programid is 5) {
				rc.programResults = instance.ResultsFrameworkElementGateway.getRSIResults();
			} else {
				rc.programResults = instance.ResultsFrameworkElementGateway.getByAttributesQuery(programid=rc.programid,orderby="Name");
			}
		</cfscript>
		<cfset rc.owners = instance.ActivityPersonGateway.getByAttributesQuery(activityid=rc.activityid) />

		<cfset event.setView(name="proposal/editproject") />
	</cffunction>

	<cffunction name="new" displayname="proposal create" output="false" returntype="void">
		<cfargument name="event" required="false" />


		<cfscript>
			//get request collection
			var rc = event.getCollection();
			//set page title
			rc.pagetitle = "Create New Proposal";
			rc.isNewProposal = "true";

			rc.progressStatus = "New Proposal";
			rc.progressAge = 0;

			//... lookup data
			//rc.projectRegion = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityRegion",ObjectID=rc.ActivityID)
			rc.countriesAll = instance.ProposalService.getRegionCountry();
			rc.availableRegions = instance.ProposalService.getRegions();
			rc.regionCountryAll = instance.ProposalService.getRegionCountry();
			rc.fundMechTypes = instance.ProposalService.getFundMechTypes();
			rc.fundingSourcesAll = instance.ProposalService.getSCTAccounts();
			rc.ctfPartners = instance.ProposalService.getCTFPartners();
			rc.allOrganizations = instance.ProposalService.getCTEOrganizations();
			rc.programs = instance.ProgramService.getProgramsQuery();


			// global variables
			rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName');



			if (rc.programid is 5) {
				rc.programResults = instance.ResultsFrameworkElementGateway.getRSIResults();
			} else {
				rc.programResults = instance.ResultsFrameworkElementGateway.getByAttributesQuery(programid=rc.programid,orderby="Name");
			}


			//... initialize activity form elements
			/* initialize form values */
			//rc.proposal = querynew("activityID,Name,proposalNumber,Description,StartDate,EndDate,BudgetCeilingAmount,projectObjective,interestSpecification,lawEnforcementSpecification,coordinationSpecification,programAudience,fundImpMechanismID,activityStatusID,activityStatus,placeOfImplementation,proposalSubmitDate,clearedPrelegalDate,isActive,programID,implementingPartner");
			rc.proposal = querynew("activityID,Name,projectTitle,proposalNumber,Description,StartDate,EndDate,BudgetCeilingAmount,projectObjective,interestSpecification,lawEnforcementSpecification,coordinationSpecification,programAudience,proposalSubmitDate,fundImpMechanismID,activityStatusID,activityStatus,placeOfImplementation,clearedPrelegalDate,isActive,implementingPartner,programID,proposalApprovedDate,AMCNBudgetSubmitDate,AMCNCongressSubmitDate,AMCNApprovedDate,FundApprovedDate,BudgetFundRequestDate,BudgetFundApprovalDate,amcnnumber,reprogramFunds,ctex,reprogramComments,fiscalYear,lessonsLearned,sustainability,cityProvince,cnId,CnTitle,relatedProjects,ctex");
			temp = QueryAddRow(rc.proposal);
			rc.fiscalYear = year(now());
			rc.projectTitle = rc.proposal.name;

			//... owners
			rc.owners = querynew("ActivityPersonID,ActivityID,LastName,FirstName,Email,Phone,Office");
			temp = QueryAddRow(rc.owners);

			//... place of implementation
			//- countries
			rc.projectCountries = querynew("CategoryID,Name,ExternalCode");
			rc.projectCountryIDs = "";
			//- regions
			rc.projectRegions = querynew("CategoryID,Name,ExternalCode");
			rc.projectOrganizations = querynew("CategoryID,Name,ExternalCode");
			rc.projectOrgIDs = "";

			//rc.getActivityResults = querynew("resultsFrameworkElementID");
			rc.resultsFrameworkElementID = "";
			//rc.getSecondaryResults = querynew("resultsFrameworkElementID");
			//rc.primaryList="";
			rc.secondaryResultsList="";

			//... implementer information - organization/partner
			rc.implementer = querynew("OrgID,Name,implementingPartner,pocLastName,pocFirstName,pocEmail,pocPhone");
			temp = QueryAddRow(rc.implementer );

			// ... funding breakdown
			rc.projectFunding = querynew("ActivityBudgetID,ActivityID,CategoryID,countryID,BudgetItem,BudgetAmount");
			temp = QueryAddRow(rc.projectFunding);
			rc.projectCountryBudget = querynew("CategoryID,Country,Region");
			temp = QueryAddRow(rc.projectCountryBudget);

			//... funding/implementation mech types
			// from lookup data

			//... funding sources
			rc.projectFundingSources = queryNew("CategoryID,Name,ExternalCode");
			rc.fundingSourceIDs = "";

			//... indicator, objective
			rc.indicators = querynew("ActivityID,name,objective");
			temp = QueryAddRow(rc.indicators);

			//... files
			rc.attachedFiles = querynew("AttachedFileID,Name,LongDescription,AttachedFileName,AttachedFileDate,ObjectTableName,ObjectTableID");
			temp = QueryAddRow(rc.attachedFiles);

			//initialize the div id variable so the page moves to the right place after adding a row
			event.paramValue("jumpTo","");

			//set default number of project owners, implementers, budget items, Objectives & Indicators, and file attachments
			event.paramValue("activityID","");
			event.paramValue("ocnt","");
			event.paramValue("icnt","");
			event.paramValue("bcnt","");
			event.paramValue("oicnt","");
			event.paramValue("fcnt","");

		</cfscript>

		<cfset event.setView(name="proposal/view") />
	</cffunction>

	<cffunction name="view" displayname="proposal edit" output="false" returntype="void">
		<cfargument name="event" required="false" />



		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "View Proposal">
		<!--- //is proposal form new --->
		<cfset rc.isNewProposal = "false" />

		<cfif not (StructKeyExists(rc,"edittype"))>
			<cfset rc.edittype = "">
		</cfif>

		<cfset rc.progressStatus = "Edit Proposal" />
		<cfset rc.progressAge = 0>

		<!--- lookup data --->
		<cfset rc.fundMechTypes = instance.ProposalService.getFundMechTypes() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.regionCountryAll = instance.ProposalService.getRegionCountry() />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.programs = instance.ProgramService.getProgramsQuery() />

		<cfset rc.ctfPartners = instance.ProposalService.getCTFPartners() />

		<!---initialize the div id variable so the page moves to the right place after adding a row--->
		<cfset rc.jumpTo = "">

		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID) />
			<cfset rc.programid = rc.proposal.programid>

				<cfset rc.projectTitle = rc.proposal.name />
				<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(activityid=rc.activityid,orderby="commentDate")>
				<cfset rc.programs = instance.ProgramService.getProgramsQuery() />
				<cfset rc.getActivityResults = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=1)>
				<cfset rc.getSecondaryResults = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=0)>
				<cfset rc.resultsFrameworkElementID=rc.getActivityResults.resultsFrameworkElementID>
				<cfset rc.secondaryResultsList=valuelist(rc.getSecondaryResults.resultsFrameworkElementID)>
				<!--- <cfset rc.programResults = instance.ResultsFrameworkElementGateway.getByAttributesQuery(programid=rc.proposal.programid,orderby="Name")> --->
				<cfscript>
					if (rc.programid is 5) {
						rc.programResults = instance.ResultsFrameworkElementGateway.getRSIResults();
					} else {
						rc.programResults = instance.ResultsFrameworkElementGateway.getByAttributesQuery(programid=rc.programid,orderby="Name");
					}
				</cfscript>

				<!--- ... owners --->
				<cfset rc.owners = instance.ActivityPersonGateway.getByAttributesQuery(activityid=rc.activityid) />
				<cfif rc.owners.recordCount EQ 0>
					<cfset Temp = QueryAddRow(rc.owners) />
				</cfif>

				<!--- ... place of implementation --->
				<cfswitch expression="#rc.proposal.placeOfImplementation#">
					<cfcase value="Country">
						<cfset rc.projectCountries = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID) />
						<cfset rc.projectCountryIDs = valuelist(rc.projectCountries.categoryID)>
						<cfset rc.countriesAll = instance.ProposalService.getRegionCountry() />
						<cfset rc.availableRegions = instance.ProposalService.getRegions() />
						<cfset rc.projectRegions = querynew("CategoryID,Name,ExternalCode") />

					</cfcase>

					<cfdefaultcase>
						<!--- none --->
						<cfset rc.countriesAll = instance.ProposalService.getRegionCountry() />
						<cfset rc.projectCountries = querynew("CategoryID,Name,ExternalCode") />
						<cfset rc.availableRegions = instance.ProposalService.getRegions() />
						<cfset rc.projectRegions = querynew("CategoryID,Name,ExternalCode") />
						<cfset rc.projectCountryIDs = "">

					</cfdefaultcase>
				</cfswitch>

				<cfset rc.projectOrganizations = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityOrganization",ObjectID=rc.ActivityID) />
				<cfset rc.projectOrgIDs = valuelist(rc.projectOrganizations.categoryID)>
				<cfset rc.allOrganizations = instance.ProposalService.getCTEOrganizations() />

				<!--- ... implementer information - organization/partner --->
				<cfset rc.projectOrgs = instance.ActivityOrgGateway.getByAttributesQuery(ActivityID=rc.activityid) />
				<cfset var getOrgIDList = iif(NOT listLen(valueList(rc.projectOrgs.orgID)),0,DE("#valueList(rc.projectOrgs.orgID)#")) />
				<cfset rc.implementer = instance.OrgGateway.getByAttributesQuery(OrgIDList=getOrgIDList) />
				<cfif rc.implementer.recordCount EQ 0>
					<cfset Temp = QueryAddRow(rc.implementer) />
				</cfif>

				<!--- ... funding breakdown --->
				<cfset rc.projectFunding = instance.ActivityBudgetGateway.getByAttributesQuery(activityid=rc.activityid) />
				<cfif rc.projectFunding.recordCount EQ 0>
					<cfset Temp = QueryAddRow(rc.projectFunding) />
				</cfif>

				<!--- ... funding mechanism --->
				<!--- proposal.fundMechTypeID --->

				<!--- ... funding sources --->
				<cfset rc.projectFundingSources = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID) />
				<cfset rc.fundingSourcesAll = instance.ProposalService.getSCTAccounts() />
				<cfset rc.fundingSourceIDs = valuelist(rc.projectFundingSources.categoryID)>


				<!--- ... indicator, objective --->
				<cfset rc.projectIndicators =  instance.ActivityIndicatorGateway.getByAttributesQuery(ActivityID=rc.activityid) />
				<cfset var getIndicatorList = iif(NOT listLen(valueList(rc.projectIndicators.indicatorID)),0,DE("#valueList(rc.projectIndicators.indicatorID)#")) />
				<cfset rc.indicators = instance.indicatorGateway.getByAttributesQuery(indicatorIDList=getIndicatorList) />
				<cfif rc.indicators.recordCount EQ 0>
					<cfset Temp = QueryAddRow(rc.indicators) />
				</cfif>

				<!--- ... attached files --->
				<cfset rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='Activity') />
				<cfif rc.attachedFiles.recordCount EQ 0>
					<cfset temp = QueryAddRow(rc.attachedFiles) />
				</cfif>
		</cfif>

		<!--- get row number values --->
		<cfset event.paramValue("ocnt","1") />
		<cfset event.paramValue("ocnt","1") />
		<cfset event.paramValue("icnt","1") />
		<cfset event.paramValue("bcnt","1") />
		<cfset event.paramValue("oicnt","1") />
		<cfset event.paramValue("fcnt","1") />

		<cfif rc.edittype is "budget">
			<cfset event.setView(name="proposal/editbudget") />
		<cfelse>
			<cfset event.setView(name="proposal/view") />
		</cfif>

	</cffunction>

	<cffunction name="editbudget" displayname="budget edit" output="false" returntype="void">
		<cfargument name="event" required="false" />

		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Edit Budget">

		<cfset rc.progressStatus = "" />
			<cfset rc.progressAge = 0 />

		<!--- lookup data --->

		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.regionCountryAll = instance.ProposalService.getRegionCountry() />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />

			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID) />
			<cfset rc.projectTitle = rc.proposal.name />

			<!--- ... funding breakdown --->
			<cfset rc.projectFunding = instance.ActivityBudgetGateway.getByAttributesQuery(activityid=rc.activityid) />
			<cfif rc.projectFunding.recordCount EQ 0>
				<cfset Temp = QueryAddRow(rc.projectFunding) />
			</cfif>

		<cfset event.paramValue("bcnt","1") />


		<cfset event.setView(name="proposal/editbudget") />

	</cffunction>

	<cffunction name="review" displayname="proposal review" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Review Proposal">

		<!--- lookup data --->
		<cfset rc.FundMechTypes = instance.ProposalService.getFundMechTypes() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.userRegionID = getPlugin("SessionStorage").getVar("curUserAuth.categoryID") />
		<cfset rc.userRegionList = getPlugin("SessionStorage").getVar("curUserAuth.Categories") />
		<cfset rc.ctfPartners = instance.ProposalService.getCTFPartners() />





		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfset rc.ownedprojectsummary = instance.ProposalGateway.getOwnedProjectSummary(sysUserID=rc.sysuserID) />
			<cfset rc.ownedprojectList = ValueList(rc.ownedprojectsummary.activityID)>
			<cfif rc.proposal.recordcount gt 0>
				<cfset rc.projectTitle = rc.proposal.name />
				<cfif rc.proposal.placeOfImplementation EQ "Country" or rc.proposal.placeOfImplementation EQ "">
					<cfset rc.projectRegions = instance.ProposalService.getActivityCountryRegions(ActivityID=rc.ActivityID)>
					<cfset rc.regionList = ValueList(rc.projectRegions.regionID)>
					<cfset rc.projectRSIRegions = instance.ProposalService.getActivityCountryRSIRegions(ActivityID=rc.ActivityID)>
					<cfset rc.rsiRegionList = ValueList(rc.projectRSIRegions.regionID)>
				<cfelse>
					<cfset rc.projectRegions = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID)>
					<cfset rc.regionList = ValueList(rc.projectRegions.categoryID)>
					<cfset rc.rsiregionList = ValueList(rc.projectRegions.categoryID)>
				</cfif>

				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>





				<!--- ... owners --->
				<cfset rc.owners = instance.ActivityPersonGateway.getByAttributesQuery(activityid=rc.activityid) />

				<!--- ... place of implementation --->
				<cfif rc.proposal.placeOfImplementation EQ "Country" or rc.proposal.placeOfImplementation EQ "">
					<cfset rc.projectCountries = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID) />
					<cfset rc.projectRegions = instance.ProposalService.getActivityCountryRegions(ActivityID=rc.ActivityID) />
				<cfelseif rc.proposal.placeOfImplementation EQ "Region">
					<cfset rc.projectRegions = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID) />
				<!--- <cfelseif rc.proposal.placeOfImplementation EQ "Organization">
					<cfset rc.projectOrganizations = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityOrganization",ObjectID=rc.ActivityID) /> --->
				</cfif>

				<cfset rc.projectOrganizations = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityOrganization",ObjectID=rc.ActivityID) />

				<!--- ... funding breakdown --->
				<cfset rc.projectFunding = instance.ActivityBudgetGateway.getByAttributesQuery(activityid=rc.activityid) />

				<!--- ... funding mechanism --->
				<!--- proposal.fundMechTypeID --->

				<!--- ... funding sources --->
				<cfset rc.projectFundingSources = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID) />
				<cfset rc.themes = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="Theme",ObjectID=rc.ActivityID) />

				<!--- ... implementer information - organization/partner --->
				<cfset rc.projectOrgs = instance.ActivityOrgGateway.getByAttributesQuery(ActivityID=rc.activityid) />
				<cfset var getOrgIDList = iif(NOT listLen(valueList(rc.projectOrgs.orgID)),0,DE("#valueList(rc.projectOrgs.orgID)#")) />
				<cfset rc.implementer = instance.OrgGateway.getByAttributesQuery(OrgIDList=getOrgIDList) />

				<!--- ... NEW Result/Indicators --->


				<cfset rc.primaryResult = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=1)>
				<cfset rc.SecondaryResult = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=0)>


	<!---			<cfif primaryResults.recordcount is not 0>

	           <cfset rc.getResult = instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.proposal.ResultsFrameworkElementID) />
	          	<cfset rc.resultsIndicators = instance.resultsFrameworkService.getResultsIndicatorsQuery(ResultsFrameworkElementID=rc.proposal.ResultsFrameworkElementID) />

				</cfif>
	--->


	      		<!--- ... indicator, objective --->

				<cfset rc.projectIndicators =  instance.ActivityIndicatorGateway.getByAttributesQuery(ActivityID=rc.activityid) />
				<cfset var getIndicatorList = iif(NOT listLen(valueList(rc.projectIndicators.indicatorID)),0,DE("#valueList(rc.projectIndicators.indicatorID)#")) />
				<cfset rc.indicators = instance.indicatorGateway.getByAttributesQuery(indicatorIDList=getIndicatorList) />

				<!--- ... attached files --->
				<cfset rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='Activity')>

				<!--- notes recommendations --->
				<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(activityid=rc.activityid,orderby="commentDate desc")>

				<cfset event.setView(name="proposal/review") />
		    <cfelse>
		    	<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		    </cfif>
		<cfelse>
			<!--- error msg --->
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>



	</cffunction>

	<cffunction name="print" displayname="proposal review" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Review Proposal">

		<!--- lookup data --->
		<cfset rc.FundMechTypes = instance.ProposalService.getFundMechTypes() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />



		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID) />
			<cfset rc.projectTitle = rc.proposal.name />

			<!--- ... progress check --->
			<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

			<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
			<cfset rc.progressAge = rc.progressStatusQ.activityAge>

			<!--- ... owners --->
			<cfset rc.owners = instance.ActivityPersonGateway.getByAttributesQuery(activityid=rc.activityid) />

			<!--- ... place of implementation --->
			<cfif rc.proposal.placeOfImplementation EQ "Country">
				<cfset rc.projectCountries = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID) />
			<cfelseif rc.proposal.placeOfImplementation EQ "Region">
				<cfset rc.projectRegions = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID) />
			</cfif>

			<!--- ... funding breakdown --->
			<cfset rc.projectFunding = instance.ActivityBudgetGateway.getByAttributesQuery(activityid=rc.activityid) />

			<!--- ... funding mechanism --->
			<!--- proposal.fundMechTypeID --->

			<!--- ... funding sources --->
			<cfset rc.projectFundingSources = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID) />


			<!--- ... implementer information - organization/partner --->
			<cfset rc.projectOrgs = instance.ActivityOrgGateway.getByAttributesQuery(ActivityID=rc.activityid) />
			<cfset var getOrgIDList = iif(NOT listLen(valueList(rc.projectOrgs.orgID)),0,DE("#valueList(rc.projectOrgs.orgID)#")) />
			<cfset rc.implementer = instance.OrgGateway.getByAttributesQuery(OrgIDList=getOrgIDList) />

			<!--- ... indicator, objective --->
			<cfset rc.projectIndicators =  instance.ActivityIndicatorGateway.getByAttributesQuery(ActivityID=rc.activityid) />
			<cfset var getIndicatorList = iif(NOT listLen(valueList(rc.projectIndicators.indicatorID)),0,DE("#valueList(rc.projectIndicators.indicatorID)#")) />
			<cfset rc.indicators = instance.indicatorGateway.getByAttributesQuery(indicatorIDList=getIndicatorList) />

			<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(activityid=rc.activityid,orderby="commentDate desc")>
		<cfelse>
			<!--- error msg --->

		</cfif>

			<cfset event.setView(name="proposal/print",layout="layout.Print") />

	</cffunction>

	<cffunction name="printamcn" displayname="proposal review" output="false" returntype="void">
		<cfargument name="event" required="false" />

		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "CN Proposal">

		<!---initialize the div id variable so the page moves to the right place after adding a row--->
		<cfset rc.jumpTo = "">

		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.cnReadyStatusIDCheck = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance complete') />

		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<!--- <cfset rc.oProposal = instance.activityService.getActivity(activityid=rc.activityID) /> --->
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID) />
			<cfset rc.projectTitle = rc.proposal.name />

			<!--- <cfdump var="#rc.proposal#">
				<cfabort> --->

			<!--- cn number --->
			<!--- <cfset rc.activityCNnum = instance.ActivityExtendedGrantGateway.getActivityCNNumber(rc.activityID) /> --->

			<cfset rc.isCNClearanceComplete = 'false'>
			<cfset var yesCnt = 0>

			<!--- get status code --->
			<!---
				<cfset rc.categoryStatusCode = instance.ActivityStatusGateway.getByAttributesQuery(CategoryID=rc.proposal.activityStatusID) />
				<cfset rc.ActivityStatus = rc.categoryStatusCode.name />
			 --->

			<!--- ... progress check --->
			<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>



			<cfif structKeyExists(rc,"cnid") and isnumeric(rc.cnid)>
				<cfset rc.activecn = instance.CNGateway.getByAttributesQuery(cnid=rc.cnID) />
			<cfelse>
				<cfset rc.activecn = instance.CNGateway.getByAttributesQuery(activityid=rc.activityID,isComplete="no") />
				<cfif rc.activecn.recordcount is 0>
					<cfset rc.activecn = instance.CNGateway.getByAttributesQuery(activityid=rc.activityID) />
				</cfif>
				<cfif isnumeric(rc.activecn.cnID)>
					<cfset rc.cnid = rc.activecn.cnID />
				<cfelse>
					<cfset rc.cnid = 0 />
				</cfif>
			</cfif>

			<cfset rc.cnActivities = instance.CNGateway.getCNActivities(cnID=rc.cnID) />
			<cfset rc.cnActivitiesList = ValueList(rc.cnActivities.proposalNumber,", ")>


			<!--- ... attached files --->
			<cfset rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.cnid,ObjectTableName='ActivityAMCN',isArchived=0) />
			<cfset rc.archivedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.cnid,ObjectTableName='ActivityAMCN',isArchived=1) />
			<cfset rc.relatedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.cnid,ObjectTableName='ActivityAMCN',isArchived=0) />
			<!--- ... get clearance --->


			<cfset rc.clearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID) />

			<cfset temp = QueryAddRow(rc.clearance) />

			<cfloop query="rc.clearance">
				<cfswitch expression="#clearanceAgencyName#">
					<cfcase value="Legal">
						<cfset rc.legalReviewStatus = rc.clearance.clearanceStatus />
						<cfset rc.legalReviewComment = rc.clearance.comments />
						<cfset rc.legalReviewDate = rc.clearance.cstatusDate />
						<cfset rc.legalReviewID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="Foreign Assist">
						<cfset rc.foreignAssistanceStatus = rc.clearance.clearanceStatus />
						<cfset rc.foreignAssistanceComment = rc.clearance.comments />
						<cfset rc.foreignAssistanceDate = rc.clearance.cstatusDate />
						<cfset rc.foreignAssistanceID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="Congressional Affairs">
						<cfset rc.congressionalAffairsStatus = rc.clearance.clearanceStatus />
						<cfset rc.congressionalAffairsComment = rc.clearance.comments />
						<cfset rc.congressionalAffairsDate = rc.clearance.cstatusDate />
						<cfset rc.congressionalAffairsID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="policy Planning">
						<cfset rc.policyPlanningStatus = rc.clearance.clearanceStatus />
						<cfset rc.policyPlanningComment = rc.clearance.comments />
						<cfset rc.policyPlanningDate = rc.clearance.cstatusDate />
						<cfset rc.policyPlanningID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="SCT Coordinator">
						<cfset rc.sctCoordinatorStatus = rc.clearance.clearanceStatus />
						<cfset rc.sctCoordinatorComment = rc.clearance.comments />
						<cfset rc.sctCoordinatorDate = rc.clearance.cstatusDate />
						<cfset rc.sctCoordinatorID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="Management and Budget">
						<cfset rc.ombReviewStatus = rc.clearance.clearanceStatus />
						<cfset rc.ombReviewComment = rc.clearance.comments />
						<cfset rc.ombReviewDate = rc.clearance.cstatusDate />
						<cfset rc.ombReviewID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="Deputy Review">
						<cfset rc.deputyReviewStatus = rc.clearance.clearanceStatus />
						<cfset rc.deputyReviewComment = rc.clearance.comments />
						<cfset rc.deputyReviewDate = rc.clearance.cstatusDate />
						<cfset rc.deputyReviewID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="AMCN Front Office">
						<cfset rc.frontOfficeStatus = rc.clearance.clearanceStatus />
						<cfset rc.frontOfficeComment = rc.clearance.comments />
						<cfset rc.frontOfficeDate = rc.clearance.cstatusDate />
						<cfset rc.frontOfficeID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="AMCN FA Front Office">
						<cfset rc.fassistfrontOfficeStatus = rc.clearance.clearanceStatus />
						<cfset rc.fassistfrontOfficeComment = rc.clearance.comments />
						<cfset rc.fassistfrontOfficeDate = rc.clearance.cstatusDate />
						<cfset rc.fassistfrontOfficeID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes' or rc.clearance.clearanceStatus IS 'N/A' >
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="Legislative Affairs">
						<cfset rc.legalAffairsFOStatus = rc.clearance.clearanceStatus />
						<cfset rc.legalAffairsFOComment = rc.clearance.comments />
						<cfset rc.legalAffairsFODate = rc.clearance.cstatusDate />
						<cfset rc.legalAffairsFOID = rc.clearance.cnClearanceID />
						<cfif rc.clearance.clearanceStatus IS 'Yes'>
							<cfset yesCnt = yesCnt + 1>
						</cfif>
					</cfcase>
					<cfcase value="Congress">
						<cfset rc.cnApprovalStatus = rc.clearance.clearanceStatus />
						<cfset rc.cnApprovalComments = rc.clearance.comments />
						<cfset rc.cnApprovalDate = rc.clearance.cstatusDate />
						<cfset rc.cnApprovalID = rc.clearance.cnClearanceID />
					</cfcase>

					<cfdefaultcase>
						<cfset event.paramValue("legalReviewStatus","") />
						<cfset event.paramValue("legalReviewComment","") />
						<cfset event.paramValue("legalReviewDate","") />
						<cfset event.paramValue("legalReviewID","") />
						<cfset event.paramValue("foreignAssistanceStatus","") />
						<cfset event.paramValue("foreignAssistanceComment","") />
						<cfset event.paramValue("foreignAssistanceDate","") />
						<cfset event.paramValue("foreignAssistanceID","") />
						<cfset event.paramValue("congressionalAffairsStatus","") />
						<cfset event.paramValue("congressionalAffairsComment","") />
						<cfset event.paramValue("congressionalAffairsDate","") />
						<cfset event.paramValue("congressionalAffairsID","") />
						<cfset event.paramValue("policyPlanningStatus","") />
						<cfset event.paramValue("policyPlanningComment","") />
						<cfset event.paramValue("policyPlanningDate","") />
						<cfset event.paramValue("policyPlanningID","") />
						<cfset event.paramValue("sctCoordinatorStatus","") />
						<cfset event.paramValue("sctCoordinatorComment","") />
						<cfset event.paramValue("sctCoordinatorDate","") />
						<cfset event.paramValue("sctCoordinatorID","") />
						<cfset event.paramValue("ombReviewStatus","") />
						<cfset event.paramValue("ombReviewComment","") />
						<cfset event.paramValue("ombReviewDate","") />
						<cfset event.paramValue("ombReviewID","") />
						<cfset event.paramValue("deputyReviewStatus","") />
						<cfset event.paramValue("deputyReviewComment","") />
						<cfset event.paramValue("deputyReviewDate","") />
						<cfset event.paramValue("deputyReviewID","") />
						<cfset event.paramValue("frontOfficeStatus","") />
						<cfset event.paramValue("frontOfficeComment","") />
						<cfset event.paramValue("frontOfficeDate","") />
						<cfset event.paramValue("frontOfficeID","") />
						<cfset event.paramValue("fassistfrontOfficeStatus","") />
						<cfset event.paramValue("fassistfrontOfficeComment","") />
						<cfset event.paramValue("fassistfrontOfficeDate","") />
						<cfset event.paramValue("fassistfrontOfficeID","") />
						<cfset event.paramValue("legalAffairsFOStatus","") />
						<cfset event.paramValue("legalAffairsFOComment","") />
						<cfset event.paramValue("legalAffairsFODate","") />
						<cfset event.paramValue("legalAffairsFOID","") />
						<cfset event.paramValue("cnApprovalStatus","") />
						<cfset event.paramValue("cnApprovalComments","") />
						<cfset event.paramValue("cnApprovalDate","") />
						<cfset event.paramValue("cnApprovalID","") />
						<cfset event.paramValue("cnApprovalID","") />

					</cfdefaultcase>
				</cfswitch>
			</cfloop>
			<cfif yesCnt EQ 10>
				<cfset rc.isCNClearanceComplete = 'true' />
			</cfif>
			<!--- notes recommendations --->
			<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(cnid=rc.cnID,orderby="commentDate",cnOnly=true)>
		</cfif>

		<cfset event.setView(name="proposal/printamcn",layout="layout.Print") />

	</cffunction>


	<cffunction name="CN" displayname="am/cn clearance" output="false" returntype="void">
		<cfargument name="event" required="false" />

		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "CN Proposal">

		<!---initialize the div id variable so the page moves to the right place after adding a row--->
		<cfset rc.jumpTo = "">

		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.cnReadyStatusIDCheck = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance complete') />

		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>

			<!--- <cfset rc.oProposal = instance.activityService.getActivity(activityid=rc.activityID) /> --->
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif structKeyExists(rc,"cnid") and isnumeric(rc.cnid)>
				<cfset rc.activecn = instance.CNGateway.getByAttributesQuery(cnid=rc.cnID) />
			<cfelse>
				<cfset rc.activecn = instance.CNGateway.getByAttributesQuery(activityid=rc.activityID,isComplete="no") />
				<cfif rc.activecn.recordcount is 0>
					<cfset rc.activecn = instance.CNGateway.getByAttributesQuery(activityid=rc.activityID) />
				</cfif>
				<cfif isnumeric(rc.activecn.cnID)>
					<cfset rc.cnid = rc.activecn.cnID />
				<cfelse>
					<cfset rc.cnid = 0 />
				</cfif>
			</cfif>

			<cfset rc.activitycns = instance.CNGateway.getActivityCNs(activityid=rc.activityID) />

			<!--- <cfset rc.inactivecns = instance.CNGateway.getByAttributesQuery(activityid=rc.activityID,isComplete="yes") /> --->
			<cfif rc.proposal.recordcount gt 0>
				<cfset rc.projectTitle = rc.proposal.name />


				<cfset rc.isCNClearanceComplete = 'false'>
				<cfset var yesCnt = 0>

				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>

				<cfset rc.cnActivities = instance.CNGateway.getCNActivities(cnID=rc.cnID) />
				<cfset rc.cnActivitiesList = ValueList(rc.cnActivities.proposalNumber,", ")>

				<!--- ... attached files --->
				<cfset rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.cnid,ObjectTableName='ActivityAMCN',isArchived=0) />
				<cfset rc.archivedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.cnid,ObjectTableName='ActivityAMCN',isArchived=1) />
				<cfset rc.relatedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.cnid,ObjectTableName='ActivityAMCN',isArchived=0) />
				<!--- ... get clearance --->

				<cfset rc.clearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID) />

				<cfset temp = QueryAddRow(rc.clearance) />

				<cfloop query="rc.clearance">
					<cfswitch expression="#clearanceAgencyName#">
						<cfcase value="Legal">
							<cfset rc.legalReviewStatus = rc.clearance.clearanceStatus />
							<cfset rc.legalReviewComment = rc.clearance.comments />
							<cfset rc.legalReviewDate = rc.clearance.cstatusDate />
							<cfset rc.legalReviewID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Foreign Assist">
							<cfset rc.foreignAssistanceStatus = rc.clearance.clearanceStatus />
							<cfset rc.foreignAssistanceComment = rc.clearance.comments />
							<cfset rc.foreignAssistanceDate = rc.clearance.cstatusDate />
							<cfset rc.foreignAssistanceID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Congressional Affairs">
							<cfset rc.congressionalAffairsStatus = rc.clearance.clearanceStatus />
							<cfset rc.congressionalAffairsComment = rc.clearance.comments />
							<cfset rc.congressionalAffairsDate = rc.clearance.cstatusDate />
							<cfset rc.congressionalAffairsID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Policy Planning">
							<cfset rc.policyPlanningStatus = rc.clearance.clearanceStatus />
							<cfset rc.policyPlanningComment = rc.clearance.comments />
							<cfset rc.policyPlanningDate = rc.clearance.cstatusDate />
							<cfset rc.policyPlanningID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="SCT Coordinator">
							<cfset rc.sctCoordinatorStatus = rc.clearance.clearanceStatus />
							<cfset rc.sctCoordinatorComment = rc.clearance.comments />
							<cfset rc.sctCoordinatorDate = rc.clearance.cstatusDate />
							<cfset rc.sctCoordinatorID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Management and Budget">
							<cfset rc.ombReviewStatus = rc.clearance.clearanceStatus />
							<cfset rc.ombReviewComment = rc.clearance.comments />
							<cfset rc.ombReviewDate = rc.clearance.cstatusDate />
							<cfset rc.ombReviewID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Deputy Review">
							<cfset rc.deputyReviewStatus = rc.clearance.clearanceStatus />
							<cfset rc.deputyReviewComment = rc.clearance.comments />
							<cfset rc.deputyReviewDate = rc.clearance.cstatusDate />
							<cfset rc.deputyReviewID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="AMCN Front Office">
							<cfset rc.frontOfficeStatus = rc.clearance.clearanceStatus />
							<cfset rc.frontOfficeComment = rc.clearance.comments />
							<cfset rc.frontOfficeDate = rc.clearance.cstatusDate />
							<cfset rc.frontOfficeID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="AMCN FA Front Office">
							<cfset rc.fassistfrontOfficeStatus = rc.clearance.clearanceStatus />
							<cfset rc.fassistfrontOfficeComment = rc.clearance.comments />
							<cfset rc.fassistfrontOfficeDate = rc.clearance.cstatusDate />
							<cfset rc.fassistfrontOfficeID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes' or rc.clearance.clearanceStatus IS 'N/A' >
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Legislative Affairs">
							<cfset rc.legalAffairsFOStatus = rc.clearance.clearanceStatus />
							<cfset rc.legalAffairsFOComment = rc.clearance.comments />
							<cfset rc.legalAffairsFODate = rc.clearance.cstatusDate />
							<cfset rc.legalAffairsFOID = rc.clearance.cnClearanceID />
							<cfif rc.clearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Congress">
							<cfset rc.cnApprovalStatus = rc.clearance.clearanceStatus />
							<cfset rc.cnApprovalComments = rc.clearance.comments />
							<cfset rc.cnApprovalDate = rc.clearance.cstatusDate />
							<cfset rc.cnApprovalID = rc.clearance.cnClearanceID />
						</cfcase>

						<cfdefaultcase>
							<cfset event.paramValue("legalReviewStatus","") />
							<cfset event.paramValue("legalReviewComment","") />
							<cfset event.paramValue("legalReviewDate","") />
							<cfset event.paramValue("legalReviewID","") />
							<cfset event.paramValue("foreignAssistanceStatus","") />
							<cfset event.paramValue("foreignAssistanceComment","") />
							<cfset event.paramValue("foreignAssistanceDate","") />
							<cfset event.paramValue("foreignAssistanceID","") />
							<cfset event.paramValue("congressionalAffairsStatus","") />
							<cfset event.paramValue("congressionalAffairsComment","") />
							<cfset event.paramValue("congressionalAffairsDate","") />
							<cfset event.paramValue("congressionalAffairsID","") />
							<cfset event.paramValue("policyPlanningStatus","") />
							<cfset event.paramValue("policyPlanningComment","") />
							<cfset event.paramValue("policyPlanningDate","") />
							<cfset event.paramValue("policyPlanningID","") />
							<cfset event.paramValue("sctCoordinatorStatus","") />
							<cfset event.paramValue("sctCoordinatorComment","") />
							<cfset event.paramValue("sctCoordinatorDate","") />
							<cfset event.paramValue("sctCoordinatorID","") />
							<cfset event.paramValue("ombReviewStatus","") />
							<cfset event.paramValue("ombReviewComment","") />
							<cfset event.paramValue("ombReviewDate","") />
							<cfset event.paramValue("ombReviewID","") />
							<cfset event.paramValue("deputyReviewStatus","") />
							<cfset event.paramValue("deputyReviewComment","") />
							<cfset event.paramValue("deputyReviewDate","") />
							<cfset event.paramValue("deputyReviewID","") />
							<cfset event.paramValue("frontOfficeStatus","") />
							<cfset event.paramValue("frontOfficeComment","") />
							<cfset event.paramValue("frontOfficeDate","") />
							<cfset event.paramValue("frontOfficeID","") />
							<cfset event.paramValue("fassistfrontOfficeStatus","") />
							<cfset event.paramValue("fassistfrontOfficeComment","") />
							<cfset event.paramValue("fassistfrontOfficeDate","") />
							<cfset event.paramValue("fassistfrontOfficeID","") />
							<cfset event.paramValue("legalAffairsFOStatus","") />
							<cfset event.paramValue("legalAffairsFOComment","") />
							<cfset event.paramValue("legalAffairsFODate","") />
							<cfset event.paramValue("legalAffairsFOID","") />
							<cfset event.paramValue("cnApprovalStatus","") />
							<cfset event.paramValue("cnApprovalComments","") />
							<cfset event.paramValue("cnApprovalDate","") />
							<cfset event.paramValue("cnApprovalID","") />
							<cfset event.paramValue("cnApprovalID","") />

						</cfdefaultcase>
					</cfswitch>
				</cfloop>
				<cfif yesCnt EQ 10>
					<cfset rc.isCNClearanceComplete = 'true' />
				</cfif>
				<!--- notes recommendations --->
				<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(cnid=rc.cnID,orderby="commentDate",cnOnly=true)>
				<cfset event.setView(name="proposal/CN") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>


	</cffunction>

	<cffunction name="fundImpMechanism" displayname="funding implementation mechanism" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Funding / Implementation Mechanism">
		<!--- lookup data --->
		<cfset rc.FundMechTypes = instance.ProposalService.getFundMechTypes() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.fundingReqDate = "">
		<cfset rc.fundingApprovalDate = "">
		<!--- <cfset rc.fundMechanism = ""> --->
		<cfset rc.isFClearanceComplete = 'false'>
		<cfset rc.isMOUModClearanceComplete = 'false' />

		<cfset var yesCnt = 0>
		<cfset var mouCnt = 0>
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>
				<cfif rc.proposal.implementationstatus is "MOU Modification">
					<cfset rc.isMOUMod = "True">
				<cfelse>
					<cfset rc.isMOUMod = "False">
				</cfif>
				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>

				<!--- ... attached files --->
				<cfset rc.attachedFiles = instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityFunding',isArchived=0) />
				<cfset rc.archivedFiles = instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityFunding',isArchived=1) />
				<cfset rc.fclearance = instance.ActivityClearanceGateway.getByAttributesQuery(ActivityID=rc.activityID) />
				<cfset temp = QueryAddRow(rc.fclearance) />
				<cfloop query="rc.fclearance">
					<cfswitch expression="#clearanceAgencyName#">
						<cfcase value="f-Legal">
							<cfset rc.legalClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.legalClearanceComment = rc.fclearance.comments />
							<cfset rc.legalClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.legalClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Program Manager">
							<cfset rc.pmClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.pmClearanceComment = rc.fclearance.comments />
							<cfset rc.pmClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.pmClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>

						<cfcase value="Budget">
							<cfset rc.BudgetClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.BudgetClearanceComment = rc.fclearance.comments />
							<cfset rc.BudgetClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.BudgetClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="MOU">
							<cfset rc.mouClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.mouClearanceComment = rc.fclearance.comments />
							<cfset rc.mouClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.mouClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Front Office">
							<cfset rc.foClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.foClearanceComment = rc.fclearance.comments />
							<cfset rc.foClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.foClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Executive Office">
							<cfset rc.sesClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.sesClearanceComment = rc.fclearance.comments />
							<cfset rc.sesClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.sesClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Acquisition Office">
							<cfset rc.aqmClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.aqmClearanceComment = rc.fclearance.comments />
							<cfset rc.aqmClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.aqmClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Agency">
							<cfset rc.agencyClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.agencyClearanceComment = rc.fclearance.comments />
							<cfset rc.agencyClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.agencyClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfdefaultcase>
							<cfset event.paramValue("legalClearanceStatus","") />
							<cfset event.paramValue("legalClearanceComment","") />
							<cfset event.paramValue("legalClearanceDate","") />
							<cfset event.paramValue("legalClearanceID","") />
							<cfset event.paramValue("pmClearanceStatus","") />
							<cfset event.paramValue("pmClearanceComment","") />
							<cfset event.paramValue("pmClearanceDate","") />
							<cfset event.paramValue("pmClearanceID","") />
							<cfset event.paramValue("BudgetClearanceStatus","") />
							<cfset event.paramValue("BudgetClearanceComment","") />
							<cfset event.paramValue("BudgetClearanceDate","") />
							<cfset event.paramValue("BudgetClearanceID","") />
							<cfset event.paramValue("mouClearanceStatus","") />
							<cfset event.paramValue("mouClearanceComment","") />
							<cfset event.paramValue("mouClearanceDate","") />
							<cfset event.paramValue("mouClearanceID","") />
							<cfset event.paramValue("foClearanceStatus","") />
							<cfset event.paramValue("foClearanceComment","") />
							<cfset event.paramValue("foClearanceDate","") />
							<cfset event.paramValue("foClearanceID","") />
							<cfset event.paramValue("sesClearanceStatus","") />
							<cfset event.paramValue("sesClearanceComment","") />
							<cfset event.paramValue("sesClearanceDate","") />
							<cfset event.paramValue("sesClearanceID","") />
							<cfset event.paramValue("aqmClearanceStatus","") />
							<cfset event.paramValue("aqmClearanceComment","") />
							<cfset event.paramValue("aqmClearanceDate","") />
							<cfset event.paramValue("aqmClearanceID","") />
							<cfset event.paramValue("agencyClearanceStatus","") />
							<cfset event.paramValue("agencyClearanceComment","") />
							<cfset event.paramValue("agencyClearanceDate","") />
							<cfset event.paramValue("agencyClearanceID","") />
						</cfdefaultcase>
					</cfswitch>
				</cfloop>
			</cfif>

			<cfif len(trim(rc.proposal.fundImpMechanismID))>
				<cfset qfundMech = instance.CategoryGateway.getByAttributesQuery(CategoryID=rc.proposal.fundImpMechanismID) />
				<cfset fundMech = qfundMech.name />

				<cfswitch expression="#fundMech#">
					<cfcase value="Bureau Transfer">
						<cfif yesCnt GTE 1>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Fund cite to post">
						<cfif yesCnt GTE 0>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Grant">
						<cfif yesCnt GTE 2>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Cooperative Agreement">
						<cfif yesCnt GTE 2>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="MOU/IAA">
						<cfif yesCnt GT 4>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Contract">
							<cfset rc.isFClearanceComplete = 'true' />
					</cfcase>
					<cfdefaultcase>
						<!--- 0 --->
					</cfdefaultcase>
				</cfswitch>
				<cfif mouCnt GT 3>
					<cfset rc.isMOUModClearanceComplete = 'true' />
				</cfif>
				<cfset event.setView(name="proposal/fundImpMechanism") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>


	</cffunction>

	<cffunction name="obStatus" displayname="Obligation Status" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Obligation Status">
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>
				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>
				<!--- ... attached files --->
				<cfset rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityObligation',isArchived=0) />
				<cfset rc.archivedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityObligation',isArchived=1) />
				<!--- ... get obligation --->
				<cfset rc.obligations = instance.ActivityObligationGateway.getByAttributesQuery(activityid=rc.activityID,orderBy="obligationDate",order="DESC") />
				<cfset rc.fundingBalance = "">
				<cfset rc.recommendations = instance.ActivityLegalRecommendationGateway.getByAttributesQuery(activityid=rc.activityid,orderby="commentDate",commentType="obligation")>
				<cfset event.setView(name="proposal/obStatus") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>

	<cffunction name="rmp" displayname="Results Monitoring" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Results Monitoring">
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>

				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>
				<!--- ... attached files --->

				<!--- ... get rmp --->
				<cfset rc.rmp = instance.ResultsFrameworkElementGateway.getProjectObjectives(activityid=rc.activityID) />

				<cfset rc.primaryResult = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=1)>
				<cfset rc.SecondaryResult = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=0)>
				<cfset rc.resultsFrameworkElementID=rc.primaryResult.resultsFrameworkElementID>
				<cfset rc.secondaryResultsList=valuelist(rc.SecondaryResult.resultsFrameworkElementID)>
				<cfscript>
					if (rc.proposal.programid is 5) {
						rc.programResults = instance.ResultsFrameworkElementGateway.getRSIResults();
					} else {
						rc.programResults = instance.ResultsFrameworkElementGateway.getByAttributesQuery(programid=rc.proposal.programid,orderby="Name");
					}
				</cfscript>

				<cfset rc.indicators = instance.ResultsFrameworkElementGateway.getProjectObjectives(activityid=rc.activityID,indicatorsOnly=true) />
				<!--- <cfset rc.measurements = instance.measurementGateway.getIndicatorMeasurements(activityid=rc.activityID,measureType='primary') /> --->
				<cfset rc.measurements = instance.measurementGateway.getIndicatorMeasurements(activityid=rc.activityID) />

				<cfset event.setView(name="proposal/rmp") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>

	<cffunction name="printrmp" displayname="Results Monitoring" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Results Monitoring">
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>

				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>
				<!--- ... attached files --->

				<!--- ... get rmp --->
				<cfset rc.rmp = instance.ResultsFrameworkElementGateway.getProjectObjectives(activityid=rc.activityID) />

				<cfset rc.primaryResult = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=1)>
				<cfset rc.SecondaryResult = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=0)>
				<cfset rc.resultsFrameworkElementID=rc.primaryResult.resultsFrameworkElementID>
				<cfset rc.secondaryResultsList=valuelist(rc.SecondaryResult.resultsFrameworkElementID)>
				<cfscript>
					if (rc.proposal.programid is 5) {
						rc.programResults = instance.ResultsFrameworkElementGateway.getRSIResults();
					} else {
						rc.programResults = instance.ResultsFrameworkElementGateway.getByAttributesQuery(programid=rc.proposal.programid,orderby="Name");
					}
				</cfscript>

				<cfset rc.indicators = instance.ResultsFrameworkElementGateway.getProjectObjectives(activityid=rc.activityID,indicatorsOnly=true) />
				<!--- <cfset rc.measurements = instance.measurementGateway.getIndicatorMeasurements(activityid=rc.activityID,measureType='primary') /> --->
				<cfset rc.measurements = instance.measurementGateway.getIndicatorMeasurements(activityid=rc.activityID) />

				<cfset event.setView(name="proposal/printrmp",layout="layout.Print") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>


	<cffunction name="saveWorkplan" output="false" hint=" saveObjective">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

        <cfset newWorkplan = instance.WorkplanService.getWorkplan()>

        <cfset populateModel(newWorkplan)>

        <cfset rc.newWorkplanID = instance.WorkplanService.saveWorkplan(newWorkplan)>


   		 <cfset getPlugin("MessageBox").setMessage("info","Workplan Saved") />
		<cfset setNextEvent(event='proposal/impStatus',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="saveObjective" output="false" hint=" saveObjective">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

        <cfset newResultsFrameworkElement = instance.ResultsFrameworkService.getResultsFrameworkElement()>

        <cfset populateModel(newResultsFrameworkElement)>

        <cfset rc.newResultsFrameworkElementID = instance.ResultsFrameworkService.saveResultsFrameworkElement(newResultsFrameworkElement)>

		<cfif len(rc.resultsframeworkelementid) is 0>
			<cfset rc.ResultsFrameworkExternalRelation = instance.ResultsFrameworkExternalRelationService.new()>

	        <cfset populatemodel(rc.ResultsFrameworkExternalRelation) />
			<cfset rc.ResultsFrameworkExternalRelation.setParentResultsFrameworkElementID(rc.parent)>
			<cfset rc.ResultsFrameworkExternalRelation.setChildResultsFrameworkElementID(rc.newResultsFrameworkElementID)>

	        <cfset retResultsFrameworkElementID =
				instance.ResultsFrameworkExternalRelationService.saveResultsFrameworkExternalRelation(ResultsFrameworkExternalRelation=rc.ResultsFrameworkExternalRelation)>

			<cfset rc.activityResultsFrameworkElement = instance.activityResultsFrameworkElementService.new()>
			<cfset populatemodel(rc.activityResultsFrameworkElement) />
			<cfset rc.activityResultsFrameworkElement.setactivityID(rc.activityID)>
			<cfset rc.activityResultsFrameworkElement.setresultsFrameworkElementID(rc.newResultsFrameworkElementID)>

			<cfset retactivityResultsFrameworkElement =
				instance.activityResultsFrameworkElementService.saveactivityResultsFrameworkElement(activityResultsFrameworkElement=rc.activityResultsFrameworkElement)>
		</cfif>
   		 <cfset getPlugin("MessageBox").setMessage("info","Objective Saved") />
		<cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="deleteObjective" output="false" hint=" saveObjective">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

		<cfset deleteObjective = instance.ResultsFrameworkElementGateway.deleteProjectObjective(ResultsFrameworkElementID=rc.ResultsFrameworkElementID)>


   		 <cfset getPlugin("MessageBox").setMessage("info","Objective Deleted") />
		<cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="deleteIndicator" output="false" hint=" saveObjective">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

		<cfset deleteIndicator = instance.ResultsFrameworkElementGateway.deleteProjectIndicator(indicatorID=rc.indicatorID)>


   		 <cfset getPlugin("MessageBox").setMessage("info","Indicator Deleted") />
		<cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="saveIndicator" output="false" hint=" saveIndicator">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

        <cfset newIndicator = instance.indicatorService.getIndicator()>
        <cfset populateModel(newIndicator)>
        <cfset rc.newIndicatorID = instance.indicatorService.saveIndicator(newIndicator)>

		<cfset newMeasurement = instance.measurementService.getMeasurement()>
        <cfset populateModel(newMeasurement)>
		<cfset newMeasurement.setIndicatorID(rc.newIndicatorID)>
		<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>

		<cfif rc.indicatorid is 0>
			<cfset rc.ResultsIndicator = instance.resultsIndicatorService.new()>
	        <cfset populatemodel(rc.resultsIndicator) />
			<cfset rc.ResultsIndicator.setResultsFrameworkElementID(rc.resultsFrameworkElementID)>
			<cfset rc.ResultsIndicator.setIndicatorID(rc.newIndicatorID)>

	        <cfset retResultsIndicatorID =
				instance.resultsIndicatorService.saveResultsIndicator(resultsIndicator=rc.ResultsIndicator)>

		</cfif>

   		 <cfset getPlugin("MessageBox").setMessage("info","Indicator Saved") />
		<cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="saveMeasurement" output="false" hint=" saveMeasurement">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

		<cfset newMeasurement = instance.measurementService.getMeasurement()>
        <cfset populateModel(newMeasurement)>
		<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>


   		 <cfset getPlugin("MessageBox").setMessage("info","Measurement Saved") />
		<cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="savePrimaryResult" output="false" hint=" savePrimaryResult">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

        <cfscript>
		if (StructKeyExists(rc,"resultsFrameworkelementID") AND len(rc.resultsFrameworkelementID)) {
								rc.activityResultsObj = instance.activityResultsFrameworkElementService.new();
								populatemodel(rc.activityResultsObj);
								rc.retDeleteActivityResults = instance.activityResultsFrameworkElementService.deleteActivityResults(activityID=#rc.activityID#,isPrimary=1);
								newActivityResultsSaved = instance.activityResultsFrameworkElementService.saveActivityREsultsFrameworkElement(rc.activityResultsObj);
							}
		</cfscript>


   		 <cfset getPlugin("MessageBox").setMessage("info","Primary Result Saved") />
		<cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="saveSecondaryResults" output="false" hint=" saveSecondaryResults">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

        <cfscript>
		if (StructKeyExists(rc,"SecondaryResultsList") AND len(rc.SecondaryResultsList)) {
								rc.retDeleteActivityResults = instance.activityResultsFrameworkElementService.deleteActivityResults(activityID=rc.ActivityID,isPrimary=0);
								rc.isPrimary="0";
								var i = 0;
							    var l = ListLen(rc.SecondaryResultsList);
							    var FieldName = "";
							    for (i = 1; i lte l; i = i + 1)  // you also can use i++ instead
							    {
							    	rc.activityResultsObj = instance.activityResultsFrameworkElementService.new();
							    	rc.resultsFrameworkElementID= ListGetAt(rc.SecondaryResultsList, i);
									populatemodel(rc.activityResultsObj);
									newActivityResultsSaved = instance.activityResultsFrameworkElementService.saveActivityREsultsFrameworkElement(rc.activityResultsObj);
							    }
							}
		</cfscript>


   		 <cfset getPlugin("MessageBox").setMessage("info","Primary Result Saved") />
		<cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="printObStatus" displayname="Obligation Status" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Obligation Status">
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>
				<cfset rc.projectTitle = rc.proposal.name />
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>

				<cfset rc.obligations = instance.ActivityObligationGateway.getByAttributesQuery(activityid=rc.activityID,orderBy="obligationDate",order="DESC") />
				<cfset qcolumns = "ProposalNumber, projectTitle, Amount, ObligationFYyearSource, ObligationNumber, Comments">
				<cfset columnTitles = "Proposal Number, Project Title, Obligated Amount, Fiscal Year, Obligation Number, Comments">
				<cfset var qreport = querynew(qcolumns) />
				<cfloop query="rc.obligations">
					<cfset QueryAddRow(qreport) />
					<cfset QuerySetCell(qreport,"proposalnumber",rc.proposal.proposalnumber) />
					<cfset QuerySetCell(qreport,"projectTitle",rc.projectTitle) />
					<cfset QuerySetCell(qreport,"Amount",rc.obligations.Amount) />
					<cfset QuerySetCell(qreport,"ObligationFYyearSource",#rc.obligations.ObligationFYyearSource#) />
					<cfset QuerySetCell(qreport,"ObligationNumber",rc.obligations.ObligationNumber) />
					<cfset QuerySetCell(qreport,"Comments",rc.obligations.Comments) />
				</cfloop>
				 <cfset mngrRpt = spreadsheetNew()>



		    <!--- Create Sheet header row --->
		   <!--- <cfset SpreadsheetAddRow(mngrRpt, "Proposal Number,Project Title,Funding Source,Fiscal Year,Countries,Regions,Status,Implementing Partners,Funding Mechanism,Requested Amount,Total Obligated,AMCN Approved Date,Budget Funding Approved Date,Description,Cleared Prelegal Date,Approved Date,AMCN Budget Submit Date,AMCN Congress Submit Date,Database ID")> --->
		   <cfset SpreadsheetAddRow(mngrRpt, columnTitles)>
	        <!--- format row header 1 --->
	        <cfset formatmngrRpt = structnew()>
	        <cfset formatmngrRpt.bold = "true">
	        <cfset formatmngrRpt.alignment = "center">
	        <cfset formatmngrRpt.textwrap = "true">
	        <cfset formatmngrRpt.color = "dark_blue">
	        <cfset formatmngrRpt.fgcolor="pale_blue">
	        <cfset SpreadsheetFormatRow(mngrRpt,formatmngrRpt,1)>

	        <!--- Add remaining rows from query --->
	        <cfset SpreadsheetAddRows(mngrRpt, qreport) />


	        <!--- Save spreadsheet --->
	       <cflock name="managerRpt" timeout="20" type="exclusive">
	            <!--- <cfset spreadsheetWrite(mngrRpt,filename,true)> --->
	            <cfspreadsheet action="write"
	                name="mngrRpt"
	                filename="#GetTempDirectory()#sct_report.xls"
	                overwrite="true" />

	        </cflock>

	        <cfset event.setView("Reports/export2xls",false) />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>

	<cffunction name="printFunding" displayname="Obligation Status" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Funding / Implementation Mechanism">
		<!--- lookup data --->
		<cfset rc.FundMechTypes = instance.ProposalService.getFundMechTypes() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.fundingReqDate = "">
		<cfset rc.fundingApprovalDate = "">
		<!--- <cfset rc.fundMechanism = ""> --->
		<cfset rc.isFClearanceComplete = 'false'>
		<cfset rc.isMOUModClearanceComplete = 'false' />

		<cfset var yesCnt = 0>
		<cfset var mouCnt = 0>
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>
				<cfif rc.proposal.implementationstatus is "MOU Modification">
					<cfset rc.isMOUMod = "True">
				<cfelse>
					<cfset rc.isMOUMod = "False">
				</cfif>
				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>

				<!--- ... attached files --->
				<cfset rc.attachedFiles = instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityFunding',isArchived=0) />
				<cfset rc.archivedFiles = instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityFunding',isArchived=1) />
				<cfset rc.fclearance = instance.ActivityClearanceGateway.getByAttributesQuery(ActivityID=rc.activityID) />
				<cfset temp = QueryAddRow(rc.fclearance) />
				<cfloop query="rc.fclearance">
					<cfswitch expression="#clearanceAgencyName#">
						<cfcase value="f-Legal">
							<cfset rc.legalClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.legalClearanceComment = rc.fclearance.comments />
							<cfset rc.legalClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.legalClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Program Manager">
							<cfset rc.pmClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.pmClearanceComment = rc.fclearance.comments />
							<cfset rc.pmClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.pmClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>

						<cfcase value="Budget">
							<cfset rc.BudgetClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.BudgetClearanceComment = rc.fclearance.comments />
							<cfset rc.BudgetClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.BudgetClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="MOU">
							<cfset rc.mouClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.mouClearanceComment = rc.fclearance.comments />
							<cfset rc.mouClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.mouClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Front Office">
							<cfset rc.foClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.foClearanceComment = rc.fclearance.comments />
							<cfset rc.foClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.foClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Executive Office">
							<cfset rc.sesClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.sesClearanceComment = rc.fclearance.comments />
							<cfset rc.sesClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.sesClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Acquisition Office">
							<cfset rc.aqmClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.aqmClearanceComment = rc.fclearance.comments />
							<cfset rc.aqmClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.aqmClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
							</cfif>
						</cfcase>
						<cfcase value="Agency">
							<cfset rc.agencyClearanceStatus = rc.fclearance.clearanceStatus />
							<cfset rc.agencyClearanceComment = rc.fclearance.comments />
							<cfset rc.agencyClearanceDate = rc.fclearance.cstatusDate />
							<cfset rc.agencyClearanceID = rc.fclearance.activityClearanceID />
							<cfif rc.fclearance.clearanceStatus IS 'Yes'>
								<cfset yesCnt = yesCnt + 1>
								<cfset mouCnt = mouCnt + 1>
							</cfif>
						</cfcase>
						<cfdefaultcase>
							<cfset event.paramValue("legalClearanceStatus","") />
							<cfset event.paramValue("legalClearanceComment","") />
							<cfset event.paramValue("legalClearanceDate","") />
							<cfset event.paramValue("legalClearanceID","") />
							<cfset event.paramValue("pmClearanceStatus","") />
							<cfset event.paramValue("pmClearanceComment","") />
							<cfset event.paramValue("pmClearanceDate","") />
							<cfset event.paramValue("pmClearanceID","") />
							<cfset event.paramValue("BudgetClearanceStatus","") />
							<cfset event.paramValue("BudgetClearanceComment","") />
							<cfset event.paramValue("BudgetClearanceDate","") />
							<cfset event.paramValue("BudgetClearanceID","") />
							<cfset event.paramValue("mouClearanceStatus","") />
							<cfset event.paramValue("mouClearanceComment","") />
							<cfset event.paramValue("mouClearanceDate","") />
							<cfset event.paramValue("mouClearanceID","") />
							<cfset event.paramValue("foClearanceStatus","") />
							<cfset event.paramValue("foClearanceComment","") />
							<cfset event.paramValue("foClearanceDate","") />
							<cfset event.paramValue("foClearanceID","") />
							<cfset event.paramValue("sesClearanceStatus","") />
							<cfset event.paramValue("sesClearanceComment","") />
							<cfset event.paramValue("sesClearanceDate","") />
							<cfset event.paramValue("sesClearanceID","") />
							<cfset event.paramValue("aqmClearanceStatus","") />
							<cfset event.paramValue("aqmClearanceComment","") />
							<cfset event.paramValue("aqmClearanceDate","") />
							<cfset event.paramValue("aqmClearanceID","") />
							<cfset event.paramValue("agencyClearanceStatus","") />
							<cfset event.paramValue("agencyClearanceComment","") />
							<cfset event.paramValue("agencyClearanceDate","") />
							<cfset event.paramValue("agencyClearanceID","") />
						</cfdefaultcase>
					</cfswitch>
				</cfloop>
			</cfif>

			<cfif len(trim(rc.proposal.fundImpMechanismID))>
				<cfset qfundMech = instance.CategoryGateway.getByAttributesQuery(CategoryID=rc.proposal.fundImpMechanismID) />
				<cfset fundMech = qfundMech.name />

				<cfswitch expression="#fundMech#">
					<cfcase value="Bureau Transfer">
						<cfif yesCnt GTE 1>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Fund cite to post">
						<cfif yesCnt GTE 0>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Grant">
						<cfif yesCnt GTE 2>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Cooperative Agreement">
						<cfif yesCnt GTE 2>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="MOU/IAA">
						<cfif yesCnt GT 4>
							<cfset rc.isFClearanceComplete = 'true' />
						</cfif>
					</cfcase>
					<cfcase value="Contract">
							<cfset rc.isFClearanceComplete = 'true' />
					</cfcase>
					<cfdefaultcase>
						<!--- 0 --->
					</cfdefaultcase>
				</cfswitch>
				<cfif mouCnt GT 3>
					<cfset rc.isMOUModClearanceComplete = 'true' />
				</cfif>
				<cfset event.setView(name="proposal/printFunding",layout="layout.Print") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>

	<cffunction name="impStatus" displayname="Obligation Status" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Implementation">
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>
				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>
				<cfset rc.workplan = instance.WorkplanService.getWorkplansQuery(activityid=rc.activityID,orderby="startdate,enddate") />
				<cfset event.setView(name="proposal/impStatus") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>

	<cffunction name="activityreports" displayname="Reports" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Reports">
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>
				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>
				<!--- ... attached files --->
				<cfset rc.attachedRptFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityReports',isArchived=0) />
				<cfset rc.archivedRptFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityReports',isArchived=1) />

				<cfset rc.indicators = instance.ResultsFrameworkElementGateway.getProjectObjectives(activityid=rc.activityID,indicatorsOnly=true) />
				<cfset rc.measurements = instance.measurementGateway.getIndicatorMeasurements(activityid=rc.activityID) />


				<cfset event.setView(name="proposal/reports") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>

	<cffunction name="editlog" displayname="Edit Log" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<!--- //set page title --->
		<cfset rc.pagetitle = "Edit Log">
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID,rolename=rc.rolename) />
			<cfif rc.proposal.recordcount gt 0>
				<cfset rc.editlog = instance.activityStatusLogService.getActivityStatusLogsQuery(activityid=rc.activityID,orderby="statusdate desc") />
				<cfset rc.projectTitle = rc.proposal.name />
				<!--- ... progress check --->
				<cfset rc.progressStatusQ = instance.activityService.getActivityStatus(activityStatusCode=rc.proposal.activityStatusCode,proposalSubmitDate=rc.proposal.proposalSubmitDate,proposalApprovedDate=rc.proposal.proposalApprovedDate,AMCNCongressSubmitDate=rc.proposal.AMCNCongressSubmitDate,AMCNApprovedDate=rc.proposal.AMCNApprovedDate,isActive=rc.proposal.isactive,implementationStatus=rc.proposal.implementationStatus) />

				<cfset rc.progressStatus = rc.progressStatusQ.activityStatus>
				<cfset rc.progressAge = rc.progressStatusQ.activityAge>
				<!--- ... attached files --->
				<cfset rc.attachedRptFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityReports',isArchived=0) />
				<cfset rc.archivedRptFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,ObjectTableName='ActivityReports',isArchived=1) />
				<cfset event.setView(name="proposal/editlog") />
			<cfelse>
				<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
			</cfif>
		<cfelse>
			<cfset event.setView(name="proposal/NotFound",layout="layout.JsonReadable") />
		</cfif>

	</cffunction>

	<cffunction name="saveProposal" displayname="proposal save" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfscript>
				var rc = event.getCollection();
		</cfscript>
		<cfif StructKeyExists(rc,'saveClone') and len(rc.saveClone)>
			<cfset rc.activityid = "">
			<cfset rc.proposalNumber = "">
		</cfif>
		<cfif structKeyExists(rc,"btnDeleteProposal") and len(rc.btnDeleteProposal)>
			<cfscript>

				updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,isActive=0);
				getPlugin("MessageBox").setMessage("info","Proposal deleted successfully");
				setNextEvent("summary.index");
			</cfscript>
		<cfelse>
		<!--- <cfif ( isUserinRole("create activity") OR isUserinRole("review activity")  )> --->
			<cfscript>

				rc.progressStatus = "Edit Proposal";
				rc.progressAge = 0;

				//capture systimedatestamp
				var logDateTime = now();

				//lookup data (needed to temporarily hold data)
				rc.countriesAll = instance.ProposalService.getRegionCountry();
				rc.regionsAll = instance.ProposalService.getRegions();
				rc.regionCountryAll = instance.ProposalService.getRegionCountry();
				rc.fundMechTypes = instance.ProposalService.getFundMechTypes();
				rc.fundingSourcesAll = instance.ProposalService.getSCTAccounts();
				rc.ctfPartners = instance.ProposalService.getCTFPartners();
				rc.allOrganizations = instance.ProposalService.getCTEOrganizations();
				rc.programs = instance.ProgramService.getProgramsQuery();
				//rc.programid = getPlugin('SessionStorage').getVar('curUserAuth.programid');

				if (rc.programid is 5) {
					rc.programResults = instance.ResultsFrameworkElementGateway.getRSIResults();
				} else {
					rc.programResults = instance.ResultsFrameworkElementGateway.getByAttributesQuery(programid=rc.programid,orderby="Name");
				}

				//initializa other variables
				// ... new report or not?
				event.paramValue('isNewProposal','');

				////////////////////////////////////////////////////////////////////////////////////////////////
				//... hold data ...
				////////////////////////////////////////////////////////////////////////////////////////////////
				//!--- ... owners --->
				rc.owners = querynew("ActivityPersonID,ActivityID,LastName,FirstName,Email,Phone,Office");
				//--- add new rows or explicitly pass values from the form to the RC scope---
				for (o=1;o<= rc.ocnt;o++ ){
					if (!StructKeyExists(rc,"ownerDelete_#o#")) {
						QueryAddRow(rc.owners);
						QuerySetCell(rc.owners,"firstName",evaluate('rc.ownerfirstname_' & o));
						QuerySetCell(rc.owners,"lastName",evaluate('rc.ownerlastname_' & o));
						QuerySetCell(rc.owners,"email",evaluate('rc.owneremail_' & o));
						QuerySetCell(rc.owners,"phone",evaluate('rc.ownerphone_' & o));
						QuerySetCell(rc.owners,"office",evaluate('rc.owneroffice_' & o));
						QuerySetCell(rc.owners,"activityPersonID",evaluate('rc.ActivityPersonID_' & o));
					}
				}

				if (StructKeyExists(rc,"resultsFrameworkelementID") and len(rc.resultsFrameworkelementID)) {
					// temp hold selection list

				} else {
					rc.resultsFrameworkelementID = "";
				}

				if (StructKeyExists(rc,"SecondaryResultsList") and len(rc.SecondaryResultsList)) {
					// temp hold selection list

				} else {
					rc.SecondaryResultsList = "";
				}

				//!--- ...project country, region ---
				//--- - country ---
				if (StructKeyExists(rc,"projectCountries") and len(rc.projectCountries)) {
					// temp hold selection list
					rc.placeOfImplementation = "Country";
					rc.projectCountryIDs = rc.projectCountries;

				} else {
					rc.projectCountries = "";
					rc.placeOfImplementation = "None";
					rc.projectCountryIDs = "";

				}



				//--- - organiztions --->
				if (StructKeyExists(rc,"projectOrganizations") and len(rc.projectOrganizations)) {
					// temp hold selection list
					rc.projectorgIDs = rc.projectOrganizations;

				} else {
					rc.projectOrganizations = "";
					rc.projectorgIDs = "";

				}

				//!--- ... implementer ---
				rc.implementer = querynew("OrgID,Name,implementingPartner,pocLastName,pocFirstName,pocEmail,pocPhone");
				//--- hold implementers ---
				for (i=1;i<=rc.icnt;i++) {
					if (!StructKeyExists(rc,"implementerDelete_#i#")) {
						QueryAddRow(rc.implementer);
						QuerySetCell(rc.implementer,"name",evaluate('implementingorganization_' & i));
						QuerySetCell(rc.implementer,"implementingPartner",evaluate('implementingpartner_' & i));
						QuerySetCell(rc.implementer,"pocFirstName",evaluate('implementerpocfirstname_' & i));
						QuerySetCell(rc.implementer,"pocLastName",evaluate('implementerpoclastname_' & i));
						QuerySetCell(rc.implementer,"pocEmail",evaluate('implementerpocemail_' & i));
						QuerySetCell(rc.implementer,"pocPhone",evaluate('implementerpocphone_' & i));
					}
				}

				//!--- ... funding breakdown ---
				rc.projectFunding = querynew("ActivityBudgetID,ActivityID,categoryToCategoryID,countryID,BudgetItem,BudgetAmount");
				//--- funding breakdown ---
				for (i=1;i<=rc.bcnt;i++) {
					if (!StructKeyExists(rc,"fundingDelete_#i#")) {
						QueryAddRow(rc.projectFunding);
						QuerySetCell(rc.projectFunding,"CountryID",evaluate('budgetcountry_' & i));
						QuerySetCell(rc.projectFunding,"BudgetItem",evaluate('BudgetItem_' & i));
						QuerySetCell(rc.projectFunding,"BudgetAmount",evaluate('budgetamount_' & i));
					}
				}

				//!--- ... projectFundingSources ---
				if (structKeyExists(rc,"projectFundingSources") and len(rc.projectFundingSources)) {
					// temp hold selection list
					rc.fundingsourceIDs = rc.projectFundingSources;

				} else {
					rc.projectFundingSources = "";
					rc.fundingsourceIDs = "";
				}

				//!--- ... indicator, objective ---
				rc.indicators = querynew("ActivityID,name,objective");
				for (i=1;i<=rc.oicnt;i++) {
					if (i < 3) {
						if (!StructKeyExists(rc,"IndicatorDelete_#i#")) {
							QueryAddRow(rc.indicators);
							QuerySetCell(rc.indicators,"name",evaluate('indicator_' & i));
							QuerySetCell(rc.indicators,"objective",evaluate('objective_' & i));
						}
					}
				}

				//!--- ... attached files ---
				var tempFileIDList = "";
				var tempFileList = instance.ProposalService.getElementIndexList(name='Attach',fieldNames=rc.fieldNames,delimiter='_');

				rc.attachedFiles = querynew("AttachedFileID,AttachedFileName,UploadedFileName,AttachedFileDate,Name,ObjectTableName,ObjectTableID");
				if (listLen(tempFileList,",")) {
					for (f=1;f<=listLen(tempFileList);f++) {
						if (StructKeyExists(rc,"attachment_#f#") AND len(evaluate('rc.attachment_' & f))) {
							//--- ... upload file ---
							attachTemp = getPlugin("FileUtils").uploadFile(fileField="form.attachment_#f#",destination=expandPath('attachedFiles'),NameConflict="makeunique");

							//--- save data ---
							oAttachedFile = instance.AttachedFileService.new();
							oAttachedFile.setAttachedFileName(attachTemp.serverFile);
							oAttachedFile.setUploadedFileName(attachTemp.clientFile);
							oAttachedFile.setAttachedFileDate(now());
							oAttachedFile.setName(evaluate('filenotes_' & f));
							oAttachedFile.setobjectTableName('Activity');
							if (len(trim(rc.activityID))) {
								oAttachedFile.setobjectTableID(rc.activityID);
							} else {
								oAttachedFile.setobjectTableID(0);
							}

							instance.AttachedFileService.saveAttachedFile(oAttachedFile);

							tempFileID = instance.AttachedFileGateway.getByAttributesQuery(AttachedFileName=attachTemp.serverFile);
							tempFileIDList = listAppend(tempFileIDList,tempFileID.attachedFileID,',');
						} else {
							//--- if no new file attached, hold previously attached ---
							if (StructKeyExists(rc,"AttachedFileID_#f#")) {
								if (StructKeyExists(rc,"deleteFile") and listLen(deleteFile,",") and listFind(deleteFile,f,",")) {
									//--- delete file ---
									deleteTemp = getPlugin("FileUtils").removeFile(expandPath('attachedFiles/#evaluate('rc.AttachedFileName_' & f)#'));
									//--- if file already in database, remove ---
									if (isNumeric(evaluate('rc.AttachedFileID_' & f))) {
										instance.AttachedFileService.deleteAttachedFile(evaluate('rc.AttachedFileID_' & f));
									}
								} else {
									tempFileIDList = listAppend(tempFileIDList,evaluate('rc.AttachedFileID_' & f),',');
								}

							}
						}

					}
				}


				// --- get attached file records ---
				//also specify attachedFileID to avoid grabbing other user attached files
				if (len(trim(rc.activityID))) {
					rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=rc.activityid,AttachedFileIDList=tempFileIDList);/*doAbort();*/
				} else {
					rc.attachedFiles =  instance.AttachedFileGateway.getByAttributesQuery(ObjectTableID=0,AttachedFileIDList=tempFileIDList);
				}

				//!--- hold rest of form data ---
				rc.proposal = querynew("activityID,projectTitle,proposalNumber,Description,StartDate,EndDate,BudgetCeilingAmount,projectObjective,interestSpecification,lawEnforcementSpecification,coordinationSpecification,programAudience,proposalSubmitDate,fundImpMechanismID,activityStatusID,activityStatus,placeOfImplementation,clearedPrelegalDate,isActive,implementingPartner,programID,proposalApprovedDate,AMCNBudgetSubmitDate,AMCNCongressSubmitDate,AMCNApprovedDate,FundApprovedDate,BudgetFundRequestDate,BudgetFundApprovalDate,amcnnumber,reprogramFunds,reprogramComments,fiscalYear,lessonsLearned,sustainability,cityProvince,cnID,cnTitle,relatedProjects,ctex");
				QueryAddRow(rc.proposal);
				QuerySetCell(rc.proposal,"activityID",rc.activityID);
				QuerySetCell(rc.proposal,"proposalNumber",rc.proposalNumber);
				QuerySetCell(rc.proposal,"projectTitle",rc.projectTitle);

				QuerySetCell(rc.proposal,"projectobjective",rc.projectobjective);
				QuerySetCell(rc.proposal,"Description",rc.description);
				QuerySetCell(rc.proposal,"interestSpecification",rc.interestSpecification);
				QuerySetCell(rc.proposal,"lawEnforcementSpecification",rc.lawEnforcementSpecification);
				QuerySetCell(rc.proposal,"coordinationSpecification",rc.coordinationSpecification);
				QuerySetCell(rc.proposal,"StartDate",rc.StartDate);
				QuerySetCell(rc.proposal,"EndDate",rc.EndDate);
				QuerySetCell(rc.proposal,"ProgramAudience",rc.ProgramAudience);
				QuerySetCell(rc.proposal,"BudgetCeilingAmount",rc.BudgetCeilingAmount);
				QuerySetCell(rc.proposal,"fundImpMechanismID",rc.fundImpMechanismID);
				QuerySetCell(rc.proposal,"activityStatusID",rc.activityStatusID);
				QuerySetCell(rc.proposal,"proposalSubmitDate",rc.proposalSubmitDate);
				QuerySetCell(rc.proposal,"clearedPrelegalDate",rc.clearedPrelegalDate);
				QuerySetCell(rc.proposal,"implementingPartner",rc.implementingPartner);
				if (StructKeyExists(rc,"projectCountries") and len(rc.projectCountries)){
					QuerySetCell(rc.proposal,"placeOfImplementation","Country");
				} else {
					QuerySetCell(rc.proposal,"placeOfImplementation","None");
				}
				QuerySetCell(rc.proposal,"programID",rc.programID);

				QuerySetCell(rc.proposal,"proposalApprovedDate",rc.proposalApprovedDate);
				QuerySetCell(rc.proposal,"AMCNBudgetSubmitDate",rc.AMCNBudgetSubmitDate);
				QuerySetCell(rc.proposal,"AMCNCongressSubmitDate",rc.AMCNCongressSubmitDate);
				QuerySetCell(rc.proposal,"AMCNApprovedDate",rc.AMCNApprovedDate);
				QuerySetCell(rc.proposal,"FundApprovedDate",rc.FundApprovedDate);
				QuerySetCell(rc.proposal,"BudgetFundRequestDate",rc.BudgetFundRequestDate);
				QuerySetCell(rc.proposal,"BudgetFundApprovalDate",rc.BudgetFundApprovalDate);
				QuerySetCell(rc.proposal,"amcnnumber",rc.amcnnumber);
				QuerySetCell(rc.proposal,"reprogramFunds",rc.reprogramFunds);
				QuerySetCell(rc.proposal,"reprogramComments",rc.reprogramComments);
				QuerySetCell(rc.proposal,"lessonsLearned",rc.lessonsLearned);
				QuerySetCell(rc.proposal,"sustainability",rc.sustainability);
				QuerySetCell(rc.proposal,"fiscalYear",rc.fiscalYear);
				QuerySetCell(rc.proposal,"cityProvince",rc.cityProvince);
				QuerySetCell(rc.proposal,"cnId",rc.cnId);
				QuerySetCell(rc.proposal,"cnTitle",rc.cnTitle);
				QuerySetCell(rc.proposal,"relatedprojects",rc.relatedprojects);
				QuerySetCell(rc.proposal,"ctex",rc.ctex);

				////////////////////////////////////////////////////////////////////////////////////////////////
				// --- inspect buttons for action ---
				////////////////////////////////////////////////////////////////////////////////////////////////
				// ... add buttons --
				////////////////////////////////////////////////////////////////////////////////////////////////
				if (structKeyExists(rc,"btnAddRow") and len(rc.btnAddRow)) {
					//!.... the div id variable so the page moves to the right place after adding a row---
					var rc.jumpTo = "";

					//!--- ... owners ---
					if (StructKeyExists(rc,"btnAddRow") and rc.btnAddRow IS "Add Additional Project Owner") {
						QueryAddRow(rc.owners);
						rc.jumpTo = "addOwner";
					}
					//!--- ... implementer ---
					if (StructKeyExists(rc,"btnAddRow") and rc.btnAddRow IS "Add Additional Implementer") {
						QueryAddRow(rc.implementer);
						rc.jumpTo = "addImplementer";
					}
					//!--- ... funding breakdown ---
					if (StructKeyExists(rc,"btnAddRow") and rc.btnAddRow IS "Add Additional Budget Item") {
						QueryAddRow(rc.projectFunding);
						rc.jumpTo = "budgetItem";
					}

					//!--- ... indicator, objective ---
					if (StructKeyExists(rc,"btnAddRow") and rc.btnAddRow IS "Add Additional Objective & Indicator") {
						QueryAddRow(rc.indicators);
						rc.jumpTo = "objectiveIndicator";
					}

					//!--- ... attached files ---
					if (StructKeyExists(rc,"btnAddRow") and rc.btnAddRow EQ "Add Document") {
						QueryAddRow(rc.attachedFiles);
						rc.jumpTo = "addDocument";
					}


						event.setView(name="proposal/view"); /* ,layout="Layout.Main" */


				}
				////////////////////////////////////////////////////////////////////////////////////////////////
				// --- {else} save proposal (validate first) ---
				////////////////////////////////////////////////////////////////////////////////////////////////
				else {
					//--- convert "hold data" back to string to save; necessary for save and validation to work ---


					// ... validate save data first before proceeding to update status ---
					// --- new forms have ro be saved first to obtain ActivityID ---
					if (StructKeyExists(rc,'isNewProposal') and len(rc.isNewProposal)) {
						if (rc.isNewProposal) {
							//--- generate proposal number for new forms ---
							var rc.ProposalNumber = "";
							var pprogram = instance.ProgramService.getProgramsQuery(programID=rc.programID).name;
							//var pprogram = getPlugin("SessionStorage").getVar("curUserAuth.program");

							rc.ProposalNumber = "#ucase(pprogram)#";
						}
					}
					if (StructKeyExists(rc,'saveClone') and len(rc.saveClone)) {
							//--- generate proposal number for new forms ---
							var rc.ProposalNumber = "";
							var pprogram = instance.ProgramService.getProgramsQuery(programID=rc.programID).name;

							rc.ProposalNumber = "#ucase(pprogram)#";
					}

					//--- attempt to save form ---
					//... initialize proposal object ---
					var oProposal = getModel("Activity").init();
					//... rename form field name to match table column name ---
					oProposal.setName(rc.projectTitle);
					//--- populate object ---
					populateModel(oProposal);

					////////////////////////////////////////////////////////////////////////////////////////////////
					// --- validate save ---
					////////////////////////////////////////////////////////////////////////////////////////////////
					var errors = arrayNew(1);
					//--- call validation ---
					arrsErrors = oProposal.validate();
					if (ArrayLen(arrsErrors)) {
						for (a=1;a<=arrayLen(arrsErrors);a++) {
							arrayAppend(errors,arrsErrors[a].message);
						}
					}

					//... funding breakdown ---
					var budgetIDList = instance.ProposalService.getElementIndexList(name='budget',fieldNames=rc.fieldNames,delimiter='_');
					var budgetSum = 0;
					for (j=1;j<=listLen(budgetIDList);j++) {
						if (!StructKeyExists(rc,"fundingDelete_#j#")) {
						 	var oBudget = instance.ActivityBudgetService.new();
						 	oBudget.setActivityID(rc.ActivityID);
						 	oBudget.setCountryID(evaluate('budgetCountry_' & j));
						 	oBudget.setBudgetItem(evaluate('budgetItem_' & j));
						 	oBudget.setBudgetAmount(evaluate('budgetAmount_' & j));
						 	if (isNumeric(evaluate('budgetAmount_' & j))) {
						 		budgetSum = budgetSum + evaluate('budgetAmount_' & j);
						 	}

						 	var barrErrors = oBudget.validateProposal();
						}
						// if errors append them ---
						if (ArrayLen(barrErrors)) {
							for(e=1;e<=arrayLen(barrErrors);e++) {
								ArrayAppend(errors,barrErrors[e].message);
							}
						}
					}

					if (listLen(budgetIDList) > 0 and isNumeric(budgetSum)) {
						sumErrors = oProposal.validateSums(budgetSum);
						if (ArrayLen(sumErrors)) {
							for (a=1;a<=arrayLen(sumErrors);a++) {
								arrayAppend(errors,sumErrors[a].message);
							}
						}
					}




					////////////////////////////////////////////////////////////////////////////////////////////////
					// --- validate submit ---
					//--- more error validation if proposal is being submitted for review ---
					if (structKeyExists(rc,"submitProposalForm") and len(rc.submitProposalForm)) {
						//--- check: required fields --->
						ssrrErrors = oProposal.validateSubmit();
						if (ArrayLen(ssrrErrors)) {
							for (a=1;a<=arrayLen(ssrrErrors);a++) {
								arrayAppend(errors,ssrrErrors[a].message);
							}
						}

						//... owners
						var ownerIDList = instance.ProposalService.getElementIndexList(name='owner',fieldNames=rc.fieldNames,delimiter='_');
						for (i=1;i<=listLen(ownerIDList);i++) {
							if (!StructKeyExists(rc,"ownerDelete_#i#")) {
								var oOwner = getModel("ActivityPerson").init();
								oOwner.setActivityID(rc.ActivityID);
								oOwner.setLastName(evaluate('ownerlastname_' & i));
								oOwner.setFirstName(evaluate('ownerfirstname_' & i));
								oOwner.setEmail(evaluate('ownerEmail_' & i));
								oOwner.setPhone(evaluate('ownerPhone_'& i));
								oOwner.setOffice(evaluate('ownerOffice_'& i));

								var osarrErrors = oOwner.validateSubmit();
							}
							// if errors append them ---
							if (ArrayLen(osarrErrors)) {
								for(e=1;e<=arrayLen(osarrErrors);e++) {
									ArrayAppend(errors,osarrErrors[e].message);
								}
							}
						}

						//... organization, implementing partner ---
						var implementerIDList = instance.ProposalService.getElementIndexList(name='implement',fieldNames=rc.fieldNames,delimiter='_');
						for (y=1;y<=listLen(implementerIDList);y++) {
							if (!StructKeyExists(rc,"implementerDelete_#y#")) {
								var oImplementer = instance.OrgService.new();
								oImplementer.setName(evaluate('implementingorganization_' & y));
								oImplementer.setimplementingPartner(evaluate('implementingpartner_' & y));
								oImplementer.setpocFirstname(evaluate('implementerpocfirstname_' & y));
								oImplementer.setpocLastName(evaluate('implementerpoclastname_' & y));
								oImplementer.setpocEmail(evaluate('implementerpocemail_' & y));
								oImplementer.setpocPhone(evaluate('implementerpocphone_' & y));

								var isarrErrors = oImplementer.validateSubmit();
							}
							// if errors append them ---
							if (ArrayLen(isarrErrors)) {
								for(e=1;e<=arrayLen(isarrErrors);e++) {
									ArrayAppend(errors,isarrErrors[e].message);
								}
							}
						}

 						//... funding breakdown ---
 						var budgetIDList = instance.ProposalService.getElementIndexList(name='budget',fieldNames=rc.fieldNames,delimiter='_');
 						for (j=1;j<=listLen(budgetIDList);j++) {
 							if (!StructKeyExists(rc,"fundingDelete_#j#")) {
 							 	var oBudget = instance.ActivityBudgetService.new();
 							 	oBudget.setActivityID(rc.ActivityID);
 							 	oBudget.setCountryID(evaluate('budgetCountry_' & j));
 							 	oBudget.setBudgetItem(evaluate('budgetItem_' & j));
 							 	oBudget.setBudgetAmount(evaluate('budgetAmount_' & j));
 								if (StructKeyExists(rc,"placeOfImplementation") AND len(rc.placeOfImplementation)) {
 									oBudget.setplaceOfImplementation(rc.placeOfImplementation);
									oBudget.setprojectCountries(rc.projectCountries);
 								}
 							 	var bsarrErrors = oBudget.validateSubmit();
 							}
							// if errors append them ---
							if (ArrayLen(bsarrErrors)) {
								for(e=1;e<=arrayLen(bsarrErrors);e++) {
									ArrayAppend(errors,bsarrErrors[e].message);
								}
							}
 						}


						//... indicator, objective --->
						var IndicatorIDList = instance.ProposalService.getElementIndexList(name='indicator',fieldNames=rc.fieldNames,delimiter='_');
						for (x=1;x<=listLen(IndicatorIDList);x++) {
							if (!StructKeyExists(rc,"IndicatorDelete_#x#")) {
								var oIndicator = instance.IndicatorService.new();
								oIndicator.setName(evaluate('indicator_' & x));
								oIndicator.setObjective(evaluate('objective_' & x));

								var nsarrErrors = oIndicator.validateSubmit();
							}
							// if errors append them ---
							if (ArrayLen(nsarrErrors)) {
								for(e=1;e<=arrayLen(nsarrErrors);e++) {
									ArrayAppend(errors,nsarrErrors[e].message);
								}
							}
						}

					}


					/*///////////////////////////////////////////////////////////////////////////////////////////////
					//!--- so if errors ---
					///////////////////////////////////////////////////////////////////////////////////////////////*/
					if (arraylen(errors)) {
						ArraySort(errors, "textnocase", "asc");

						ArrayPrepend(errors,"Error while submitting proposal for review:");
						getPlugin("MessageBox").error(message="Error while submitting proposal for review: <br />",messageArray=errors);


							event.setView(name="proposal/view"); /*,layout="Layout.Main"*/

					} else {
						/*///////////////////////////////////////////////////////////////////////////////////////////////
						//!--- save proposal ---
						////////////////////////////////////////////////////////////////////////////////////////////////*/
						//!--- save object first ---
						rc.ActivityID = instance.ActivityService.saveActivity(oProposal);

						//... now save the rest of the form
						if (len(trim(rc.ActivityID)) and isNumeric(rc.ActivityID)) {
							////////////////////////////////////////////////////////////////////////////////////////////////
							//!--- ... owners ---
							ownerIDList = instance.ProposalService.getElementIndexList(name='owner',fieldNames=rc.fieldNames,delimiter='_');
							//... purge existing data ---
							instance.ActivityPersonGateway.deleteByAttributesQuery(ActivityID=rc.ActivityID);

							for (i=1;i<=listLen(ownerIDList);i++){
								if (!StructKeyExists(rc,"ownerDelete_#i#")) {
									var oOwner = getModel("ActivityPerson").init();
									oOwner.setActivityID(rc.ActivityID);
									oOwner.setLastName(evaluate('ownerlastname_' & i));
									oOwner.setFirstName(evaluate('ownerfirstname_' & i));
									oOwner.setEmail(evaluate('ownerEmail_' & i));
									oOwner.setPhone(evaluate('ownerPhone_'& i));
									oOwner.setOffice(evaluate('ownerOffice_'& i));

									instance.ActivityPersonService.saveActivityPerson(oOwner);

								}
							}

							if (StructKeyExists(rc,"resultsFrameworkelementID") AND len(rc.resultsFrameworkelementID)) {
								rc.activityResultsObj = instance.activityResultsFrameworkElementService.new();
								populatemodel(rc.activityResultsObj);
								rc.retDeleteActivityResults = instance.activityResultsFrameworkElementService.deleteActivityResults(activityID=#rc.activityID#,isPrimary=1);
								newActivityResultsSaved = instance.activityResultsFrameworkElementService.saveActivityREsultsFrameworkElement(rc.activityResultsObj);
							}

							if (StructKeyExists(rc,"SecondaryResultsList") AND len(rc.SecondaryResultsList)) {
								rc.retDeleteActivityResults = instance.activityResultsFrameworkElementService.deleteActivityResults(activityID=rc.ActivityID,isPrimary=0);
								rc.isPrimary="0";
								var i = 0;
							    var l = ListLen(rc.SecondaryResultsList);
							    var FieldName = "";
							    for (i = 1; i lte l; i = i + 1)  // you also can use i++ instead
							    {
							    	rc.activityResultsObj = instance.activityResultsFrameworkElementService.new();
							    	rc.resultsFrameworkElementID= ListGetAt(rc.SecondaryResultsList, i);
									populatemodel(rc.activityResultsObj);
									newActivityResultsSaved = instance.activityResultsFrameworkElementService.saveActivityREsultsFrameworkElement(rc.activityResultsObj);
							    }
							}


							////////////////////////////////////////////////////////////////////////////////////////////////
							//--- ... place of implementation ---

									if(StructKeyExists(rc,"projectCountries") AND len(rc.projectCountries)){
										instance.ObjectCategoryService.updateObjectCategories(ClassName="ActivityPlace",ObjectID=rc.ActivityID,CategoryIDList=rc.projectCountries,primary="0");
									}



							////////////////////////////////////////////////////////////////////////////////////////////////
							//--- ... implementation partners ---
							if (StructKeyExists(rc,"projectOrganizations") AND len(rc.projectOrganizations)){
									instance.ObjectCategoryService.updateObjectCategories(ClassName="ActivityOrganization",ObjectID=rc.ActivityID,CategoryIDList=rc.projectOrganizations,primary="0");
							}

							////////////////////////////////////////////////////////////////////////////////////////////////
							//--- ... organization, implementing partner ---
							// get orgID list --
							var implementersArr = instance.ActivityOrgService.getActivityOrgs(ActivityID=rc.ActivityID);
							for (i=1;i<=arrayLen(implementersArr);i++){
								instance.OrgService.deleteOrg(OrgID=implementersArr[i].getOrgID());
							}
							// now delete org-activity relationship ---
							instance.ActivityOrgGateway.deleteByAttributesQuery(ActivityID=rc.ActivityID);
							// build ID list ---
							var implementerIDList = instance.ProposalService.getElementIndexList(name='implement',fieldNames=rc.fieldNames,delimiter='_');
							for (y=1;y<=listLen(implementerIDList);y++){
								if (!StructKeyExists(rc,"implementerDelete_#y#")) {
									var oImplementer = instance.OrgService.new();
									oImplementer.setName(evaluate('implementingorganization_' & y));
									oImplementer.setimplementingPartner(evaluate('implementingpartner_' & y));
									oImplementer.setpocFirstname(evaluate('implementerpocfirstname_' & y));
									oImplementer.setpocLastName(evaluate('implementerpoclastname_' & y));
									oImplementer.setpocEmail(evaluate('implementerpocemail_' & y));
									oImplementer.setpocPhone(evaluate('implementerpocphone_' & y));

									var newOrgID = instance.OrgService.saveOrg(oImplementer);
									// create activityOrg object and associate with ne org ---
									var oActvityOrg = instance.ActivityOrgService.createActivityOrg(ActivityID=rc.ActivityID,OrgID=newOrgID );
									instance.ActivityOrgService.saveActivityOrg(oActvityOrg);
								}
							}

							////////////////////////////////////////////////////////////////////////////////////////////////
							//--- ... funding breakdown ---
							var budgetIDList = instance.ProposalService.getElementIndexList(name='budget',fieldNames=rc.fieldNames,delimiter='_');
							instance.ActivityBudgetGateway.deleteByAttributesQuery(ActivityID=rc.ActivityID);
							for (j=1;j<=listLen(budgetIDList);j++){
								if (!StructKeyExists(rc,"fundingDelete_#j#")) {
									var oBudget = instance.ActivityBudgetService.new();
									oBudget.setActivityID(rc.ActivityID);
									oBudget.setCountryID(evaluate('budgetCountry_' & j));
									oBudget.setBudgetItem(evaluate('budgetItem_' & j));
									oBudget.setBudgetAmount(REReplace(evaluate('budgetAmount_' & j),",","","all"));
									if (StructKeyExists(rc,"placeOfImplementation") AND len(rc.placeOfImplementation)) {
										oBudget.setplaceOfImplementation(rc.placeOfImplementation);
										oBudget.setprojectCountries(rc.projectCountries);
									}
									instance.ActivityBudgetService.saveActivityBudget(oBudget);
								}
							}

							////////////////////////////////////////////////////////////////////////////////////////////////
							// ... projectFundingSources ---
							if (StructKeyExists(rc,"projectFundingSources")){ /*AND len(rc.projectFundingSources)*/
								instance.ObjectCategoryService.updateObjectCategories(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID,CategoryIDList=rc.projectFundingSources,primary="0");
							}

							////////////////////////////////////////////////////////////////////////////////////////////////
							//--- ... indicator, objective ---
							//--- get indicatorsID list ---
							var indicatorArr = instance.ActivityIndicatorService.getActivityIndicators(ActivityID=rc.ActivityID);
							// --- delete indicator related to activity ---
							instance.ActivityIndicatorGateway.deleteByAttributesQuery(ActivityID=rc.ActivityID);
							for (n=1;n<=arrayLen(indicatorArr);n++) {
								instance.indicatorService.deleteIndicator(indicatorID=indicatorArr[n].getIndicatorID());
							}
							//--- build ID list ---
							var IndicatorIDList = instance.ProposalService.getElementIndexList(name='indicator',fieldNames=rc.fieldNames,delimiter='_');
							for (x=1;x<=listLen(IndicatorIDList);x++) {
								if (!StructKeyExists(rc,"IndicatorDelete_#x#")) {
									var oIndicator = instance.IndicatorService.new();
									oIndicator.setName(evaluate('indicator_' & x));
									oIndicator.setObjective(evaluate('objective_' & x));
									var newIndicatorID = instance.IndicatorService.saveIndicator(oIndicator);
									//--- create activity indicator object ---
									var oActivityInd = instance.ActivityIndicatorService.createActivityIndicator(ActivityID=rc.ActivityID,IndicatorID=newIndicatorID);
									instance.ActivityIndicatorService.saveActivityIndicator(oActivityInd);
								}
							}

							////////////////////////////////////////////////////////////////////////////////////////////////
							//--- ... files ---
							/* the only thing left to do here is to link attached file to activity*/
							if (StructKeyExists(rc,"attachedFiles") and rc.attachedFiles.recordCount ) {
								for (f=1;f<=rc.attachedFiles.recordCount;f++) {

									//--- save data ---
									oAttachedFile = getModel("AttachedFile").init();
									oAttachedFile.setAttachedFileID(rc.attachedFiles.AttachedFileID[f]);
									oAttachedFile.setAttachedFileName(rc.attachedFiles.AttachedFileName[f]);
									oAttachedFile.setUploadedFileName(rc.attachedFiles.UploadedFileName[f]);
									oAttachedFile.setAttachedFileDate(rc.attachedFiles.AttachedFileDate[f]);
									oAttachedFile.setobjectTableName(rc.attachedFiles.objectTableName[f]);
									oAttachedFile.setName(rc.attachedFiles.Name[f]);
									oAttachedFile.setobjectTableID(rc.activityID);

									instance.AttachedFileService.saveAttachedFile(oAttachedFile);

								}
							}


							////////////////////////////////////////////////////////////////////////////////////////////////
							//!-- update statuses ---
							//--- prepare to save ---
							//////////////////////////
							//--- log activity ---
							var oActivityStatusLog = instance.ActivityStatusLogService.new();
							oActivityStatusLog.setActivityID(rc.ActivityID);
							oActivityStatusLog.setStatusDate(logDateTime);
							oActivityStatusLog.setSysUserID(rc.SysUserID);
							var activityStatusID = "";

							//////////////////////////
							//--- save draft ---
							if (structKeyExists(rc,"saveProposalForm") and len(rc.saveProposalForm)){
								if ( rc.saveProposalForm EQ 'save' ) {

									if (rc.activitystatusid lt 268) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal in-progress');
										oActivityStatusLog.setActivityStatusID(ActivityStatusID);
									} else {
										ActivityStatusID = rc.activityStatusID;
										oActivityStatusLog.setActivityStatusID(ActivityStatusID);

									}

									oActivityStatusLog.setlogNote('proposal saved');
									//  update status ---
									updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
									instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
									// -- message and next event  ---
									getPlugin("MessageBox").setMessage("info","Proposal saved successfully");
									if (rc.activitystatusid lt 268) {
										setNextEvent(event='proposal.view',queryString='activityID/#rc.activityID#');
									} else {
										setNextEvent(event='proposal.review',queryString='activityID/#rc.activityID#');
									}

								} else if ( rc.saveProposalForm EQ 'Update Proposal' ) {


									ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal updated');

									oActivityStatusLog.setActivityStatusID(ActivityStatusID);
									oActivityStatusLog.setlogNote('proposal updated');
									//  update status ---
									//updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
									instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
									// -- message and next event ---
									getPlugin("MessageBox").setMessage("info","Proposal updated successfully");
									setNextEvent(event='proposal.review',queryString='activityID/#rc.activityID#');

								}
							} else if (structKeyExists(rc,"saveClone") and len(rc.saveClone)) {
									ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal in-progress');
									oActivityStatusLog.setActivityStatusID(ActivityStatusID);

									oActivityStatusLog.setlogNote('proposal cloned');
									//  update status ---
									updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
									instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
									// -- message and next event  ---
									getPlugin("MessageBox").setMessage("info","Proposal cloned successfully");
									setNextEvent(event='proposal.view',queryString='activityID/#rc.activityID#');

							} else if (structKeyExists(rc,"submitProposalForm") and len(rc.submitProposalForm)) {

								var theProposal = getModel("ActivityService").getActivity(rc.activityID);

								projectFundingSources = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityFundingSource",ObjectID=rc.ActivityID);
								FundingSourceList = ValueList(projectFundingSources.CategoryID);

								if (rc.proposal.placeOfImplementation EQ "Country") {
									var projectRegions = instance.ProposalService.getActivityCountryRegions(ActivityID=rc.ActivityID);
								}
								else if (rc.proposal.placeOfImplementation EQ "Region") {
									var projectRegions = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=rc.ActivityID);
								}
								else {
									var projectRegions = queryNew("categoryID,Name");
								}


								//if ((structKeyExists(rc,"skipAMCN") and len(rc.skipAMCN)) or getPlugin("SessionStorage").getVar("curUserAuth.programID") is 6){
								if (structKeyExists(rc,"skipAMCN") and len(rc.skipAMCN)){
									ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program fully obligated');
									oActivityStatusLog.setActivityStatusID(activityStatusID);
									oActivityStatusLog.setlogNote('proposal submitted with no amcn required');
									updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime,clearedPrelegalDate=logDateTime,proposalApprovedDate=logDateTime,AMCNBudgetSubmitDate=logDateTime,AMCNCongressSubmitDate=logDateTime,AMCNApprovedDate=logDateTime,FundApprovedDate=logDateTime,BudgetFundRequestDate=logDateTime,BudgetFundApprovalDate=logDateTime);

									oObStatus = instance.ActivityObligationService.new();
									oObStatus.setActivityID(rc.activityID);
									oObStatus.setAmount(rc.BudgetCeilingAmount);
									oObStatus.setObligationDate(logDateTime);
									oObStatus.setObligationFYyearSource(rc.fiscalYear);
									oObStatus.setComments("Fully obligated - no clearance needed");
									oObStatus.setsysUserID(rc.sysUserID);
									saveOb = instance.ActivityObligationService.saveActivityObligation(oObStatus);
								} else {
									//if rsi with only one region, send to regional review; else, send to program review
									if (((projectFundingSources.recordCount gt 0) and (projectRegions.recordcount eq 1) and (listfind(FundingSourceList,305) or listfind(FundingSourceList,306) or listfind(FundingSourceList,307))) or (rc.ProgramID is 5 and (projectRegions.recordcount eq 1))) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('rsi submitted');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted for regional review');
									} else if (rc.ProgramID is 3 or rc.ProgramID is 1 or rc.ProgramID is 6) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal approved');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted with no approval required');

									} else if (rc.ProgramID is 2) {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal submitted');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted with no legal pre-clear required');

									} else {
										ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal submitted');
										oActivityStatusLog.setActivityStatusID(activityStatusID);
										oActivityStatusLog.setlogNote('proposal submitted for review');
									}

									// update status ---
									if (rc.ProgramID is 3 or rc.ProgramID is 1 or rc.ProgramID is 6) {
										updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime,clearedPrelegalDate=logDateTime,proposalApprovedDate=logDateTime);
									} else if (rc.ProgramID is 2) {
										updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime,clearedPrelegalDate=logDateTime);
									} else {
										updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID,proposalSubmitDate=logDateTime);
									}
								}

								instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);


								var emailReceps = instance.ProposalService.userEmails(programID=rc.ProgramID,ActivityID=rc.ActivityID);

								//send email ---
								// Create a new mail object ---

								Email = instance.MailService.newMail();
								Email.setTo( emailReceps.reviewerEmails );
								Email.setFrom( "noreply@ctprograms.com" );
								/* if (isUserLoggedIn()) { Email.setCC( emailReceps.submitterEmails ); } */
								Email.setType( "html" );
								Email.setSubject( ucase(theProposal.getproposalNumber()) & " Proposal Submitted" );
								if (((projectFundingSources.recordCount gt 0) and (projectRegions.recordcount gt 1) and (listfind(FundingSourceList,305) or listfind(FundingSourceList,306) or listfind(FundingSourceList,307))) or (rc.ProgramID is 5 and (projectRegions.recordcount gt 1))) {
									Email.setBody( "<p>This is to notify you that a proposal has been SUBMITTED to the management system and assigned ID <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>" & ucase(theProposal.getproposalNumber()) & "</a>. This project covers multiple regions, requiring additional communication with corresponding regional coordinators. Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> to log on to the system and see the proposal's details and text.</p><br /><p>www.ctprograms.com</p>" );
								} else {
									Email.setBody( "<p>This is to notify you that a proposal has been SUBMITTED to the management system and assigned ID <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>" & ucase(theProposal.getproposalNumber()) & "</a>. Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> to log on to the system and see the proposal's details and text.</p><br /><p>www.ctprograms.com</p>" );
								}
								// Send email
								instance.MailService.send( Email );

								/*-- message and next event ---*/
								getPlugin("MessageBox").setMessage("info","Proposal submitted for review successfully");

								setNextEvent("summary.index");


							} else if (structKeyExists(rc,"btnReturnProposal") and len(rc.btnReturnProposal)) {

								ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal draft');
								// --- clear all previos sttuses and dates
								//rProposal = instance.ActivityService.getActivity(rc.ActivityID);
								oProposal.setproposalSubmitDate('');
								oProposal.setclearedPrelegalDate('');
								oProposal.setActivityStatusID(ActivityStatusID);
								// --- save new proposal ---
								rc.ActivityID = instance.ActivityService.saveActivity(oProposal);

								oActivityStatusLog.setActivityStatusID(activityStatusID);
								oActivityStatusLog.setlogNote('proposal returned to submitter');
								instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);

								//get email recipients

								var emailReceps = instance.ProposalService.userEmails(programID=rc.ProgramID,ActivityID=rc.ActivityID);

								//send email ---
								if ( listLen(emailReceps.submitterEmails,",") ) {
									// Create a new mail object ---
									Email = instance.MailService.newMail();
									Email.setTo( emailReceps.submitterEmails );
									Email.setFrom( "noreply@ctprograms.com" );
									//Email.setCC( "emailReceps.reviewerEmails" );
									Email.setType( "html" );
									Email.setSubject( ucase(oProposal.getproposalNumber()) & " Proposal Returned" );
									Email.setBody( "<p>This is to notify you that Proposal <a href=#event.buildLink('proposal.view.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been RETURNED in the management system. Please follow the <a href=#event.buildLink('proposal.view.activityID.' & rc.ActivityID)#>link</a> to log on to the system to see the proposal's details and text.</p><br /><p>www.ctprograms.com</p>" );
								}
								/* Send email */
								instance.MailService.send( Email );

								/*
								Email.setSubject( ucase(oProposal.getproposalNumber()) & " Proposal Submitted" );
								Email.setBody( "<p>This is to notify you that a proposal has been SUBMITTED to the management system and assigned ID "
												& ucase(oProposal.getproposalNumber()) &
												". Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> to log on to the system and see the proposal’s details and text.</p>
												<p>/  /* www.ctprograms.com* /#event.buildLink('proposal.review.activityID.' & rc.ActivityID)# </p>" );
								// Send email
								instance.MailService.send( Email );
								*/


								//update status ---
								getPlugin("MessageBox").setMessage("info","Proposal returned successfully");
								setNextEvent("summary.index");

							} else if (structKeyExists(rc,"btnDeleteProposal") and len(rc.btnDeleteProposal)){

								//-- update isActive ---
								updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,isActive=0);
								getPlugin("MessageBox").setMessage("info","Proposal deleted successfully");
								setNextEvent("summary.index");

							} else if (structKeyExists(rc,"btnDenyProposal") and len(rc.btnDenyProposal)){

								//-- update status ---


								activityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal denied');
								oActivityStatusLog.setActivityStatusID(activityStatusID);
								oActivityStatusLog.setlogNote('program deny proposal');
								updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
								instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);
								getPlugin("MessageBox").setMessage("info","Proposal denied successfully");
								setNextEvent("summary.index");

							}


						}/*-- end if activityID exists --- */

					}/*-- end else "no errors" ---*/


						event.setView(name="proposal/view");//,layout="Layout.Main"


				}// -- end else "not add button" ---

			</cfscript>

		<!--- <cfelse>
			<cfset getPlugin("MessageBox").setMessage("Error","Sorry you do not have rights to take this action!") />
			<cfset event.setView(name="proposal/view",layout="Layout.Main") />
		</cfif> --->
		</cfif>
	</cffunction>

	<cffunction name="addProposal" displayname="proposal save" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfscript>
				var rc = event.getCollection();
				rc.progressStatus = "Edit Proposal";
				rc.progressAge = 0;

				//capture systimedatestamp
				var logDateTime = now();
				var rc.ProposalNumber = "";
				var pprogram = instance.ProgramService.getProgramsQuery(programID=rc.programID).name;
				rc.ProposalNumber = "#ucase(pprogram)#";


				var oProposal = getModel("Activity").init();
				//oProposal.setName(rc.projectTitle);
				populateModel(oProposal);

				rc.ActivityID = instance.ActivityService.saveActivity(oProposal);

				var oActivityStatusLog = instance.ActivityStatusLogService.new();
				oActivityStatusLog.setActivityID(rc.ActivityID);
				oActivityStatusLog.setStatusDate(logDateTime);
				oActivityStatusLog.setSysUserID(rc.SysUserID);
				var activityStatusID = "";
				ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal in-progress');
				oActivityStatusLog.setActivityStatusID(ActivityStatusID);
				oActivityStatusLog.setlogNote('proposal saved');

				updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID);
				instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);

				getPlugin("MessageBox").setMessage("info","Proposal saved successfully");
				setNextEvent(event='proposal.editproject',queryString='activityID/#rc.activityID#');
			</cfscript>
	</cffunction>

	<cffunction name="saveProposalBudget" displayname="proposal save" output="false" returntype="void">
		<cfargument name="event" required="false" />

<!--- 		<cfif isUserinRole("review activity") > --->
			<cfscript>

				//--- get request collection ---
				var rc = event.getCollection();
				//capture systimedatestamp
				var logDateTime = now();

				rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName');
				rc.regionCountryAll = instance.ProposalService.getRegionCountry();
				rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID');
				rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID);
				rc.projectTitle = rc.proposal.name;


				//!--- ... funding breakdown ---
				rc.projectFunding = querynew("ActivityBudgetID,ActivityID,categoryToCategoryID,countryID,BudgetItem,BudgetAmount");
				//--- funding breakdown ---
				for (i=1;i<=rc.bcnt;i++) {
					if (!StructKeyExists(rc,"fundingDelete_#i#")) {
						QueryAddRow(rc.projectFunding);
						QuerySetCell(rc.projectFunding,"CountryID",evaluate('budgetcountry_' & i));
						QuerySetCell(rc.projectFunding,"BudgetItem",evaluate('BudgetItem_' & i));
						QuerySetCell(rc.projectFunding,"BudgetAmount",evaluate('budgetamount_' & i));
					}
				}


				if (structKeyExists(rc,"btnAddRow") and len(rc.btnAddRow)) {
					//!.... the div id variable so the page moves to the right place after adding a row---
					var rc.jumpTo = "";


					//!--- ... funding breakdown ---
					if (StructKeyExists(rc,"btnAddRow") and rc.btnAddRow IS "Add Budget Item") {
						QueryAddRow(rc.projectFunding);
						rc.jumpTo = "budgetItem";
					}


					//redirect and reload page with added fields
					//event.setView(name="proposal/editbudget"); /* ,layout="Layout.Main" */
					event.setView(name="proposal/editbudget");

				}
				////////////////////////////////////////////////////////////////////////////////////////////////
				// --- {else} save proposal (validate first) ---
				////////////////////////////////////////////////////////////////////////////////////////////////
				else {



					//... funding breakdown ---
					var errors = arrayNew(1);


					//... funding breakdown ---
					var budgetIDList = instance.ProposalService.getElementIndexList(name='budget',fieldNames=rc.fieldNames,delimiter='_');
					for (j=1;j<=listLen(budgetIDList);j++) {
						if (!StructKeyExists(rc,"fundingDelete_#j#")) {
						 	var oBudget = instance.ActivityBudgetService.new();
						 	oBudget.setActivityID(rc.ActivityID);
						 	oBudget.setCountryID(evaluate('budgetCountry_' & j));
						 	oBudget.setBudgetItem(evaluate('budgetItem_' & j));
						 	oBudget.setBudgetAmount(evaluate('budgetAmount_' & j));

						 	var barrErrors = oBudget.validateProposal();
						}
						// if errors append them ---
						if (ArrayLen(barrErrors)) {
							for(e=1;e<=arrayLen(barrErrors);e++) {
								ArrayAppend(errors,barrErrors[e].message);
							}
						}

						if (arraylen(errors)) {
						ArraySort(errors, "textnocase", "asc");


						ArrayPrepend(errors,"Error while editing budget:");
						getPlugin("MessageBox").error(message="Error while editing budget: <br />",messageArray=errors);
						event.setView(name="proposal/editbudget");

					} else {
						var budgetIDList = instance.ProposalService.getElementIndexList(name='budget',fieldNames=rc.fieldNames,delimiter='_');
							instance.ActivityBudgetGateway.deleteByAttributesQuery(ActivityID=rc.ActivityID);
							for (j=1;j<=listLen(budgetIDList);j++){
								if (!StructKeyExists(rc,"fundingDelete_#j#")) {
									var oBudget = instance.ActivityBudgetService.new();
									oBudget.setActivityID(rc.ActivityID);
									oBudget.setCountryID(evaluate('budgetCountry_' & j));
									oBudget.setBudgetItem(evaluate('budgetItem_' & j));
									oBudget.setBudgetAmount(REReplace(evaluate('budgetAmount_' & j),",","","all"));
									instance.ActivityBudgetService.saveActivityBudget(oBudget);
								}
							}
					}

					}





						//event.setView(name="proposal/editbudget");//,layout="Layout.Main"
						setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#');


				}

			</cfscript>
			<cfset rc.pagetitle = "Edit Budget">

	</cffunction>

	<cffunction name="renameDocument" displayname="edit document name" output="false" returntype="void">
		<cfargument name="event" required="false" />

			<cfscript>
				//--- get request collection ---
				var rc = event.getCollection();
				//capture systimedatestamp
				var logDateTime = now();

				if (structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)) {
					instance.AttachedFileService.renameAttachedFile(attachedfileid=rc.attachedFileID,name=rc.name);
				}

				setNextEvent(event='proposal/#rc.target#',queryString='activityID/#rc.activityID#');

			</cfscript>

	</cffunction>

	<cffunction name="saveReviewComment" displayname="send review messages" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<!--- summon request collection --->
		<cfset var rc = event.getCollection()>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />

		<!--- determine sender --->
		<!--- <cfif IsUserinRole("pre-legal review activity") >
			<cfset rc.sender = "Legal">
		<cfelseif IsUserInRole("review activity")>
			<cfset rc.sender = "Program">
		<cfelseif IsUserInRole("regional review")>
			<cfset rc.sender = "Regional">
		<cfelse> --->
			<cfset rc.sender = getPlugin('SessionStorage').getVar('curUserAuth.roleName')>
		<!--- </cfif> --->

		<!--- if edit proposal, just skip all commenting --->
		<cfif StructKeyExists(rc,"editProposal") AND len(rc.editProposal)>
			<cfset setNextEvent(event='proposal/view',queryString='activityID/#rc.activityID#')>
		</cfif>

		<cfif StructKeyExists(rc,"addComment") AND len(rc.addComment) >

			<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
			<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
			<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
			<cfset oLegalRecommendation.setSender(rc.sender) />
		    <cfset oLegalRecommendation.setComments(rc.prelegalComment) />
			<cfset oLegalRecommendation.setcommentDate(logDateTime) />
			<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />
			<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
			<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>


		<cfelse>

			<!--- log status --->
			<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
			<cfset oActivityStatusLog.setActivityID(rc.ActivityID) />
			<cfset oActivityStatusLog.setStatusDate(logDateTime) />
			<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />
			<cfset var activityStatusID = "" />

			<!--- Create a new mail object --->
			<cfset Email = instance.MailService.newMail() />
			<!--- get proposal details --->
			<cfset var oProposal = getModel("ActivityService").getActivity(rc.activityID) />
			<cfset var emails = instance.ProposalService.userEmails(programID=oProposal.getprogramID(),ActivityID=rc.ActivityID) />

			<cfif StructKeyExists(rc,"saveComment") AND len(rc.saveComment) >
				<cfif StructKeyExists(rc,"prelegalComment") AND len(trim(rc.prelegalComment))>

					<!--- save comment --->
					<!--- TODO: abstract:: first instance - this is used in multiple places --->
					<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
					<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
					<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
					<cfset oLegalRecommendation.setSender(rc.sender) />
					<cfset oLegalRecommendation.setComments(rc.prelegalComment) />
					<cfset oLegalRecommendation.setcommentDate(logDateTime) />
					<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />



						<cfset activityStatusID = LSParseNumber(rc.setStatusID) />
						<cfset oActivityStatusLog.setActivityStatusID(activityStatusID) />
						<cfset oActivityStatusLog.setlogNote(rc.setLogNote) />

					<!--- save comment --->
					<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
				<cfelse>
					<cfset getPlugin("MessageBox").setMessage("Error","Please enter comment/note to send.") />
					<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
				</cfif>

			<cfelseif StructKeyExists(rc,"prelegalClear") AND len(trim(rc.prelegalClear))>
				<cfset activityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('pre-legal cleared') />
				<cfset oActivityStatusLog.setActivityStatusID(activityStatusID) />
				<cfset oActivityStatusLog.setlogNote('legal pre-clear proposal') />

				<!--- TODO: abstract:: second instance - this is used in multiple places --->
				<cfif StructKeyExists(rc,"prelegalComment") AND len(trim(rc.prelegalComment))>
					<!--- save comment --->
					<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
					<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
					<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
					<cfset oLegalRecommendation.setSender(rc.sender) />
					<cfset oLegalRecommendation.setComments(rc.prelegalComment) />
					<cfset oLegalRecommendation.setcommentDate(logDateTime) />
					<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />

					<!--- save comment --->
					<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
				<cfelse>
					<cfset getPlugin("MessageBox").setMessage("Error","Please enter comment/note to send.") />
					<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
				</cfif>

				<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,clearedPrelegalDate=logDateTime) />


				    <cfscript>
						Email.setTo( emails.reviewerEmails );
						Email.setFrom( "noreply@ctprograms.com" );
						Email.setType( "html" );
						Email.setSubject( "Proposal Pre-cleared" );
						Email.setBody( "<p>This is to notify you that Legal has pre-cleared Proposal " & ucase(oProposal.getproposalNumber()) & ". Please follow the link or access the management system to see comments and details of the proposal.</p><p>www.ctprograms.com</p>" );
					</cfscript>
					 <cfset instance.MailService.send( Email ) />

			<cfelseif StructKeyExists(rc,"reviewComplete") AND len(rc.reviewComplete)>
				<!--- <cfif rc.reviewComplete IS "holdProposal"> --->
				<cfif rc.reviewComplete IS "Hold Proposal">
					<cfset activityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal on-hold') />
					<cfset oActivityStatusLog.setActivityStatusID(activityStatusID) />
					<cfset oActivityStatusLog.setlogNote('program hold proposal') />

					<cfif StructKeyExists(rc,"prelegalComment") AND len(trim(rc.prelegalComment))>
					<!--- save comment --->
						<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
						<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
						<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
						<cfset oLegalRecommendation.setSender(rc.sender) />
						<cfset oLegalRecommendation.setComments(rc.prelegalComment) />
						<cfset oLegalRecommendation.setcommentDate(logDateTime) />
						<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />

						<!--- save comment --->
						<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
					<cfelse>
						<cfset getPlugin("MessageBox").setMessage("Error","Please enter comment/note to send.") />
						<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
					</cfif>

				    <cfscript>
						Email.setTo( emails.submitterEmails );
						Email.setFrom( "noreply@ctprograms.com" );
						//Email.setCC( emails.reviewerEmails );
						Email.setType( "html" );
						Email.setSubject( ucase(oProposal.getproposalNumber()) &  " Proposal On-hold" );
						Email.setBody( "<p>This is to notify you that Proposal <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been PLACED ON HOLD. Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> or access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>" );
					</cfscript>
					<!--- Send email --->
					<cfset instance.MailService.send( Email ) />

				<!--- <cfelseif rc.reviewComplete IS "denyProposal"> --->
				<cfelseif rc.reviewComplete IS "Deny Proposal">
					<cfset activityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal denied') />
					<cfset oActivityStatusLog.setActivityStatusID(activityStatusID) />
					<cfset oActivityStatusLog.setlogNote('program deny proposal') />

					<cfif StructKeyExists(rc,"prelegalComment") AND len(trim(rc.prelegalComment))>
					<!--- save comment --->
						<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
						<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
						<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
						<cfset oLegalRecommendation.setSender(rc.sender) />
						<cfset oLegalRecommendation.setComments(rc.prelegalComment) />
						<cfset oLegalRecommendation.setcommentDate(logDateTime) />
						<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />

						<!--- save comment --->
						<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
					<cfelse>
						<cfset getPlugin("MessageBox").setMessage("Error","Please enter comment/note to send.") />
						<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
					</cfif>

				    <cfscript>
						Email.setTo( emails.submitterEmails );
						Email.setFrom( "noreply@ctprograms.com" );
						//Email.setCC( emails.reviewerEmails );
						Email.setType( "html" );
						Email.setSubject( ucase(oProposal.getproposalNumber()) &  " Proposal Denied" );
					 	Email.setBody( "<p>This is to notify you that Proposal <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been denied. Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> or access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>" );
					</cfscript>
					<!--- Send email --->
					<cfset instance.MailService.send( Email ) />

				<!--- <cfelseif rc.reviewComplete IS "approveProposal"> --->
				<cfelseif rc.reviewComplete IS "Approve Proposal">
					<!--- verify funding sources have been selected --->
					<cfif rc.fundingSourceCnt EQ 0>
						<cfset getPlugin("MessageBox").setMessage("Error","You have not selected funding sources for this program. Click on the 'Edit Proposal' button and add funding source(s) to proceed.") />
						<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
					</cfif>

					<cfset activityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal approved') />
					<cfset oActivityStatusLog.setActivityStatusID(activityStatusID) />
					<cfset oActivityStatusLog.setlogNote('program approve proposal ') />

					<cfif StructKeyExists(rc,"prelegalComment") AND len(trim(rc.prelegalComment))>
					<!--- save comment --->
						<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
						<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
						<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
						<cfset oLegalRecommendation.setSender(rc.sender) />
						<cfset oLegalRecommendation.setComments(rc.prelegalComment) />
						<cfset oLegalRecommendation.setcommentDate(logDateTime) />
						<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />

						<!--- save comment --->
						<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
					<cfelse>
						<cfset getPlugin("MessageBox").setMessage("Error","Please enter comment/note to send.") />
						<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
					</cfif>

					<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,proposalApprovedDate=logDateTime) />

				    <cfscript>
						Email.setTo( emails.submitterEmails );
						Email.setFrom( "noreply@ctprograms.com" );
						//Email.setCC( emails.reviewerEmails );
						Email.setType( "html" );
						Email.setSubject( ucase(oProposal.getproposalNumber()) &  " Proposal Approved" );
						Email.setBody( "<p>This is to notify you that Proposal <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been APPROVED. Please follow the <a href=#event.buildLink('proposal.review.activityID.' & rc.ActivityID)#>link</a> or access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>" );
					</cfscript>
					<!--- Send email --->
					<cfset instance.MailService.send( Email ) />

				<cfelseif rc.reviewComplete IS "re-activate Proposal">
					<cfset activityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal re-activated') />
					<cfset oActivityStatusLog.setActivityStatusID(activityStatusID) />
					<cfset oActivityStatusLog.setlogNote('proposal re-activated') />

					<cfif StructKeyExists(rc,"prelegalComment") AND len(trim(rc.prelegalComment))>
					<!--- save comment --->
						<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
						<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
						<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
						<cfset oLegalRecommendation.setSender(rc.sender) />
						<cfset oLegalRecommendation.setComments(rc.prelegalComment) />
						<cfset oLegalRecommendation.setcommentDate(logDateTime) />
						<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />

						<!--- save comment --->
						<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
					<cfelse>
						<cfset getPlugin("MessageBox").setMessage("Error","Please enter comment/note to send.") />
						<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
					</cfif>

					<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID) />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

					<cfset getPlugin("MessageBox").setMessage("info","Proposal re-activated successfully.") />
					<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
				</cfif>

			<cfelseif structKeyExists(rc,"btnReturnProposal") and len(rc.btnReturnProposal) >

				<cfset ActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('proposal draft') />

				<cfif StructKeyExists(rc,"prelegalComment") AND len(trim(rc.prelegalComment))>
					<!--- save comment --->
					<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
					<cfset oLegalRecommendation.setActivityID(rc.ActivityID) />
					<cfset oLegalRecommendation.setActivityStatusID(ActivityStatusID) />
					<cfset oLegalRecommendation.setSender("Review") />
					<cfset oLegalRecommendation.setComments(rc.prelegalComment) />
					<cfset oLegalRecommendation.setcommentDate(logDateTime) />
					<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />

					<!--- save comment --->
					<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />
				<cfelse>
					<cfset getPlugin("MessageBox").setMessage("Error","Please enter comment/note to send.") />
					<cfset setNextEvent(event='proposal/review',queryString='activityID/#rc.activityID#')>
				</cfif>

				<!--- clear all previos sttuses and dates --->
				<cfset oProposal = instance.ActivityService.getActivity(rc.ActivityID) />
				<cfset oProposal.setproposalSubmitDate('') />
				<cfset oProposal.setclearedPrelegalDate('') />
				<cfset oProposal.setActivityStatusID(ActivityStatusID) />
				<cfset instance.ActivityService.saveActivity(oProposal) />


				<cfset oActivityStatusLog.setActivityStatusID(activityStatusID) />
				<cfset oActivityStatusLog.setlogNote('proposal returned to submitter') />
				<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

				<!--- //get email recipients --->
				<cfif NOT isUserLoggedIn() and ((StructKeyExists(rc,"prgm") and trim(len(rc.prgm)) and isNumeric(rc.prgm)))>
					<cfset var submittingProgramID = rc.prgm />
				<cfelseif isUserLoggedIn() >
					<cfset var submittingProgramID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />
				</cfif>

				<cfset var emailReceps = instance.ProposalService.userEmails(programID=submittingProgramID,ActivityID=rc.ActivityID) />

				<cfif listLen(emailReceps.submitterEmails,",")>
					<!--- //send email --->
					<!--- // Create a new mail object --->
					<cfset Email = instance.MailService.newMail()	/>
					<cfset Email.setTo( emailReceps.submitterEmails ) />
					<cfset Email.setFrom( "noreply@ctprograms.com" ) />
					<!--- <cfset Email.setCC( emailReceps.reviewerEmails ) /> --->
					<cfset Email.setType( "html" ) />
					<cfset Email.setSubject( ucase(oProposal.getproposalNumber()) &  " Proposal Returned" ) />
					<cfset Email.setBody( "<p>This is to notify you that Proposal <a href=#event.buildLink('proposal.view.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been RETURNED in the management system. Please follow the <a href=#event.buildLink('proposal.view.activityID.' & rc.ActivityID)#>link</a> to log on to the system to see the proposal's details and text.</p><br /><p>www.ctprograms.com</p>" ) />
					<!--- /* Send email */ --->
					<cfset instance.MailService.send( Email ) />
				</cfif>

				<!---//update status ------>
				<cfset getPlugin("MessageBox").setMessage("info","Proposal returned successfully") />
				<cfset setNextEvent("summary.index") />

			</cfif>

			<!--- ... save --->

				<!--- update status for all --->
				<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=ActivityStatusID) />

				<!--- complete status log --->
				<cfif updateStatus>
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
				</cfif>


			<cfset setNextEvent("summary/index") />
		</cfif>
	</cffunction>

	<cffunction name="saveCNComment" displayname="send cn messages" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<!--- summon request collection --->
		<cfset var rc = event.getCollection()>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset rc.sender = getPlugin('SessionStorage').getVar('curUserAuth.roleName')>

		<cfif StructKeyExists(rc,"addComment") AND len(rc.addComment) >

			<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
			<cfset oLegalRecommendation.setActivityID(rc.activityID) />
			<cfset oLegalRecommendation.setCNID(rc.CNID) />
			<cfset oLegalRecommendation.setActivityStatusID(281) />
			<cfset oLegalRecommendation.setSender(rc.sender) />
		    <cfset oLegalRecommendation.setComments(rc.prelegalComment) />
			<cfset oLegalRecommendation.setcommentDate(logDateTime) />
			<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />
			<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />


		</cfif>


		<cfset setNextEvent(event='proposal/cn',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="saveObComment" displayname="send review messages" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<!--- summon request collection --->
		<cfset var rc = event.getCollection()>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset rc.sender = getPlugin('SessionStorage').getVar('curUserAuth.roleName')>

		<cfif StructKeyExists(rc,"addComment") AND len(rc.addComment) >

			<cfset var oLegalRecommendation = instance.ActivityLegalRecommendationService.new() />
			<cfset oLegalRecommendation.setActivityID(rc.activityID) />
			<cfset oLegalRecommendation.setActivityStatusID(rc.ActivityStatusID) />
			<cfset oLegalRecommendation.setSender(rc.sender) />
		    <cfset oLegalRecommendation.setComments(rc.prelegalComment) />
			<cfset oLegalRecommendation.setcommentDate(logDateTime) />
			<cfset oLegalRecommendation.setsysUserID(rc.sysUserID) />
			<cfset oLegalRecommendation.setcommentType("obligation") />
			<cfset instance.ActivityLegalRecommendationService.saveActivityLegalRecommendation(oLegalRecommendation) />


		</cfif>


		<cfset setNextEvent(event='proposal/obstatus',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="saveImpStatus" displayname="send review messages" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<!--- summon request collection --->
		<cfset var rc = event.getCollection()>

		<cfset var logDateTime = now() />


		<!--- update status --->
		<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
		<cfset oActivityStatusLog.setActivityID(rc.ActivityID) />
		<cfset oActivityStatusLog.setStatusDate(logDateTime) />
		<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />


		<cfif StructKeyExists(rc,"saveImpStatus") and StructKeyExists(rc,"implementationStatus")>
			<cfif StructKeyExists(rc,"implementationStatus") and rc.implementationStatus is "Active" and len(rc.modStatus)>
				<cfset impstatus = rc.modStatus>
			<cfelse>
				<cfset impstatus = rc.implementationStatus>
			</cfif>
			<cfset updateImpStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,implementationStatus=impstatus) />
			<cfset updateDates = instance.activityGateway.updateByAttributes(ActivityID=rc.ActivityID,startDate=rc.startDate,endDate=rc.endDate) />
			<cfset oActivityStatusLog.setActivityStatusID(rc.activityStatusID) />
			<cfset oActivityStatusLog.setlogNote("Update Implementation Status") />
			<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
		</cfif>


		<cfset setNextEvent(event='proposal/impStatus',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="submitCN" displayname="am/cn submit to budget" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset var rc.jumpTo = "">

		<!--- <cfif isUserInRole("attach am/cn document")> --->
			<cfif ( StructKeyExists(rc,"documentUpload") AND len(rc.documentUpload) ) AND ( StructKeyExists(rc,"documentTitle") AND len(rc.documentTitle) )>
				<!--- ... upload file --->
				<cfset attachTemp = getPlugin("FileUtils").uploadFile(fileField="form.documentUpload",destination=expandPath('attachedFiles'),NameConflict="makeunique") />

				<cfset rc.cnActivities = instance.CNGateway.getCNActivities(cnID=rc.cnID) />
				<cfset rc.cnActivitiesList = ValueList(rc.cnActivities.proposalNumber,", ")>
				<cfset rc.cnActivityIDList = ValueList(rc.cnActivities.activityid,", ")>

				<!--- save data --->
				<cfset oAttachedFile = instance.AttachedFileService.new() />
				<cfset oAttachedFile.setAttachedFileName(attachTemp.serverFile) />
				<cfset oAttachedFile.setUploadedFileName(attachTemp.clientFile) />
				<cfset oAttachedFile.setAttachedFileDate(now()) />
				<cfset oAttachedFile.setName(rc.documentTitle) />
				<cfset oAttachedFile.setLongDescription(rc.LongDescription) />
				<cfset oAttachedFile.setobjectTableName('ActivityAMCN') />
				<cfset oAttachedFile.setobjectTableID(rc.cnID) />
				<cfset instance.AttachedFileService.saveAttachedFile(oAttachedFile) />

				<!--- update status --->
				<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
				<cfset oActivityStatusLog.setActivityID(rc.ActivityID) />
				<cfset oActivityStatusLog.setStatusDate(logDateTime) />
				<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />

				<cfset var newActivityStatusID = "" />
				<cfif StructKeyExists(rc,"saveCommentDoc") AND len(rc.saveCommentDoc)>
					<!--- do not change status --->
					 <cfset newActivityStatusID  = rc.activityStatusID />
					<cfset oActivityStatusLog.setlogNote('Budget uploaded am/cn document') />
					<cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
				<cfelseif StructKeyExists(rc,"submitCN") AND len(rc.submitCN)>
					<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn submitted to budget') />
					<cfset oActivityStatusLog.setlogNote('CN submitted to budget') />
					<cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) />
					<!--- get proposal details --->
					<cfset var oProposal = getModel("ActivityService").getActivity(rc.activityID) />
					<!--- //get email recipients --->
					<cfset var submittingProgramID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />
					<cfset var emailReceps = instance.ProposalService.userEmails(programID=submittingProgramID,ActivityID=rc.ActivityID) />

					<cfloop query = "rc.cnActivities">

						<cfset oActivityStatusLog.setActivityID(rc.cnActivities.activityid) />
						<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
						<cfif rc.cnActivities.implementationstatus is "CN Re-notification">
							<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,AMCNBudgetSubmitDate=logDateTime) />
						<cfelse>
							<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,AMCNBudgetSubmitDate=logDateTime,ActivityStatusID=newActivityStatusID) />
						</cfif>

					</cfloop>

					<cfset updateCNStatus = instance.CNGateway.updateByAttributes(cnID=rc.cnID,BudgetSubmitDate=logDateTime) />
					<cfset Email = instance.MailService.newMail()	/>
					<cfset Email.setTo( emailReceps.budgetEmails ) />
					<cfset Email.setFrom( "noreply@ctprograms.com" ) />
					<!--- <cfset Email.setCC( emailReceps.reviewerEmails ) /> --->
					<cfset Email.setType( "html" ) />
					<cfset Email.setSubject( ucase(rc.cnActivitiesList) &  " Program CN Draft submitted" ) />
					<cfif rc.cnActivities.recordcount gt 1>
						<cfset Email.setBody( "<p>This is to notify you that Proposals #rc.cnActivitiesList# have been SUBMITTED to you to process a CN. Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>" ) />
					<cfelse>
						<cfset Email.setBody( "<p>This is to notify you that Proposal <a href=#event.buildLink('proposal.amcn.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been SUBMITTED to you to process a CN. Please follow the <a href=#event.buildLink('proposal.amcn.activityID.' & rc.ActivityID)#>link</a> or access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>" ) />
					</cfif>
					<!--- /* Send email */ --->
					<cfset instance.MailService.send( Email ) />
				</cfif>


				<cfset getPlugin("MessageBox").setMessage("info","Document uploaded successfully!") />



				<cfset setNextEvent(event='proposal/cn',queryString='activityID/#rc.activityID#/cnid/#rc.cnid#') />

			<cfelse>
				<!--- error message: no file attached --->
				<cfset getPlugin("MessageBox").setMessage("error","Error: Enter document description and select document to upload!") />
			</cfif>

		<cfset setNextEvent(event='proposal/cn',queryString='activityID/#rc.activityID#/cnid/#rc.cnid#') />
	</cffunction>


	<cffunction name="saveCN" displayname="am/cnclearance" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />

		<cfset rc.cnActivities = instance.CNGateway.getCNActivities(cnID=rc.cnID) />
		<cfset rc.cnActivitiesList = ValueList(rc.cnActivities.proposalNumber,", ")>
		<cfset rc.cnActivityIDList = ValueList(rc.cnActivities.activityid,", ")>
		<cfset Email = instance.MailService.newMail() />
		<cfset var oProposal = getModel("ActivityService").getActivity(rc.activityID) />
		<cfset var emails = instance.ProposalService.userEmails(programID=oProposal.getprogramID(),ActivityID=rc.activityID) />


		<cfset rc.ctClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="SCT Coordinator") />
		<cfif (StructKeyExists(rc,"ctClearance") AND rc.ctclearance.recordcount gt 0) >
			<cfset rc.previousCtReviewStatus = rc.ctClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousCtReviewStatus = "" />
		</cfif>
		<cfset rc.legalClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="Legal") />
		<cfif (StructKeyExists(rc,"legalClearance") AND rc.legalclearance.recordcount gt 0) >
			<cfset rc.previousLegalReviewStatus = rc.legalClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousLegalReviewStatus = "" />
		</cfif>
		<cfset rc.fClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="Foreign Assist") />
		<cfif (StructKeyExists(rc,"fClearance") AND rc.fClearance.recordcount gt 0) >
			<cfset rc.previousFReviewStatus = rc.fClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousFReviewStatus = "" />
		</cfif>
		<cfset rc.hClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="Congressional Affairs") />
		<cfif (StructKeyExists(rc,"hClearance") AND rc.hclearance.recordcount gt 0) >
			<cfset rc.previousHReviewStatus = rc.hClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousHReviewStatus = "" />
		</cfif>
		<cfset rc.spClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="Policy Planning") />
		<cfif (StructKeyExists(rc,"spClearance") AND rc.spClearance.recordcount gt 0) >
			<cfset rc.previousSPReviewStatus = rc.spClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousSPReviewStatus = "" />
		</cfif>
		<cfset rc.foClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="AMCN Front Office") />
		<cfif (StructKeyExists(rc,"foClearance") AND rc.foClearance.recordcount gt 0) >
			<cfset rc.previousFOReviewStatus = rc.foClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousFOReviewStatus = "" />
		</cfif>
		<cfset rc.dasClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="Deputy Review") />
		<cfif (StructKeyExists(rc,"dasClearance") AND rc.dasClearance.recordcount gt 0) >
			<cfset rc.previousDASReviewStatus = rc.dasClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousDASReviewStatus = "" />
		</cfif>
		<cfset rc.ombClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="Management and Budget") />
		<cfif (StructKeyExists(rc,"ombClearance") AND rc.ombClearance.recordcount gt 0) >
			<cfset rc.previousOMBReviewStatus = rc.ombClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousOMBReviewStatus = "" />
		</cfif>
		<cfset rc.faClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="AMCN FA Front Office") />
		<cfif (StructKeyExists(rc,"faClearance") AND rc.faClearance.recordcount gt 0) >
			<cfset rc.previousFAReviewStatus = rc.faClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousFAReviewStatus = "" />
		</cfif>
		<cfset rc.laClearance = instance.CNClearanceGateway.getByAttributesQuery(CNID=rc.cnID,clearanceAgencyName="Legislative Affairs") />
		<cfif (StructKeyExists(rc,"laClearance") AND rc.laClearance.recordcount gt 0) >
			<cfset rc.previousLAReviewStatus = rc.laClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousLAReviewStatus = "" />
		</cfif>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset var newActivityStatusID = rc.activityStatusID />
		<cfset var statusLogMsg = "">
		<!--- <cfset var rc.jumpTo = ""> --->

		<!--- update status --->
		<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />

		<cfset oActivityStatusLog.setStatusDate(logDateTime) />
		<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />

		<cfif (StructKeyExists(rc,"CNnumber") AND len(trim(rc.CNnumber))) >

				<cfset instance.CNGateway.updateByAttributes(cnID=rc.cnID,CNnumber=rc.CNnumber) />
			</cfif>


		<cfif (StructKeyExists(rc,"cnapproval") AND rc.cnapproval IS "Update CN Congressional Approval Status")>



			<cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) />

			<cfif rc.cnApprovalStatus IS 'Pending'>
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn submitted to congress') />
				<cfset statusLogMsg = statusLogMsg & 'Budget submits AMCN to congress' />
				<!--- <cfset rc.AMCNApprovedDate = logDateTime> --->
				<cfset updateCNStatus = instance.CNGateway.updateByAttributes(cnID=rc.cnID,CongressSubmitDate=logDateTime) />

				 <cfloop query = "rc.cnActivities">

					<cfset oActivityStatusLog.setActivityID(rc.cnActivities.activityid) />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
					<cfif <!--- rc.cnActivities.activitystatusid is 297 or ---> rc.cnActivities.implementationstatus is "CN Re-notification">
						<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,AMCNCongressSubmitDate=logDateTime) />
					<cfelse>
						<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,AMCNCongressSubmitDate=logDateTime,ActivityStatusID=newActivityStatusID) />
					</cfif>

				</cfloop>

			    <cfscript>
					Email.setTo( emails.reviewerEmails );
					Email.setFrom( "noreply@ctprograms.com" );
					Email.setCC( emails.submitterEmails );
					Email.setType( "html" );
					Email.setSubject( "CN Transmitted: Project(s) " & ucase(rc.cnActivitiesList) );
					Email.setBody( "<p>This is to notify you that a CN has been TRANSMITTED for Project(s) #rc.cnActivitiesList# on #dateFormat(logDateTime,'dd mmm, yyyy')#. <p>CN Title: #rc.cntitle# <p>CN Number: #rc.cnnumber# <p>Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>");
					instance.MailService.send( Email );
					</cfscript>
				<cfset getPlugin("MessageBox").setMessage("info","AM/CN TRANSMITTED to congress, approval status updated successfully!") />
				<!--- Send email --->


			<cfelseif rc.cnApprovalStatus IS 'Approved'>
				<cfset statusLogMsg = statusLogMsg & 'Congress approves AMCN' />

				<cfset updateCNStatus = instance.CNGateway.updateByAttributes(cnID=rc.cnID,ApprovedDate=logDateTime) />

				<cfloop query = "rc.cnActivities">
					<cfset oActivityStatusLog.setActivityID(rc.cnActivities.activityid) />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

					<cfif <!--- rc.cnActivities.activitystatusid is 297 or ---> rc.cnActivities.implementationstatus is "CN Re-notification">
						<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,AMCNApprovedDate=logDateTime,implementationStatus='Active') />
					<cfelse>
						<cfif rc.cnActivities.programid is 1>
							<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program fully obligated') />
							<cfset updateActivityStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,ActivityStatusID=newActivityStatusID,AMCNApprovedDate=logDateTime,FundApprovedDate=logDateTime,BudgetFundRequestDate=logDateTime,BudgetFundApprovalDate=logDateTime) />
	<!--- 						<cfscript>
								oObStatus = instance.ActivityObligationService.new();
								oObStatus.setActivityID(rc.cnActivities.activityid);
								oObStatus.setAmount(oProposal.getBudgetCeilingAmount());
								oObStatus.setObligationDate(logDateTime);
								oObStatus.setObligationFYyearSource(oProposal.getfiscalYear());
								oObStatus.setComments("Fully obligated - CN cleared");
								oObStatus.setsysUserID(rc.sysUserID);
								saveOb = instance.ActivityObligationService.saveActivityObligation(oObStatus);
							</cfscript> --->
						<cfelse>
							<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn approved') />
							<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,ActivityStatusID=newActivityStatusID,AMCNApprovedDate=logDateTime) />
						</cfif>
					</cfif>

				</cfloop>


			    <cfscript>
					Email.setTo( emails.reviewerEmails );
					Email.setFrom( "noreply@ctprograms.com" );
					Email.setCC( emails.submitterEmails );
					Email.setType( "html" );
					Email.setSubject( "CN Approved: Project(s) " & ucase(rc.cnActivitiesList) );
					Email.setBody( "<p>This is to notify you that a CN has been APPROVED for Project(s) #rc.cnActivitiesList#. <p>Please confirm the funding mechanism type for each of these projects, which are now in your workload summary.</p><p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>");
					instance.MailService.send( Email );
				</cfscript>

				<cfscript>
					Email.setTo( emails.budgetEmails );
					Email.setFrom( "noreply@ctprograms.com" );
					Email.setType( "html" );
					Email.setSubject( "CN Approved: Project(s) " & ucase(rc.cnActivitiesList) );
					Email.setBody( "<p>This is to notify you that a CN has been APPROVED for Project(s) #rc.cnActivitiesList#. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>");
					instance.MailService.send( Email );
				</cfscript>
				<cfset getPlugin("MessageBox").setMessage("info","AM/CN congressional approval status APPROVED successfully! <br />Now complete funding requirements.") />
				<!--- Send email --->


			<cfelseif rc.cnApprovalStatus IS 'Denied'>
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn denied') />
				<cfset statusLogMsg = statusLogMsg & 'Congress denies AMCN' />

				<cfloop query = "rc.cnActivities">
					<cfset oActivityStatusLog.setActivityID(rc.cnActivities.activityid) />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

					<cfif not (<!--- rc.cnActivities.activitystatusid is 297 or ---> rc.cnActivities.implementationstatus is "CN Re-notification")>
						<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,ActivityStatusID=newActivityStatusID) />
					</cfif>

				</cfloop>

			    <cfscript>
					Email.setTo( emails.reviewerEmails );
					Email.setFrom( "noreply@ctprograms.com" );
					Email.setCC( emails.submitterEmails );
					Email.setType( "html" );
					Email.setSubject( "CN Denied: Project(s) " & ucase(rc.cnActivitiesList) );
					Email.setBody( "<p>This is to notify you that a CN with Project(s) #rc.cnActivitiesList# has been denied. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>");
					instance.MailService.send( Email );
				</cfscript>
				<cfset getPlugin("MessageBox").setMessage("info","AM/CN congressional approval status  successfully!") />
				<!--- Send email --->


			<cfelseif rc.cnApprovalStatus IS 'On-Hold'>
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn on-hold') />
				<cfset statusLogMsg = statusLogMsg & 'Congress holds AMCN' />

				<cfloop query = "#rc.cnActivities#">
					<cfset oActivityStatusLog.setActivityID(rc.cnActivities.activityid) />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

					<cfif not (<!--- rc.cnActivities.activitystatusid is 297 or ---> rc.cnActivities.implementationstatus is "CN Re-notification")>
						<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,ActivityStatusID=newActivityStatusID) />
					</cfif>

				</cfloop>

			    <cfscript>
					Email.setTo( emails.reviewerEmails );
					Email.setFrom( "noreply@ctprograms.com" );
					Email.setCC( emails.submitterEmails );
					Email.setType( "html" );
					Email.setSubject( "CN Placed On-hold: Project(s) " & ucase(rc.cnActivitiesList) );
					Email.setBody( "<p>This is to notify you that a CN with Project(s) #rc.cnActivitiesList# has been PLACED ON HOLD. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>");
					instance.MailService.send( Email );
				</cfscript>
				<cfset getPlugin("MessageBox").setMessage("info","AM/CN congressional approval status ON-HOLD successfully!") />
				<!--- Send email --->


			<cfelseif rc.cnApprovalStatus IS 'Withdrawn'>
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn withdrawn') />
				<cfset statusLogMsg = statusLogMsg & 'AMCN is withdrawn' />

				<cfloop query = "#rc.cnActivities#">
					<cfset oActivityStatusLog.setActivityID(rc.cnActivities.activityid) />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

					<cfif not (<!--- rc.cnActivities.activitystatusid is 297 or ---> rc.cnActivities.implementationstatus is "CN Re-notification")>
						<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(activityID=rc.cnActivities.activityid,ActivityStatusID=newActivityStatusID) />
					</cfif>

				</cfloop>

			    <cfscript>
					Email.setTo( emails.reviewerEmails );
					Email.setFrom( "noreply@ctprograms.com" );
					Email.setCC( emails.submitterEmails );
					Email.setType( "html" );
					Email.setSubject( "CN Withdrawn: Project(s) " & ucase(rc.cnActivitiesList) );
					Email.setBody( "<p>This is to notify you that a CN with Project(s) #rc.cnActivitiesList# has been WITHDRAWN. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>");
					instance.MailService.send( Email );
				</cfscript>
				<cfset getPlugin("MessageBox").setMessage("info","CN congressional approval status WITHDRAWN successfully!") />
				<!--- Send email --->

				<cfset var oProposal = getModel("ActivityService").getActivity(rc.activityID) />
				<cfset var emails = instance.ProposalService.userEmails(programID=oProposal.getprogramID(),ActivityID=rc.ActivityID) />

			</cfif>

			<cfif ( StructKeyExists(rc,"cnnumber") and len(trim(rc.cnnumber)) ) and ( StructKeyExists(rc,"cnApprovalStatus") and len(trim(rc.cnApprovalStatus)) ) or (StructKeyExists(rc,"cnApprovalStatus") and trim(rc.cnApprovalStatus) is "On-Hold")>
				<!--- CN clearance update --->
				<cfset oCNStatus = instance.CNClearanceService.new() />
				<cfset oCNStatus.setCNClearanceID(rc.cnApprovalID) />
				<cfset oCNStatus.setCNID(rc.cnID) />
				<cfset oCNStatus.setClearanceAgencyName("Congress") />
				<cfset oCNStatus.setClearanceStatus(rc.cnApprovalStatus) />
				<cfset oCNStatus.setComments(rc.cnApprovalComments) />
				<cfset oCNStatus.setCstatusDate(logDateTime) />
				<cfset oCNStatus.setsysUserID(rc.sysUserID) />

				<!--- save CN update --->
				<cfset instance.CNClearanceService.saveCNClearance(oCNStatus) />

			<cfelse>
				<cfset getPlugin("MessageBox").setMessage("error","Error: Please enter CN Number and update CN Congressional Approval status to 'Pending' first.") />
				<cfset setNextEvent(event='proposal/cn',queryString='activityID/#rc.activityID#/cnid/#rc.cnid#')>
			</cfif>

		<cfelseif (StructKeyExists(rc,"clearanceStatus") AND rc.clearanceStatus IS "complete")>
			<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance complete') />
			<cfset statusLogMsg = statusLogMsg & '; Budget completes CN clearance' />

		<cfelse>

			<cfif StructKeyExists(rc,"legalReviewStatus") AND len(trim(rc.legalReviewStatus))>


				<cfif rc.roleName IS "Legal">
					<cfif rc.legalReviewStatus IS 'Yes'>
						<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn legal cleared') />
						<cfset statusLogMsg = statusLogMsg & '; Legal cleared CN' />
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN Legal Clearance Set To Yes: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that the CN Legal Clearance Status with Project(s) #rc.cnActivitiesList# has been set to Yes. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>
					<cfelseif rc.legalReviewStatus IS 'No'>
						<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn legal recommendation made') />
						<cfset statusLogMsg = statusLogMsg & '; Legal denies CN' />
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN Legal Clearance Set To No: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that the CN Legal Clearance Status with Project(s) #rc.cnActivitiesList# has been set to No. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>
					<cfelseif rc.legalReviewStatus IS 'Questions for Program' and rc.previousLegalReviewStatus is not 'Questions for Program' and rc.previousLegalReviewStatus is not 'Questions for Both'>
						<cfset newActivityStatusID = rc.activityStatusID />
						<cfset statusLogMsg = statusLogMsg & '; Legal questions for program' />
						<cfscript>
							Email.setTo( emails.reviewerEmails );
							Email.setCC( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "L requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that L requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>
					<cfelseif rc.legalReviewStatus IS 'Questions for Budget' and rc.previousLegalReviewStatus is not 'Questions for Budget' and rc.previousLegalReviewStatus is not 'Questions for Both'>
						<cfset newActivityStatusID = rc.activityStatusID />
						<cfset statusLogMsg = statusLogMsg & '; Legal questions for budget' />
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "L requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that L requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>
					<cfelseif rc.legalReviewStatus IS 'Questions for Both' and rc.previousLegalReviewStatus is not 'Questions for Both'>
						<cfset newActivityStatusID = rc.activityStatusID />
						<cfset statusLogMsg = statusLogMsg & '; Legal questions for program and budget' />
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "L requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that L requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>

					<cfelse>
						<cfset newActivityStatusID = rc.activityStatusID />
						<cfset statusLogMsg = statusLogMsg & '; Legal clearance still pending' />
						statusLogMsg
					</cfif>
					<cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) />
				<cfelseif rc.roleName IS "Budget" or rc.rolename is "BudgetAdmin">
					<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn legal clearance pending') />
					<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to L for clearance' />
					<cfif rc.previousLegalReviewStatus is not "Pending">

						<cfscript>
							Email.setTo( emails.legalEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "CN Legal Clearance Set To Pending: Project(s) " & ucase(rc.cnActivitiesList) );
							Email.setBody( "<p>This is to notify you that the CN Legal Clearance Status with Project(s) #rc.cnActivitiesList# has been set to Pending. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				</cfif>

				<!--- "L" clearance update --->
				<cfset oLegalClearance = instance.CNClearanceService.new() />
				<cfset oLegalClearance.setCNClearanceID(rc.legalReviewID) />
				<cfset oLegalClearance.setCNID(rc.cnID) />
				<cfset oLegalClearance.setClearanceAgencyName("Legal") />
				<cfset oLegalClearance.setClearanceStatus(rc.legalReviewStatus) />
				<cfset oLegalClearance.setComments(rc.legalReviewComment) />
				<cfset oLegalClearance.setCstatusDate(logDateTime) />
				<cfset oLegalClearance.setsysUserID(rc.sysUserID) />

				<!--- save legal --->
				<cfset instance.CNClearanceService.saveCNClearance(oLegalClearance) />
			</cfif>

			<cfif StructKeyExists(rc,"foreignAssistanceStatus") AND len(trim(rc.foreignAssistanceStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.foreignAssistanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to F for clearance' />
					<cfif rc.previousFReviewStatus is not "Pending">
						<cfscript>
							Email.setTo( emails.fEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "CN F Clearance Set To Pending: Project(s) " & ucase(rc.cnActivitiesList) );
							Email.setBody( "<p>This is to notify you that the CN F Clearance Status with Project(s) #rc.cnActivitiesList# has been set to Pending. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif (rc.foreignAssistanceStatus IS 'Questions for Program' and rc.previousFReviewStatus is not 'Questions for Program' and rc.previousFReviewStatus is not 'Questions for Both') or (rc.foreignAssistanceStatus IS 'Questions for Budget' and rc.previousFReviewStatus is not 'Questions for Budget' and rc.previousFReviewStatus is not 'Questions for Both') or (rc.foreignAssistanceStatus IS 'Questions for Both' and rc.previousLegalReviewStatus is not 'Questions for Both')>
						<cfset statusLogMsg = statusLogMsg & '; F questions' />
						<cfif rc.foreignAssistanceStatus IS 'Questions for Program'>
							<cfscript>
								Email.setTo( emails.reviewerEmails );
								Email.setCC( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.foreignAssistanceStatus IS 'Questions for Budget'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.foreignAssistanceStatus IS 'Questions for Both'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
								Email.setCC( emails.reviewerEmails );
							</cfscript>
						</cfif>
						<cfscript>
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "F requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that F requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


				<cfelseif rc.foreignAssistanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Foreign Assist clears CN' />
					<cfif rc.previousFReviewStatus is not "Yes">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN F Clearance Received:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that F Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been received. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif rc.foreignAssistanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Foreign Assist denies CN' />
					<cfif rc.previousFReviewStatus is not "No">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN F Clearance Denied:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that F Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been denied. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				</cfif>

				<!--- </cfif> --->
				<!--- "F" clearance update --->
				<cfset oForeignAssistClearance = instance.CNClearanceService.new() />
				<cfset oForeignAssistClearance.setCNClearanceID(rc.foreignAssistanceID) />
				<cfset oForeignAssistClearance.setCNID(rc.cnID) />
				<cfset oForeignAssistClearance.setClearanceAgencyName("Foreign Assist") />
				<cfset oForeignAssistClearance.setClearanceStatus(rc.foreignAssistanceStatus) />
				<cfset oForeignAssistClearance.setComments(rc.foreignAssistanceComment) />
				<cfset oForeignAssistClearance.setCstatusDate(logDateTime) />
				<cfset oForeignAssistClearance.setsysUserID(rc.sysUserID) />

				<!--- save F --->
				<cfset instance.CNClearanceService.saveCNClearance(oForeignAssistClearance) />
			</cfif>

			<cfif StructKeyExists(rc,"congressionalAffairsStatus") AND len(trim(rc.congressionalAffairsStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.congressionalAffairsStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to H for clearance' />
					<cfif rc.previousHReviewStatus is not "Pending">
						<cfscript>
							Email.setTo( emails.hEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "CN H Clearance Set To Pending: Project(s) " & ucase(rc.cnActivitiesList) );
							Email.setBody( "<p>This is to notify you that the CN H Clearance Status with Project(s) #rc.cnActivitiesList# has been set to Pending. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif (rc.congressionalAffairsStatus IS 'Questions for Program' and rc.previousHReviewStatus is not 'Questions for Program' and rc.previousHReviewStatus is not 'Questions for Both') or (rc.congressionalAffairsStatus IS 'Questions for Budget' and rc.previousHReviewStatus is not 'Questions for Budget' and rc.previousHReviewStatus is not 'Questions for Both') or (rc.congressionalAffairsStatus IS 'Questions for Both' and rc.previousHReviewStatus is not 'Questions for Both')>
						<cfset statusLogMsg = statusLogMsg & ';H questions' />
						<cfif rc.congressionalAffairsStatus IS 'Questions for Program'>
							<cfscript>
								Email.setTo( emails.reviewerEmails );
								Email.setCC( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.congressionalAffairsStatus IS 'Questions for Budget'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.congressionalAffairsStatus IS 'Questions for Both'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
								Email.setCC( emails.reviewerEmails );
							</cfscript>
						</cfif>
						<cfscript>
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "H requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that F requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


				<cfelseif rc.congressionalAffairsStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Congressional Affairs clears CN' />
					<cfif rc.previousHReviewStatus is not "Yes">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN H Clearance Received:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that H Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been received. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif rc.congressionalAffairsStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Congressional Affairs denies CN' />
					<cfif rc.previousHReviewStatus is not "No">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN H Clearance Denied:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that H Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been denied. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				</cfif>
				<!--- </cfif> --->

				<!--- "H" clearance update --->
				<cfset oCongressAffairsClearance = instance.CNClearanceService.new() />
				<cfset oCongressAffairsClearance.setCNClearanceID(rc.congressionalAffairsID) />
				<cfset oCongressAffairsClearance.setCNID(rc.cnID) />
				<cfset oCongressAffairsClearance.setClearanceAgencyName("Congressional Affairs") />
				<cfset oCongressAffairsClearance.setClearanceStatus(rc.congressionalAffairsStatus) />
				<cfset oCongressAffairsClearance.setComments(rc.congressionalAffairsComment) />
				<cfset oCongressAffairsClearance.setCstatusDate(logDateTime) />
				<cfset oCongressAffairsClearance.setsysUserID(rc.sysUserID) />

				<!--- save H --->
				<cfset instance.CNClearanceService.saveCNClearance(oCongressAffairsClearance) />
			</cfif>

			<cfif StructKeyExists(rc,"policyPlanningStatus") AND len(trim(rc.policyPlanningStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.policyPlanningStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to S/P for clearance' />
					<cfif rc.previousSPReviewStatus is not "Pending">
						<cfscript>
							Email.setTo( emails.spEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "CN S/P Clearance Set To Pending: Project(s) " & ucase(rc.cnActivitiesList) );
							Email.setBody( "<p>This is to notify you that the CN S/P Clearance Status with Project(s) #rc.cnActivitiesList# has been set to Pending. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif (rc.policyPlanningStatus IS 'Questions for Program' and rc.previousSPReviewStatus is not 'Questions for Program' and rc.previousSPReviewStatus is not 'Questions for Both') or (rc.policyPlanningStatus IS 'Questions for Budget' and rc.previousSPReviewStatus is not 'Questions for Budget' and rc.previousSPReviewStatus is not 'Questions for Both') or (rc.policyPlanningStatus IS 'Questions for Both' and rc.previousSPReviewStatus is not 'Questions for Both')>
						<cfset statusLogMsg = statusLogMsg & ';S/P questions' />
						<cfif rc.policyPlanningStatus IS 'Questions for Program'>
							<cfscript>
								Email.setTo( emails.reviewerEmails );
								Email.setCC( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.policyPlanningStatus IS 'Questions for Budget'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.policyPlanningStatus IS 'Questions for Both'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
								Email.setCC( emails.reviewerEmails );
							</cfscript>
						</cfif>
						<cfscript>
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "S/P requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that S/P requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>

				<cfelseif rc.policyPlanningStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Policy Planning clears CN' />
					<cfif rc.previousSPReviewStatus is not "Yes">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN S/P Clearance Received:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that S/P Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been received. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif rc.policyPlanningStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Policy Planning denies CN' />
					<cfif rc.previousSPReviewStatus is not "No">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN S/P Clearance Denied:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that S/P Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been denied. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				</cfif>

				<!--- </cfif> --->
				<!--- "S/P" clearance update --->
				<cfset oPolicyPlanningClearance = instance.CNClearanceService.new() />
				<cfset oPolicyPlanningClearance.setCNClearanceID(rc.policyPlanningID) />
				<cfset oPolicyPlanningClearance.setCNID(rc.cnID) />
				<cfset oPolicyPlanningClearance.setClearanceAgencyName("Policy Planning") />
				<cfset oPolicyPlanningClearance.setClearanceStatus(rc.policyPlanningStatus) />
				<cfset oPolicyPlanningClearance.setComments(rc.policyPlanningComment) />
				<cfset oPolicyPlanningClearance.setCstatusDate(logDateTime) />
				<cfset oPolicyPlanningClearance.setsysUserID(rc.sysUserID) />

				<!--- save S/P --->
				<cfset instance.CNClearanceService.saveCNClearance(oPolicyPlanningClearance) />
			</cfif>

			<cfif StructKeyExists(rc,"sctCoordinatorStatus") AND len(trim(rc.sctCoordinatorStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.sctCoordinatorStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to CT for clearance' />
					statusLogMsg
				<cfelseif rc.sctCoordinatorStatus IS 'Questions for Program' and rc.previousCtReviewStatus is not 'Questions for Program'>
						<cfset statusLogMsg = statusLogMsg & '; CT questions' />

						<cfscript>
							Email.setTo( emails.reviewerEmails );
							Email.setCC( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CT requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that CT requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


				<cfelseif rc.sctCoordinatorStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; CT clears CN' />
				<cfelseif rc.sctCoordinatorStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; CT denies CN' />
				</cfif>

				<!--- </cfif> --->
				<!--- "SCT" clearance update --->
				<cfset oSCTClearance = instance.CNClearanceService.new() />
				<cfset oSCTClearance.setCNClearanceID(rc.sctCoordinatorID) />
				<cfset oSCTClearance.setCNID(rc.cnID) />
				<cfset oSCTClearance.setClearanceAgencyName("SCT Coordinator") />
				<cfset oSCTClearance.setClearanceStatus(rc.sctCoordinatorStatus) />
				<cfset oSCTClearance.setComments(rc.sctCoordinatorComment) />
				<cfset oSCTClearance.setCstatusDate(logDateTime) />
				<cfset oSCTClearance.setsysUserID(rc.sysUserID) />

				<!--- save SCT --->
				<cfset instance.CNClearanceService.saveCNClearance(oSCTClearance)>
			</cfif>
			<!---  --->

			<!---  --->
			<cfif StructKeyExists(rc,"ombReviewStatus") AND len(trim(rc.ombReviewStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.ombReviewStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to OMB for clearance' />
				<cfelseif rc.ombReviewStatus IS 'Questions for Program' and rc.previousOMBReviewStatus is not 'Questions for Program'>
						<cfset statusLogMsg = statusLogMsg & '; OMB questions' />

						<cfscript>
							Email.setTo( emails.reviewerEmails );
							Email.setCC( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "OMB requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that OMB requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


				<cfelseif rc.ombReviewStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; OMB clears CN' />
				<cfelseif rc.ombReviewStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; OMB denies CN' />
				</cfif>

				<!--- </cfif> --->
				<!--- "Deputy Review" clearance update --->
				<cfset oOmbReview = instance.CNClearanceService.new() />
				<cfset oOmbReview.setCNClearanceID(rc.ombReviewID) />
				<cfset oOmbReview.setCNID(rc.cnID) />
				<cfset oOmbReview.setClearanceAgencyName("Management and Budget") />
				<cfset oOmbReview.setClearanceStatus(rc.ombReviewStatus) />
				<cfset oOmbReview.setComments(rc.ombReviewComment) />
				<cfset oOmbReview.setCstatusDate(logDateTime) />
				<cfset oOmbReview.setsysUserID(rc.sysUserID) />

				<!--- save Deputy Review --->
				<cfset instance.CNClearanceService.saveCNClearance(oOmbReview) />
			</cfif>

			<!---  --->
			<cfif StructKeyExists(rc,"deputyReviewStatus") AND len(trim(rc.deputyReviewStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.deputyReviewStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to DAS for clearance' />
				<cfelseif rc.deputyReviewStatus IS 'Questions for Program' and rc.previousDASReviewStatus is not 'Questions for Program'>
						<cfset statusLogMsg = statusLogMsg & '; DAS questions' />

						<cfscript>
							Email.setTo( emails.reviewerEmails );
							Email.setCC( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "DAS requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that DAS requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


				<cfelseif rc.deputyReviewStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; DAS clears CN' />
				<cfelseif rc.deputyReviewStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; DAS denies CN' />
				</cfif>

				<!--- </cfif> --->
				<!--- "Deputy Review" clearance update --->
				<cfset oDeputyReview = instance.CNClearanceService.new() />
				<cfset oDeputyReview.setCNClearanceID(rc.deputyReviewID) />
				<cfset oDeputyReview.setCNID(rc.cnID) />
				<cfset oDeputyReview.setClearanceAgencyName("Deputy Review") />
				<cfset oDeputyReview.setClearanceStatus(rc.deputyReviewStatus) />
				<cfset oDeputyReview.setComments(rc.deputyReviewComment) />
				<cfset oDeputyReview.setCstatusDate(logDateTime) />
				<cfset oDeputyReview.setsysUserID(rc.sysUserID) />

				<!--- save Deputy Review --->
				<cfset instance.CNClearanceService.saveCNClearance(oDeputyReview) />
			</cfif>

			<cfif StructKeyExists(rc,"frontOfficeStatus") AND len(trim(rc.frontOfficeStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.frontOfficeStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to Front Office for clearance' />
					<cfif rc.previousFOReviewStatus is not "Pending">
						<cfscript>
							Email.setTo( emails.foEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "CN FO Clearance Set To Pending: Project(s) " & ucase(rc.cnActivitiesList) );
							Email.setBody( "<p>This is to notify you that the CN FO Clearance Status with Project(s) #rc.cnActivitiesList# has been set to Pending. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif (rc.frontOfficeStatus IS 'Questions for Program' and rc.previousFOReviewStatus is not 'Questions for Program' and rc.previousFOReviewStatus is not 'Questions for Both') or (rc.frontOfficeStatus IS 'Questions for Budget' and rc.previousFOReviewStatus is not 'Questions for Budget' and rc.previousFOReviewStatus is not 'Questions for Both') or (rc.frontOfficeStatus IS 'Questions for Both' and rc.previousFOReviewStatus is not 'Questions for Both')>
						<cfset statusLogMsg = statusLogMsg & ';FO questions' />
						<cfif rc.frontOfficeStatus IS 'Questions for Program'>
							<cfscript>
								Email.setTo( emails.reviewerEmails );
								Email.setCC( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.frontOfficeStatus IS 'Questions for Budget'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
							</cfscript>
						<cfelseif rc.frontOfficeStatus IS 'Questions for Both'>
							<cfscript>
								Email.setTo( emails.budgetEmails );
								Email.setCC( emails.reviewerEmails );
							</cfscript>
						</cfif>
						<cfscript>
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "FO requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that FO requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>

				<cfelseif rc.frontOfficeStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Front Office clears CN' />
					<cfif rc.previousFOReviewStatus is not "Yes">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN FO Clearance Received:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that FO Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been received. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				<cfelseif rc.frontOfficeStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Front Office denies CN' />
					<cfif rc.previousFOReviewStatus is not "No">
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "CN FO Clearance Denied:  " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that FO Clearance Status on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#)) has been denied. <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


					</cfif>
				</cfif>

				<!--- </cfif> --->
				<!--- "front Office" clearance update --->
				<cfset ofrontOffice = instance.CNClearanceService.new() />
				<cfset ofrontOffice.setCNClearanceID(rc.frontOfficeID) />
				<cfset ofrontOffice.setCNID(rc.cnID) />
				<cfset ofrontOffice.setClearanceAgencyName("AMCN Front Office") />
				<cfset ofrontOffice.setClearanceStatus(rc.frontOfficeStatus) />
				<cfset ofrontOffice.setComments(rc.frontOfficeComment) />
				<cfset ofrontOffice.setCstatusDate(logDateTime) />
				<cfset ofrontOffice.setsysUserID(rc.sysUserID) />

				<!--- save front office --->
				<cfset instance.CNClearanceService.saveCNClearance(ofrontOffice) />
			</cfif>

			<cfif StructKeyExists(rc,"fassistfrontOfficeStatus") AND len(trim(rc.fassistfrontOfficeStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.frontOfficeStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to Front Office for clearance' />
				<cfelseif rc.frontOfficeStatus IS 'Questions for Program' and rc.previousFAReviewStatus is not 'Questions for Program'>
						<cfset statusLogMsg = statusLogMsg & '; FA questions' />

						<cfscript>
							Email.setTo( emails.reviewerEmails );
							Email.setCC( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "FA requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that FA requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


				<cfelseif rc.frontOfficeStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Front Office clears CN' />
				<cfelseif rc.frontOfficeStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Front Office denies CN' />
				</cfif>
				<!--- </cfif> --->

				<!--- "front Office" clearance update --->
				<cfset ofassistfrontOffice = instance.CNClearanceService.new() />
				<cfset ofassistfrontOffice.setCNClearanceID(rc.fassistfrontOfficeID) />
				<cfset ofassistfrontOffice.setCNID(rc.cnID) />
				<cfset ofassistfrontOffice.setClearanceAgencyName("AMCN FA Front Office") />
				<cfset ofassistfrontOffice.setClearanceStatus(rc.fassistfrontOfficeStatus) />
				<cfset ofassistfrontOffice.setComments(rc.fassistfrontOfficeComment) />
				<cfset ofassistfrontOffice.setCstatusDate(logDateTime) />
				<cfset ofassistfrontOffice.setsysUserID(rc.sysUserID) />

				<!--- save front office --->
				<cfset instance.CNClearanceService.saveCNClearance(ofassistfrontOffice) />
			</cfif>

			<cfif StructKeyExists(rc,"legalAffairsFOStatus") AND len(trim(rc.legalAffairsFOStatus))>
				<!--- <cfif rc.roleName IS "Budget"> --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('am/cn clearance pending') />

				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.legalAffairsFOStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends CN to Legislative Affairs FO for clearance' />
				<cfelseif rc.legalAffairsFOStatus IS 'Questions for Program' and rc.previousLAReviewStatus is not 'Questions for Program'>
						<cfset statusLogMsg = statusLogMsg & '; LA questions' />

						<cfscript>
							Email.setTo( emails.reviewerEmails );
							Email.setCC( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setType( "html" );
							Email.setSubject( "Legislative Affairs requires clarification: " & rc.cntitle );
							Email.setBody( "<p>This is to notify you that Legislative Affairs requires clarification on CN #rc.cntitle# (Project(s): #rc.cnActivitiesList#). <p>CN Title: #rc.cntitle#<p>CN Number: #rc.cnnumber# <p>Please access the management system to view the CN.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>


				<cfelseif rc.legalAffairsFOStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Legislative Affairs FO clears CN' />
				<cfelseif rc.legalAffairsFOStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Legislative Affairs FO denies CN' />
				</cfif>

				<!--- </cfif> --->
				<!--- "SCT" clearance update --->
				<cfset olegalAffairsFO = instance.CNClearanceService.new() />
				<cfset olegalAffairsFO.setCNClearanceID(rc.legalAffairsFOID) />
				<cfset olegalAffairsFO.setCNID(rc.cnID) />
				<cfset olegalAffairsFO.setClearanceAgencyName("Legislative Affairs") />
				<cfset olegalAffairsFO.setClearanceStatus(rc.legalAffairsFOStatus) />
				<cfset olegalAffairsFO.setComments(rc.legalAffairsFOComment) />
				<cfset olegalAffairsFO.setCstatusDate(logDateTime) />
				<cfset olegalAffairsFO.setsysUserID(rc.sysUserID) />

				<!--- save SCT --->
				<cfset instance.CNClearanceService.saveCNClearance(olegalAffairsFO) />
			</cfif>

			<cfset getPlugin("MessageBox").setMessage("info","AM/CN clearance updated successfully!") />
		</cfif>



		<cfif StructKeyExists(rc,"cnApprovalStatus") and rc.cnApprovalStatus IS 'Approved'>
			<cfset getPlugin("MessageBox").setMessage("info","CN clearance updated successfully!") />
			<cfset setNextEvent(event='proposal/CN',queryString='activityID/#rc.activityID#/cnid/#rc.cnid#')>
		<cfelse>
			<cfset setNextEvent(event='proposal/CN',queryString='activityID/#rc.activityID#/cnid/#rc.cnid#')>
		</cfif>

	</cffunction>

	<cffunction name="confirmfundingMechanism" displayname="Funding Mechanism Clearance" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset var statusLogMsg = "">

		<!--- update status --->
		<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
		<cfset oActivityStatusLog.setActivityID(rc.ActivityID) />
		<cfset oActivityStatusLog.setStatusDate(logDateTime) />
		<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />

		<cfparam name="rc.moucheck1" default="">
		<cfparam name="rc.moucheck2" default="">
		<cfparam name="rc.cagrantcheck" default="">
		<cfparam name="rc.btcheck" default="">
		<cfparam name="rc.fccheck" default="">
		<cfparam name="rc.contractcheck" default="">


		<cfif StructKeyExists(rc,"btnConfirmFundMech") and len(rc.btnConfirmFundMech)>
			<cfif StructKeyExists(rc,"fundImpMechanismID") AND len(rc.fundImpMechanismID) and (((rc.fundImpMechanismID is 318 and listlen(rc.contractcheck) is 3) or (rc.fundImpMechanismID is 4 and listlen(rc.moucheck1) is 5) or (rc.fundImpMechanismID is 4 and listlen(rc.moucheck2) is 4) or (rc.fundImpMechanismID is 5 and listlen(rc.cagrantcheck) is 8) or (rc.fundImpMechanismID is 347 and listlen(rc.cagrantcheck) is 8) or (rc.fundImpMechanismID is 2 and len(rc.bureauTransferPOC) gt 0) or (rc.fundImpMechanismID is 3 and len(rc.bureauTransferPOC) gt 0)) <!--- or not (rc.fundImpMechanismID is 318 or rc.fundImpMechanismID is 4) --->)>
				<!--- do not change status --->
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') />
				<cfset statusLogMsg = statusLogMsg & 'funding implementation type confirmed' />
				<cfset updateFundMechID = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,fundImpMechanismID=rc.fundImpMechanismID,activityStatusID=newActivityStatusID,bureauTransferPOC=rc.bureauTransferPOC) />
				<cfset var submittingProgramID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />
				<cfset var emailReceps = instance.ProposalService.userEmails(programID=submittingProgramID,ActivityID=rc.ActivityID) />
				<cfset Email = instance.MailService.newMail()	/>
				<cfset Email.setTo( emailReceps.budgetEmails ) />
				<cfset Email.setFrom( "noreply@ctprograms.com" ) />
				<cfset Email.setType( "html" ) />
				<cfset Email.setSubject( ucase(rc.proposalnumber) &  " Funding Mechanism Confirmed by Program" ) />
				<cfset Email.setBody( "<p>This is to notify you that Proposal #rc.proposalnumber# has had its funding mechanism confirmed by Program. Please access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>" ) />
					<!--- /* Send email */ --->
				<cfset instance.MailService.send( Email ) />
			<cfelse>
				<cfset updateFundMechID = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,fundImpMechanismID=rc.fundImpMechanismID) />
				<cfset getPlugin("MessageBox").setMessage("error","Please make sure all Funding Mechanism confirmation requirements are met below. ") />
				<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>
			</cfif>

		</cfif>

		<cfset setNextEvent(event='summary/index')>

	</cffunction>

	<cffunction name="savefundingMechanism" displayname="Funding Mechanism Clearance" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />
		<cfset rc.fclearance = instance.ActivityClearanceGateway.getByAttributesQuery(ActivityID=rc.activityID,clearanceAgencyName="f-Legal") />
		<cfset Email = instance.MailService.newMail() />
		<cfif (StructKeyExists(rc,"fclearance") AND rc.fclearance.recordcount gt 0) >
			<cfset rc.previousLegalFStatus = rc.fClearance.clearanceStatus />
		<cfelse>
			<cfset rc.previousLegalFStatus = "" />
		</cfif>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset var newActivityStatusID = rc.activityStatusID />
		<cfset var statusLogMsg = "">

		<!--- update status --->
		<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
		<cfset oActivityStatusLog.setActivityID(rc.ActivityID) />
		<cfset oActivityStatusLog.setStatusDate(logDateTime) />
		<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />

		<!--- update funding/implementation mechanism --->
		<cfif StructKeyExists(rc,"btnChangeFundMech") and len(rc.btnChangeFundMech)>
			<cfif StructKeyExists(rc,"fundImpMechanismID") AND len(rc.fundImpMechanismID)>
				<!--- do not change status --->
				<cfset newActivityStatusID = rc.activityStatusID />
				<cfset statusLogMsg = statusLogMsg & 'funding implementation type changed' />
				<cfset updateFundMechID = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,fundImpMechanismID=rc.fundImpMechanismID) />
			</cfif>
		</cfif>

		<!--- add mou mod --->
		<cfif StructKeyExists(rc,"btnMOUMod") and len(rc.btnMOUMod)>

				<cfset newActivityStatusID = rc.activityStatusID />
				<cfset statusLogMsg = statusLogMsg & 'MOU/IAA Modification Added' />
				<cfset resetMOUclearances = instance.ActivityClearanceGateway.resetMOUClearances(ActivityID=rc.ActivityID)>
				<cfset updateFundMechID = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,implementationStatus='MOU Modification',budgetfundrequestdate=now()) />

		</cfif>



		<!--- upload document --->
		<cfif StructKeyExists(rc,"btnUploadDocument") and len(rc.btnUploadDocument)>
			<cfif ( StructKeyExists(rc,"documentUpload") and len(trim(rc.documentUpload)) ) and ( StructKeyExists(rc,"documentTitle") and len(trim(rc.documentTitle)) )>
				<!--- do not change status --->
				<cfset newActivityStatusID = rc.activityStatusID />
				<cfset statusLogMsg = statusLogMsg & 'funding document uploaded' />
				<!--- ... upload file --->
				<cfset attachTemp = getPlugin("FileUtils").uploadFile(fileField="form.documentUpload",destination=expandPath('attachedFiles'),NameConflict="makeunique") />
				<!--- save data --->
				<cfset oAttachedFile = instance.AttachedFileService.new() />
				<cfset oAttachedFile.setAttachedFileName(attachTemp.serverFile) />
				<cfset oAttachedFile.setUploadedFileName(attachTemp.clientFile) />
				<cfset oAttachedFile.setAttachedFileDate(now()) />
				<cfset oAttachedFile.setName(rc.documentTitle) />
				<cfset oAttachedFile.setobjectTableName('ActivityFunding') />
				<cfset oAttachedFile.setobjectTableID(rc.activityID) />

				<cfset instance.AttachedFileService.saveAttachedFile(oAttachedFile) />
				<cfset getPlugin("MessageBox").setMessage("info","Funding/Implementation mechanism document uploaded successfully!") />
			<cfelse>
				<cfset getPlugin("MessageBox").setMessage("error","Error: Please enter document description and select document to upload.") />
				<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>
			</cfif>
		</cfif>

		<!--- </cfif> --->
		<cfif StructKeyExists(rc,"btnUpdateClearanceStatus") AND len(trim(rc.btnUpdateClearanceStatus))>

			<cfif StructKeyExists(rc,"fundingReqDate") >
				<cfif len(trim(rc.fundingReqDate)) and isDate(rc.fundingReqDate)>
					<cfset newActivityStatusID = rc.ActivityStatusID />
					<cfset updateFundreq = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,budgetFundRequestDate=rc.fundingReqDate) />
					<!--- 'program funding clearance complete' --->
					<cfset statusLogMsg = 'Budget sends funding request' />
					<!--- <cfset getPlugin("MessageBox").setMessage("info","Funding/Implementation funding request date updated successfully!") /> --->
				<cfelse>
					<cfset getPlugin("MessageBox").setMessage("error","Error: Please enter a valid funding request date.") />
					<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>
				</cfif>
			</cfif>

			<cfif rc.isMOUMod is not "True">
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') />
			<cfelse>
				<cfset newActivityStatusID = rc.ActivityStatusID />
			</cfif>

			<cfif StructKeyExists(rc,"legalClearanceStatus") AND len(trim(rc.legalClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.legalClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to L' />
					<cfif rc.previousLegalFStatus is not "Pending">
						<!--- Create a new mail object --->

						<!--- get proposal details --->
						<cfset var oProposal = getModel("ActivityService").getActivity(rc.activityID) />
						<cfset var emails = instance.ProposalService.userEmails(programID=oProposal.getprogramID(),ActivityID=rc.ActivityID) />
						<cfscript>
							Email.setTo( emails.legalEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "Funding Legal Clearance Set To Pending: Proposal " & ucase(oProposal.getproposalNumber()) );
							Email.setBody( "<p>This is to notify you that a Funding Legal Clearance Status with Proposal <a href=#event.buildLink('proposal.fundimpmechanism.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been set to Pending. Please follow the <a href=#event.buildLink('proposal.fundImpMechanism.activityID.' & rc.ActivityID)#>link</a> or access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>
					</cfif>
				<cfelseif rc.legalClearanceStatus IS 'Yes'>
					<cfif rc.previousLegalFStatus is not "Yes">
						<!--- Create a new mail object --->

						<!--- get proposal details --->
						<cfset var oProposal = getModel("ActivityService").getActivity(rc.activityID) />
						<cfset var emails = instance.ProposalService.userEmails(programID=oProposal.getprogramID(),ActivityID=rc.ActivityID) />
						<cfscript>
							Email.setTo( emails.budgetEmails );
							Email.setFrom( "noreply@ctprograms.com" );
							Email.setCC( emails.reviewerEmails );
							Email.setType( "html" );
							Email.setSubject( "Funding Legal Clearance Approved: Proposal " & ucase(oProposal.getproposalNumber()) );
							Email.setBody( "<p>This is to notify you that a Funding Legal Clearance Status with Proposal <a href=#event.buildLink('proposal.fundimpmechanism.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been set to Yes. Please follow the <a href=#event.buildLink('proposal.fundImpMechanism.activityID.' & rc.ActivityID)#>link</a> or access the management system to view the proposal.</p><br /><p>www.ctprograms.com</p>");
							instance.MailService.send( Email );
						</cfscript>
					</cfif>
					<cfset statusLogMsg = statusLogMsg & '; Legal clears funding' />
				<cfelseif rc.legalClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Legal denies funding' />
				</cfif>
				<!--- "L" clearance update --->
				<cfset oLegalClearance = instance.ActivityClearanceService.new() />
				<cfset oLegalClearance.setActivityClearanceID(rc.legalClearanceID) />
				<cfset oLegalClearance.setActivityID(rc.ActivityID) />
				<cfset oLegalClearance.setClearanceAgencyName("f-Legal") />
				<cfset oLegalClearance.setClearanceStatus(rc.legalClearanceStatus) />
				<cfset oLegalClearance.setComments(rc.legalClearanceComment) />
				<cfset oLegalClearance.setCstatusDate(logDateTime) />
				<cfset oLegalClearance.setActivityStatusID(newActivityStatusID) />
				<cfset oLegalClearance.setsysUserID(rc.sysUserID) />
				<!--- save legal --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oLegalClearance) />
			</cfif>

			<cfif StructKeyExists(rc,"pmClearanceStatus") AND len(trim(rc.pmClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.pmClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to PM' />
				<cfelseif rc.pmClearanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; PM clears funding' />
				<cfelseif rc.pmClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; PM denies funding' />
				</cfif>
				<!--- "PM" clearance update --->
				<cfset oProgramManager = instance.ActivityClearanceService.new() />
				<cfset oProgramManager.setActivityClearanceID(rc.pmClearanceID) />
				<cfset oProgramManager.setActivityID(rc.ActivityID) />
				<cfset oProgramManager.setClearanceAgencyName("Program Manager") />
				<cfset oProgramManager.setClearanceStatus(rc.pmClearanceStatus) />
				<cfset oProgramManager.setComments(rc.pmClearanceComment) />
				<cfset oProgramManager.setCstatusDate(logDateTime) />
				<cfset oProgramManager.setActivityStatusID(newActivityStatusID) />
				<cfset oProgramManager.setsysUserID(rc.sysUserID) />
				<!--- save PM --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oProgramManager) />
			</cfif>

			<cfif StructKeyExists(rc,"BudgetClearanceStatus") AND len(trim(rc.budgetClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.budgetClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to B' />
				<cfelseif rc.budgetClearanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Budget clears funding' />
				<cfelseif rc.budgetClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Budget denies funding' />
				</cfif>
				<!--- "Budget" clearance update --->
				<cfset oBudget = instance.ActivityClearanceService.new() />
				<cfset oBudget.setActivityClearanceID(rc.budgetClearanceID) />
				<cfset oBudget.setActivityID(rc.ActivityID) />
				<cfset oBudget.setClearanceAgencyName("Budget") />
				<cfset oBudget.setClearanceStatus(rc.budgetClearanceStatus) />
				<cfset oBudget.setComments(rc.budgetClearanceComment) />
				<cfset oBudget.setCstatusDate(logDateTime) />
				<cfset oBudget.setActivityStatusID(newActivityStatusID) />
				<cfset oBudget.setsysUserID(rc.sysUserID) />
				<!--- save Budget --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oBudget) />
			</cfif>

			<cfif StructKeyExists(rc,"mouClearanceStatus") AND len(trim(rc.mouClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.mouClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to MOU' />
				<cfelseif rc.mouClearanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; MOU clears funding' />
				<cfelseif rc.mouClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; MOU denies funding' />
				</cfif>
				<!--- "Budget" clearance update --->
				<cfset oMOU = instance.ActivityClearanceService.new() />
				<cfset oMOU.setActivityClearanceID(rc.mouClearanceID) />
				<cfset oMOU.setActivityID(rc.ActivityID) />
				<cfset oMOU.setClearanceAgencyName("MOU") />
				<cfset oMOU.setClearanceStatus(rc.mouClearanceStatus) />
				<cfset oMOU.setComments(rc.mouClearanceComment) />
				<cfset oMOU.setCstatusDate(logDateTime) />
				<cfset oMOU.setActivityStatusID(newActivityStatusID) />
				<cfset oMOU.setsysUserID(rc.sysUserID) />
				<!--- save Budget --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oMOU) />
			</cfif>

			<cfif StructKeyExists(rc,"foClearanceStatus") AND len(trim(rc.foClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.foClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to F/O' />
				<cfelseif rc.foClearanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; F/O clears funding' />
				<cfelseif rc.foClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; F/O denies funding' />
				</cfif>
				<!--- "F/O" clearance update --->
				<cfset oFrontOffice = instance.ActivityClearanceService.new() />
				<cfset oFrontOffice.setActivityClearanceID(rc.foClearanceID) />
				<cfset oFrontOffice.setActivityID(rc.ActivityID) />
				<cfset oFrontOffice.setClearanceAgencyName("Front Office") />
				<cfset oFrontOffice.setClearanceStatus(rc.foClearanceStatus) />
				<cfset oFrontOffice.setComments(rc.foClearanceComment) />
				<cfset oFrontOffice.setCstatusDate(logDateTime) />
				<cfset oFrontOffice.setActivityStatusID(newActivityStatusID) />
				<cfset oFrontOffice.setsysUserID(rc.sysUserID) />
				<!--- save F/O --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oFrontOffice) />
			</cfif>

			<cfif StructKeyExists(rc,"sesClearanceStatus") AND len(trim(rc.sesClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.sesClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to Executive Office' />
				<cfelseif rc.sesClearanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Executive Office clears funding' />
				<cfelseif rc.sesClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Executive Office denies funding' />
				</cfif>
				<!--- "SES" clearance update --->
				<cfset oExecutiveOffice = instance.ActivityClearanceService.new() />
				<cfset oExecutiveOffice.setActivityClearanceID(rc.sesClearanceID) />
				<cfset oExecutiveOffice.setActivityID(rc.ActivityID) />
				<cfset oExecutiveOffice.setClearanceAgencyName("Executive Office") />
				<cfset oExecutiveOffice.setClearanceStatus(rc.sesClearanceStatus) />
				<cfset oExecutiveOffice.setComments(rc.sesClearanceComment) />
				<cfset oExecutiveOffice.setCstatusDate(logDateTime) />
				<cfset oExecutiveOffice.setActivityStatusID(newActivityStatusID) />
				<cfset oExecutiveOffice.setsysUserID(rc.sysUserID) />
				<!--- save SES --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oExecutiveOffice) />
			</cfif>

			<cfif StructKeyExists(rc,"aqmClearanceStatus") AND len(trim(rc.aqmClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.aqmClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to Executive Office' />
				<cfelseif rc.aqmClearanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Executive Office clears funding' />
				<cfelseif rc.aqmClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Executive Office denies funding' />
				</cfif>
				<!--- "AQM" clearance update --->
				<cfset oAcquisitionOffice = instance.ActivityClearanceService.new() />
				<cfset oAcquisitionOffice.setActivityClearanceID(rc.aqmClearanceID) />
				<cfset oAcquisitionOffice.setActivityID(rc.ActivityID) />
				<cfset oAcquisitionOffice.setClearanceAgencyName("Acquisition Office") />
				<cfset oAcquisitionOffice.setClearanceStatus(rc.aqmClearanceStatus) />
				<cfset oAcquisitionOffice.setComments(rc.aqmClearanceComment) />
				<cfset oAcquisitionOffice.setCstatusDate(logDateTime) />
				<cfset oAcquisitionOffice.setActivityStatusID(newActivityStatusID) />
				<cfset oAcquisitionOffice.setsysUserID(rc.sysUserID) />
				<!--- save AQM --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oAcquisitionOffice) />
			</cfif>

			<cfif StructKeyExists(rc,"agencyClearanceStatus") AND len(trim(rc.agencyClearanceStatus))>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<!--- <cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) /> --->
				<cfif rc.agencyClearanceStatus IS 'Pending'>
					<cfset statusLogMsg = statusLogMsg & '; Budget sends funding clearance to Agency' />
				<cfelseif rc.agencyClearanceStatus IS 'Yes'>
					<cfset statusLogMsg = statusLogMsg & '; Agency clears funding' />
				<cfelseif rc.agencyClearanceStatus IS 'No'>
					<cfset statusLogMsg = statusLogMsg & '; Agency denies funding' />
				</cfif>
				<!--- "Agency" clearance update --->
				<cfset oAgency = instance.ActivityClearanceService.new() />
				<cfset oAgency.setActivityClearanceID(rc.agencyClearanceID) />
				<cfset oAgency.setActivityID(rc.ActivityID) />
				<cfset oAgency.setClearanceAgencyName("Agency") />
				<cfset oAgency.setClearanceStatus(rc.agencyClearanceStatus) />
				<cfset oAgency.setComments(rc.agencyClearanceComment) />
				<cfset oAgency.setCstatusDate(logDateTime) />
				<cfset oAgency.setActivityStatusID(newActivityStatusID) />
				<cfset oAgency.setsysUserID(rc.sysUserID) />
				<!--- save Agency --->
				<cfset instance.ActivityClearanceService.saveActivityClearance(oAgency) />
			</cfif>

			<cfif NOT len(trim(statusLogMsg))>
				<cfset getPlugin("MessageBox").setMessage("error","Error: No clearance update selected.") />
				<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>
			</cfif>

			<cfset getPlugin("MessageBox").setMessage("info","Funding/Implementation mechanism clearance status updated successfully!") />
		</cfif>

		<!--- save funding request date --->
		<!--- <cfif StructKeyExists(rc,"btnSaveFundingReq")>
			<cfif StructKeyExists(rc,"fundingReqDate") AND isDate(rc.fundingReqDate)>
				<cfset newActivityStatusID = rc.ActivityStatusID />
				<cfset updateFundreq = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,budgetFundRequestDate=rc.fundingReqDate) />
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /><!--- 'program funding clearance complete' --->
				<cfset statusLogMsg = 'Budget sends funding request' />

				<cfset getPlugin("MessageBox").setMessage("info","Funding/Implementation funding request date updated successfully!") />
			<cfelse>
				<cfset getPlugin("MessageBox").setMessage("error","Error: Please enter a valid funding request date.") />
				<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>
			</cfif>
		</cfif> --->

		<!--- save funding request date --->
		<cfif StructKeyExists(rc,"fundApproval")>
			<cfif StructKeyExists(rc,"fundingApprovalDate") AND isDate(rc.fundingApprovalDate)>
				<!--- <cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding clearance pending') /> --->
				<cfset newActivityStatusID = rc.ActivityStatusID />
				<cfset updateFundreq = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,budgetFundApprovalDate=rc.fundingApprovalDate) />
				<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding approved') />
				<cfset statusLogMsg = 'Budget approves funding' />

					<!--- Create a new mail object --->


					<!--- get proposal details --->
					<cfset var oProposal = getModel("ActivityService").getActivity(rc.activityID) />
					<cfset var emailReceps = instance.ProposalService.userEmails(programID=oProposal.getprogramID(),ActivityID=rc.ActivityID) />

					<!--- //send email --->
					<!--- // Create a new mail object --->

					<cfset Email.setTo( emailReceps.reviewerEmails ) />
					<cfset Email.setFrom( "noreply@ctprograms.com" ) />
					<cfset Email.setCC( emailReceps.submitterEmails ) />
					<cfset Email.setType( "html" ) />
					<cfset Email.setSubject( ucase(oProposal.getproposalNumber()) &  " Program Funding approved" ) />
					<cfset Email.setBody( "<p>This is to notify you that funding for Proposal <a href=#event.buildLink('proposal.fundImpMechanism.activityID.' & rc.ActivityID)#>" & ucase(oProposal.getproposalNumber()) & "</a> has been APPROVED. Please follow the <a href=#event.buildLink('proposal.fundImpMechanism.activityID.' & rc.ActivityID)#>link</a> or access the management system to see details related to this decision.</p><br /><p>www.ctprograms.com</p>" ) />
					<!--- /* Send email */ --->
					<cfset instance.MailService.send( Email ) />

			<cfelse>
				<cfset getPlugin("MessageBox").setMessage("error","Error: Please enter a valid funding approval date.") />
				<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>
			</cfif>
		</cfif>

		<!--- <cfif NOT isDefined("newActivityStatusID")></cfif> --->
		<cfset oActivityStatusLog.setActivityStatusID(newActivityStatusID) />
		<cfset oActivityStatusLog.setlogNote(statusLogMsg) />

		<!--- update activity status --->
		<cfif ( StructKeyExists(rc,"fundApproval") and rc.fundApproval is "Save and Complete Funding/Implementation" )
				and ( StructKeyExists(rc,"fundingApprovalDate") AND isDate(rc.fundingApprovalDate) )>
			<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,FundApprovedDate=logDateTime,ActivityStatusID=newActivityStatusID) />
			<cfset getPlugin("MessageBox").setMessage("info","Program funding approved! Program is now ready for obligation.") />

			<cfset setNextEvent(event='proposal/obStatus',queryString='activityID/#rc.activityID#')>
		<cfelse>
			<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=newActivityStatusID) />
		</cfif>

		<cfif  StructKeyExists(rc,"saveMouMod")>
			<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,implementationStatus='Active') />
			<cfset getPlugin("MessageBox").setMessage("info","MOU/IAA Modification approved.") />

			<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>
		</cfif>


		<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
		<cfset setNextEvent(event='proposal/fundImpMechanism',queryString='activityID/#rc.activityID#')>

	</cffunction>

	<cffunction name="saveObStatus" displayname="Obligation Status" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset var newActivityStatusID = "" />
		<cfset var statusLogMsg = "">

		<!--- update status --->
		<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
		<cfset oActivityStatusLog.setActivityID(rc.ActivityID) />
		<cfset oActivityStatusLog.setStatusDate(logDateTime) />
		<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />


			<cfif StructKeyExists(rc,"saveCommentDoc")>
				<cfif ( StructKeyExists(rc,"documentUpload") and len(form.documentUpload) ) and ( StructKeyExists(rc,"documentTitle") and len(rc.documentTitle) ) >
					<!--- ... upload file --->
					<cfset attachTemp = getPlugin("FileUtils").uploadFile(fileField="form.documentUpload",destination=expandPath('attachedFiles'),NameConflict="makeunique") />

					<!--- save data --->
					<cfset oAttachedFile = instance.AttachedFileService.new() />
					<cfset oAttachedFile.setAttachedFileName(attachTemp.serverFile) />
					<cfset oAttachedFile.setUploadedFileName(attachTemp.clientFile) />
					<cfset oAttachedFile.setAttachedFileDate(now()) />
					<cfset oAttachedFile.setName(rc.documentTitle) />
					<cfset oAttachedFile.setobjectTableName('ActivityObligation') />
					<cfset oAttachedFile.setobjectTableID(rc.activityID) />
					<cfset instance.AttachedFileService.saveAttachedFile(oAttachedFile) />

					<!--- status --->
					<cfset oActivityStatusLog.setActivityStatusID(rc.activityStatusID) />
					<cfset oActivityStatusLog.setlogNote("Obligation document uploaded") />
					<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
				<cfelse>
					<cfset getPlugin("MessageBox").setMessage("error","Error: Enter document description and select document to upload.") />
					<cfset setNextEvent(event='proposal/obStatus',queryString='activityID/#rc.activityID#') />
				</cfif>
			</cfif>


		<!--- ... save obligation --->
		<cfif StructKeyExists(rc,"updateObligation") OR StructKeyExists(rc,"fullyObigPrgm")>


			 		<!--- strip amount of numeic formating --->
					<cfset rc.obligAmount =  REReplace(rc.obligAmount,",","","all") />


					<cfif (StructKeyExists(rc,"obligAmount") and len(trim(rc.obligAmount)) and isNumeric(trim(rc.obligAmount)))
						and (StructKeyExists(rc,"obligFY")
							and len(trim(rc.obligFY)) is 4) >
							<cfif StructKeyExists(rc,"updateObligation") and rc.updateObligation is "Deobligate Funds">
								<cfset rc.obligAmount =  rc.obligAmount * -1 />
							</cfif>


						<cfset oObStatus = instance.ActivityObligationService.new()>
						<cfset oObStatus.setActivityID(rc.activityID) />
						<cfset oObStatus.setAmount(rc.obligAmount) />
						<cfset oObStatus.setObligationDate(logDateTime) />
						<cfset oObStatus.setObligationFYyearSource(rc.obligFY) />
						<cfset oObStatus.setComments(rc.obligComment) />
						<cfset oObStatus.setObligationNumber(rc.ObligationNumber) />
						<cfset oObStatus.setsysUserID(rc.sysUserID) />

						<cfset var qoblig = instance.ActivityObligationGateway.getByAttributesQuery(activityID=rc.activityID) />
						<cfset var totalAmountObligated = IIF(qoblig.totalObligAmount EQ '',DE("0"),qoblig.totalObligAmount) />
						<cfset var errors = arrayNew(1) />



						<cfif arraylen(errors)>
							<cfset ArrayPrepend(errors,"The following errors occured:") />
							<cfset getPlugin("MessageBox").error(message='Form error:<br />',messageArray=errors) />
							<cfset setNextEvent(event='proposal.obStatus',persist='activityID,errors') />
						<cfelse>

							<!--- amount within range --->
							<cfset saveOb = instance.ActivityObligationService.saveActivityObligation(oObStatus) />
							<cfif saveOb>


								<!--- ... update z obligation status --->
								<cfif StructKeyExists(rc,"updateObligation")>
									<cfset getPlugin("MessageBox").setMessage("info","Obligation amount updated successfully.") />
									<cfset oActivityStatusLog.setActivityStatusID(rc.activityStatusID) />
									<cfset oActivityStatusLog.setlogNote("Activity funds obligated") />
									<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
								</cfif>


							</cfif>
						</cfif>


					</cfif>

					<!--- ... fully obligate program --->
					<cfif StructKeyExists(rc,"fullyObigPrgm")>
						<cfset oActivityStatusLog.setActivityStatusID(rc.activityStatusID) />
						<cfset oActivityStatusLog.setlogNote("Program fully obligated.") />
						<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

						<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program fully obligated') />
						<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=newActivityStatusID) />

						<cfset getPlugin("MessageBox").setMessage("info","Program is successfully marked 'Fully Obligated'") />
					</cfif>




		</cfif>

		<!--- ... restore obligation status --->
		<cfif StructKeyExists(rc,"restoreObigStatus")>
			<cfset oActivityStatusLog.setActivityStatusID(rc.activityStatusID) />
			<cfset oActivityStatusLog.setlogNote("Program obligation status restored.") />
			<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

			<cfset newActivityStatusID = instance.ActivityStatusService.getActivityStatusIDfromName('program funding approved') />
			<cfset updateStatus = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,ActivityStatusID=newActivityStatusID) />

			<cfset getPlugin("MessageBox").setMessage("info","Program obligation status has been restored.") />
		</cfif>

		<cfif StructKeyExists(rc,"reprogram") and StructKeyExists(rc,"reprogramFunds")>
			<cfset updateReprogram = instance.activityExtendedGrantGateway.updateByAttributes(ActivityID=rc.ActivityID,reprogramFunds=1,reprogramComments=rc.reprogramComments) />
			<cfset oActivityStatusLog.setActivityStatusID(rc.activityStatusID) />
			<cfset oActivityStatusLog.setlogNote("Reprogram; Comments: " & rc.reprogramComments) />
			<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
		</cfif>

		<cfset setNextEvent(event='proposal/obStatus',queryString='activityID/#rc.activityID#')>
	</cffunction>

	<cffunction name="saveReports" displayname="Project Reports" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<!--- set log datetime --->
		<cfset var logDateTime = now() />
		<cfset var rc.jumpTo = "">

		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfif ( StructKeyExists(rc,"documentUpload") AND len(rc.documentUpload) ) AND ( StructKeyExists(rc,"documentTitle") AND len(rc.documentTitle) )>
				<!--- ... upload file --->
				<cfset attachTemp = getPlugin("FileUtils").uploadFile(fileField="form.documentUpload",destination=expandPath('attachedFiles'),NameConflict="makeunique") />
				<!--- save data --->
				<cfset oAttachedFile = instance.AttachedFileService.new() />
				<cfset oAttachedFile.setAttachedFileName(attachTemp.serverFile) />
				<cfset oAttachedFile.setUploadedFileName(attachTemp.clientFile) />
				<cfset oAttachedFile.setAttachedFileDate(now()) />
				<cfset oAttachedFile.setName(rc.documentTitle) />
				<cfset oAttachedFile.setobjectTableName('ActivityReports') />
				<cfset oAttachedFile.setobjectTableID(rc.activityID) />
				<cfset instance.AttachedFileService.saveAttachedFile(oAttachedFile) />
				<!--- update status --->
				<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
				<cfset oActivityStatusLog.setActivityID(rc.ActivityID) />
				<cfset oActivityStatusLog.setStatusDate(logDateTime) />
				<cfset oActivityStatusLog.setSysUserID(rc.SysUserID) />
				<cfset oActivityStatusLog.setActivityStatusID(rc.activityStatusID) />
				<cfset oActivityStatusLog.setlogNote("Activity project report uploaded") />
				<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />

				<cfset getPlugin("MessageBox").setMessage("info","Report document uploaded successfully.") />
			<cfelse>
				<cfset getPlugin("MessageBox").setMessage("error","Error: Enter document description and select document to upload.") />
				<cfset setNextEvent(event='proposal/activityreports',queryString='activityID/#rc.activityID#') />
			</cfif>
		</cfif>

		<cfset setNextEvent(event='proposal/activityreports',queryString='activityID/#rc.activityID#')>
	</cffunction>


	<cffunction name="archiveFile" displayname="Archive File" output="false" returntype="void" >
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset instance.AttachedFileService.archiveAttachedFile(rc.attachedFileID) />
		</cfif>

		<cfset setNextEvent(event='proposal/#rc.backto#',queryString='activityID/#rc.activityID#')>
	</cffunction>

	<cffunction name="unarchiveFile" displayname="Unarchive File" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset instance.AttachedFileService.unarchiveAttachedFile(rc.attachedFileID) />
		</cfif>

		<cfset setNextEvent(event='proposal/#rc.backto#',queryString='activityID/#rc.activityID#')>
	</cffunction>

	<cffunction name="deactivateFile" displayname="Delete File" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfif structKeyExists(rc,"ActivityID") and isnumeric(rc.activityid)>
			<cfset instance.AttachedFileService.deactivateAttachedFile(rc.attachedFileID) />
		</cfif>

		<cfset setNextEvent(event='proposal/#rc.backto#',queryString='activityID/#rc.activityID#')>
	</cffunction>

	<cffunction name="deleteOb" displayname="Delete Obligation" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfif structKeyExists(rc,"ActivityObligateID") and isnumeric(rc.activityobligateid)>
			<cfset instance.ActivityObligationService.deleteActivityObligation(rc.activityobligateid) />
		</cfif>

		<cfset setNextEvent(event='proposal/obstatus',queryString='activityID/#rc.activityID#')>
	</cffunction>


	<cffunction name="setActivityReporting"  displayname="Set Reporting Schedule" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfif StructKeyExists(rc,"deleteall") and len(rc.deleteall)>
			<cfset rc.deleteAll = instance.measurementGateway.deleteActivityMeasurements(activityid=rc.activityID) />
		</cfif>

		<cfset rc.indicators = instance.ResultsFrameworkElementGateway.getProjectObjectives(activityid=rc.activityID,indicatorsOnly=true) />
		<cfset rc.projectcountries = instance.ProposalGateway.getProjectCountryDisaggIDs(activityid=rc.activityID) />
		<cfset projectcountrylist = valuelist(rc.projectcountries.disaggid)>
		<cfset thestartdate = dateformat(rc.startdate)>
		<cfset theenddate = dateformat(rc.enddate)>

		<cfif StructKeyExists(rc,"reconcile") and len(rc.reconcile)>

			<cfset rc.deleteEdges = instance.measurementGateway.reconcileActivityMeasurements(activityid=rc.activityID,startdate=thestartdate,enddate=theenddate,countrylist=projectcountrylist) />

			 <cfinvoke component="Proposal" method="generateSchedule" returnvariable="scheduleArray">
				<cfinvokeargument name="period" value="#rc.period#">
				<cfinvokeargument name="startdate" value="#thestartdate#">
				<cfinvokeargument name="enddate" value="#theenddate#">
			</cfinvoke>

			<cfoutput query="rc.indicators">
				<cfloop index="i" from="1" to="#arrayLen(scheduleArray)#">

					<cfset newMeasurement = instance.measurementService.getMeasurement()>
					<cfset populateModel(newMeasurement)>
					<cfset newMeasurement.setIndicatorID(rc.indicators.IndicatorID)>
					<cfset newMeasurement.setMeasurementID(0)>
					<cfset newMeasurement.setStartDate(#scheduleArray[i][1]#)>
					<cfset newMeasurement.setEndDate(#scheduleArray[i][2]#)>

					<cfset checkmeasure = instance.measurementGateway.getByAttributesQuery(activityid=rc.activityID,indicatorid=rc.indicators.IndicatorID,startdate=scheduleArray[i][1],enddate=scheduleArray[i][2]) />
					<cfif checkmeasure.recordcount eq 0>

						<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>

						<cfset newMeasurement.setDisaggID(1)>
						<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>

						<cfset newMeasurement.setDisaggID(2)>
						<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>

						<cfloop query="rc.projectcountries">
							<cfset newMeasurement.setDisaggID(rc.projectcountries.disaggID)>
							<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>
						</cfloop>

					<cfelse>
						<cfset checkmeasuredisagg = instance.measurementGateway.getByAttributesQuery(activityid=rc.activityID,indicatorid=rc.indicators.IndicatorID,disaggid=1,startdate=scheduleArray[i][1],enddate=scheduleArray[i][2]) />
						<cfif checkmeasuredisagg.recordcount eq 0>
							<cfset newMeasurement.setDisaggID(1)>
							<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>
						</cfif>

						<cfset checkmeasuredisagg = instance.measurementGateway.getByAttributesQuery(activityid=rc.activityID,indicatorid=rc.indicators.IndicatorID,disaggid=2,startdate=scheduleArray[i][1],enddate=scheduleArray[i][2]) />
						<cfif checkmeasuredisagg.recordcount eq 0>
							<cfset newMeasurement.setDisaggID(2)>
							<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>
						</cfif>

						<cfloop query="rc.projectcountries">
							<cfset checkmeasuredisagg = instance.measurementGateway.getByAttributesQuery(activityid=rc.activityID,indicatorid=rc.indicators.IndicatorID,disaggid=rc.projectcountries.disaggID,startdate=scheduleArray[i][1],enddate=scheduleArray[i][2]) />
							<cfif checkmeasuredisagg.recordcount eq 0>
								<cfset newMeasurement.setDisaggID(rc.projectcountries.disaggID)>
								<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>
							</cfif>
						</cfloop>
					</cfif>
				</cfloop>
			</cfoutput>

		<cfelse>

			<cfinvoke component="Proposal" method="generateSchedule" returnvariable="scheduleArray">
				<cfinvokeargument name="period" value="#rc.period#">
				<cfinvokeargument name="startdate" value="#thestartdate#">
				<cfinvokeargument name="enddate" value="#theenddate#">
			</cfinvoke>

			<cfoutput query="rc.indicators">
				<cfloop index="i" from="1" to="#arrayLen(scheduleArray)#">

					<cfset newMeasurement = instance.measurementService.getMeasurement()>
					<cfset populateModel(newMeasurement)>
					<cfset newMeasurement.setIndicatorID(rc.indicators.IndicatorID)>
					<cfset newMeasurement.setMeasurementID(0)>
					<cfset newMeasurement.setStartDate(#scheduleArray[i][1]#)>
					<cfset newMeasurement.setEndDate(#scheduleArray[i][2]#)>
					<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>

					<cfset newMeasurement.setDisaggID(1)>
					<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>

					<cfset newMeasurement.setDisaggID(2)>
					<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>

					<cfloop query="rc.projectcountries">
						<cfset newMeasurement.setDisaggID(rc.projectcountries.disaggID)>
						<cfset rc.retMeasurementID = instance.measurementService.saveMeasurement(newMeasurement)>
					</cfloop>
				</cfloop>
			</cfoutput>

		</cfif>

		 <cfset setNextEvent(event='proposal/rmp',queryString='activityID/#rc.activityID#')>


	</cffunction>




	<!---GENERATE REPORTING SCHEDULE; TAKES 3 INPUTS: START/END DATES AND PERIOD (LENGTH IN MONTHS OF EACH REPORTING PERIOD; MUST BE DIVISIBLE into 12)--->
	<cffunction name="generateSchedule" access="public" returntype="Array">
		<cfargument name="startdate" type="date" required="yes">
		<cfargument name="enddate" type="date" required="yes">
		<cfargument name="period" type="numeric" required="no" default="3" hint="The number of months each report covers. For quarterly reporting, this is 3 (the default). Twelve must be evenly divisible by this number. This number must be <=12." >

		<cfif (12 mod arguments.period) or (arguments.period gt 12) or (arguments.period lte 0) >
               <cfthrow message="Period must be gt 0, lte 12 and be divisible into 12. Period submitted: #arguments.period#">
        <cfelseif arguments.enddate lte arguments.startdate>
               <cfthrow message="Start date must not be greater than end date.">
		</cfif>


		<!--- SET PROJECT START/END DATE MONTHS AND YEARS --->
		<cfset var startmonth = #dateformat(arguments.startdate,"m")#>
		<cfset var endmonth = #dateformat(arguments.enddate,"m")#>
		<cfset var startyear = #dateformat(arguments.startdate,"yyyy")#>
		<cfset var endyear = #dateformat(arguments.enddate,"yyyy")#>

		<!--- DETERMINE FREQUENCY --->
		<cfset var frequency = 12/arguments.period>

		<!--- SET ARRAY VARIABLES --->
		<cfset var theArray = arraynew(2)>
		<cfset var theArrayCount = 1>

		<!--- SET MONTH OF REPORTING SCHEDULE BOUNDARIES --->
		<cfloop from="1" to="#frequency#" index="i">
			<cfif startmonth gte ((i-1) * arguments.period + 1) and startmonth lt (i * arguments.period +1)>
				<cfset firstperiod = ((i-1) * arguments.period + 1)>
			</cfif>
			<cfif endmonth gte ((i-1) * arguments.period + 1) and endmonth lt (i * arguments.period +1)>
				<cfset lastperiod = ((i-1) * arguments.period + 1)>
			</cfif>
		</cfloop>

		<!--- LOOP THROUGH YEARS; SET FIRST AND LAST MONTH OF REPORTING SCHEDULE ACCORDING TO BOUNDARIES --->
		<cfloop from="#startyear#" to="#endyear#" index="y">
			<cfif y eq startyear>
				<cfset thefirst = firstperiod>
			<cfelse>
				<cfset thefirst = 1>
			</cfif>
			<cfif y eq endyear>
				<cfset thelast = lastperiod>
			<cfelse>
				<cfset thelast = 12>
			</cfif>
			<!--- LOOP THROUGH REPORTING PERIODS, SETTING START AND END DATES FOR EACH --->
			<cfloop from="#thefirst#" to="#thelast#" index="m" step="#arguments.period#">
				<cfset therepstartdate = dateformat(createdate(y,m,1),"mm/dd/yyyy")>
				<cfset therependdate = dateformat(createdate(y,m+(arguments.period-1),daysinmonth(createdate(y,m+(arguments.period-1),1))),"mm/dd/yyyy")>
				<!--- POPULATE ARRAY --->
				<cfset theArray[theArrayCount][1]=therepstartdate>
    			<cfset theArray[theArrayCount][2]=therependdate>
				<cfset theArrayCount = theArrayCount + 1>
			</cfloop>
		</cfloop>
		<cfreturn theArray>
	</cffunction>






</cfcomponent>
