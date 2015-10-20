
<cfcomponent displayname="measurement" output="false">
		<cfproperty name="MeasurementID" type="numeric" default="" />
		<cfproperty name="ActivityID" type="numeric" default="" />
		<cfproperty name="IndicatorID" type="numeric" default="" />
		<cfproperty name="DisaggID" type="numeric" default="" />
		<cfproperty name="isBaseline" type="boolean" default="" />
		<cfproperty name="Actual" type="numeric" default="" />
		<cfproperty name="ActualNotes" type="string" default="" />
		<cfproperty name="Target" type="numeric" default="" />
		<cfproperty name="TargetNotes" type="string" default="" />
		<cfproperty name="StartDate" type="date" default="" />
		<cfproperty name="EndDate" type="date" default="" />
		<cfproperty name="ReportDate" type="date" default="" />
		<cfproperty name="ReviewedBy" type="string" default="" />
		<cfproperty name="ReviewDate" type="string" default="" />
		<cfproperty name="ReviewType" type="string" default="" />
		<cfproperty name="ReviewNotes" type="string" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="measurement" output="false">
		<cfargument name="MeasurementID" type="string" required="false" default="" />
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="IndicatorID" type="string" required="false" default="" />
		<cfargument name="DisaggID" type="string" required="false" default="" />
		<cfargument name="isBaseline" type="string" required="false" default="" />
		<cfargument name="Actual" type="string" required="false" default="" />
		<cfargument name="ActualNotes" type="string" required="false" default="" />
		<cfargument name="Target" type="string" required="false" default="" />
		<cfargument name="TargetNotes" type="string" required="false" default="" />
		<cfargument name="StartDate" type="string" required="false" default="" />
		<cfargument name="EndDate" type="string" required="false" default="" />
		<cfargument name="ReportDate" type="string" required="false" default="" />
		<cfargument name="ReviewedBy" type="string" required="false" default="" />
		<cfargument name="ReviewDate" type="string" required="false" default="" />
		<cfargument name="ReviewType" type="string" required="false" default="" />
		<cfargument name="ReviewNotes" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setMeasurementID(arguments.MeasurementID) />
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setIndicatorID(arguments.IndicatorID) />
		<cfset setDisaggID(arguments.DisaggID) />
		<cfset setisBaseline(arguments.isBaseline) />
		<cfset setActual(arguments.Actual) />
		<cfset setActualNotes(arguments.ActualNotes) />
		<cfset setTarget(arguments.Target) />
		<cfset setTargetNotes(arguments.TargetNotes) />
		<cfset setStartDate(arguments.StartDate) />
		<cfset setEndDate(arguments.EndDate) />
		<cfset setReportDate(arguments.ReportDate) />
		<cfset setReviewedBy(arguments.ReviewedBy) />
		<cfset setReviewDate(arguments.ReviewDate) />
		<cfset setReviewType(arguments.ReviewType) />
		<cfset setReviewNotes(arguments.ReviewNotes) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="measurement" output="false">
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
		
		<!--- MeasurementID --->
		<cfif (NOT len(trim(getMeasurementID())))>
			<cfset thisError.field = "MeasurementID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "MeasurementID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getMeasurementID())) AND NOT isNumeric(trim(getMeasurementID())))>
			<cfset thisError.field = "MeasurementID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "MeasurementID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ActivityID --->
		<cfif (len(trim(getActivityID())) AND NOT isNumeric(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IndicatorID --->
		<cfif (len(trim(getIndicatorID())) AND NOT isNumeric(trim(getIndicatorID())))>
			<cfset thisError.field = "IndicatorID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IndicatorID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- DisaggID --->
		<cfif (len(trim(getDisaggID())) AND NOT isNumeric(trim(getDisaggID())))>
			<cfset thisError.field = "DisaggID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DisaggID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- isBaseline --->
		<cfif (len(trim(getisBaseline())) AND NOT isBoolean(trim(getisBaseline())))>
			<cfset thisError.field = "isBaseline" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "isBaseline is not boolean" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Actual --->
		<cfif (len(trim(getActual())) AND NOT isNumeric(trim(getActual())))>
			<cfset thisError.field = "Actual" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Actual is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ActualNotes --->
		<cfif (len(trim(getActualNotes())) AND NOT IsSimpleValue(trim(getActualNotes())))>
			<cfset thisError.field = "ActualNotes" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActualNotes is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getActualNotes())) GT 1073741823)>
			<cfset thisError.field = "ActualNotes" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ActualNotes is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Target --->
		<cfif (len(trim(getTarget())) AND NOT isNumeric(trim(getTarget())))>
			<cfset thisError.field = "Target" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Target is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- TargetNotes --->
		<cfif (len(trim(getTargetNotes())) AND NOT IsSimpleValue(trim(getTargetNotes())))>
			<cfset thisError.field = "TargetNotes" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "TargetNotes is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getTargetNotes())) GT 1073741823)>
			<cfset thisError.field = "TargetNotes" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "TargetNotes is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- StartDate --->
		<cfif (len(trim(getStartDate())) AND NOT isDate(trim(getStartDate())))>
			<cfset thisError.field = "StartDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "StartDate is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- EndDate --->
		<cfif (len(trim(getEndDate())) AND NOT isDate(trim(getEndDate())))>
			<cfset thisError.field = "EndDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "EndDate is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ReportDate --->
		<cfif (len(trim(getReportDate())) AND NOT isDate(trim(getReportDate())))>
			<cfset thisError.field = "ReportDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ReportDate is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ReviewedBy --->
		<cfif (len(trim(getReviewedBy())) AND NOT IsSimpleValue(trim(getReviewedBy())))>
			<cfset thisError.field = "ReviewedBy" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ReviewedBy is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getReviewedBy())) GT 255)>
			<cfset thisError.field = "ReviewedBy" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ReviewedBy is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ReviewDate --->
		<cfif (len(trim(getReviewDate())) AND NOT IsSimpleValue(trim(getReviewDate())))>
			<cfset thisError.field = "ReviewDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ReviewDate is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getReviewDate())) GT 255)>
			<cfset thisError.field = "ReviewDate" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ReviewDate is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ReviewType --->
		<cfif (len(trim(getReviewType())) AND NOT IsSimpleValue(trim(getReviewType())))>
			<cfset thisError.field = "ReviewType" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ReviewType is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getReviewType())) GT 255)>
			<cfset thisError.field = "ReviewType" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ReviewType is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ReviewNotes --->
		<cfif (len(trim(getReviewNotes())) AND NOT IsSimpleValue(trim(getReviewNotes())))>
			<cfset thisError.field = "ReviewNotes" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ReviewNotes is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getReviewNotes())) GT 1073741823)>
			<cfset thisError.field = "ReviewNotes" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ReviewNotes is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setMeasurementID" access="public" returntype="void" output="false">
		<cfargument name="MeasurementID" type="string" required="true" />
		<cfset variables.instance.MeasurementID = arguments.MeasurementID />
	</cffunction>
	<cffunction name="getMeasurementID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.MeasurementID />
	</cffunction>

	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>

	<cffunction name="setIndicatorID" access="public" returntype="void" output="false">
		<cfargument name="IndicatorID" type="string" required="true" />
		<cfset variables.instance.IndicatorID = arguments.IndicatorID />
	</cffunction>
	<cffunction name="getIndicatorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IndicatorID />
	</cffunction>

	<cffunction name="setDisaggID" access="public" returntype="void" output="false">
		<cfargument name="DisaggID" type="string" required="true" />
		<cfset variables.instance.DisaggID = arguments.DisaggID />
	</cffunction>
	<cffunction name="getDisaggID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DisaggID />
	</cffunction>

	<cffunction name="setisBaseline" access="public" returntype="void" output="false">
		<cfargument name="isBaseline" type="string" required="true" />
		<cfset variables.instance.isBaseline = arguments.isBaseline />
	</cffunction>
	<cffunction name="getisBaseline" access="public" returntype="string" output="false">
		<cfreturn variables.instance.isBaseline />
	</cffunction>

	<cffunction name="setActual" access="public" returntype="void" output="false">
		<cfargument name="Actual" type="string" required="true" />
		<cfset variables.instance.Actual = arguments.Actual />
	</cffunction>
	<cffunction name="getActual" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Actual />
	</cffunction>

	<cffunction name="setActualNotes" access="public" returntype="void" output="false">
		<cfargument name="ActualNotes" type="string" required="true" />
		<cfset variables.instance.ActualNotes = arguments.ActualNotes />
	</cffunction>
	<cffunction name="getActualNotes" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActualNotes />
	</cffunction>

	<cffunction name="setTarget" access="public" returntype="void" output="false">
		<cfargument name="Target" type="string" required="true" />
		<cfset variables.instance.Target = arguments.Target />
	</cffunction>
	<cffunction name="getTarget" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Target />
	</cffunction>

	<cffunction name="setTargetNotes" access="public" returntype="void" output="false">
		<cfargument name="TargetNotes" type="string" required="true" />
		<cfset variables.instance.TargetNotes = arguments.TargetNotes />
	</cffunction>
	<cffunction name="getTargetNotes" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TargetNotes />
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

	<cffunction name="setReportDate" access="public" returntype="void" output="false">
		<cfargument name="ReportDate" type="string" required="true" />
		<cfset variables.instance.ReportDate = arguments.ReportDate />
	</cffunction>
	<cffunction name="getReportDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ReportDate />
	</cffunction>

	<cffunction name="setReviewedBy" access="public" returntype="void" output="false">
		<cfargument name="ReviewedBy" type="string" required="true" />
		<cfset variables.instance.ReviewedBy = arguments.ReviewedBy />
	</cffunction>
	<cffunction name="getReviewedBy" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ReviewedBy />
	</cffunction>

	<cffunction name="setReviewDate" access="public" returntype="void" output="false">
		<cfargument name="ReviewDate" type="string" required="true" />
		<cfset variables.instance.ReviewDate = arguments.ReviewDate />
	</cffunction>
	<cffunction name="getReviewDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ReviewDate />
	</cffunction>

	<cffunction name="setReviewType" access="public" returntype="void" output="false">
		<cfargument name="ReviewType" type="string" required="true" />
		<cfset variables.instance.ReviewType = arguments.ReviewType />
	</cffunction>
	<cffunction name="getReviewType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ReviewType />
	</cffunction>

	<cffunction name="setReviewNotes" access="public" returntype="void" output="false">
		<cfargument name="ReviewNotes" type="string" required="true" />
		<cfset variables.instance.ReviewNotes = arguments.ReviewNotes />
	</cffunction>
	<cffunction name="getReviewNotes" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ReviewNotes />
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
