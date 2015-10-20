<cfcomponent displayname="Workplan" output="false">
	
		<cfproperty name="WorkplanID" type="numeric" default="" />
		<cfproperty name="ActivityID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="Description" type="string" default="" />
		<cfproperty name="StartDate" type="date" default="" />
		<cfproperty name="EndDate" type="date" default="" />
		<cfproperty name="CompleteDate" type="date" default="" />



	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Workplan" output="false">
		<cfargument name="WorkplanID" type="string" required="false" default="" />
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
    	<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="StartDate" type="string" required="false" default="" />
		<cfargument name="EndDate" type="string" required="false" default="" />
		<cfargument name="CompleteDate" type="string" required="false" default="" />



		<!--- run setters --->
		<cfset setWorkplanID(arguments.WorkplanID) />
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setName(arguments.Name) />
    	<cfset setDescription(arguments.Description) />
		<cfset setStartDate(arguments.StartDate) />
		<cfset setEndDate(arguments.EndDate) />
		<cfset setCompleteDate(arguments.CompleteDate) />

				
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Workplan" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="array" output="true">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		
		<!--- Name --->
		<cfif (len(trim(getName())) AND NOT IsSimpleValue(trim(getName())))>				
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Title is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) GT 250)>			
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Title is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Description --->			
		<cfif (len(trim(getDescription())) AND NOT IsSimpleValue(trim(getDescription())))>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Description is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDescription())) GT 4000)>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Description is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- StartDate --->
		<cfif (len(trim(getStartDate())) AND NOT isDate(trim(getStartDate())))>
			<cfset thisError.field = "StartDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Start Date is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset startdatevalid = 0>
		<cfelseif (len(trim(getStartDate())) AND isDate(trim(getStartDate())))>
			<cfset startdatevalid = 1>
		<cfelseif NOT len(trim(getStartDate())) >
			<cfset startdatevalid = 0>
		</cfif>
		
		<!--- EndDate --->		
		<cfif (len(trim(getEndDate())) AND NOT isDate(trim(getEndDate())))>
			<cfset thisError.field = "EndDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "End Date is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset enddatevalid = 0>
		<cfelseif (len(trim(getEndDate())) AND isDate(trim(getEndDate())))>
			<cfset enddatevalid = 1>
		<cfelseif NOT len(trim(getEndDate())) >
			<cfset enddatevalid = 0>
		</cfif>

		<!--- Enforce start date is equal or prior to end date --->
		<cfif startdatevalid gt 0 and enddatevalid gt 0>
			<cfif datecompare(getStartDate(),getEndDate()) gt 0>
				<cfset thisError.field = "StartDate" />
				<cfset thisError.type = "invalidType" />
				<cfset thisError.message = "Start Date has to be before End Date" />
				<cfset arrayAppend(errors,duplicate(thisError)) />
			</cfif>
		</cfif>
		
		<cfreturn errors />
	</cffunction>



	<!---
	ACCESSORS
	--->
	<cffunction name="setWorkplanID" access="public" returntype="void" output="false">
		<cfargument name="WorkplanID" type="string" required="true" />
		<cfset variables.instance.WorkplanID = arguments.WorkplanID />
	</cffunction>
	<cffunction name="getWorkplanID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.WorkplanID />
	</cffunction>

	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>



	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>


	<cffunction name="setStartDate" access="public" returntype="void" output="false">
		<cfargument name="StartDate" type="string" required="true" />
		<cfset variables.instance.StartDate = arguments.StartDate />
	</cffunction>
	<cffunction name="getStartDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.StartDate />
	</cffunction>

	<cffunction name="setEndDate" access="public" returntype="void" output="false">
		<cfargument name="EndDate" type="string" required="true" />
		<cfset variables.instance.EndDate = arguments.EndDate />
	</cffunction>
	<cffunction name="getEndDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.EndDate />
	</cffunction>
	
	<cffunction name="setCompleteDate" access="public" returntype="void" output="false">
		<cfargument name="CompleteDate" type="string" required="true" />
		<cfset variables.instance.CompleteDate = arguments.CompleteDate />
	</cffunction>
	<cffunction name="getCompleteDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CompleteDate />
	</cffunction>


	
	<!---
	DUMP
	--->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

</cfcomponent>
