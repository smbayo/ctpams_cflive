
<cfcomponent displayname="Indicator" output="false">
		<cfproperty name="IndicatorID" type="numeric" default="" />
		<cfproperty name="ParentID" type="string" default="" />
		<cfproperty name="ResponsiblePersonID" type="numeric" default="" />
		<cfproperty name="ResultsFrameworkElementID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="Definition" type="string" default="" />
		<cfproperty name="Justification" type="string" default="" />
		<cfproperty name="IntendedChangeDirection" type="string" default="" />
		<cfproperty name="IsOnAnnualReport" type="string" default="" />
		<cfproperty name="IndicatorCategoryID" type="numeric" default="" />
		<cfproperty name="UnitofMeasure" type="string" default="" />
		<cfproperty name="IndicatorScaleID" type="numeric" default="" />
		<cfproperty name="isOutput" type="boolean" default="" />
		<cfproperty name="isOutcome" type="boolean" default="" />
		<cfproperty name="objective" type="string" default="" />
		<cfproperty name="dataSource" type="string" default="" />
		<cfproperty name="dataFreq" type="string" default="" />
		<cfproperty name="collectionMethod" type="string" default="" />
        
        
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Indicator" output="false">
		<cfargument name="IndicatorID" type="string" required="false" default="" />
		<cfargument name="ParentID" type="string" required="false" default="" />
		<cfargument name="ResponsiblePersonID" type="string" required="false" default="" />
		<cfargument name="ResultsFrameworkElementID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Definition" type="string" required="false" default="" />
		<cfargument name="Justification" type="string" required="false" default="" />
		<cfargument name="IntendedChangeDirection" type="string" required="false" default="" />
		<cfargument name="IsOnAnnualReport" type="string" required="false" default="" />
		<cfargument name="IndicatorCategoryID" type="string" required="false" default="" />
		<cfargument name="UnitofMeasure" type="string" required="false" default="" />
		<cfargument name="IndicatorScaleID" type="string" required="false" default="" />
		<cfargument name="isOutput" type="string" required="false" default="" />
		<cfargument name="isOutcome" type="string" required="false" default="" />
		<cfargument name="objective" type="string" required="false" default="" />
		<cfargument name="dataSource" type="string" required="false" default="" />
		<cfargument name="dataFreq" type="string" required="false" default="" />
		<cfargument name="collectionMethod" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setIndicatorID(arguments.IndicatorID) />
		<cfset setParentID(arguments.ParentID) />
		<cfset setResponsiblePersonID(arguments.ResponsiblePersonID) />
		<cfset setResultsFrameworkElementID(arguments.ResultsFrameworkElementID) />
		<cfset setName(arguments.Name) />
		<cfset setDefinition(arguments.Definition) />
		<cfset setJustification(arguments.Justification) />
		<cfset setIntendedChangeDirection(arguments.IntendedChangeDirection) />
		<cfset setIsOnAnnualReport(arguments.IsOnAnnualReport) />
		<cfset setIndicatorCategoryID(arguments.IndicatorCategoryID) />
		<cfset setUnitofMeasure(arguments.UnitofMeasure) />
		<cfset setIndicatorScaleID(arguments.IndicatorScaleID) />
		<cfset setisOutput(arguments.isOutput) />
		<cfset setisOutcome(arguments.isOutcome) />
		<cfset setobjective(arguments.objective) />
		<cfset setDataSource(arguments.dataSource) />
		<cfset setDataFreq(arguments.dataFreq) />
 		<cfset setCollectionMethod(arguments.collectionMethod) />
       
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Indicator" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validateSubmit" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
	
		<!--- Name --->
		<cfif NOT len(trim(getName()))>				
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Form Section ##15: Indicator is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>		
		<cfif (len(trim(getName())) AND NOT IsSimpleValue(trim(getName())))>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Form Section ##15: Indicator is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) GT 255)>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Form Section ##15: Indicator is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- objective --->
		<cfif NOT len(trim(getobjective()))>				
			<cfset thisError.field = "Objective" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Form Section ##15: Objective is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>			
		<cfif (len(trim(getobjective())) AND NOT IsSimpleValue(trim(getobjective())))>
			<cfset thisError.field = "Objective" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Form Section ##15: Objective is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getobjective())) GT 255)>
			<cfset thisError.field = "Objective" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Form Section ##15: Objective is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>		
		
		<cfreturn errors />
	</cffunction>

	<cffunction name="validate" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		
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
		
		<!--- ParentID --->
		<cfif (len(trim(getParentID())) AND NOT IsSimpleValue(trim(getParentID())))>
			<cfset thisError.field = "ParentID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ParentID is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getParentID())) GT 255)>
			<cfset thisError.field = "ParentID" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ParentID is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ResponsiblePersonID --->
		<cfif (len(trim(getResponsiblePersonID())) AND NOT isNumeric(trim(getResponsiblePersonID())))>
			<cfset thisError.field = "ResponsiblePersonID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ResponsiblePersonID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ResultsFrameworkElementID --->
		<cfif (len(trim(getResultsFrameworkElementID())) AND NOT isNumeric(trim(getResultsFrameworkElementID())))>
			<cfset thisError.field = "ResultsFrameworkElementID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ResultsFrameworkElementID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Name --->
		<cfif (len(trim(getName())) AND NOT IsSimpleValue(trim(getName())))>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Name is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) GT 255)>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Name is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Definition --->
		<cfif (len(trim(getDefinition())) AND NOT IsSimpleValue(trim(getDefinition())))>
			<cfset thisError.field = "Definition" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Definition is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDefinition())) GT 255)>
			<cfset thisError.field = "Definition" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Definition is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- dataSource --->
		<cfif (len(trim(getdataSource())) AND NOT IsSimpleValue(trim(getdataSource())))>
			<cfset thisError.field = "dataSource" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "dataSource is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getdataSource())) GT 255)>
			<cfset thisError.field = "dataSource" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "dataSource is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<!--- dataFreq --->
		<cfif (len(trim(getdataFreq())) AND NOT IsSimpleValue(trim(getdataFreq())))>
			<cfset thisError.field = "dataFreq" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "dataFreq is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getdataFreq())) GT 255)>
			<cfset thisError.field = "dataFreq" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "dataFreq is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
        
       	<!--- collectionMethod --->
        <cfif (len(trim(getcollectionMethod())) AND NOT IsSimpleValue(trim(getcollectionMethod())))>
			<cfset thisError.field = "collectionMethod" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "collectionMethod is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getcollectionMethod())) GT 255)>
			<cfset thisError.field = "collectionMethod" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "collectionMethod is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

        
        
        
        
        
        
        
		<!--- Justification --->
		<cfif (len(trim(getJustification())) AND NOT IsSimpleValue(trim(getJustification())))>
			<cfset thisError.field = "Justification" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Justification is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getJustification())) GT 255)>
			<cfset thisError.field = "Justification" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Justification is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IntendedChangeDirection --->
		<cfif (len(trim(getIntendedChangeDirection())) AND NOT IsSimpleValue(trim(getIntendedChangeDirection())))>
			<cfset thisError.field = "IntendedChangeDirection" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IntendedChangeDirection is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getIntendedChangeDirection())) GT 255)>
			<cfset thisError.field = "IntendedChangeDirection" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "IntendedChangeDirection is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IsOnAnnualReport --->
		<cfif (len(trim(getIsOnAnnualReport())) AND NOT IsSimpleValue(trim(getIsOnAnnualReport())))>
			<cfset thisError.field = "IsOnAnnualReport" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IsOnAnnualReport is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getIsOnAnnualReport())) GT 255)>
			<cfset thisError.field = "IsOnAnnualReport" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "IsOnAnnualReport is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IndicatorCategoryID --->
		<cfif (len(trim(getIndicatorCategoryID())) AND NOT isNumeric(trim(getIndicatorCategoryID())))>
			<cfset thisError.field = "IndicatorCategoryID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IndicatorCategoryID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- UnitofMeasure --->
		<cfif (len(trim(getUnitofMeasure())) AND NOT IsSimpleValue(trim(getUnitofMeasure())))>
			<cfset thisError.field = "UnitofMeasure" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "UnitofMeasure is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getUnitofMeasure())) GT 255)>
			<cfset thisError.field = "UnitofMeasure" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "UnitofMeasure is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IndicatorScaleID --->
		<cfif (len(trim(getIndicatorScaleID())) AND NOT isNumeric(trim(getIndicatorScaleID())))>
			<cfset thisError.field = "IndicatorScaleID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IndicatorScaleID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- isOutput --->
		<cfif (len(trim(getisOutput())) AND NOT isBoolean(trim(getisOutput())))>
			<cfset thisError.field = "isOutput" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "isOutput is not boolean" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- isOutcome --->
		<cfif (len(trim(getisOutcome())) AND NOT isBoolean(trim(getisOutcome())))>
			<cfset thisError.field = "isOutcome" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "isOutcome is not boolean" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- objective --->
		<cfif (len(trim(getobjective())) AND NOT IsSimpleValue(trim(getobjective())))>
			<cfset thisError.field = "objective" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "objective is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getobjective())) GT 255)>
			<cfset thisError.field = "objective" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "objective is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>		
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setIndicatorID" access="public" returntype="void" output="false">
		<cfargument name="IndicatorID" type="string" required="true" />
		<cfset variables.instance.IndicatorID = arguments.IndicatorID />
	</cffunction>
	<cffunction name="getIndicatorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IndicatorID />
	</cffunction>

	<cffunction name="setParentID" access="public" returntype="void" output="false">
		<cfargument name="ParentID" type="string" required="true" />
		<cfset variables.instance.ParentID = arguments.ParentID />
	</cffunction>
	<cffunction name="getParentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentID />
	</cffunction>

	<cffunction name="setResponsiblePersonID" access="public" returntype="void" output="false">
		<cfargument name="ResponsiblePersonID" type="string" required="true" />
		<cfset variables.instance.ResponsiblePersonID = arguments.ResponsiblePersonID />
	</cffunction>
	<cffunction name="getResponsiblePersonID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ResponsiblePersonID />
	</cffunction>

	<cffunction name="setResultsFrameworkElementID" access="public" returntype="void" output="false">
		<cfargument name="ResultsFrameworkElementID" type="string" required="true" />
		<cfset variables.instance.ResultsFrameworkElementID = arguments.ResultsFrameworkElementID />
	</cffunction>
	<cffunction name="getResultsFrameworkElementID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ResultsFrameworkElementID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setDefinition" access="public" returntype="void" output="false">
		<cfargument name="Definition" type="string" required="true" />
		<cfset variables.instance.Definition = arguments.Definition />
	</cffunction>
	<cffunction name="getDefinition" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Definition />
	</cffunction>

	<cffunction name="setJustification" access="public" returntype="void" output="false">
		<cfargument name="Justification" type="string" required="true" />
		<cfset variables.instance.Justification = arguments.Justification />
	</cffunction>
	<cffunction name="getJustification" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Justification />
	</cffunction>

	<cffunction name="setIntendedChangeDirection" access="public" returntype="void" output="false">
		<cfargument name="IntendedChangeDirection" type="string" required="true" />
		<cfset variables.instance.IntendedChangeDirection = arguments.IntendedChangeDirection />
	</cffunction>
	<cffunction name="getIntendedChangeDirection" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IntendedChangeDirection />
	</cffunction>

	<cffunction name="setIsOnAnnualReport" access="public" returntype="void" output="false">
		<cfargument name="IsOnAnnualReport" type="string" required="true" />
		<cfset variables.instance.IsOnAnnualReport = arguments.IsOnAnnualReport />
	</cffunction>
	<cffunction name="getIsOnAnnualReport" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IsOnAnnualReport />
	</cffunction>

	<cffunction name="setIndicatorCategoryID" access="public" returntype="void" output="false">
		<cfargument name="IndicatorCategoryID" type="string" required="true" />
		<cfset variables.instance.IndicatorCategoryID = arguments.IndicatorCategoryID />
	</cffunction>
	<cffunction name="getIndicatorCategoryID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IndicatorCategoryID />
	</cffunction>

	<cffunction name="setUnitofMeasure" access="public" returntype="void" output="false">
		<cfargument name="UnitofMeasure" type="string" required="true" />
		<cfset variables.instance.UnitofMeasure = arguments.UnitofMeasure />
	</cffunction>
	<cffunction name="getUnitofMeasure" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UnitofMeasure />
	</cffunction>

	<cffunction name="setIndicatorScaleID" access="public" returntype="void" output="false">
		<cfargument name="IndicatorScaleID" type="string" required="true" />
		<cfset variables.instance.IndicatorScaleID = arguments.IndicatorScaleID />
	</cffunction>
	<cffunction name="getIndicatorScaleID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IndicatorScaleID />
	</cffunction>

	<cffunction name="setisOutput" access="public" returntype="void" output="false">
		<cfargument name="isOutput" type="string" required="true" />
		<cfset variables.instance.isOutput = arguments.isOutput />
	</cffunction>
	<cffunction name="getisOutput" access="public" returntype="string" output="false">
		<cfreturn variables.instance.isOutput />
	</cffunction>

	<cffunction name="setisOutcome" access="public" returntype="void" output="false">
		<cfargument name="isOutcome" type="string" required="true" />
		<cfset variables.instance.isOutcome = arguments.isOutcome />
	</cffunction>
	<cffunction name="getisOutcome" access="public" returntype="string" output="false">
		<cfreturn variables.instance.isOutcome />
	</cffunction>

	<cffunction name="setobjective" access="public" returntype="void" output="false">
		<cfargument name="objective" type="string" required="true" />
		<cfset variables.instance.objective = arguments.objective />
	</cffunction>
	<cffunction name="getobjective" access="public" returntype="string" output="false">
		<cfreturn variables.instance.objective />
	</cffunction>


	<cffunction name="setDataSource" access="public" returntype="void" output="false">
		<cfargument name="DataSource" type="string" required="true" />
		<cfset variables.instance.DataSource = arguments.DataSource />
	</cffunction>
	<cffunction name="getDataSource" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DataSource />
	</cffunction>

	<cffunction name="setDataFreq" access="public" returntype="void" output="false">
		<cfargument name="DataFreq" type="string" required="true" />
		<cfset variables.instance.DataFreq = arguments.DataFreq />
	</cffunction>
	<cffunction name="getDataFreq" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DataFreq />
	</cffunction>

	<cffunction name="setcollectionMethod" access="public" returntype="void" output="false">
		<cfargument name="collectionMethod" type="string" required="true" />
		<cfset variables.instance.collectionMethod = arguments.collectionMethod />
	</cffunction>
	<cffunction name="getcollectionMethod" access="public" returntype="string" output="false">
		<cfreturn variables.instance.collectionMethod />
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
