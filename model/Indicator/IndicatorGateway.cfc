
<cfcomponent displayname="IndicatorGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="IndicatorGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
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
		<cfargument name="indicatorIDList" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="dataSource" type="string" required="false" />		
        <cfargument name="dataFreq" type="string" required="false" />		
        <cfargument name="collectionMethod" type="string" required="false" />
        		
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				IndicatorID,
				ParentID,
				ResponsiblePersonID,
				ResultsFrameworkElementID,
				Name,
				Definition,
				Justification,
				IntendedChangeDirection,
				IsOnAnnualReport,
				IndicatorCategoryID,
				UnitofMeasure,
				IndicatorScaleID,
				isOutput,
				isOutcome,
				objective,
                    dataSource,
                    dataFreq,
                    collectionMethod
                
			FROM	Indicator
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"IndicatorID") and len(arguments.IndicatorID)>
			AND	IndicatorID = <cfqueryparam value="#arguments.IndicatorID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ParentID") and len(arguments.ParentID)>
			AND	ParentID = <cfqueryparam value="#arguments.ParentID#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ResponsiblePersonID") and len(arguments.ResponsiblePersonID)>
			AND	ResponsiblePersonID = <cfqueryparam value="#arguments.ResponsiblePersonID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ResultsFrameworkElementID") and len(arguments.ResultsFrameworkElementID)>
			AND	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ResultsFrameworkElementIDisNULL") >
			AND	ResultsFrameworkElementID is <cfif not arguments.ResultsFrameworkElementIDisNULL> not </cfif> NULL
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Definition") and len(arguments.Definition)>
			AND	Definition = <cfqueryparam value="#arguments.Definition#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Justification") and len(arguments.Justification)>
			AND	Justification = <cfqueryparam value="#arguments.Justification#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"IntendedChangeDirection") and len(arguments.IntendedChangeDirection)>
			AND	IntendedChangeDirection = <cfqueryparam value="#arguments.IntendedChangeDirection#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"IsOnAnnualReport") and len(arguments.IsOnAnnualReport)>
			AND	IsOnAnnualReport = <cfqueryparam value="#arguments.IsOnAnnualReport#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"IndicatorCategoryID") and len(arguments.IndicatorCategoryID)>
			AND	IndicatorCategoryID = <cfqueryparam value="#arguments.IndicatorCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"UnitofMeasure") and len(arguments.UnitofMeasure)>
			AND	UnitofMeasure = <cfqueryparam value="#arguments.UnitofMeasure#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"IndicatorScaleID") and len(arguments.IndicatorScaleID)>
			AND	IndicatorScaleID = <cfqueryparam value="#arguments.IndicatorScaleID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"isOutput") and len(arguments.isOutput)>
			AND	isOutput = <cfqueryparam value="#arguments.isOutput#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments,"isOutcome") and len(arguments.isOutcome)>
			AND	isOutcome = <cfqueryparam value="#arguments.isOutcome#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments,"objective") and len(arguments.objective)>
			AND	objective = <cfqueryparam value="#arguments.objective#" CFSQLType="cf_sql_varchar" />
		</cfif>		
		<cfif structKeyExists(arguments,"dataSource") and len(arguments.dataSource)>
			AND	dataSource = <cfqueryparam value="#arguments.dataSource#" CFSQLType="cf_sql_varchar" />
		</cfif>		
		<cfif structKeyExists(arguments,"dataFreq") and len(arguments.dataFreq)>
			AND	dataFreq = <cfqueryparam value="#arguments.dataFreq#" CFSQLType="cf_sql_varchar" />
		</cfif>		
		<cfif structKeyExists(arguments,"collectionMethod") and len(arguments.collectionMethod)>
			AND	collectionMethod = <cfqueryparam value="#arguments.collectionMethod#" CFSQLType="cf_sql_varchar" />
		</cfif>		
		<cfif structKeyExists(arguments,"indicatorIDList") and len(arguments.indicatorIDList)>
			AND	IndicatorID IN (#arguments.indicatorIDList#)
		</cfif>				
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getIndicatorWithSourceQuery" access="public" output="false" returntype="query">
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT *
			FROM	Indicator
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"IndicatorID") and len(arguments.IndicatorID)>
			AND	IndicatorID = <cfqueryparam value="#arguments.IndicatorID#" CFSQLType="cf_sql_integer" />
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>


	<cffunction name="getIndicatorDataSourceQuery" access="public" output="false" returntype="query">
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT * FROM	IndicatorDatasource
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"IndicatorID") and len(arguments.IndicatorID)>
			AND	IndicatorID = <cfqueryparam value="#arguments.IndicatorID#" CFSQLType="cf_sql_integer" />
		</cfif>
 		</cfquery>
		
		<cfreturn qList />
	</cffunction>


	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="IndicatorID" type="numeric" required="false" />
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
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="dataSource" type="string" required="false" />		
        <cfargument name="dataFreq" type="string" required="false" />		
        <cfargument name="collectionMethod" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","Indicator").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>

</cfcomponent>
