
<cfcomponent displayname="IndicatorDAO" hint="table ID column = IndicatorID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="IndicatorDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="Numeric">
		<cfargument name="Indicator" type="Indicator" required="true" />
			
		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Indicator
					(
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
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Indicator.getParentID()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getParentID())#" />,
					<cfqueryparam value="#arguments.Indicator.getResponsiblePersonID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getResponsiblePersonID())#" />,
					<cfqueryparam value="#arguments.Indicator.getResultsFrameworkElementID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getResultsFrameworkElementID())#" />,
					<cfqueryparam value="#arguments.Indicator.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getName())#" />,
					<cfqueryparam value="#arguments.Indicator.getDefinition()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getDefinition())#" />,
					<cfqueryparam value="#arguments.Indicator.getJustification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getJustification())#" />,
					<cfqueryparam value="#arguments.Indicator.getIntendedChangeDirection()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getIntendedChangeDirection())#" />,
					<cfqueryparam value="#arguments.Indicator.getIsOnAnnualReport()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getIsOnAnnualReport())#" />,
					<cfqueryparam value="#arguments.Indicator.getIndicatorCategoryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getIndicatorCategoryID())#" />,
					<cfqueryparam value="#arguments.Indicator.getUnitofMeasure()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getUnitofMeasure())#" />,
					<cfqueryparam value="#arguments.Indicator.getIndicatorScaleID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getIndicatorScaleID())#" />,
					<cfqueryparam value="#arguments.Indicator.getisOutput()#" CFSQLType="cf_sql_bit" null="#not len(arguments.Indicator.getisOutput())#" />,
					<cfqueryparam value="#arguments.Indicator.getisOutcome()#" CFSQLType="cf_sql_bit" null="#not len(arguments.Indicator.getisOutcome())#" />,
					<cfqueryparam value="#arguments.Indicator.getobjective()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getobjective())#" />,
					<cfqueryparam value="#arguments.Indicator.getDatasource()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getdataSource())#" />,			
                    <cfqueryparam value="#arguments.Indicator.getdataFreq()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getdataFreq())#" />,				
                     <cfqueryparam value="#arguments.Indicator.getcollectionMethod()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getcollectionMethod())#" />					
                   );
				SELECT @@IDENTITY as IndicatorID;
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn qCreate.IndicatorID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Indicator" type="Indicator" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
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
				WHERE	IndicatorID = <cfqueryparam value="#arguments.Indicator.getIndicatorID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Indicator.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="numeric">
		<cfargument name="Indicator" type="Indicator" required="true" />
	
		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Indicator
				SET
					ParentID = <cfqueryparam value="#arguments.Indicator.getParentID()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getParentID())#" />,
					ResponsiblePersonID = <cfqueryparam value="#arguments.Indicator.getResponsiblePersonID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getResponsiblePersonID())#" />,
					ResultsFrameworkElementID = <cfqueryparam value="#arguments.Indicator.getResultsFrameworkElementID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getResultsFrameworkElementID())#" />,
					Name = <cfqueryparam value="#arguments.Indicator.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getName())#" />,
					Definition = <cfqueryparam value="#arguments.Indicator.getDefinition()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getDefinition())#" />,
					Justification = <cfqueryparam value="#arguments.Indicator.getJustification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getJustification())#" />,
					IntendedChangeDirection = <cfqueryparam value="#arguments.Indicator.getIntendedChangeDirection()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getIntendedChangeDirection())#" />,
					IsOnAnnualReport = <cfqueryparam value="#arguments.Indicator.getIsOnAnnualReport()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getIsOnAnnualReport())#" />,
					IndicatorCategoryID = <cfqueryparam value="#arguments.Indicator.getIndicatorCategoryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getIndicatorCategoryID())#" />,
					UnitofMeasure = <cfqueryparam value="#arguments.Indicator.getUnitofMeasure()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getUnitofMeasure())#" />,
					IndicatorScaleID = <cfqueryparam value="#arguments.Indicator.getIndicatorScaleID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Indicator.getIndicatorScaleID())#" />,
					isOutput = <cfqueryparam value="#arguments.Indicator.getisOutput()#" CFSQLType="cf_sql_bit" null="#not len(arguments.Indicator.getisOutput())#" />,
					isOutcome = <cfqueryparam value="#arguments.Indicator.getisOutcome()#" CFSQLType="cf_sql_bit" null="#not len(arguments.Indicator.getisOutcome())#" />,
					objective = <cfqueryparam value="#arguments.Indicator.getobjective()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getobjective())#" />,
                   	dataSource = <cfqueryparam value="#arguments.Indicator.getDataSource()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getDataSource())#" />,
                   	dataFreq = <cfqueryparam value="#arguments.Indicator.getDataFreq()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getDataFreq())#" />,
                   	collectionMethod = <cfqueryparam value="#arguments.Indicator.getcollectionMethod()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Indicator.getcollectionMethod())#" />
				WHERE	IndicatorID = <cfqueryparam value="#arguments.Indicator.getIndicatorID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn arguments.Indicator.getIndicatorID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Indicator" type="Indicator" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	Indicator 
				WHERE	IndicatorID = <cfqueryparam value="#arguments.Indicator.getIndicatorID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Indicator" type="Indicator" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	Indicator
			WHERE	IndicatorID = <cfqueryparam value="#arguments.Indicator.getIndicatorID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="numeric">
		<cfargument name="Indicator" type="Indicator" required="true" />
		<cfset var success = false />
		<cfif Indicator.getIndicatorID() is not "" and exists(arguments.Indicator)>
			<cfset success = update(arguments.Indicator) />
		<cfelse>
			<cfset success = create(arguments.Indicator) />
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
