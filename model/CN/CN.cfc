
<cfcomponent displayname="CN" output="false">
		<cfproperty name="CNID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="CNNumber" type="string" default="" />
		<cfproperty name="BudgetSubmitDate" type="date" default="" />
		<cfproperty name="CongressSubmitDate" type="date" default="" />
		<cfproperty name="ApprovedDate" type="date" default="" />
		<cfproperty name="CNType" type="string" default="" />

		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="CN" output="false">
		<cfargument name="CNID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="CNNumber" type="string" required="false" default="" />
		<cfargument name="BudgetSubmitDate" type="string" required="false" default="" />
		<cfargument name="CongressSubmitDate" type="string" required="false" default="" />
		<cfargument name="ApprovedDate" type="string" required="false" default="" />
		<cfargument name="CNType" type="string" required="false" default="" />

		
		<!--- run setters --->
		<cfset setCNID(arguments.CNID) />
		<cfset setName(arguments.Name) />
		<cfset setCNNumber(arguments.CNNumber) />
		<cfset setBudgetSubmitDate(arguments.BudgetSubmitDate) />
		<cfset setCongressSubmitDate(arguments.CongressSubmitDate) />
		<cfset setApprovedDate(arguments.ApprovedDate) />
		<cfset setCNType(arguments.CNType) />

		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="CN" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>



	<!---
	ACCESSORS
	--->
	<cffunction name="setCNID" access="public" returntype="void" output="false">
		<cfargument name="CNID" type="string" required="true" />
		<cfset variables.instance.CNID = arguments.CNID />
	</cffunction>
	<cffunction name="getCNID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CNID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setCNNumber" access="public" returntype="void" output="false">
		<cfargument name="CNNumber" type="string" required="true" />
		<cfset variables.instance.CNNumber = arguments.CNNumber />
	</cffunction>
	<cffunction name="getCNNumber" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CNNumber />
	</cffunction>

	<cffunction name="setBudgetSubmitDate" access="public" returntype="void" output="false">
		<cfargument name="BudgetSubmitDate" type="string" required="true" />
		<cfset variables.instance.Email = arguments.BudgetSubmitDate />
	</cffunction>
	<cffunction name="getBudgetSubmitDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.BudgetSubmitDate />
	</cffunction>

	<cffunction name="setCongressSubmitDate" access="public" returntype="void" output="false">
		<cfargument name="CongressSubmitDate" type="string" required="true" />
		<cfset variables.instance.CongressSubmitDate = arguments.CongressSubmitDate />
	</cffunction>
	<cffunction name="getCongressSubmitDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CongressSubmitDate />
	</cffunction>

	<cffunction name="setApprovedDate" access="public" returntype="void" output="false">
		<cfargument name="ApprovedDate" type="string" required="true" />
		<cfset variables.instance.ApprovedDate = arguments.ApprovedDate />
	</cffunction>
	<cffunction name="getApprovedDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ApprovedDate />
	</cffunction>

	<cffunction name="setCNType" access="public" returntype="void" output="false">
		<cfargument name="CNType" type="string" required="true" />
		<cfset variables.instance.CNType = arguments.CNType />
	</cffunction>
	<cffunction name="getCNType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CNType />
	</cffunction>




</cfcomponent>