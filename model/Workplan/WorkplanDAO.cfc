<cfcomponent displayname="WorkplanDAO" hint="table ID column = WorkplanID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="WorkplanDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="Numeric">
		<cfargument name="Workplan" type="Workplan" required="true" />

		<cfset var qCreate = "" />
		<!--- <cftry> --->
		
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Workplan
					(
					ActivityID,
					Name,
					Description,
					StartDate,
					EndDate,                 
					CompleteDate
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Workplan.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Workplan.getActivityID())#" />,
					<cfqueryparam value="#arguments.Workplan.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Workplan.getName())#" />,
					<cfqueryparam value="#left(arguments.Workplan.getDescription(),4000)#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Workplan.getDescription())#" />,
					<cfqueryparam value="#arguments.Workplan.getStartDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Workplan.getStartDate())#" />,
					<cfqueryparam value="#arguments.Workplan.getEndDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Workplan.getEndDate())#" />,
					<cfqueryparam value="#arguments.Workplan.getCompleteDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Workplan.getCompleteDate())#" />
					)
					SELECT @@Identity as WorkplanID
			</cfquery>

		<cfreturn qCreate.WorkplanID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Workplan" type="Workplan" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT 
					Workplan.WorkplanID, 
					Workplan.ActivityID, 
					Workplan.Name, 
					Workplan.Description, 
				  	Workplan.StartDate, 
					Workplan.EndDate, 
					Workplan.CompleteDate
									
				FROM Workplan 
				WHERE	Workplan.WorkplanID = <cfqueryparam value="#arguments.Workplan.getWorkplanID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Workplan.init(argumentCollection=strReturn)>
		<cfelse>
		  <cfthrow type="IndexOutOfRangeException" message="No Workplan found matching the request criteria (arguments.Workplan.getWorkplanID()=#arguments.Workplan.getWorkplanID()#)." />
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="Numeric">
		<cfargument name="Workplan" type="Workplan" required="true" />

		<cfset var qUpdate = "" />

				<cfquery name="qUpdate" datasource="#dsn.getName()#">
					UPDATE	Workplan
					SET
						ActivityID = <cfqueryparam value="#arguments.Workplan.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Workplan.getActivityID())#" />,
						Name = <cfqueryparam value="#left(arguments.Workplan.getName(),255)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Workplan.getName())#" />,
						Description = <cfqueryparam value="#left(arguments.Workplan.getDescription(),4000)#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Workplan.getDescription())#" />,
						StartDate = <cfqueryparam value="#arguments.Workplan.getStartDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Workplan.getStartDate())#" />,
						EndDate = <cfqueryparam value="#arguments.Workplan.getEndDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Workplan.getEndDate())#" />,
						CompleteDate = <cfqueryparam value="#arguments.Workplan.getCompleteDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Workplan.getCompleteDate())#" />

					WHERE	WorkplanID = <cfqueryparam value="#arguments.Workplan.getWorkplanID()#" CFSQLType="cf_sql_integer" />
				</cfquery>

				

		<cfreturn arguments.Workplan.getWorkplanID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Workplan" type="Workplan" required="true" />

		<cfset var qDelete = "">
		<cftry>
			
			<cfquery name="qDelete1" datasource="#dsn.getName()#">
				DELETE FROM	Workplan 
				WHERE	WorkplanID = <cfqueryparam value="#arguments.Workplan.getWorkplanID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
					
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Workplan" type="Workplan" required="true" />

		<cfset var qExists = "">
		<cfif arguments.Workplan.getWorkplanID() is not "">
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	Workplan
				WHERE	WorkplanID = <cfqueryparam value="#arguments.Workplan.getWorkplanID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<cfif qExists.idexists>
				<cfreturn true />
			<cfelse>
				<cfreturn false />
			</cfif>
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Workplan" type="Workplan" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Workplan)>
			<cfset success = update(arguments.Workplan) />
		<cfelse>
			<cfset success = create(arguments.Workplan) />
		</cfif>
		
		<cfreturn success />
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<!---TODO: Refactor this method and move it into an application scoped utility library. 
		There are about 30 declarations of this method throughout the app. 
		--->
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
