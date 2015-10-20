
<cfcomponent displayname="WorkplanGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<cffunction name="init" access="public" output="false" returntype="WorkplanGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="WorkplanID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="CompleteDate" type="date" required="false" />

		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT 
				Workplan.ActivityID, 
				Workplan.WorkplanID, 
				Workplan.Name, 
				Workplan.Description, 
			 	Workplan.StartDate, 
				Workplan.EndDate, 
				Workplan.CompleteDate
			FROM Workplan 
			WHERE	0=0


		<cfif structKeyExists(arguments,"workplanID") and len(arguments.workplanID)>
			AND	Workplan.workplanID = <cfqueryparam value="#arguments.workplanID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	Workplan.ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Workplan.Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
			AND	Workplan.Description like <cfqueryparam value="%#arguments.Description#%" CFSQLType="cf_sql_longvarchar" />
		</cfif>
	    <cfif structKeyExists(arguments,"StartDate") and len(arguments.StartDate)>
	      	AND Workplan.StartDate = <cfqueryparam value="#arguments.StartDate#" CFSQLType="cf_sql_timestamp" />
	    </cfif>
		<cfif structKeyExists(arguments,"EndDate") and len(arguments.EndDate)>
			AND	Workplan.EndDate = <cfqueryparam value="#arguments.EndDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"CompleteDate") and len(arguments.CompleteDate)>
			AND	Workplan.CompleteDate = <cfqueryparam value="#arguments.CompleteDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
			    
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	
	<cffunction name="updateByAttributes" access="public" output="false" returntype="boolean">
		<cfargument name="WorkplanID" type="numeric" required="true" />
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="true" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />		
		<cfargument name="CompleteDate" type="date" required="false" />		
		
		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Workplan
				SET
					activityid = <cfqueryparam value="#arguments.activityid#" CFSQLType="cf_sql_integer"  />
					
				<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
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
				</cfif>
				<cfif structKeyExists(arguments,"CompleteDate") and len(arguments.CompleteDate)>
					,CompleteDate = <cfqueryparam value="#arguments.CompleteDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CompleteDate)#" />
				</cfif>
				
				WHERE	WorkplanID = <cfqueryparam value="#arguments.WorkplanID#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfreturn true />
	</cffunction>
	

</cfcomponent>