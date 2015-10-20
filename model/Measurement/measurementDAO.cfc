
<cfcomponent displayname="measurementDAO" hint="table ID column = MeasurementID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="measurementDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="measurement" type="measurement" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Measurement
					(
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
					)
				VALUES
					(
					<cfqueryparam value="#arguments.measurement.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getActivityID())#" />,
					<cfqueryparam value="#arguments.measurement.getIndicatorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getIndicatorID())#" />,
					<cfqueryparam value="#arguments.measurement.getDisaggID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getDisaggID())#" />,
					<cfqueryparam value="#arguments.measurement.getisBaseline()#" CFSQLType="cf_sql_bit" null="#not len(arguments.measurement.getisBaseline())#" />,
					<cfqueryparam value="#arguments.measurement.getActual()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getActual())#" />,
					<cfqueryparam value="#arguments.measurement.getActualNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.measurement.getActualNotes())#" />,
					<cfqueryparam value="#arguments.measurement.getTarget()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getTarget())#" />,
					<cfqueryparam value="#arguments.measurement.getTargetNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.measurement.getTargetNotes())#" />,
					<cfqueryparam value="#arguments.measurement.getStartDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.measurement.getStartDate())#" />,
					<cfqueryparam value="#arguments.measurement.getEndDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.measurement.getEndDate())#" />,
					<cfqueryparam value="#arguments.measurement.getReportDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.measurement.getReportDate())#" />,
					<cfqueryparam value="#arguments.measurement.getReviewedBy()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.measurement.getReviewedBy())#" />,
					<cfqueryparam value="#arguments.measurement.getReviewDate()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.measurement.getReviewDate())#" />,
					<cfqueryparam value="#arguments.measurement.getReviewType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.measurement.getReviewType())#" />,
					<cfqueryparam value="#arguments.measurement.getReviewNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.measurement.getReviewNotes())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="measurement" type="measurement" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
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
				WHERE	MeasurementID = <cfqueryparam value="#arguments.measurement.getMeasurementID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.measurement.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="measurement" type="measurement" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Measurement
				SET
					ActivityID = <cfqueryparam value="#arguments.measurement.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getActivityID())#" />,
					IndicatorID = <cfqueryparam value="#arguments.measurement.getIndicatorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getIndicatorID())#" />,
					DisaggID = <cfqueryparam value="#arguments.measurement.getDisaggID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getDisaggID())#" />,
					isBaseline = <cfqueryparam value="#arguments.measurement.getisBaseline()#" CFSQLType="cf_sql_bit" null="#not len(arguments.measurement.getisBaseline())#" />,
					Actual = <cfqueryparam value="#arguments.measurement.getActual()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getActual())#" />,
					ActualNotes = <cfqueryparam value="#arguments.measurement.getActualNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.measurement.getActualNotes())#" />,
					Target = <cfqueryparam value="#arguments.measurement.getTarget()#" CFSQLType="cf_sql_integer" null="#not len(arguments.measurement.getTarget())#" />,
					TargetNotes = <cfqueryparam value="#arguments.measurement.getTargetNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.measurement.getTargetNotes())#" />,
					StartDate = <cfqueryparam value="#arguments.measurement.getStartDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.measurement.getStartDate())#" />,
					EndDate = <cfqueryparam value="#arguments.measurement.getEndDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.measurement.getEndDate())#" />,
					ReportDate = <cfqueryparam value="#arguments.measurement.getReportDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.measurement.getReportDate())#" />,
					ReviewedBy = <cfqueryparam value="#arguments.measurement.getReviewedBy()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.measurement.getReviewedBy())#" />,
					ReviewDate = <cfqueryparam value="#arguments.measurement.getReviewDate()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.measurement.getReviewDate())#" />,
					ReviewType = <cfqueryparam value="#arguments.measurement.getReviewType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.measurement.getReviewType())#" />,
					ReviewNotes = <cfqueryparam value="#arguments.measurement.getReviewNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.measurement.getReviewNotes())#" />
				WHERE	MeasurementID = <cfqueryparam value="#arguments.measurement.getMeasurementID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="measurement" type="measurement" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	Measurement 
				WHERE	MeasurementID = <cfqueryparam value="#arguments.measurement.getMeasurementID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="measurement" type="measurement" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	Measurement
			WHERE	MeasurementID = <cfqueryparam value="#arguments.measurement.getMeasurementID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="measurement" type="measurement" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.measurement)>
			<cfset success = update(arguments.measurement) />
		<cfelse>
			<cfset success = create(arguments.measurement) />
		</cfif>
		
		<cfreturn success />
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
