<cfcomponent name="proposalService" output="false">

	<!--- Dependencies --->
	<cfproperty name="ProposalGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityService" inject="model" scope="instance" />
	<cfproperty name="Activity" inject="model" scope="instance" />
	<cfproperty name="CategoryGateway" inject="model" scope="instance" />
	<cfproperty name="ObjectCategoryService" inject="model" scope="instance" />
	<cfproperty name="ActivityStatusLogService" inject="model" scope="instance" />
	<cfproperty name="ActivityLegalRecommendationGateway" inject="model" scope="instance" />


	<cffunction name="init" access="public" output="false" returntype="ProposalService">
		<cfreturn this />
	</cffunction>

	<!--- ---------------------------------------- LOOK UP ---------------------------------------- --->

	<cffunction name="getRegionCountry" access="public" output="false" returntype="Query">
		<cfset var qregCtry = instance.ProposalGateway.getRegionCountryByAttributesQuery() />

		<cfreturn qregCtry />
	</cffunction>

	<cffunction name="getActivityCountryRegions" access="public" output="false" returntype="Query">
		<cfargument name="ActivityID" type="numeric" required="true" />

		<cfset var qregCtry = instance.ProposalGateway.getActivityCountryRegionsQuery(argumentCollection=arguments) />

		<cfreturn qregCtry />
	</cffunction>

	<cffunction name="getActivityCountryRSIRegions" access="public" output="false" returntype="Query">
		<cfargument name="ActivityID" type="numeric" required="true" />

		<cfset var qregCtry = instance.ProposalGateway.getActivityCountryRSIRegionsQuery(argumentCollection=arguments) />

		<cfreturn qregCtry />
	</cffunction>

	<cffunction name="getRegions" access="public" output="false" returntype="Query">
	    <cfset var region = instance.categoryGateway.getByAttributesQuery(Name="Region") />
	    <cfset var qregion= instance.categoryGateway.getByAttributesQuery(parentid=region.categoryID,orderby="name") />

		<cfreturn qregion />
	</cffunction>

	<cffunction name="getStateRegions" access="public" output="false" returntype="Query">
	    <cfset var region = instance.categoryGateway.getByAttributesQuery(Name="State Region") />
	    <cfset var qregion= instance.categoryGateway.getByAttributesQuery(parentid=region.categoryID,orderby="name") />

		<cfreturn qregion />
	</cffunction>

	<cffunction name="getCTEOrganizations" access="public" output="false" returntype="Query">
	    <cfset var organization = instance.categoryGateway.getByAttributesQuery(Name="CTE Organization") />
	    <cfset var qorganization= instance.categoryGateway.getByAttributesQuery(parentid=organization.categoryID,orderby="name") />

		<cfreturn qorganization />
	</cffunction>

	<cffunction name="getCTFPartners" access="public" output="false" returntype="Query">
	    <cfset var organization = instance.categoryGateway.getByAttributesQuery(Name="CTF Partner") />
	    <cfset var qorganization= instance.categoryGateway.getByAttributesQuery(parentid=organization.categoryID,orderby="name") />

		<cfreturn qorganization />
	</cffunction>

	<cffunction name="getCTFUmbrellas" access="public" output="false" returntype="Query">
	    <cfset var qorganization= instance.categoryGateway.getCTFUmbrellas() />

		<cfreturn qorganization />
	</cffunction>

	<cffunction name="getFundMechTypes" access="public" output="false" returntype="Query">
	    <cfset var FundMech = instance.categoryGateway.getByAttributesQuery(Name="Funding Mechanism Type") />
	    <cfset var qFundMechs = instance.categoryGateway.getByAttributesQuery(parentid=FundMech.categoryID,orderby="name") />

		<cfreturn qFundMechs />
	</cffunction>

	<cffunction name="getSCTAccounts" access="public" output="false" returntype="Query">
	    <cfset var sctAccounts = instance.categoryGateway.getByAttributesQuery(Name="SCT Accounts") />
	    <cfset var qsctAccounts = instance.categoryGateway.getByAttributesQuery(parentid=sctAccounts.categoryID,orderby="name") />

		<cfreturn qsctAccounts />
	</cffunction>

	<cffunction name="getThemes" access="public" output="false" returntype="Query">
	    <cfset var sctAccounts = instance.categoryGateway.getByAttributesQuery(Name="Theme") />
	    <cfset var qsctAccounts = instance.categoryGateway.getByAttributesQuery(parentid=sctAccounts.categoryID,orderby="name") />

		<cfreturn qsctAccounts />
	</cffunction>

	<cffunction name="getCnActivities" access="public" output="false" returntype="Query">
		<cfargument name="cnID" type="numeric" required="true" />

		<cfset var qregCtry = instance.ProposalGateway.getCnActivities(argumentCollection=arguments) />

		<cfreturn qregCtry />
	</cffunction>

	<cffunction name="getAvailableFundingSources" access="public" output="false" returntype="Query">
		<cfargument name="activityID" type="numeric" required="true">

	    <cfset var qallFundingSource = getSCTAccounts() />
	    <cfset var qprjFundingSource = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityFundingSource",ObjectID=arguments.ActivityID) />
	    <cfset var lstFundingSource = IIF(qprjFundingSource.recordCount EQ 0,DE("0"),DE("#valueList(qprjFundingSource.categoryID,',')#")) />

	    <cfquery name="qavailableFundingSources" dbtype="query">
		    SELECT CategoryID,Name
		      FROM qallFundingSource
		     WHERE CategoryID NOT IN (#lstFundingSource#)
		</cfquery>

		<cfreturn qavailableFundingSources  />
	</cffunction>

	<cffunction name="getAvailableRegions" access="public" output="false" returntype="Query">
		<cfargument name="activityID" type="numeric" required="true">

	    <cfset var qallregions = getRegions() />
	    <cfset var qprjRegions = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=arguments.ActivityID) />
	    <cfset var lstRegion = IIF(qprjRegions.recordCount EQ 0,DE("0"),DE("#valueList(qprjRegions.categoryID,',')#")) />

	    <cfquery name="qavailableRegions" dbtype="query">
		    SELECT CategoryID,Name
		      FROM qallregions
		     WHERE CategoryID NOT IN (#lstRegion#)
		</cfquery>

		<cfreturn qavailableRegions  />
	</cffunction>

	<cffunction name="getAvailableCountries" access="public" output="false" returntype="Query">
		<cfargument name="activityID" type="numeric" required="true">

	    <cfset var qallCountries = getRegionCountry() />
	    <cfset var qprjCountries = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityPlace",ObjectID=arguments.ActivityID) />
	    <cfset var lstCountry = IIF(qprjCountries.recordCount EQ 0,DE("0"),DE("#valueList(qprjCountries.categoryID,',')#")) />

	    <cfquery name="qavailableCountries" dbtype="query">
		    SELECT CategoryID,Name
		      FROM qallCountries
		     WHERE CategoryID NOT IN (#lstCountry#)
		</cfquery>

		<cfreturn qavailableCountries  />
	</cffunction>

	<cffunction name="getUserEditable" access="public" output="false" returntype="string">
		<cfargument name="SysUserID" type="numeric" required="false" />

		<cfreturn instance.ProposalGateway.getUserEditable(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getAvailableOrganizations" access="public" output="false" returntype="Query">
		<cfargument name="activityID" type="numeric" required="true">

	    <cfset var qallorganizations = getCTEOrganizations() />
	    <cfset var qprjOrganizations = instance.ObjectCategoryService.getObjectCategorysQuery(ClassName="ActivityOrganization",ObjectID=arguments.ActivityID) />
	    <cfset var lstOrganization = IIF(qprjOrganizations.recordCount EQ 0,DE("0"),DE("#valueList(qprjOrganizations.categoryID,',')#")) />

	    <cfquery name="qavailableOrganizations" dbtype="query">
		    SELECT CategoryID,Name
		      FROM qallorganizations
		     WHERE CategoryID NOT IN (#lstOrganization#)
		</cfquery>

		<cfreturn qavailableOrganizations  />
	</cffunction>

	<cffunction name="getMatrix" access="public" output="false" returntype="Query">
		<cfargument name="programID" type="string" required="false">

		<cfset var theMatrix =  instance.ProposalGateway.getReportSummary(programID=arguments.programID) />

		<cfreturn theMatrix />
	</cffunction>

	<cffunction name="getManagerReport" access="public" output="false" returntype="Query">
		<cfargument name="programID" type="string" required="false">
		<cfargument name="countryID" type="string" required="false">
		<cfargument name="regionID" type="string" required="false">
		<cfargument name="stateregionID" type="string" required="false">
		<cfargument name="fundingsourceID" type="string" required="false">
		<cfargument name="statusID" type="string" required="false">
		<cfargument name="reprogramFunds" type="string" required="false">
		<cfargument name="fy" type="string" required="false">

		<cfset var manageRpt =  instance.ProposalGateway.getManagerReport(argumentCollection=arguments) />
		<!--- <cfset var manageRpt =  instance.ProposalGateway.getReportSummary() /> --->

		<cfreturn manageRpt />
	</cffunction>

	<cffunction name="userEmails" access="public" output="false" returntype="struct">
		<cfargument name="programID" type="string" required="false" default="">
		<cfargument name="activityID" type="string" required="false" default="">

		<cfset var qemails = instance.ProposalGateway.getUserEmail(programID=arguments.programID,ActivityID=arguments.activityID) />

		<cfscript>
			//the struct to return
			var stReturn = structnew();
			//the lists to hold emails for all userroles
			var lstSubmitter = "";
			var lstReviewer = "";
			var lstLegal = "";
			var lstBudget = "";
			var lstF = "";
			var lstH = "";
			var lstSP = "";
			var lstFO = "";

			//loop over the cols and build the struct from the query row
			for(i=1;i<=qemails.recordcount;i++){
				//submitter
				if( len(trim(qemails.programID[i])) AND (qemails.roleName[i] == "submitter" OR qemails.roleName[i] == "submitter/program") ) {
					lstSubmitter = listAppend(lstSubmitter,qemails.email[i]);
					if (qemails.roleName[i] == "submitter/program") {
						lstReviewer = listAppend(lstReviewer,qemails.email[i]);
					}
				}
				else if ( qemails.roleName[i] == "Program" OR qemails.roleName[i] == "Program Review" OR qemails.roleName[i] == "submitter/program" ) {
					lstReviewer = listAppend(lstReviewer,qemails.email[i]);
					if (qemails.roleName[i] == "submitter/program") {
						lstSubmitter = listAppend(lstSubmitter,qemails.email[i]);
					}
				}
				else if ( qemails.roleName[i] == "legal" ) {
					lstLegal = listAppend(lstLegal,qemails.email[i]);
				}
				else if ( qemails.roleName[i] == "budget" ) {
					lstBudget = listAppend(lstBudget,qemails.email[i]);
				}
				else if ( qemails.roleName[i] == "F Clearance" ) {
					lstF = listAppend(lstF,qemails.email[i]);
				}
				else if ( qemails.roleName[i] == "H Clearance" ) {
					lstH = listAppend(lstH,qemails.email[i]);
				}
				else if ( qemails.roleName[i] == "S/P Clearance" ) {
					lstSP = listAppend(lstSP,qemails.email[i]);
				}
				else if ( qemails.roleName[i] == "FO Clearance" ) {
					lstFO = listAppend(lstFO,qemails.email[i]);
				}
			}

			//build email struct
			stReturn.submitterEmails = lstSubmitter;
			stReturn.reviewerEmails = lstReviewer;
			stReturn.legalEmails = lstLegal;
			stReturn.budgetEmails = lstBudget;
			stReturn.fEmails = lstF;
			stReturn.hEmails = lstH;
			stReturn.spEmails = lstSP;
			stReturn.foEmails = lstFO;

			//return the struct
			return stReturn;
		</cfscript>

	</cffunction>

	<!--- ---------------------------------------- UTILITY  --------------------------------------- --->

	<cffunction name="getElementIndexList" access="public" output="false" returntype="string">
		<cfargument name="name" type="string" required="false">
		<cfargument name="fieldNames" type="string" required="false">
		<cfargument name="delimiter" type="string" required="false">

		<cfset var tokenList = "">
		<cfif listLen(trim(arguments.fieldNames),",")>
			<cfloop list="#arguments.fieldNames#" index="curIndex" delimiters=",">
				<cfif curIndex CONTAINS arguments.name>
					<cfset cur = getToken(curIndex,2,"#arguments.delimiter#")>
					<cfif NOT listFind(tokenList,cur,',')>
						<cfset tokenList = listAppend(tokenList,cur,',')>
					</cfif>
				</cfif>
			</cfloop>
		</cfif>

		<cfreturn tokenList />
	</cffunction>


</cfcomponent>