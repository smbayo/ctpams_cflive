<cfcomponent displayname="ActivityObligationGateway" output="false">
	
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityObligationGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityObligateID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="Amount" type="numeric" required="false" />
		<cfargument name="obligationDate" type="date" required="false" />
		<cfargument name="ObligationFYyearSource" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="order" type="string" required="false" />
		<cfargument name="obligationNumber" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ActivityObligateID,
				ActivityID,
				Amount,
				obligationDate,
				ObligationFYyearSource,
				Comments,
				isActive,
				sysUserID,
				ObligationNumber
				<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
				,(SELECT isNull(sum(Amount),0) FROM ActivityObligation v1 WHERE v1.ActivityID = ActivityObligation.ActivityID) totalObligAmount
				</cfif>
			FROM	ActivityObligation
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ActivityObligateID") and len(arguments.ActivityObligateID)>
			AND	ActivityObligateID = <cfqueryparam value="#arguments.ActivityObligateID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Amount") and len(arguments.Amount)>
			AND	Amount = <cfqueryparam value="#arguments.Amount#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"obligationDate") and len(arguments.obligationDate)>
			AND	obligationDate = <cfqueryparam value="#arguments.obligationDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"ObligationFYyearSource") and len(arguments.ObligationFYyearSource)>
			AND	ObligationFYyearSource = <cfqueryparam value="#arguments.ObligationFYyearSource#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Comments") and len(arguments.Comments)>
			AND	Comments = <cfqueryparam value="#arguments.Comments#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"isActive") and len(arguments.isActive)>
			AND	isActive = <cfqueryparam value="#arguments.isActive#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments,"sysUserID") and len(arguments.sysUserID)>
			AND	sysUserID = <cfqueryparam value="#arguments.sysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ObligationNumber") and len(arguments.ObligationNumber)>
			AND	ObligationNumber = <cfqueryparam value="#arguments.ObligationNumber#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby# <cfif structKeyExists(arguments, "order") and len(arguments.order)> #arguments.order# </cfif>
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ActivityObligateID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="Amount" type="numeric" required="false" />
		<cfargument name="obligationDate" type="date" required="false" />
		<cfargument name="ObligationFYyearSource" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="obligationNumber" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ActivityObligation").init(argumentCollection=queryRowToStruct(qList,i)) />
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

	<cffunction name="updateByAttributes" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityObligateID" type="numeric" required="true" />
		<cfargument name="Amount" type="numeric" required="false" />
		<cfargument name="obligationDate" type="date" required="false" />
		<cfargument name="ObligationFYyearSource" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="obligationNumber" type="string" required="false" />
		
		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityObligation
				SET
				isActive = 1
				<!--- <cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
					,Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Name)#" />
				</cfif>
				<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
					,Description = <cfqueryparam value="#arguments.Description#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Description)#" />
				</cfif>
				<cfif structKeyExists(arguments,"StartDate") and len(arguments.StartDate)>
					,StartDate = <cfqueryparam value="#arguments.StartDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.StartDate)#" />
				</cfif>	
				<cfif structKeyExists(arguments,"EndDate") and len(arguments.EndDate)>
					,EndDate = <cfqueryparam value="#arguments.EndDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.EndDate)#" />
				</cfif> --->
				<cfif structKeyExists(arguments,"Comments") and len(arguments.Comments)>
					,Comments = <cfqueryparam value="#arguments.Comments#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Comments)#" />
				</cfif>
				<cfif structKeyExists(arguments,"obligationNumber") and len(arguments.obligationNumber)>
					,obligationNumber = <cfqueryparam value="#arguments.obligationNumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.obligationNumber)#" />
				</cfif>
				<cfif structKeyExists(arguments,"ObligationDate") and len(arguments.ObligationDate)>
					,ObligationDate = <cfqueryparam value="#arguments.obligationDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.obligationDate)#" />
				</cfif>	
				<cfif structKeyExists(arguments,"Amount") and len(arguments.Amount)>
					,Amount = <cfqueryparam value="#arguments.Amount#" CFSQLType="cf_sql_integer" null="#not len(arguments.Amount)#" />
				</cfif>
				<cfif structKeyExists(arguments,"ObligationFYyearSource") and len(arguments.ObligationFYyearSource)>
					,ObligationFYyearSource = <cfqueryparam value="#arguments.ObligationFYyearSource#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ObligationFYyearSource)#" />
				</cfif>
				
				WHERE	ActivityObligateID = <cfqueryparam value="#arguments.ActivityObligateID#" CFSQLType="cf_sql_integer" />
			</cfquery>

		<cfreturn true />
	</cffunction>

</cfcomponent>
