
<cfcomponent displayname="CNGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="CNGateway">
		<cfreturn this />
	</cffunction>

	<cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="CNIDList" type="string" required="false" />

		<cfquery name="qList" datasource="#dsn.getName()#">
			DELETE
			FROM	Org
			WHERE	0=0

		<cfif structKeyExists(arguments,"CNID") and len(arguments.CNID)>
			AND	CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CNIDList") and listlen(arguments.CNIDList)>
			AND	CNID IN (#arguments.CNIDList#)
		</cfif>
		</cfquery>

		<cfreturn />
	</cffunction>

	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="CNNumber" type="string" required="false" />
		<cfargument name="BudgetSubmitDate" type="date" required="false" />
		<cfargument name="CongressSubmitDate" type="date" required="false" />
		<cfargument name="ApprovedDate" type="date" required="false" />
		<cfargument name="isComplete" type="string" required="false" />
		<cfargument name="CNType" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />


		<cfset var qList = "" />
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				CNID,
				Name,
				name as cntitle,
				CNNumber,
				BudgetSubmitDate,
				CongressSubmitDate,
				ApprovedDate,
				CNType
				<!--- , STUFF
                             ((SELECT        ', ' + proposalnumber
                                 FROM            vw_CNActivities
                                 WHERE        vw_CNActivities.cnid = cn.cnID
                                 ORDER BY proposalnumber FOR XML PATH('')), 1, 1, '') AS activities --->
			FROM	CN
			WHERE	0=0

		<cfif structKeyExists(arguments,"CNID") and len(arguments.CNID)>
			AND	CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	CNID in (select cnid from activitycn where activityid = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />)
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"CNNumber") and len(arguments.CNNumber)>
			AND	CNNumber = <cfqueryparam value="#arguments.CNNumber#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetSubmitDate") and len(arguments.BudgetSubmitDate)>
			AND	BudgetSubmitDate = <cfqueryparam value="#arguments.BudgetSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"CongressSubmitDate") and len(arguments.CongressSubmitDate)>
			AND	CongressSubmitDate = <cfqueryparam value="#arguments.CongressSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"ApprovedDate") and len(arguments.ApprovedDate)>
				AND	ApprovedDate = <cfqueryparam value="#arguments.ApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"isComplete") and len(arguments.isComplete)>
			<cfif arguments.isComplete is "no">
				AND	ApprovedDate is null
			<cfelseif arguments.isComplete is "yes">
				AND	ApprovedDate is not null
			</cfif>
		</cfif>
		<cfif structKeyExists(arguments,"CNType") and len(arguments.CNType)>
			AND	CNType = <cfqueryparam value="#arguments.CNType#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>

		<cfreturn qList />
	</cffunction>

	<cffunction name="updateByAttributes" access="public" output="false" returntype="boolean">
		<cfargument name="CNID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="CNNumber" type="string" required="false" />
		<cfargument name="BudgetSubmitDate" type="date" required="false" />
		<cfargument name="CongressSubmitDate" type="date" required="false" />
		<cfargument name="ApprovedDate" type="date" required="false" />
		<cfargument name="CNType" type="string" required="false" default="" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	CN
				SET
				cntype = <cfqueryparam value="#arguments.CNType#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNType)#" />
				<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
					,Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Name)#" />
				</cfif>
				<cfif structKeyExists(arguments,"CNNumber") and len(arguments.CNNumber)>
					,CNNumber = <cfqueryparam value="#arguments.CNNumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNNumber)#" />
				</cfif>
				<cfif structKeyExists(arguments,"BudgetSubmitDate") and len(arguments.BudgetSubmitDate)>
					,BudgetSubmitDate = <cfqueryparam value="#arguments.BudgetSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.BudgetSubmitDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"CongressSubmitDate") and len(arguments.CongressSubmitDate)>
					,CongressSubmitDate = <cfqueryparam value="#arguments.CongressSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CongressSubmitDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"ApprovedDate") and len(arguments.ApprovedDate)>
					,ApprovedDate = <cfqueryparam value="#arguments.ApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"CNType") and len(arguments.CNType)>
					,CNType = <cfqueryparam value="#arguments.CNType#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNType)#" />
				</cfif>

				WHERE	CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
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


	<cffunction name="getLinkedCNActivities" access="public" output="false" returntype="Query">
	    <cfargument name="CNID" type="numeric" required="true" />

	    <cfset var qGrantsList = "">

	    <cfquery name="qGrantsList" datasource="#dsn.getName()#">
	      SELECT activityid, proposalnumber, projectTitle
	      FROM vw_CNActivities
	      WHERE
	      cnID = <cfqueryparam value="#arguments.cnID#" CFSQLType="cf_sql_integer" />
	      order by proposalnumber
	    </cfquery>

	    <cfreturn qGrantsList>
    </cffunction>



	<cffunction name="getPotentialCNActivities" access="public" output="false" returntype="Query">
	  <!---   <cfargument name="CNID" type="numeric" required="true" /> --->

	    <cfset var qGrantsList = "">

	    <cfquery name="qGrantsList" datasource="#dsn.getName()#">
	      SELECT activityid, proposalnumber, projectTitle
	      FROM vw_fullActivities a
	      WHERE
	      ((implementationStatus = 'CN Re-notification') or (a.activityStatusID >= 276 and a.activityStatusID < 282))
	      and isactive = 1
	     <!---  and activityid not in (select activityid from vw_cnactivities where cnid = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />) --->
	      and activityid not in (select activityid from vw_cnactivities where approveddate is null)
	       order by proposalnumber
	    </cfquery>

	    <cfreturn qGrantsList>
    </cffunction>

	<cffunction name="setLinkedCNs" access="public" output="false" returntype="boolean">
		<cfargument name="CNID" type="numeric" required="true" />
		<cfargument name="activityList" type="string" required="true" />
		<cfargument name="cnnumber" type="string" required="true" />
		<cfargument name="cntitle" type="string" required="true" />

		<cfset var setOriginal = "" />
		<cfset var setNew = "" />
		<cfset var setParent = "" />
		<cfset var getFirst = ListFirst(arguments.activityList)>

		<cfif arguments.cnID is 0>
		  	<cfquery name="insertcn" datasource="#dsn.getName()#">
				insert into cn (name, cnnumber)
				values (<cfqueryparam value="#arguments.cntitle#" CFSQLType="cf_sql_varchar" />,<cfqueryparam value="#arguments.cnnumber#" CFSQLType="cf_sql_varchar" />)
				SELECT @@Identity as cnID
			</cfquery>
		<cfelse>
			<cfquery name="updatecn" datasource="#dsn.getName()#">
				update cn
				set name = <cfqueryparam value="#arguments.cntitle#" CFSQLType="cf_sql_varchar" />,
				cnnumber = <cfqueryparam value="#arguments.cnnumber#" CFSQLType="cf_sql_varchar" />
				where cnid = <cfqueryparam value="#arguments.cnID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfset insertcn.cnid = arguments.cnID>
		</cfif>

		<!--- <cftry> --->
		<cfquery name="deleteLink" datasource="#dsn.getName()#">
			delete from activitycn
			where
			cnID = <cfqueryparam value="#cnID#" CFSQLType="cf_sql_integer" />
		</cfquery>



		<cfloop list="#arguments.activityList#" index="i">
   			<cfquery datasource="#dsn.getName()#" name="setNew">
				insert into activitycn (cnid, activityid)
				values (<cfqueryparam value="#insertcn.cnID#" CFSQLType="cf_sql_integer" />, <cfqueryparam value="#i#" CFSQLType="cf_sql_integer" />)
			</cfquery>
  		</cfloop>


		<cfreturn true />
	</cffunction>


	<cffunction name="getCNActivities" access="public" output="false" returntype="Query">
		<cfargument name="cnid" type="numeric" required="true">
		<cfquery name="qreviewWScn" datasource="#dsn.getName()#">
			select proposalnumber, projecttitle, activityid, programid, activitystatusid, implementationstatus, budgetceilingamount
			from vw_cnactivities
			where cnid = <cfqueryparam value="#arguments.cnID#" CFSQLType="cf_sql_integer" />
			order by proposalnumber
		</cfquery>
		<cfreturn qreviewWScn />
	</cffunction>

	<cffunction name="getActivityCNs" access="public" output="false" returntype="Query">
		<cfargument name="activityid" type="numeric" required="true">
		<cfquery name="qreviewWScn" datasource="#dsn.getName()#">
			select cntitle, cnnumber, cnid
			from vw_cnactivities
			where activityid = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
			order by budgetsubmitdate desc
		</cfquery>
		<cfreturn qreviewWScn />
	</cffunction>

</cfcomponent>