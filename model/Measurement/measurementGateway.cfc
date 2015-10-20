
<cfcomponent displayname="measurementGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="measurementGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="MeasurementID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="DisaggID" type="numeric" required="false" />
		<cfargument name="isBaseline" type="boolean" required="false" />
		<cfargument name="Actual" type="numeric" required="false" />
		<cfargument name="ActualNotes" type="string" required="false" />
		<cfargument name="Target" type="numeric" required="false" />
		<cfargument name="TargetNotes" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="ReportDate" type="date" required="false" />
		<cfargument name="ReviewedBy" type="string" required="false" />
		<cfargument name="ReviewDate" type="string" required="false" />
		<cfargument name="ReviewType" type="string" required="false" />
		<cfargument name="ReviewNotes" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				MeasurementID,
				ActivityID,
				IndicatorID,
				DisaggID,
				isBaseline,
				Actual,
				ActualNotes,
				Target,
				TargetNotes,
				StartDate,
				EndDate,
				ReportDate,
				ReviewedBy,
				ReviewDate,
				ReviewType,
				ReviewNotes
			FROM	Measurement
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"MeasurementID") and len(arguments.MeasurementID)>
			AND	MeasurementID = <cfqueryparam value="#arguments.MeasurementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"IndicatorID") and len(arguments.IndicatorID)>
			AND	IndicatorID = <cfqueryparam value="#arguments.IndicatorID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"DisaggID") and len(arguments.DisaggID)>
			AND	DisaggID = <cfqueryparam value="#arguments.DisaggID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"isBaseline") and len(arguments.isBaseline)>
			AND	isBaseline = <cfqueryparam value="#arguments.isBaseline#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments,"Actual") and len(arguments.Actual)>
			AND	Actual = <cfqueryparam value="#arguments.Actual#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActualNotes") and len(arguments.ActualNotes)>
			AND	ActualNotes = <cfqueryparam value="#arguments.ActualNotes#" CFSQLType="cf_sql_longvarchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Target") and len(arguments.Target)>
			AND	Target = <cfqueryparam value="#arguments.Target#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"TargetNotes") and len(arguments.TargetNotes)>
			AND	TargetNotes = <cfqueryparam value="#arguments.TargetNotes#" CFSQLType="cf_sql_longvarchar" />
		</cfif>
		<cfif structKeyExists(arguments,"StartDate") and len(arguments.StartDate)>
			AND	StartDate = <cfqueryparam value="#arguments.StartDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"EndDate") and len(arguments.EndDate)>
			AND	EndDate = <cfqueryparam value="#arguments.EndDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"ReportDate") and len(arguments.ReportDate)>
			AND	ReportDate = <cfqueryparam value="#arguments.ReportDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"ReviewedBy") and len(arguments.ReviewedBy)>
			AND	ReviewedBy = <cfqueryparam value="#arguments.ReviewedBy#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ReviewDate") and len(arguments.ReviewDate)>
			AND	ReviewDate = <cfqueryparam value="#arguments.ReviewDate#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ReviewType") and len(arguments.ReviewType)>
			AND	ReviewType = <cfqueryparam value="#arguments.ReviewType#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ReviewNotes") and len(arguments.ReviewNotes)>
			AND	ReviewNotes = <cfqueryparam value="#arguments.ReviewNotes#" CFSQLType="cf_sql_longvarchar" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="MeasurementID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="DisaggID" type="numeric" required="false" />
		<cfargument name="isBaseline" type="boolean" required="false" />
		<cfargument name="Actual" type="numeric" required="false" />
		<cfargument name="ActualNotes" type="string" required="false" />
		<cfargument name="Target" type="numeric" required="false" />
		<cfargument name="TargetNotes" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="ReportDate" type="date" required="false" />
		<cfargument name="ReviewedBy" type="string" required="false" />
		<cfargument name="ReviewDate" type="string" required="false" />
		<cfargument name="ReviewType" type="string" required="false" />
		<cfargument name="ReviewNotes" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","measurement").init(argumentCollection=queryRowToStruct(qList,i)) />
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
	
	<cffunction name="getIndicatorMeasurements" access="public" output="false" returntype="query">
		<cfargument name="activityID" type="numeric" required="true" />
		<cfargument name="indicatorID" type="numeric" required="false" />
		<cfargument name="measureType" type="string" required="false" />

		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				indicatorname,
				IndicatorID,
				measurementID,
				activityid,
				ResultsFrameworkElementID,
				actual,
				target,
				startdate,
				enddate,
				disaggid,
				isbaseline,
				disaggname,
				disaggsetname,
				objective
			FROM	vw_fullMeasurements
			WHERE	activityid = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
			<cfif structKeyExists(arguments,"indicatorID") and len(arguments.indicatorID)>
				AND	indicatorID = <cfqueryparam value="#arguments.indicatorID#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments,"measureType") and arguments.measureType is 'primary'>
				and disaggid is null
			<cfelseif structKeyExists(arguments,"measureType") and arguments.measureType is 'disagg'>
				and disaggid is not null
			</cfif>	    
		    and (isbaseline is null or isbaseline = 0)
		    order by startdate, objective, indicatorname, disaggid

		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="deleteActivityMeasurements" access="public" output="false" returntype="boolean">
		<cfargument name="activityID" type="numeric" required="true" />
	
		<cfset var qDelete = "" />		
		<cfquery name="qDelete" datasource="#dsn.getName()#">
			DELETE
			FROM	Measurement
			WHERE	activityid = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
		</cfquery>
	<cfreturn true />
	</cffunction>

	<cffunction name="reconcileActivityMeasurements" access="public" output="false" returntype="boolean">
		<cfargument name="activityID" type="numeric" required="true" />
		<cfargument name="startdate" type="string" required="true" />
		<cfargument name="enddate" type="string" required="true" />
		<cfargument name="countrylist" type="string" required="true" />
	
		<cfset var qReconcile = "" />		
		<cfquery name="qReconcile" datasource="#dsn.getName()#">
			DELETE
			FROM	Measurement
			WHERE	activityid = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
			and 	((enddate < '#arguments.startdate#' or startdate > '#arguments.enddate#') or disaggid not in (#arguments.countrylist#))
		</cfquery>
	<cfreturn true />
	</cffunction>
	
</cfcomponent>
