
<cfcomponent displayname="DisaggSetIndicator" output="false">
		<cfproperty name="DisaggSetID" type="numeric" default="" />
		<cfproperty name="IndicatorID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="DisaggSetIndicator" output="false">
		<cfargument name="DisaggSetID" type="string" required="false" default="" />
		<cfargument name="IndicatorID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setDisaggSetID(arguments.DisaggSetID) />
		<cfset setIndicatorID(arguments.IndicatorID) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="DisaggSetIndicator" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		
		<!--- DisaggSetID --->
		<cfif (NOT len(trim(getDisaggSetID())))>
			<cfset thisError.field = "DisaggSetID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "DisaggSetID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDisaggSetID())) AND NOT isNumeric(trim(getDisaggSetID())))>
			<cfset thisError.field = "DisaggSetID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DisaggSetID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IndicatorID --->
		<cfif (NOT len(trim(getIndicatorID())))>
			<cfset thisError.field = "IndicatorID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "IndicatorID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getIndicatorID())) AND NOT isNumeric(trim(getIndicatorID())))>
			<cfset thisError.field = "IndicatorID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IndicatorID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setDisaggSetID" access="public" returntype="void" output="false">
		<cfargument name="DisaggSetID" type="string" required="true" />
		<cfset variables.instance.DisaggSetID = arguments.DisaggSetID />
	</cffunction>
	<cffunction name="getDisaggSetID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DisaggSetID />
	</cffunction>

	<cffunction name="setIndicatorID" access="public" returntype="void" output="false">
		<cfargument name="IndicatorID" type="string" required="true" />
		<cfset variables.instance.IndicatorID = arguments.IndicatorID />
	</cffunction>
	<cffunction name="getIndicatorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IndicatorID />
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
