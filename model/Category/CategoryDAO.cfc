
<cfcomponent displayname="CategoryDAO" hint="table ID column = CategoryID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="CategoryDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="Category" type="Category" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Category
					(
					CategoryID,
					ParentID,
					Name,
					Description,
					ExternalCode
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Category.getCategoryID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Category.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Category.getParentID())#" />,
					<cfqueryparam value="#arguments.Category.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Category.getName())#" />,
					<cfqueryparam value="#arguments.Category.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Category.getDescription())#" />,
					<cfqueryparam value="#arguments.Category.getExternalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Category.getExternalCode())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Category" type="Category" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					CategoryID,
					ParentID,
					Name,
					Description,
					ExternalCode
				FROM	Category
				WHERE	CategoryID = <cfqueryparam value="#arguments.Category.getCategoryID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Category.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Category" type="Category" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Category
				SET
					ParentID = <cfqueryparam value="#arguments.Category.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Category.getParentID())#" />,
					Name = <cfqueryparam value="#arguments.Category.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Category.getName())#" />,
					Description = <cfqueryparam value="#arguments.Category.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Category.getDescription())#" />,
					ExternalCode = <cfqueryparam value="#arguments.Category.getExternalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Category.getExternalCode())#" />
				WHERE	CategoryID = <cfqueryparam value="#arguments.Category.getCategoryID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Category" type="Category" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	Category 
				WHERE	CategoryID = <cfqueryparam value="#arguments.Category.getCategoryID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Category" type="Category" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	Category
			WHERE	CategoryID = <cfqueryparam value="#arguments.Category.getCategoryID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Category" type="Category" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Category)>
			<cfset success = update(arguments.Category) />
		<cfelse>
			<cfset success = create(arguments.Category) />
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
