
<cfcomponent name="IndicatorService" output="false" singleton="true">

	<cfproperty name="IndicatorGateway" inject="model" scope="instance" />
	<cfproperty name="IndicatorDAO" inject="model" scope="instance" />
	<cfproperty name="Indicator" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="IndicatorService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="Indicator">
		<cfreturn instance.indicator.init() />
	</cffunction>

	<cffunction name="createIndicator" access="public" output="false" returntype="Indicator">
		<cfargument name="IndicatorID" type="numeric" required="true" />
		<cfargument name="ParentID" type="string" required="false" />
		<cfargument name="ResponsiblePersonID" type="numeric" required="false" />
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Definition" type="string" required="false" />
		<cfargument name="Justification" type="string" required="false" />
		<cfargument name="IntendedChangeDirection" type="string" required="false" />
		<cfargument name="IsOnAnnualReport" type="string" required="false" />
		<cfargument name="IndicatorCategoryID" type="numeric" required="false" />
		<cfargument name="UnitofMeasure" type="string" required="false" />
		<cfargument name="IndicatorScaleID" type="numeric" required="false" />
		<cfargument name="isOutput" type="boolean" required="false" />
		<cfargument name="isOutcome" type="boolean" required="false" />
		<cfargument name="objective" type="string" required="false" />
		<cfargument name="dataSource" type="string" required="false" />		
        <cfargument name="dataFreq" type="string" required="false" />		
        <cfargument name="collectionMethod" type="string" required="false" />		
        
		<cfset var Indicator = createObject("component","Indicator").init(argumentCollection=arguments) />
		
		<cfreturn Indicator />
	</cffunction>

	<cffunction name="getIndicator" access="public" output="false" returntype="Indicator">
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfset var Indicator = "">
			
		<cfif structKeyExists(arguments,"indicatorid")>
			<cfset Indicator = createIndicator(argumentCollection=arguments) />
		
			<cfset instance.IndicatorDAO.read(Indicator) />
			
		<cfelse>
			<cfset Indicator = instance.Indicator.init()>
		</cfif>
		
		<cfreturn Indicator />
	</cffunction>

	<cffunction name="getIndicators" access="public" output="false" returntype="array">
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<cfargument name="ResponsiblePersonID" type="numeric" required="false" />
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ResultsFrameworkElementIDisNULL" type="boolean" required="false" hint="if TRUE, get all Indicators not belonging to a ResultsFramework. if FALSE, get all ResultsFramework Indicators. If undefined, ignore." />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Definition" type="string" required="false" />
		<cfargument name="Justification" type="string" required="false" />
		<cfargument name="IntendedChangeDirection" type="string" required="false" />
		<cfargument name="IsOnAnnualReport" type="string" required="false" />
		<cfargument name="IndicatorCategoryID" type="numeric" required="false" />
		<cfargument name="UnitofMeasure" type="string" required="false" />
		<cfargument name="IndicatorScaleID" type="numeric" required="false" />
		<cfargument name="isOutput" type="boolean" required="false" />
		<cfargument name="isOutcome" type="boolean" required="false" />
		<cfargument name="objective" type="string" required="false" />
		<cfargument name="dataSource" type="string" required="false" />		
        <cfargument name="dataFreq" type="string" required="false" />		
        <cfargument name="collectionMethod" type="string" required="false" />		
		
		<cfreturn instance.IndicatorGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>
	
    <cffunction name="getIndicatorWithSource" access="public" output="false" returntype="query">
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfreturn instance.IndicatorGateway.getIndicatorWithSourceQuery(indicatorID=arguments.indicatorID) />
	</cffunction>

	<cffunction name="getIndicatorsQuery" access="public" output="false" returntype="query">
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<cfargument name="ResponsiblePersonID" type="numeric" required="false" />
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ResultsFrameworkElementIDisNULL" type="boolean" required="false" hint="if TRUE, get all Indicators not belonging to a ResultsFramework. if FALSE, get all ResultsFramework Indicators. If undefined, ignore." />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Definition" type="string" required="false" />
		<cfargument name="Justification" type="string" required="false" />
		<cfargument name="IntendedChangeDirection" type="string" required="false" />
		<cfargument name="IsOnAnnualReport" type="string" required="false" />
		<cfargument name="IndicatorCategoryID" type="numeric" required="false" />
		<cfargument name="UnitofMeasure" type="string" required="false" />
		<cfargument name="IndicatorScaleID" type="numeric" required="false" />
		<cfargument name="isOutput" type="boolean" required="false" />
		<cfargument name="isOutcome" type="boolean" required="false" />
		<cfargument name="dataSource" type="string" required="false" />		
        <cfargument name="dataFreq" type="string" required="false" />		
        <cfargument name="collectionMethod" type="string" required="false" />		

        
        
		<cfreturn instance.IndicatorGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>


	<cffunction name="saveIndicator" access="public" output="false" returntype="numeric">
		<cfargument name="Indicator" type="Indicator" required="true" />
		<cfreturn instance.IndicatorDAO.save(Indicator) />
	</cffunction>

	
	<cffunction name="deleteIndicator" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorID" type="numeric" required="true" />

		<cfset var Indicator = this.createIndicator(argumentCollection=arguments) />
		       
		<cfreturn instance.IndicatorDAO.delete(Indicator) />
	</cffunction>


<!---	<cffunction name="getIndicatorDataSourceQuery" access="public" output="false" returntype="query">
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfreturn instance.IndicatorGateway.getIndicatorDataSourceQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getIndicatorDataSource" access="public" output="false" returntype="query">
		<cfargument name="sourceID" type="numeric" required="true" />
		<cfreturn instance.IndicatorGateway.getIndicatorDataSource(argumentCollection=arguments) />
	</cffunction>

--->



	
</cfcomponent>
