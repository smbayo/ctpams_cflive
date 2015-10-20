<cfcomponent displayname="ProgramDAO" hint="table ID column = ProgramID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ProgramDAO">
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="Program" type="Program" required="true" />

		<cfset var qCreate = "" />
		
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Program
					(
					ParentID,
					Name,
					Description,
					Address1,
					Address2,
					City,
					PostalCode,
					CountryID,
					Telephone
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Program.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getParentID())#" />,
					<cfqueryparam value="#arguments.Program.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getName())#" />,
					<cfqueryparam value="#arguments.Program.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getDescription())#" />,
					<cfqueryparam value="#arguments.Program.getAddress1()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getAddress1())#" />,
					<cfqueryparam value="#arguments.Program.getAddress2()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getAddress2())#" />,
					<cfqueryparam value="#arguments.Program.getCity()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getCity())#" />,
					<cfqueryparam value="#arguments.Program.getPostalCode()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getPostalCode())#" />,
					<cfqueryparam value="#arguments.Program.getCountryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getCountryID())#" />,
					<cfqueryparam value="#arguments.Program.getTelephone()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getTelephone())#" />
					)
			</cfquery>

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Program" type="Program" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					ProgramID,
					ParentID,
					Name,
					Description,
					Address1,
					Address2,
					City,
					PostalCode,
					CountryID,
					Telephone
				FROM	Program
				WHERE	ProgramID = <cfqueryparam value="#arguments.Program.getProgramID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Program.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Program" type="Program" required="true" />

		<cfset var qUpdate = "" />
		
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Program
				SET
					ParentID = <cfqueryparam value="#arguments.Program.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getParentID())#" />,
					Name = <cfqueryparam value="#arguments.Program.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getName())#" />,
					Description = <cfqueryparam value="#arguments.Program.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getDescription())#" />,
					Address1 = <cfqueryparam value="#arguments.Program.getAddress1()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getAddress1())#" />,
					Address2 = <cfqueryparam value="#arguments.Program.getAddress2()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getAddress2())#" />,
					City = <cfqueryparam value="#arguments.Program.getCity()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Program.getCity())#" />,
					PostalCode = <cfqueryparam value="#arguments.Program.getPostalCode()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getPostalCode())#" />,
					CountryID = <cfqueryparam value="#arguments.Program.getCountryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getCountryID())#" />,
					Telephone = <cfqueryparam value="#arguments.Program.getTelephone()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Program.getTelephone())#" />
		
                
                WHERE	ProgramID = <cfqueryparam value="#arguments.Program.getProgramID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Program" type="Program" required="true" />

		<cfset var qDelete = "">
		
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	Program 
				WHERE	ProgramID = <cfqueryparam value="#arguments.Program.getProgramID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Program" type="Program" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	Program
			WHERE	ProgramID = <cfqueryparam value="#arguments.Program.getProgramID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Program" type="Program" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Program)>
			<cfset success = update(arguments.Program) />
		<cfelse>
			<cfset success = create(arguments.Program) />
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
