<cfcomponent name="Report" output="false" extends="coldbox.system.EventHandler" autowire="true">

	<!--- Inject Dependencies --->
	<cfproperty name="ProgramGateway" inject="model" scope="instance">
	<cfproperty name="ResultsFrameworkElementGateway" inject="model" scope="instance">
	<cfproperty name="ProposalGateway" inject="model" scope="instance">
	<cfproperty name="ProposalService" inject="model" scope="instance">
	<cfproperty name="ActivityStatusGateway" inject="model" scope="instance">
	<cfproperty name="ActivityStatusService" inject="model" scope="instance">
	<cfproperty name="ProgramService" inject="model" scope="instance">
	<cfproperty name="ReportService" inject="model" scope="instance">
	<cfproperty name="Report" inject="model" scope="instance">
	<cfproperty name="activityService" inject="model" scope="instance">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<!--- ************************************************************* --->
	<cffunction name="onRequestStart" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">

		<cfscript>
			var rc = Event.getCollection();

			//Set xeh's
			rc.xehLogout = "General.doLogout";
			rc.xehHome = "General.Home";
			rc.xehSearchOrg = "Report.searchResults";
		</cfscript>
	</cffunction>

	<!------------------------------------------- PUBLIC EVENTS --------------------------------------->

<!---  HOME/INDEX --->

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfset rc.programs = instance.ProgramService.getProgramsQuery() />
		<cfset rc.countries = instance.ProposalService.getRegionCountry() />
		<cfset rc.regions = instance.ProposalService.getRegions() />
		<cfset rc.stateregions = instance.ProposalService.getStateRegions() />
		<cfset rc.FundingSources = instance.ProposalService.getSCTAccounts() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfset rc.Organizations = instance.ProposalService.getCTEOrganizations() />
		<cfset rc.FundingMechs = instance.ProposalService.getFundMechTypes() />
		<cfset rc.themes = instance.ProposalService.getThemes() />
		<cfset rc.Implementers = instance.ProposalService.getCTFPartners() />
		<cfparam name="rc.charttype" default="bar">

		<cfparam name="rc.programID" default="0">
		<cfparam name="rc.countryID" default="0">
		<cfparam name="rc.rsiregionID" default="0">
		<cfparam name="rc.orgID" default="0">
		<cfparam name="rc.stateregionID" default="0">
		<cfparam name="rc.FundingSourceID" default="0">
		<cfparam name="rc.ThemeID" default="0">
		<cfparam name="rc.FundingMechID" default="0">
		<cfparam name="rc.ImplementerID" default="0">
		<cfparam name="rc.StatusID" default="0">
		<cfparam name="rc.reprogramFunds" default="">
		<cfparam name="rc.ctex" default="0">
		<cfparam name="rc.keyword" default="">
		<cfparam name="rc.fy" default="0">
		<cfparam name="rc.columns" default="0">
		<cfparam name="rc.impstatus" default="">

		<cfset var programID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />

		<cfif (structKeyExists(rc,"exportBudget") and len(rc.exportBudget))>
			<cfset var rc.summary = instance.proposalGateway.getManagerReportBudget(programID=rc.programID,countryID=rc.countryID,regionID=rc.rsiregionID,stateregionID=rc.stateregionID,fundingsourceID=rc.fundingsourceID,themeID=rc.themeID,statusID=rc.statusID,reprogramFunds=rc.reprogramFunds,fy=rc.fy,keyword=rc.keyword,orgid=rc.orgid,impstatus=rc.impstatus,fundingmechid=rc.fundingmechid,implementerid=rc.implementerid,ctex=rc.ctex) />
			<cfset var rc.programchart = instance.proposalGateway.getFilteredProgramSums(programID=rc.programID,countryID=rc.countryID,regionID=rc.rsiregionID,stateregionID=rc.stateregionID,fundingsourceID=rc.fundingsourceID,statusID=rc.statusID,reprogramFunds=rc.reprogramFunds,fy=rc.fy,keyword=rc.keyword,orgid=rc.orgid,impstatus=rc.impstatus,fundingmechid=rc.fundingmechid,implementerid=rc.implementerid) />

			<!--- Create new spreadsheet --->
		    <cfset mngrRpt = spreadsheetNew()>

		    <!--- Create Sheet header row --->
		    <cfset SpreadsheetAddRow(mngrRpt, "Database ID, Activity Number, Activity Name, Fiscal Year, Program, Budget Requested, Total Obligated, Budget Item Country, Implementer, Organization, Budget Item Description, Budget Item Amount, State Region, RSI Region, Start Date, End Date, Program Audience, AMCN Number, Funding Mechanism, Description, Objective, Interest Specification, Law Enforcement Specification, Coordination Specification, Proposal Submit Date, Proposal Approved Date, Cleared Prelegal Date, AMCN Budget Submit Date, AMCN Congress Submit Date, AMCN Approved Date, Funding Approved Date, Budget Funding Requested Date, Budget Funding Approval Date, Reprogram Funds (1 = true), Activity Status ID")>
	        <!--- format row header 1 --->
	        <cfset formatmngrRpt = structnew()>
	        <cfset formatmngrRpt.bold = "true">
	        <cfset formatmngrRpt.alignment = "center">
	        <cfset formatmngrRpt.textwrap = "true">
	        <cfset formatmngrRpt.color = "dark_blue">
	        <cfset formatmngrRpt.fgcolor="pale_blue">
	        <cfset SpreadsheetFormatRow(mngrRpt,formatmngrRpt,1)>

	        <!--- Add remaining rows from query --->
	        <cfset SpreadsheetAddRows(mngrRpt, rc.summary) />


	        <!--- Save spreadsheet --->
	        <cflock name="managerRpt" timeout="20" type="exclusive">
	            <!--- <cfset spreadsheetWrite(mngrRpt,filename,true)> --->
	            <cfspreadsheet action="write"
	                name="mngrRpt"
	                filename="#GetTempDirectory()#sct_report.xls"
	                overwrite="true" />

	        </cflock>

	        <cfset event.setView("Reports/export2xls",false) />

		<cfelseif  (structKeyExists(rc,"exportObligated") and len(rc.exportObligated))>
			<cfset var rc.summary = instance.proposalGateway.getManagerReport(programID=rc.programID,countryID=rc.countryID,regionID=rc.rsiregionID,stateregionID=rc.stateregionID,fundingsourceID=rc.fundingsourceID,themeID=rc.themeID,statusID=rc.statusID,reprogramFunds=rc.reprogramFunds,fy=rc.fy,keyword=rc.keyword,orgid=rc.orgid,impstatus=rc.impstatus,fundingmechid=rc.fundingmechid,implementerid=rc.implementerid,ctex=rc.ctex) />
			<cfset var qSummary = rc.summary>
			<cfset qcolumns = "ProposalNumber, projectTitle, fundingSources, amcnnumber, fiscalyear, projectAmount, statusname">
			<cfset columnTitles = "Proposal Number, Project Title, Funding Source, CN Number, Fiscal Year, Requested Amount, Status">
				<cfif listfind(rc.columns,"Countries")>
					<cfset qcolumns = qcolumns & ", Country">
					<cfset columnTitles = columnTitles & ", Countries">
				</cfif>
				<cfif listfind(rc.columns,"Regions")>
					<cfset qcolumns = qcolumns & ", region">
					<cfset columnTitles = columnTitles & ", Regions">
				</cfif>
				<cfif listfind(rc.columns,"Implementing Orgs")>
					<cfset qcolumns = qcolumns & ", implementingOrgs">
					<cfset columnTitles = columnTitles & ", Implementing Orgs">
				</cfif>
				<cfif listfind(rc.columns,"Implementing Partners")>
					<cfset qcolumns = qcolumns & ", implementingPartners">
					<cfset columnTitles = columnTitles & ", Implementing Partners">
					<cfset qcolumns = qcolumns & ", partnerDetails">
					<cfset columnTitles = columnTitles & ", Partner Details">
				</cfif>
				<cfif listfind(rc.columns,"Total Obligated")>
					<cfset qcolumns = qcolumns & ", totObAmount">
					<cfset columnTitles = columnTitles & ", Total Obligated">
				</cfif>
				<cfif listfind(rc.columns,"Obligation Numbers")>
					<cfset qcolumns = qcolumns & ", obligationNumbers">
					<cfset columnTitles = columnTitles & ", Obligation Numbers">
				</cfif>
				<cfif listfind(rc.columns,"AMCN Approved Date")>
					<cfset qcolumns = qcolumns & ", AMCNApprovedDate">
					<cfset columnTitles = columnTitles & ", AMCN Approved Date">
				</cfif>
				<cfif listfind(rc.columns,"Budget Funding Approved Date")>
					<cfset qcolumns = qcolumns & ", budgetfundapprovaldate">
					<cfset columnTitles = columnTitles & ", Budget Funding Approved Date">
				</cfif>
				<cfif listfind(rc.columns,"Description")>
					<cfset qcolumns = qcolumns & ", description">
					<cfset columnTitles = columnTitles & ", Description">
				</cfif>
				<cfif listfind(rc.columns,"Cleared Prelegal Date")>
					<cfset qcolumns = qcolumns & ", clearedprelegaldate">
					<cfset columnTitles = columnTitles & ", Cleared Prelegal Date">
				</cfif>
				<cfif listfind(rc.columns,"Approved Date")>
					<cfset qcolumns = qcolumns & ", proposalapproveddate">
					<cfset columnTitles = columnTitles & ", Approved Date">
				</cfif>
				<cfif listfind(rc.columns,"AMCN Budget Submit Date")>
					<cfset qcolumns = qcolumns & ", amcnbudgetsubmitdate">
					<cfset columnTitles = columnTitles & ", AMCN Budget Submit Date">
				</cfif>
				<cfif listfind(rc.columns,"AMCN Congress Submit Date")>
					<cfset qcolumns = qcolumns & ", amcncongresssubmitdate">
					<cfset columnTitles = columnTitles & ", AMCN Congress Submit Date">
				</cfif>
				<cfif listfind(rc.columns,"Funding Mechanism")>
					<cfset qcolumns = qcolumns & ", implementmethod">
					<cfset columnTitles = columnTitles & ", Funding Mechanism">
				</cfif>
				<cfif listfind(rc.columns,"Program Audience")>
					<cfset qcolumns = qcolumns & ", programAudience">
					<cfset columnTitles = columnTitles & ", Program Audience">
				</cfif>
				<cfif listfind(rc.columns,"Period of Performance")>
					<cfset qcolumns = qcolumns & ", startDate">
					<cfset qcolumns = qcolumns & ", endDate">
					<cfset columnTitles = columnTitles & ", Start Date">
					<cfset columnTitles = columnTitles & ", End Date">
				</cfif>
				<cfif listfind(rc.columns,"Project Purpose")>
					<cfset qcolumns = qcolumns & ", projectObjective">
					<cfset columnTitles = columnTitles & ", Project Purpose">
				</cfif>
				<cfif listfind(rc.columns,"Implementation Status")>
					<cfset qcolumns = qcolumns & ", implementationStatus">
					<cfset columnTitles = columnTitles & ", Implementation Status">
				</cfif>
				<cfif listfind(rc.columns,"Results Framework")>
					<cfset qcolumns = qcolumns & ", primaryResult">
					<cfset columnTitles = columnTitles & ", Primary Result">
					<cfset qcolumns = qcolumns & ", secondaryResults">
					<cfset columnTitles = columnTitles & ", Secondary Results">
				</cfif>
			<cfset qcolumns = qcolumns & ", activityid">
			<cfset columnTitles = columnTitles & ", Database ID">
			<cfset var qreport = querynew(qcolumns) />

		   	<cfloop query="qsummary">
				<cfset QueryAddRow(qreport) />
				<cfset QuerySetCell(qreport,"proposalnumber",qSummary.proposalnumber) />
				<cfset QuerySetCell(qreport,"projectTitle",qSummary.projectTitle) />
				<cfset QuerySetCell(qreport,"fundingSources",qSummary.fundingSources) />
				<cfset QuerySetCell(qreport,"amcnnumber","#qSummary.cnnumbers# ") />
				<cfset QuerySetCell(qreport,"fiscalyear",qSummary.fiscalyear) />
				<cfset QuerySetCell(qreport,"projectAmount",qSummary.projectAmount) />
				<cfif qSummary.ctex is 1>
					<cfset QuerySetCell(qreport,"statusname","Archived - Inactive") />
				<cfelse>
					<cfset QuerySetCell(qreport,"statusname",qSummary.statusname) />
				</cfif>
				<cfif listfind(rc.columns,"Countries")>
					<cfset QuerySetCell(qreport,"Country",qSummary.Country) />
				</cfif>
				<cfif listfind(rc.columns,"Regions")>
					<cfset QuerySetCell(qreport,"region",qSummary.region) />
				</cfif>
				<cfif listfind(rc.columns,"Implementing Orgs")>
					<cfset QuerySetCell(qreport,"implementingOrgs",qSummary.implementingOrgs) />
				</cfif>
				<cfif listfind(rc.columns,"Implementing Partners")>
					<cfset QuerySetCell(qreport,"implementingPartners",qSummary.ctfpartner) />
					<cfset QuerySetCell(qreport,"partnerDetails",qSummary.implementingPartners) />
				</cfif>
				<cfif listfind(rc.columns,"Total Obligated")>
					<cfset QuerySetCell(qreport,"totObAmount",qSummary.totObAmount) />
				</cfif>
				<cfif listfind(rc.columns,"Obligation Numbers")>
					<cfset QuerySetCell(qreport,"obligationNumbers",qSummary.obligationnumbers) />
				</cfif>
				<cfif listfind(rc.columns,"AMCN Approved Date")>
					<cfset QuerySetCell(qreport,"AMCNApprovedDate",dateformat(qSummary.AMCNApprovedDate, "mm/dd/yyyy")) />
				</cfif>
				<cfif listfind(rc.columns,"Budget Funding Approved Date")>
					<cfset QuerySetCell(qreport,"budgetfundapprovaldate",dateformat(qSummary.budgetfundapprovaldate, "mm/dd/yyyy")) />
				</cfif>
				<cfif listfind(rc.columns,"Description")>
					<cfset QuerySetCell(qreport,"description",qSummary.description) />
				</cfif>
				<cfif listfind(rc.columns,"Cleared Prelegal Date")>
					<cfset QuerySetCell(qreport,"clearedprelegaldate",dateformat(qSummary.clearedprelegaldate, "mm/dd/yyyy")) />
				</cfif>
				<cfif listfind(rc.columns,"Approved Date")>
					<cfset QuerySetCell(qreport,"proposalapproveddate",dateformat(qSummary.proposalapproveddate, "mm/dd/yyyy")) />
				</cfif>
				<cfif listfind(rc.columns,"AMCN Budget Submit Date")>
					<cfset QuerySetCell(qreport,"amcnbudgetsubmitdate",dateformat(qSummary.amcnbudgetsubmitdate, "mm/dd/yyyy")) />
				</cfif>
				<cfif listfind(rc.columns,"AMCN Congress Submit Date")>
					<cfset QuerySetCell(qreport,"amcncongresssubmitdate",dateformat(qSummary.amcncongresssubmitdate, "mm/dd/yyyy")) />
				</cfif>
				<cfif listfind(rc.columns,"Funding Mechanism")>
					<cfset QuerySetCell(qreport,"implementmethod",qSummary.implementmethod) />
				</cfif>
				<cfif listfind(rc.columns,"Program Audience")>
					<cfset QuerySetCell(qreport,"programAudience",qSummary.programAudience) />
				</cfif>
				<cfif listfind(rc.columns,"Period of Performance")>
					<cfset QuerySetCell(qreport,"startDate",dateformat(qSummary.startDate, "mm/dd/yyyy")) />
					<cfset QuerySetCell(qreport,"endDate",dateformat(qSummary.endDate, "mm/dd/yyyy")) />
				</cfif>
				<cfif listfind(rc.columns,"Project Purpose")>
					<cfset QuerySetCell(qreport,"projectObjective",qSummary.projectObjective) />
				</cfif>
				<cfif listfind(rc.columns,"Implementation Status")>
					<cfset QuerySetCell(qreport,"implementationStatus",qSummary.implementationStatus) />
				</cfif>
				<cfif listfind(rc.columns,"Results Framework")>
					<cfset QuerySetCell(qreport,"primaryResult",qSummary.primaryResult) />
					<cfset QuerySetCell(qreport,"secondaryResults",qSummary.secondaryResults) />
				</cfif>

				<cfset QuerySetCell(qreport,"activityid",qSummary.activityid) />


			</cfloop>
			<!--- Create new spreadsheet --->
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
		<cfelseif  (structKeyExists(rc,"submit") and len(rc.submit))>
			<cfset rc.summary = instance.proposalGateway.getManagerReport(programID=rc.programID,themeID=rc.themeID,countryID=rc.countryID,regionID=rc.rsiregionID,stateregionID=rc.stateregionID,fundingsourceID=rc.fundingsourceID,statusID=rc.statusID,reprogramFunds=rc.reprogramFunds,fy=rc.fy,keyword=rc.keyword,orgid=rc.orgid,impstatus=rc.impstatus,fundingmechid=rc.fundingmechid,implementerid=rc.implementerid,ctex=rc.ctex) />
			<cfset rc.PageTitle = "CT Programs" />
			<cfset event.setView("Reports/index") />
		<cfelseif  (structKeyExists(rc,"submitextended") and len(rc.submitextended)) >
			<cfset rc.summary = instance.proposalGateway.getManagerReport(programID=rc.programID,themeID=rc.themeID,countryID=rc.countryID,regionID=rc.rsiregionID,stateregionID=rc.stateregionID,fundingsourceID=rc.fundingsourceID,statusID=rc.statusID,reprogramFunds=rc.reprogramFunds,fy=rc.fy,keyword=rc.keyword,orgid=rc.orgid,impstatus=rc.impstatus,fundingmechid=rc.fundingmechid,implementerid=rc.implementerid) />
			<cfset rc.PageTitle = "CT Programs" />
			<cfset event.setLayout("Layout.CleanNoWidth") />
			<cfset event.setView("Reports/filteredreport") />
		<cfelse>
			<cfset rc.PageTitle = "CT Programs" />
			<cfset event.setView("Reports/index") />
		</cfif>


	</cffunction>

<!--- CHARTS --->

	<cffunction name="filteredchartbyprogram" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.charttype" default="bar">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">



		<cfset rc.countries = instance.ProposalService.getRegionCountry() />
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfset rc.themes = instance.ProposalService.getThemes() />

		<cfset event.setView("Reports/charts/filteredchart") />
	</cffunction>

	<cffunction name="filteredchartbyregion" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.charttype" default="bar">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">

		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfset rc.themes = instance.ProposalService.getThemes() />

		<cfset event.setView("Reports/charts/filteredchartbyregion") />
	</cffunction>

	<cffunction name="filteredchartbycountry" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.charttype" default="bar">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">

		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfset rc.themes = instance.ProposalService.getThemes() />

		<cfset event.setView("Reports/charts/filteredchartbycountry") />
	</cffunction>

	<cffunction name="filteredchartbyorg" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.charttype" default="bar">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">

		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfset rc.themes = instance.ProposalService.getThemes() />

		<cfset event.setView("Reports/charts/filteredchartbyorg") />
	</cffunction>

	<cffunction name="filteredchartbyimplementer" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.charttype" default="bar">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">

		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfset rc.themes = instance.ProposalService.getThemes() />

		<cfset event.setView("Reports/charts/filteredchartbyimplementer") />
	</cffunction>

	<cffunction name="filteredchartxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.implementer" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">
		<cfset rc.sums =  instance.proposalGateway.getProgramSums(fy=rc.fy,region=rc.region,countryname=rc.countryname,programname=rc.programname,statusID=rc.statusID,themeID=rc.themeID,implementer=rc.implementer) />

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.countryname is not "">
			<cfset countrycaption = #rc.countryname#>
		<cfelse>
			<cfset countrycaption = "All">
		</cfif>
		<cfif rc.region is not "">
			<cfset regioncaption = #rc.region#>
		<cfelse>
			<cfset regioncaption = "All">
		</cfif>

		<cfset thecaption = "Total Amount Requested, by Program (FY: " & fycaption & "; Country: " & countrycaption & "; Region: " & regioncaption & ")">

		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Program">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.caption = "#thecaption#">
		<!--- <cfset ChartData.xmlRoot.XmlAttributes.paletteColors = "052558,02335b,d4d5d7,8e0010,4a4a4a,9d545c"> --->
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#program#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<!--- <cfif len(rc.countryname)>
				<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/fundsbycountrylist?fy=#rc.fy#&programname=#program#&countryname=#rc.countryname#&region=#rc.region#&origin=programchart&statusID=#rc.statusID#')#">
			<cfelse>
				<cfif len(rc.region)>
					<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/filteredchartbycountry?fy=#rc.fy#&program=#program#&region=#rc.region#')#">
				<cfelse>
					<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/filteredchartbyregion?fy=#rc.fy#&program=#program#')#">
				</cfif>
			</cfif> --->
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/fundsbyprogramlist?program=#program#&region=#rc.region#&countryname=#rc.countryname#&fy=#rc.fy#')#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredorgchartxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.organization" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.StatusID" default="">
		<cfset rc.sums =  instance.proposalGateway.getProgramOrgSums(fy=rc.fy,organization=rc.organization,program=rc.program,statusID=rc.statusID) />

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.organization is not "">
			<cfset orgcaption = #rc.organization#>
		<cfelse>
			<cfset orgcaption = "All">
		</cfif>

		<cfset thecaption = "Total Amount Requested, by Program (FY: " & fycaption & "; Organization: " & orgcaption &  ")">

		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Program">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.caption = "#thecaption#">
		<!--- <cfset ChartData.xmlRoot.XmlAttributes.paletteColors = "052558,02335b,d4d5d7,8e0010,4a4a4a,9d545c"> --->
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#program#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredexpenditurechartxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.implementer" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.StatusID" default="">
		<cfset rc.sums =  instance.proposalGateway.getFYSums(implementer=rc.implementer,fy=rc.fy,region=rc.region,countryname=rc.countryname,programname=rc.programname,statusID=rc.statusID) />


		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Fiscal Year">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<!--- <cfset ChartData.xmlRoot.XmlAttributes.paletteColors = "052558,02335b,d4d5d7,8e0010,4a4a4a,9d545c"> --->
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfif fy is "">
				<cfset thefy = "Not yet attributed">
			<cfelse>
				<cfset thefy = "#fy#">
			</cfif>
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#thefy#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredorgexpenditurechartxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.organization" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.StatusID" default="">
		<cfset rc.sums =  instance.proposalGateway.getFYOrgSums(fy=rc.fy,organization=rc.organization,program=rc.program,statusID=rc.statusID) />


		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Fiscal Year">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<!--- <cfset ChartData.xmlRoot.XmlAttributes.paletteColors = "052558,02335b,d4d5d7,8e0010,4a4a4a,9d545c"> --->
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfif fy is "">
				<cfset thefy = "Not yet attributed">
			<cfelse>
				<cfset thefy = "#fy#">
			</cfif>
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#thefy#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredchartbyregionxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">
		<cfset rc.sums =  instance.proposalGateway.getRegionSums(countryname=rc.countryname,themeID=rc.themeID,region=rc.region,fy=rc.fy,program=rc.program,statusID=rc.statusID) />

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.program is not "">
			<cfset programcaption = #rc.program#>
		<cfelse>
			<cfset programcaption = "All">
		</cfif>

		<cfset thecaption = "Total Amount Requested, by Region (FY: " & fycaption & "; Program: " & programcaption & ")">

		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Region">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.caption = "#thecaption#">
		<!--- <cfset ChartData.xmlRoot.XmlAttributes.paletteColors = "052558,02335b,d4d5d7,8e0010,4a4a4a,9d545c"> --->
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#region#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/fundsbyregionlist?region=#region#&origin=regionchart&fy=#rc.fy#&program=#rc.program#')#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredchartbycountryxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">
		<cfset rc.sums =  instance.proposalGateway.getCountrySums(fy=rc.fy,themeID=rc.themeID,program=rc.program,region=rc.region,statusID=rc.statusID) />

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.program is not "">
			<cfset programcaption = #rc.program#>
		<cfelse>
			<cfset programcaption = "All">
		</cfif>
		<cfif rc.region is not "">
			<cfset regioncaption = #rc.region#>
		<cfelse>
			<cfset regioncaption = "All">
		</cfif>

		<cfset thecaption = "Total Amount Requested, by Country (FY: " & fycaption & "; Program: " & programcaption & "; Region: " & regioncaption & ")">


		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Country">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.showValues = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.caption = "#thecaption#">
		<!--- <cfset ChartData.xmlRoot.XmlAttributes.paletteColors = "052558,02335b,d4d5d7,8e0010,4a4a4a,9d545c"> --->
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#country#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/fundsbycountrylist?countryname=#country#&origin=countrychart&program=#rc.program#&fy=#rc.fy#')#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredchartbyorgxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">
		<cfset rc.sums =  instance.proposalGateway.getOrgSums(fy=rc.fy,program=rc.program,statusID=rc.statusID,themeID=rc.themeID) />

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.program is not "">
			<cfset programcaption = #rc.program#>
		<cfelse>
			<cfset programcaption = "All">
		</cfif>


		<cfset thecaption = "Total Amount Requested, by Organization (FY: " & fycaption & "; Program: " & programcaption &  ")">


		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Organization">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.showValues = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.caption = "#thecaption#">
		<!--- <cfset ChartData.xmlRoot.XmlAttributes.paletteColors = "052558,02335b,d4d5d7,8e0010,4a4a4a,9d545c"> --->
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#organization#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/fundsbyorglist?fy=#rc.fy#&program=#rc.program#&organization=#organization#&origin=orgchart&statusID=#rc.statusID#')#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredchartbyimplementerxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.umbrella" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">
		<cfset rc.sums =  instance.proposalGateway.getImplementerSums(fy=rc.fy,themeID=rc.themeID,program=rc.program,statusID=rc.statusID,region=rc.region,umbrella=rc.umbrella) />

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.program is not "">
			<cfset programcaption = #rc.program#>
		<cfelse>
			<cfset programcaption = "All">
		</cfif>
		<cfif rc.region is not "">
			<cfset regioncaption = #rc.region#>
		<cfelse>
			<cfset regioncaption = "All">
		</cfif>


		<cfset thecaption = "Total Amount Requested, by Implementer (FY: " & fycaption & "; Program: " & programcaption & "; Region: " & regioncaption &  ")">


		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Implementer">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.showValues = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.caption = "#thecaption#">
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#implementer#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/fundsbyimplementerlist?fy=#rc.fy#&program=#rc.program#&region=#rc.region#&implementer=#implementer#&statusID=#rc.statusID#')#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

	<cffunction name="filteredchartbyimpumbrellaxml" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.themeID" default="">
		<cfset rc.sums =  instance.proposalGateway.getImpUmbrellaSums(fy=rc.fy,themeID=rc.themeID,program=rc.program,statusID=rc.statusID,region=rc.region) />

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.program is not "">
			<cfset programcaption = #rc.program#>
		<cfelse>
			<cfset programcaption = "All">
		</cfif>
		<cfif rc.region is not "">
			<cfset regioncaption = #rc.region#>
		<cfelse>
			<cfset regioncaption = "All">
		</cfif>


		<cfset thecaption = "Total Amount Requested, by Implementer Umbrella Organization (FY: " & fycaption & "; Program: " & programcaption & "; Region: " & regioncaption &  ")">


		<cfset ChartData = XmlNew()>
		<cfset ChartData.xmlRoot = XmlElemNew(ChartData,"chart")>
		<cfset ChartData.xmlRoot.XmlAttributes.xaxisname = "Implementer">
		<cfset ChartData.xmlRoot.XmlAttributes.yaxisname = "Amount">
		<cfset ChartData.xmlRoot.XmlAttributes.numdivlines = "5">
		<cfset ChartData.xmlRoot.XmlAttributes.numberPefix = "$">
		<cfset ChartData.xmlRoot.XmlAttributes.showSum = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.showValues = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.caption = "#thecaption#">
		<cfset ChartData.xmlRoot.XmlAttributes.showCanvasBg = "0">
		<cfset ChartData.xmlRoot.XmlAttributes.exportEnabled = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportAtClient = "1">
		<cfset ChartData.xmlRoot.XmlAttributes.exportHandler = "fcExporter1">

		<cfset c1 = 1>

		<cfloop query="rc.sums">
			<cfset ChartData.chart.XmlChildren[#c1#] = XmlElemNew(ChartData,"set")>
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.label = "#implementer#">
    		<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.value = "#totalbudget#">
			<cfset ChartData.chart.XmlChildren[#c1#].XmlAttributes.link = "#event.buildLink('reports/fundsbyimpumbrellalist?fy=#rc.fy#&program=#rc.program#&region=#rc.region#&umbrella=#implementer#&statusID=#rc.statusID#')#">
			<cfset c1 = c1 + 1>
		</cfloop>



		<cfset rc.chartdata = chartdata>
		<cfset event.setLayout("Layout.JsonReadable") />
		<cfset event.setView("Reports/charts/chartxml") />
	</cffunction>

<!--- MAPS --->

	<cffunction name="fundsbycountrymap" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.country" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.themeID" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.ResultsFrameworkElementID" default="">
		<cfparam name="rc.big" default="false">

		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.themes = instance.ProposalService.getThemes() />
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfset rc.bycountry =  instance.proposalGateway.getMapReport(program=rc.program,region=rc.region,fy=rc.fy,statusID=rc.statusID,themeID=rc.themeID) />
		<cfset countrylist =''>
		<cfset jstring=''>
		<cfset jstring=(jstring & '{"type":"FeatureCollection","features":[')>
		<cfloop query="rc.bycountry">
			<cfset jstring=jstring & '{"type":"Feature","id":"' & externalcode>
			<cfset jstring=jstring & '","properties":{"budget":"' & dollarformat(totalBudget)>
			<cfset jstring=jstring & '","budgetplain":' & totalbudget>
			<cfset jstring=jstring & ',"queryparam":"&countryname=' & country>
			<cfset jstring=jstring & '&program=' & rc.program>
			<cfset jstring=jstring & '&fy=' & rc.fy>
			<cfset jstring=jstring & '" , "name":"' & country>
			<cfset jstring=jstring & '"},"geometry":{"type":"' & type>
			<cfset jstring=jstring & '","coordinates":' & coordinates>
			<cfset jstring=jstring & '}}'>
			<cfif rc.bycountry.currentRow lt rc.bycountry.recordcount>
				<cfset jstring=jstring & ','>
			</cfif>
			<cfset countrylist=countrylist & country & ', '>
		</cfloop>
		<cfset jstring=jstring & ']}'>
		<cfset rc.jstring=jstring>
		<cfset rc.countrylist = countrylist>

		<cfset event.setView("Reports/maps/fundsbycountrymap") />


	</cffunction>

	<cffunction name="staffmap" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		<cfset event.setLayout("Layout.CleanNoScripts") />
		<cfset event.setView(name='Reports/maps/staffmap')>
	</cffunction>

<!--- PROFILES --->


	<cffunction name="fundsbycountrylist" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="map">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.country" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.countries = instance.ProposalService.getRegionCountry() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />

		<cfset var rc.bycountry = instance.proposalGateway.getProfile(countryname=rc.countryname,mapid=rc.country,fy=rc.fy,program=rc.program,statusID=rc.statusID) />
		<cfset event.setView("Reports/profiles/fundsbycountrylist") />
	</cffunction>

	<cffunction name="fundsbyorglist" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="orgchart">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.orgID" default="">
		<cfparam name="rc.organization" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.organizations = instance.ProposalService.getCTEOrganizations() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />

		<cfset var rc.bycountry = instance.proposalGateway.getOrgProfile(programname=rc.programname,organization=rc.organization,fy=rc.fy,program=rc.program,statusID=rc.statusID) />

		<cfset event.setView("Reports/profiles/fundsbyorglist") />
	</cffunction>

	<cffunction name="fundsbycountrylistword" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="map">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.country" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.groupfunding" default="">
		<cfparam name="rc.sortby" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.countries = instance.ProposalService.getRegionCountry() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />
		<cfif len(rc.groupfunding)>
			<cfset rc.sortby = "fundstype, program, fy desc, proposalnumber">
		</cfif>

		<cfset var rc.bycountry = instance.proposalGateway.getProfile(programname=rc.programname,countryname=rc.countryname,mapid=rc.country,fy=rc.fy,program=rc.program,statusID=rc.statusID,sortby=rc.sortby) />
		<cfset var rc.sums =  instance.proposalGateway.getProgramSums(fy=rc.fy,region=rc.region,countryname=rc.countryname,programname=rc.program,statusID=rc.statusID) />
		<cfset var rc.fysums =  instance.proposalGateway.getFYSums(fy=rc.fy,region=rc.region,countryname=rc.countryname,programname=rc.program,statusID=rc.statusID) />

		<cfif cgi.SERVER_NAME is 'ctprogramstest.com'>
			<cfset expPath = "C:\inetpub\wwwroot\CT-PAMS\includes\images\generated\">
		<cfelseif cgi.SERVER_NAME is '127.0.0.1'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelse>
			<cfset expPath = "d:\web\pams\includes\images\generated\">
		</cfif>

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.countryname is not "">
			<cfset countrycaption = #rc.countryname#>
		<cfelse>
			<cfset countrycaption = "All">
		</cfif>


		<cfset thecaption = "Total Amount by Program (FY: " & fycaption & "; Country: " & countrycaption  & ")">
		<cfset thefycaption = "Total Amount by FY (Country: " & countrycaption  & ")">
        <cfset rc.imagenamepie = #CreateUUID()#>
		<cfset rc.imagenamebar = #CreateUUID()#>

		<cfchart
				 name="countryPieChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thecaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="pie"
							query="rc.sums"
							valuecolumn="totalbudget"
							itemcolumn="program"
								 colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c"
								 	>
		</cfchart>

		<cfchart
				 name="countryBarChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thefycaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="bar"
							query="rc.fysums"
							valuecolumn="totalbudget"
							itemcolumn="fy"
								 colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c"
								 	>
		</cfchart>


		    <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamebar#.jpg"
		    source = "#countryBarChart#"
		    	overwrite = "yes"
		    >

		     <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamepie#.jpg"
		    source = "#countryPieChart#"
		    	overwrite = "yes"
		    >

		<cfif rc.type is "pdf">
			<cfset event.setView(name='Reports/profiles/fundsbycountrylistpdf',noLayout='true')>
		<cfelse>
			<cfset event.setView(name='Reports/profiles/fundsbycountrylistword',noLayout='true')>
		</cfif>
	</cffunction>

	<cffunction name="fundsbyorglistword" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="orgchart">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.organization" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.orgID" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.sortby" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.organizations = instance.ProposalService.getCTEOrganizations() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />

		<cfset var rc.bycountry = instance.proposalGateway.getOrgProfile(programname=rc.program,organization=rc.organization,fy=rc.fy,program=rc.program,statusID=rc.statusID,sortby=rc.sortby) />

		<cfset rc.sums =  instance.proposalGateway.getProgramOrgSums(fy=rc.fy,organization=rc.organization,program=rc.program,statusID=rc.statusID) />
		<cfset rc.fysums =  instance.proposalGateway.getFYOrgSums(fy=rc.fy,organization=rc.organization,program=rc.program,statusID=rc.statusID) />

		<cfif cgi.SERVER_NAME is 'ctprogramstest.com'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelseif cgi.SERVER_NAME is '127.0.0.1'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelse>
			<cfset expPath = "d:\web\pams\includes\images\generated\">
		</cfif>



		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.organization is not "">
			<cfset orgcaption = #rc.organization#>
		<cfelse>
			<cfset orgcaption = "All">
		</cfif>

		<cfset thecaption = "Total Amount by Program (FY: " & fycaption & "; Organization: " & orgcaption &  ")">


		<cfset thefycaption = "Total Amount by FY (Org: " & orgcaption  & ")">
		<cfset rc.imagenamepie = #CreateUUID()#>
		<cfset rc.imagenamebar = #CreateUUID()#>


		<cfchart
				 name="orgPieChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thecaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="pie"
							query="rc.sums"
							valuecolumn="totalbudget"
							itemcolumn="program"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>

		<cfchart
				 name="orgBarChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thefycaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="bar"
							query="rc.fysums"
							valuecolumn="totalbudget"
							itemcolumn="fy"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>


		    <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamebar#.jpg"
		    source = "#orgBarChart#"
		    	overwrite = "yes"
		    >

		     <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamepie#.jpg"
		    source = "#orgPieChart#"
		    	overwrite = "yes"
		    >


		<cfif rc.type is "pdf">
			<cfset event.setView(name='Reports/profiles/fundsbyorglistpdf',noLayout='true')>
		<cfelse>
			<cfset event.setView(name='Reports/profiles/fundsbyorglistword',noLayout='true')>
		</cfif>
	</cffunction>

	<cffunction name="fundsbyregionlist" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="map">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />

		<cfif len(rc.region)>
			<cfset var rc.byregion = instance.proposalGateway.getProfile(program=rc.program,region=rc.region,fy=rc.fy,statusID=rc.statusID) />
			<cfset event.setView("Reports/profiles/fundsbyregionlist") />
		<cfelse>
			<cfset setNextEvent(event='reports/filteredchartbyregion') />
		</cfif>
	</cffunction>

    <cffunction name="fundsbyprogramlist" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="map">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.countries = instance.ProposalService.getRegionCountry() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />

		<cfif len(rc.program)>
			<cfset var rc.byprogram = instance.proposalGateway.getProfile(program=rc.program,region=rc.region,countryname=rc.countryname,fy=rc.fy,statusID=rc.statusID) />
			<cfset event.setView("Reports/profiles/fundsbyprogramlist") />
		<cfelse>
			<cfset setNextEvent(event='reports/filteredchartbyprogram') />
		</cfif>
	</cffunction>

	<cffunction name="fundsbyimplementerlist" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.implementer" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.Implementers = instance.ProposalService.getCTFPartners() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />


		<cfset var rc.byimplementer = instance.proposalGateway.getProfile(implementer=rc.implementer,program=rc.program,region=rc.region,fy=rc.fy,statusID=rc.statusID) />

		<cfset event.setView("Reports/profiles/fundsbyimplementerlist") />
	</cffunction>

	<cffunction name="fundsbyimpumbrellalist" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.umbrella" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.umbrellas = instance.ProposalService.getCTFUmbrellas() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />


		<cfset var rc.byimplementer = instance.proposalGateway.getProfile(umbrella=rc.umbrella,program=rc.program,region=rc.region,fy=rc.fy,statusID=rc.statusID) />

		<cfset event.setView("Reports/profiles/fundsbyimpumbrellalist") />
	</cffunction>

	<cffunction name="fundsbyregionlistword" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="map">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.sortby" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />

		<cfset var rc.byregion = instance.proposalGateway.getProfile(program=rc.program,region=rc.region,fy=rc.fy,statusID=rc.statusID,sortby=rc.sortby) />

		<cfset var rc.sums =  instance.proposalGateway.getProgramSums(fy=rc.fy,region=rc.region,countryname=rc.countryname,programname=rc.program,statusID=rc.statusID) />
		<cfset var rc.fysums =  instance.proposalGateway.getFYSums(fy=rc.fy,region=rc.region,countryname=rc.countryname,programname=rc.program,statusID=rc.statusID) />

		<cfif cgi.SERVER_NAME is 'ctprogramstest.com'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelseif cgi.SERVER_NAME is '127.0.0.1'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelse>
			<cfset expPath = "d:\web\pams\includes\images\generated\">
		</cfif>

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.region is not "">
			<cfset regioncaption = #rc.region#>
		<cfelse>
			<cfset regioncaption = "All">
		</cfif>


		<cfset thecaption = "Total Amount by Program (FY: " & fycaption & "; Region: " & regioncaption  & ")">
		<cfset thefycaption = "Total Amount by FY (Region: " & regioncaption  & ")">
		<cfset rc.imagenamepie = #CreateUUID()#>
		<cfset rc.imagenamebar = #CreateUUID()#>


		<cfchart
				 name="regionPieChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thecaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="pie"
							query="rc.sums"
							valuecolumn="totalbudget"
							itemcolumn="program"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>

		<cfchart
				 name="regionBarChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thefycaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="bar"
							query="rc.fysums"
							valuecolumn="totalbudget"
							itemcolumn="fy"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>


		    <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamebar#.jpg"
		    source = "#regionBarChart#"
		    	overwrite = "yes"
		    >

		     <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamepie#.jpg"
		    source = "#regionPieChart#"
		    	overwrite = "yes"
		    >




		<cfif rc.type is "pdf">
			<cfset event.setView(name='Reports/profiles/fundsbyregionlistpdf',noLayout='true')>
		<cfelse>
			<cfset event.setView(name='Reports/profiles/fundsbyregionlistword',noLayout='true')>
		</cfif>

	</cffunction>

	<cffunction name="fundsbyprogramlistword" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.origin" default="map">
		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.programname" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.countryname" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.sortby" default="">
		<cfparam name="rc.export" default="false">
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />

		<cfset var rc.byprogram = instance.proposalGateway.getProfile(program=rc.program,region=rc.region,countryname=rc.countryname,fy=rc.fy,statusID=rc.statusID,sortby=rc.sortby) />

		<cfset var rc.sums =  instance.proposalGateway.getRegionSums(fy=rc.fy,programname=rc.program,statusID=rc.statusID,program=rc.program,countryname=rc.countryname,region=rc.region) />
		<cfset var rc.fysums =  instance.proposalGateway.getFYSums(fy=rc.fy,programname=rc.program,statusID=rc.statusID,program=rc.program,countryname=rc.countryname,region=rc.region) />

		<cfif cgi.SERVER_NAME is 'ctprogramstest.com'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelseif cgi.SERVER_NAME is '127.0.0.1'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelse>
			<cfset expPath = "d:\web\pams\includes\images\generated\">
		</cfif>

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.region is not "">
			<cfset regioncaption = #rc.region#>
		<cfelse>
			<cfset regioncaption = "All">
		</cfif>


		<cfset thecaption = "Total Amount by Region (FY: " & fycaption &  ")">
		<cfset thefycaption = "Total Amount by FY">
		<cfset rc.imagenamepie = #CreateUUID()#>
		<cfset rc.imagenamebar = #CreateUUID()#>


		<cfchart
				 name="programPieChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thecaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="pie"
							query="rc.sums"
							valuecolumn="totalbudget"
							itemcolumn="region"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>

		<cfchart
				 name="programBarChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thefycaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="bar"
							query="rc.fysums"
							valuecolumn="totalbudget"
							itemcolumn="fy"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>


		    <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamebar#.jpg"
		    source = "#programBarChart#"
		    	overwrite = "yes"
		    >

		     <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamepie#.jpg"
		    source = "#programPieChart#"
		    	overwrite = "yes"
		    >


		<cfif rc.type is "pdf">
			<cfset event.setView(name='Reports/profiles/fundsbyprogramlistpdf',noLayout='true')>
		<cfelse>
			<cfset event.setView(name='Reports/profiles/fundsbyprogramlistword',noLayout='true')>
		</cfif>
	</cffunction>

	<cffunction name="fundsbyimplementerlistword" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfparam name="rc.fy" default="">
		<cfparam name="rc.region" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.program" default="">
		<cfparam name="rc.implementer" default="">
		<cfparam name="rc.StatusID" default="">
		<cfparam name="rc.export" default="false">
		<cfparam name="rc.sortby" default="">
		<cfset rc.regions = instance.ProposalService.getStateRegions() />
		<cfset rc.programs =  instance.programGateway.getByAttributesQuery() />
		<cfset rc.Implementers = instance.ProposalService.getCTFPartners() />
		<cfset rc.ActivityStatuses = instance.ActivityStatusService.getActivityStatusQuery(isactive=true) />


		<cfset var rc.byimplementer = instance.proposalGateway.getProfile(implementer=rc.implementer,program=rc.program,region=rc.region,fy=rc.fy,statusID=rc.statusID,sortby=rc.sortby) />

		 <cfset rc.sums =  instance.proposalGateway.getProgramSums(fy=rc.fy,program=rc.program,statusID=rc.statusID,region=rc.region,implementer=rc.implementer) />
		<cfset var rc.fysums =  instance.proposalGateway.getFYSums(fy=rc.fy,programname=rc.program,statusID=rc.statusID,program=rc.program,implementer=rc.implementer,region=rc.region) />

		<cfif cgi.SERVER_NAME is 'ctprogramstest.com'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelseif cgi.SERVER_NAME is '127.0.0.1'>
			<cfset expPath = "c:\inetpub\wwwroot\ct-pams\includes\images\generated\">
		<cfelse>
			<cfset expPath = "d:\web\pams\includes\images\generated\">
		</cfif>

		<cfif rc.fy is not "">
			<cfset fycaption = #rc.fy#>
		<cfelse>
			<cfset fycaption = "All">
		</cfif>
		<cfif rc.region is not "">
			<cfset regioncaption = #rc.region#>
		<cfelse>
			<cfset regioncaption = "All">
		</cfif>


		<cfset thecaption = "Total Amount by Program (FY: " & fycaption &  "; Region: " & regioncaption & ")">
		<cfset thefycaption = "Total Amount by FY">
		<cfset rc.imagenamepie = #CreateUUID()#>
		<cfset rc.imagenamebar = #CreateUUID()#>


		<cfchart
				 name="programPieChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thecaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="pie"
							query="rc.sums"
							valuecolumn="totalbudget"
							itemcolumn="region"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>

		<cfchart
				 name="programBarChart" format="jpg"
					chartwidth="480"
				chartheight="400"
				yaxistitle="Amount"
					title="#thefycaption#"
						show3D="yes">
			<!--- within the chart --->
			<cfchartseries type="bar"
							query="rc.fysums"
							valuecolumn="totalbudget"
							itemcolumn="fy"
								colorlist="7e98ad,b39022,7ca30b,a65d2e,025e5e,8d2f2f,7c417c">
		</cfchart>


		    <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamebar#.jpg"
		    source = "#programBarChart#"
		    	overwrite = "yes"
		    >

		     <cfimage
		    action = "write"
		    destination = "#expPath##rc.imagenamepie#.jpg"
		    source = "#programPieChart#"
		    	overwrite = "yes"
		    >


		<cfif rc.type is "pdf">
			<cfset event.setView(name='Reports/profiles/fundsbyimplementerlistpdf',noLayout='true')>
		<cfelse>
			<cfset event.setView(name='Reports/profiles/fundsbyimplementerlistword',noLayout='true')>
		</cfif>
	</cffunction>


	<!--- SEARCH --->


	<cffunction name="search" output="false" hint="search proposal/programs" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfset rc.userProgramID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />

		<cfif StructKeyExists(rc,"searchType") and len(rc.searchType) and StructKeyExists(rc,"searchTerm") and len(rc.searchTerm)>
			<cfswitch expression="#rc.searchType#">
				<cfcase value="CNNumber">
						<cfset rc.searchResults = instance.proposalGateway.getReportSummary(CNNumber = "#trim(rc.searchTerm)#") />
				</cfcase>
				<cfcase value="ProgramTitle">
						<cfset rc.searchResults = instance.proposalGateway.getReportSummary(ProgramTitle = "#trim(rc.searchTerm)#") />
				</cfcase>
				<cfcase value="SystemID">
						<cfset rc.searchResults = instance.proposalGateway.getReportSummary(SystemID = "#trim(rc.searchTerm)#") />
				</cfcase>
				<cfcase value="Country">
						<cfset rc.searchResults = instance.proposalGateway.getReportSummary(Country = "#trim(rc.searchTerm)#") />
				</cfcase>
				<cfcase value="Region">
						<cfset rc.searchResults = instance.proposalGateway.getReportSummary(Region = "#trim(rc.searchTerm)#") />
				</cfcase>


				<cfdefaultcase>
						<cfset rc.searchResults = instance.proposalGateway.getReportSummary(All = "#trim(rc.searchTerm)#") />
				</cfdefaultcase>
			</cfswitch>
			<cfset getPlugin("MessageBox").setMessage("info","Search results for '#rc.searchTerm#'") />
			<cfset event.setView("Reports/search")>
		<cfelse>
			<cfset setNextEvent(event='summary/index') />
		</cfif>

		<!--- message --->

	</cffunction>



<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

