
<cfcomponent displayname="AttachedFileGateway" output="false">


	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />


	<cffunction name="init" access="public" output="false" returntype="AttachedFileGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="AttachedFileID" type="numeric" required="false" />
		<cfargument name="ObjectTableName" type="string" required="false" />
		<cfargument name="ObjectTableID" type="numeric" required="false" />
		<cfargument name="cnID" type="numeric" required="false" />
        <cfargument name="Name" type="string" required="false" />
		<cfargument name="LongDescription" type="string" required="false" />
		<cfargument name="AttachedFileName" type="string" required="false" />
		<cfargument name="UploadedFileName" type="string" required="false" />
		<cfargument name="AttachedFileDate" type="date" required="false" />
		<cfargument name="AttachedFileIDList" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" default="attachedfiledate desc" />
		<cfargument name="isArchived" type="numeric" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				AttachedFileID,
                ObjectTableName,
				ObjectTableID,
				Name,
				LongDescription,
				AttachedFileName,
				UploadedFileName,
				AttachedFileDate, 
				cnID
			FROM	vw_AttachedFiles
			WHERE	isactive = 1
		
		<cfif structKeyExists(arguments,"AttachedFileID") and len(arguments.AttachedFileID)>
			AND	AttachedFileID = <cfqueryparam value="#arguments.AttachedFileID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ObjectTableName") and len(arguments.ObjectTableName)>
			AND	ObjectTableName = <cfqueryparam value="#arguments.ObjectTableName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ObjectTableID") and len(arguments.ObjectTableID)>
			AND	ObjectTableID = <cfqueryparam value="#arguments.ObjectTableID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"cnID") and len(arguments.cnID)>
			AND	cnID = <cfqueryparam value="#arguments.cnID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"LongDescription") and len(arguments.LongDescription)>
			AND	LongDescription = <cfqueryparam value="#arguments.LongDescription#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"AttachedFileName") and len(arguments.AttachedFileName)>
			AND	AttachedFileName = <cfqueryparam value="#arguments.AttachedFileName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"UploadedFileName") and len(arguments.UploadedFileName)>
			AND	UploadedFileName = <cfqueryparam value="#arguments.UploadedFileName#" CFSQLType="cf_sql_varchar" />
		</cfif>		
		<cfif structKeyExists(arguments,"AttachedFileDate") and len(arguments.AttachedFileDate)>
			AND	AttachedFileDate = <cfqueryparam value="#arguments.AttachedFileDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"AttachedFileIDList") and len(arguments.AttachedFileIDList)>
			AND	AttachedFileID IN (<cfqueryparam value="#arguments.AttachedFileIDList#" CFSQLType="cf_sql_integer" list="true"/>)
		</cfif>		
		<cfif structKeyExists(arguments,"isArchived") and len(arguments.isArchived)>
			AND	isArchived = <cfqueryparam value="#arguments.isArchived#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="AttachedFileID" type="numeric" required="false" />
		<cfargument name="ObjectTableName" type="string" required="false" />
		<cfargument name="ObjectTableID" type="numeric" required="false" />
        
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="LongDescription" type="string" required="false" />
		<cfargument name="AttachedFileName" type="string" required="false" />
		<cfargument name="UploadedFileName" type="string" required="false" />
		<cfargument name="AttachedFileDate" type="date" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","AttachedFile").init(argumentCollection=queryRowToStruct(qList,i)) />
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