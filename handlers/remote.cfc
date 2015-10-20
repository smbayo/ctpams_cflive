<cfcomponent name="proposal" extends="coldbox.system.EventHandler" autowire="true">
	
	<cfproperty name="ActivityObligationGateway" inject="model" scope="instance" />
	<cfproperty name="ProposalGateway" inject="model" scope="instance" />
	
	<cffunction name="saveBudgetAmountRemote" output="false" returntype="string" access="remote">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		
		<cfset rc.value = replace(rc.value,",","","All")>
		<cfset rc.value = replace(rc.value,"$","","All")>
		
		<cfif structKeyExists(rc,"id") and isnumeric(rc.id) and isnumeric(rc.value) >
			<cfset updateAmount = instance.activityObligationGateway.updateByAttributes(ActivityObligateID=rc.id,Amount=rc.value) />
			<cfreturn dollarformat(rc.value) />
		<cfelse>
			<cfreturn "Please enter a number." />
		</cfif>	
	</cffunction>


	<cffunction name="saveBudgetDateRemote" output="false" returntype="string" access="remote">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
				
		<cfif structKeyExists(rc,"id") and isnumeric(rc.id) and isdate(rc.value)>
			<cfset updateAmount = instance.activityObligationGateway.updateByAttributes(ActivityObligateID=rc.id,ObligationDate=rc.value) />
			<cfreturn rc.value />
		<cfelse>
			<cfreturn "Please enter a date." />
		</cfif>
	</cffunction>	


	<cffunction name="saveBudgetCommentsRemote" output="false" returntype="string" access="remote">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
				
		<cfif structKeyExists(rc,"id") and isnumeric(rc.id)>
			<cfset updateComments = instance.activityObligationGateway.updateByAttributes(ActivityObligateID=rc.id,Comments=rc.value) />

		</cfif>
		<cfreturn rc.value />
	</cffunction>	


	<cffunction name="saveBudgetObNumberRemote" output="false" returntype="string" access="remote">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
				
		<cfif structKeyExists(rc,"id") and isnumeric(rc.id)>
			<cfset updateObNumber = instance.activityObligationGateway.updateByAttributes(ActivityObligateID=rc.id,ObligationNumber=rc.value) />

		</cfif>
		<cfreturn rc.value />
	</cffunction>		
	
	
	<cffunction name="saveBudgetFYRemote" output="false" returntype="string" access="remote">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfif structKeyExists(rc,"id") and isnumeric(rc.id) and isnumeric(rc.value) and len(rc.value) is 4 >
			<cfset updateAmount = instance.activityObligationGateway.updateByAttributes(ActivityObligateID=rc.id,ObligationFYyearSource=rc.value) />
			<cfreturn rc.value />
		<cfelse>
			<cfreturn "Please enter a year." />
		</cfif>	
	</cffunction>

	<cffunction name="searchtypeahead" output="true" hint="search proposal/programs" returntype="any">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />
		
		<cfset jstring="">
		<cfset jstring=(jstring & '[')>
		<cfset rc.searchAhead = instance.proposalGateway.getReportSummary() />

		<cfloop query="rc.searchAhead">
			<cfif rc.searchAhead.currentRow gt 1>
				<cfset jstring=jstring & ','>
			</cfif>
			<cfset jstring=jstring & '"' & trim(left(REReplace(projecttitle,"[""]|’|'|“|”|[.]","","ALL"),30)) & '"'>

		</cfloop>
		<cfset jstring=jstring & ']'>
		<cfset rc.jstring=jstring>
		
		<cfcontent
			type="text/plain"
			reset="true"
			variable="#ToBinary( ToBase64( jstring ) )#"
			/>

	</cffunction>
	


	<cffunction name="programregioncountryjson" output="true" hint="tree data" returntype="string">
		<cfargument name="event" required="false" />
		
		<cfquery name="treeData"  datasource="sctdb">
			select sum(budgetamount) as countrybudget, program, region, country
			from vw_activityProgramBudget
			where region is not null
			group by program, region, country
		</cfquery>
		
		<cfset jstring="">
		<cfset jstring=(jstring & '{"name" : "CT Programs", "children" : [')>
		<cfset theprogram = "">
		
		<cfset theprogram = "">
		<cfoutput query="treeData" group="program">
			<cfset theregion = "">
			<!--- <cfif AlljsonQuery.currentRow gt 1>
				<cfset jstring=jstring & ']},'>
			</cfif> --->
			<!--- <cfset jstring=(jstring & '{')> --->
			
			<cfif not theprogram is "">
				<cfset jstring=jstring & ','>
			</cfif>
			<cfset jstring=jstring & '{"name":"' & program & '","children":['>
			<cfset theprogram = program>
			<cfoutput group="region">
				<cfset thecountry = "">
				<cfif not theregion is "">
					<cfset jstring=jstring & ','>
				</cfif>
				<cfset jstring=jstring & '{"name":"' & region & '", "children":['>
				<cfset theregion = region>
				<cfoutput group="country">
					<cfif not thecountry is "">
						<cfset jstring=jstring & ','>
					</cfif>
					<cfset jstring=jstring & '{"name":"' & country & '", "size":' & countrybudget & '}'>
					<cfset thecountry = country>
				</cfoutput>
				<cfset jstring=jstring & ']}'>
			</cfoutput>
			<cfset jstring=jstring & ']}'>

		
		</cfoutput>
		<cfset jstring=jstring & ']}'>
		
		<cfcontent
			type="application/json"
			reset="true"
			variable="#ToBinary( ToBase64( jstring ) )#"
			/>
			
			<cfreturn jstring>


	</cffunction>

	<cffunction name="programregionjson" output="true" hint="tree data" returntype="string">
		<cfargument name="event" required="false" />
		
		<cfquery name="treeData"  datasource="sctdb">
			select sum(budgetamount) as regionbudget, program, region
			from vw_activityProgramBudget
			where region is not null
			group by program, region
		</cfquery>
		
		<cfset jstring="">
		<cfset jstring=(jstring & '{"name" : "CT Programs", "children" : [')>
		<cfset theprogram = "">
		
		<cfset theprogram = "">
		<cfoutput query="treeData" group="program">
			<cfset theregion = "">
			<!--- <cfif AlljsonQuery.currentRow gt 1>
				<cfset jstring=jstring & ']},'>
			</cfif> --->
			<!--- <cfset jstring=(jstring & '{')> --->
			
			<cfif not theprogram is "">
				<cfset jstring=jstring & ','>
			</cfif>
			<cfset jstring=jstring & '{"name":"' & program & '","children":['>
			<cfset theprogram = program>
			<cfoutput group="region">
				<cfif not theregion is "">
					<cfset jstring=jstring & ','>
				</cfif>
				<cfset jstring=jstring & '{"name":"' & region & '", "size":' & regionbudget & '}'>
				<cfset theregion = region>

			</cfoutput>
			<cfset jstring=jstring & ']}'>

		
		</cfoutput>
		<cfset jstring=jstring & ']}'>
		
		<cfcontent
			type="application/json"
			reset="true"
			variable="#ToBinary( ToBase64( jstring ) )#"
			/>
			
			<cfreturn jstring>


	</cffunction>

	<cffunction name="regioncountryjson" output="true" hint="tree data" returntype="string">
		<cfargument name="event" required="false" />
		
		<cfquery name="treeData"  datasource="sctdb">
			select sum(budgetamount) as countrybudget, region, country
			from vw_activityProgramBudget
			where region is not null
			group by region, country
		</cfquery>
		
		<cfset jstring="">
		<cfset jstring=(jstring & '{"name" : "CT Programs", "children" : [')>
		
		<cfset theregion = "">
		<cfoutput query="treeData" group="region">
			<cfset thecountry = "">

			
			<cfif not theregion is "">
				<cfset jstring=jstring & ','>
			</cfif>
			<cfset jstring=jstring & '{"name":"' & region & '","children":['>
			<cfset theregion = region>
			<cfoutput group="country">

				<cfif not thecountry is "">
					<cfset jstring=jstring & ','>
				</cfif>
				<cfset jstring=jstring & '{"name":"' & country & '", "size":' & countrybudget & '}'>
				<cfset thecountry = country>

			</cfoutput>
			<cfset jstring=jstring & ']}'>

		
		</cfoutput>
		<cfset jstring=jstring & ']}'>
		
		<cfcontent
			type="application/json"
			reset="true"
			variable="#ToBinary( ToBase64( jstring ) )#"
			/>
			
			<cfreturn jstring>


	</cffunction>



</cfcomponent>