
<cfcomponent displayname="AttachedFileDAO" hint="table ID column = AttachedFileID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="AttachedFileDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="numeric">
		<cfargument name="AttachedFile" type="AttachedFile" required="true" />

		<cfset var qCreate = "" />
<!---		<cftry>--->
			<cfquery name="qcreate" datasource="#dsn.getName()#">
				INSERT INTO AttachedFile
					(
					<!---AttachedFileID,--->
					Name,
                    ObjectTableName,
                    ObjectTableID,
					LongDescription,
					AttachedFileName,
					UploadedFileName,
					AttachedFileDate
					)
				VALUES
					(
					<!---<cfqueryparam value="#arguments.AttachedFile.getAttachedFileID()#" CFSQLType="cf_sql_integer" />,--->
					<cfqueryparam value="#arguments.AttachedFile.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getName())#" />,
                    <cfqueryparam value="#arguments.AttachedFile.getObjectTableName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getObjectTableName())#" />,
                    <cfqueryparam value="#arguments.AttachedFile.getObjectTableID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.AttachedFile.getObjectTableID())#" />,
					<cfqueryparam value="#arguments.AttachedFile.getLongDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getLongDescription())#" />,
					<cfqueryparam value="#arguments.AttachedFile.getAttachedFileName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getAttachedFileName())#" />,
					<cfqueryparam value="#arguments.AttachedFile.getUploadedFileName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getUploadedFileName())#" />,
					<cfqueryparam value="#arguments.AttachedFile.getAttachedFileDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AttachedFile.getAttachedFileDate())#" />
					)
					select @@identity as maxid
			</cfquery>
			<!---<cfcatch type="database">--->
            	<!-- <cfreturn qcreate.maxid /> -->
			<!---</cfcatch>
		</cftry>--->
		<cfreturn true />
	</cffunction>

	<cffunction name="grabLastID" access="public" output="false" returntype="query">
		<cfset var qLastID = "" />
		<!--- <cftry> --->
        
			<cfquery name="qLastID" datasource="#dsn.getName()#">
				select max(doc_id) as maxdoc from project_documents
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn qLastID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="AttachedFile" type="AttachedFile" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<!--- <cftry> --->
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					AttachedFileID,
					Name,
                    ObjectTableName,
                    ObjectTableID,
                    LongDescription,
					AttachedFileName,
					UploadedFileName,
					AttachedFileDate
				FROM	AttachedFile
				WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFile.getAttachedFileID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database"> --->
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<!--- <cfset qRead = queryNew("id") />
			</cfcatch> --->
		<!--- </cftry> ---> 
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.AttachedFile.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFile" type="AttachedFile" required="true" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	AttachedFile
				SET
					Name = <cfqueryparam value="#arguments.AttachedFile.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getName())#" />,                    
                    ObjectTableName = <cfqueryparam value="#arguments.AttachedFile.getObjectTableName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getObjectTableName())#" />,
                    ObjectTableID = <cfqueryparam value="#arguments.AttachedFile.getObjectTableID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.AttachedFile.getObjectTableID())#" />,
					LongDescription = <cfqueryparam value="#arguments.AttachedFile.getLongDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getLongDescription())#" />,
					AttachedFileName = <cfqueryparam value="#arguments.AttachedFile.getAttachedFileName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getAttachedFileName())#" />,
					UploadedFileName = <cfqueryparam value="#arguments.AttachedFile.getUploadedFileName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AttachedFile.getUploadedFileName())#" />,
					AttachedFileDate = <cfqueryparam value="#arguments.AttachedFile.getAttachedFileDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AttachedFile.getAttachedFileDate())#" />
				WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFile.getAttachedFileID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="archive" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />

		<cfset var qArchive = "" />
		<!--- <cftry> --->
			<cfquery name="qArchive" datasource="#dsn.getName()#">
				UPDATE	AttachedFile
				SET
                    isArchived = 1
				WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFileID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="deactivate" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />

		<cfset var qArchive = "" />
		<!--- <cftry> --->
			<cfquery name="qArchive" datasource="#dsn.getName()#">
				UPDATE	AttachedFile
				SET
                    isActive = 0
				WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFileID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="rename" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		<cfargument name="name" type="string" required="true" />

		<cfset var qrename = "" />
		<!--- <cftry> --->
			<cfquery name="qrename" datasource="#dsn.getName()#">
				UPDATE	AttachedFile
				SET
                    name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Name)#" />
				WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFileID#" CFSQLType="cf_sql_integer" />
			</cfquery>
>
		<cfreturn true />
	</cffunction>

	<cffunction name="unarchive" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />

		<cfset var qArchive = "" />
		<!--- <cftry> --->
			<cfquery name="qArchive" datasource="#dsn.getName()#">
				UPDATE	AttachedFile
				SET
                    isArchived = 0
				WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFileID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFile" type="AttachedFile" required="true" />

		<cfset var qDelete = "">
		<!--- <cftry> --->
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	AttachedFile 
				WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFile.getAttachedFileID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFile" type="AttachedFile" required="true" />

		<cfset var qExists = "">
		<cfif      arguments.AttachedFile.getAttachedFileID() is ''>
           <cfreturn false>
        </cfif>
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	AttachedFile
			WHERE	AttachedFileID = <cfqueryparam value="#arguments.AttachedFile.getAttachedFileID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFile" type="AttachedFile" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.AttachedFile)>
			<cfset success = update(arguments.AttachedFile) />
		<cfelse>
			<cfset success = create(arguments.AttachedFile) />
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
