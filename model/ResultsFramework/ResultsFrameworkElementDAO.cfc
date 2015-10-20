
<cfcomponent displayname="ResultsFrameworkElementDAO" hint="table ID column = ResultsFrameworkElementID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />


	
	<cffunction name="init" access="public" output="false" returntype="ResultsFrameworkElementDAO">
       
        <cfreturn this>
	</cffunction>
	
 <!---   <cffunction name="new" access="public" output="false" returntype="ResultsFrameworkElement">
		
		<cfset var resultsFrameworkElement=instance.resultsFrameworkElement.init()>
        
        <cfreturn resultsFrameworkElement>
	</cffunction>--->
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElement" type="ResultsFrameworkElement" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ResultsFrameworkElement
					(
					ParentID,
                    ProgramID,
					Name,
					Description,
					DisplayNumber,
					Abbreviation,
					LevelDescription,
					ExternalCode,
					ExternalCodeDescription
					)
				VALUES
					(
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ResultsFrameworkElement.getParentID())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getProgramID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ResultsFrameworkElement.getProgramID())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getName())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getDescription())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getDisplayNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getDisplayNumber())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getAbbreviation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getAbbreviation())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getLevelDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getLevelDescription())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getExternalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getExternalCode())#" />,
					<cfqueryparam value="#arguments.ResultsFrameworkElement.getExternalCodeDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getExternalCodeDescription())#" />
					)
         SELECT @@IDENTITY as ResultsFrameworkElementID;
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn qCreate.ResultsFrameworkElementID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ResultsFrameworkElement" type="ResultsFrameworkElement" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					ResultsFrameworkElementID,
					ParentID,
                    ProgramID,
					Name,
					Description,
					DisplayNumber,
					Abbreviation,
					LevelDescription,
					ExternalCode,
					ExternalCodeDescription
				FROM	ResultsFrameworkElement
				WHERE	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElement.getResultsFrameworkElementID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ResultsFrameworkElement.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElement" type="ResultsFrameworkElement" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ResultsFrameworkElement
				SET
					ParentID = <cfqueryparam value="#arguments.ResultsFrameworkElement.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ResultsFrameworkElement.getParentID())#" />,
					ProgramID = <cfqueryparam value="#arguments.ResultsFrameworkElement.getProgramID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ResultsFrameworkElement.getProgramID())#" />,
                    Name = <cfqueryparam value="#arguments.ResultsFrameworkElement.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getName())#" />,
					Description = <cfqueryparam value="#arguments.ResultsFrameworkElement.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getDescription())#" />,
					DisplayNumber = <cfqueryparam value="#arguments.ResultsFrameworkElement.getDisplayNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getDisplayNumber())#" />,
					Abbreviation = <cfqueryparam value="#arguments.ResultsFrameworkElement.getAbbreviation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getAbbreviation())#" />,
					LevelDescription = <cfqueryparam value="#arguments.ResultsFrameworkElement.getLevelDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getLevelDescription())#" />,
					ExternalCode = <cfqueryparam value="#arguments.ResultsFrameworkElement.getExternalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getExternalCode())#" />,
					ExternalCodeDescription = <cfqueryparam value="#arguments.ResultsFrameworkElement.getExternalCodeDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ResultsFrameworkElement.getExternalCodeDescription())#" />
				WHERE	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElement.getResultsFrameworkElementID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElement" type="ResultsFrameworkElement" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ResultsFrameworkElement 
				WHERE	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElement.getResultsFrameworkElementID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElement" type="ResultsFrameworkElement" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ResultsFrameworkElement
            
			WHERE	ResultsFrameworkElementID 
            <cfif arguments.ResultsFrameworkElement.getResultsFrameworkElementID() is "">
			is NULL           
          	<cfelse>
            
           = <cfqueryparam value="#arguments.ResultsFrameworkElement.getResultsFrameworkElementID()#" CFSQLType="cf_sql_integer" />
           </cfif>
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElement" type="ResultsFrameworkElement" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.ResultsFrameworkElement)>
			<cfset success = update(arguments.ResultsFrameworkElement) />
		<cfelse>
			<cfset success = create(arguments.ResultsFrameworkElement) />
		</cfif>
		
		<cfreturn success />
	</cffunction>

	<cffunction name="queryRowToStruct" access="public" output="false" returntype="struct">
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
