<cfcomponent displayname="ActivityLegalRecommendationGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="ActivityLegalRecommendationGateway">
		<cfreturn this />
	</cffunction>

	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityRecommID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="ActivityStatusID" type="numeric" required="false" />
		<cfargument name="Sender" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="commentType" type="string" required="false" />
		<cfargument name="commentDate" type="date" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="cnOnly" type="boolean" required="false" />

		<cfset var qList = "" />
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ActivityRecommID,
				ActivityID,
				CNID,
				ActivityStatusID,
				Sender,
				Comments,
				commentType,
				commentDate,
				isActive,
				sysUserID
			FROM	ActivityLegalRecommendation
			WHERE	0=0

		<cfif structKeyExists(arguments,"ActivityRecommID") and len(arguments.ActivityRecommID)>
			AND	ActivityRecommID = <cfqueryparam value="#arguments.ActivityRecommID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CNID") and len(arguments.CNID)>
			AND	CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityStatusID") and len(arguments.ActivityStatusID)>
			AND	ActivityStatusID = <cfqueryparam value="#arguments.ActivityStatusID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Sender") and len(arguments.Sender)>
			AND	Sender = <cfqueryparam value="#arguments.Sender#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Comments") and len(arguments.Comments)>
			AND	Comments = <cfqueryparam value="#arguments.Comments#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"commentType") and len(arguments.commentType)>
			AND	commentType = <cfqueryparam value="#arguments.commentType#" CFSQLType="cf_sql_varchar" />
		<cfelse>
			AND	commentType is null
		</cfif>
		<cfif structKeyExists(arguments,"commentDate") and len(arguments.commentDate)>
			AND	commentDate = <cfqueryparam value="#arguments.commentDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"isActive") and len(arguments.isActive)>
			AND	isActive = <cfqueryparam value="#arguments.isActive#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments,"sysUserID") and len(arguments.sysUserID)>
			AND	sysUserID = <cfqueryparam value="#arguments.sysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"cnOnly") and len(arguments.cnOnly)>
			AND	ActivityStatusID in (276,277,278,279,280,281,282,283,284,285,286,287,288)
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>

		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ActivityRecommID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="ActivityStatusID" type="numeric" required="false" />
		<cfargument name="Sender" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="commentType" type="string" required="false" />
		<cfargument name="commentDate" type="date" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />

		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ActivityLegalRecommendation").init(argumentCollection=queryRowToStruct(qList,i)) />
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
