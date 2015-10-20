
<cfcomponent name="ActivityIndicatorService" output="false">

	<cfproperty name="ActivityIndicatorGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityIndicatorDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityIndicator" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ActivityIndicatorService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createActivityIndicator" access="public" output="false" returntype="ActivityIndicator">
		<cfargument name="ActivityIndicatorID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
			
		<cfset var ActivityIndicator = createObject("component","ActivityIndicator").init(argumentCollection=arguments) />
		<cfreturn ActivityIndicator />
	</cffunction>

	<cffunction name="getActivityIndicator" access="public" output="false" returntype="ActivityIndicator">
		
		<cfset var ActivityIndicator = createActivityIndicator(argumentCollection=arguments) />
		<cfset instance.ActivityIndicatorDAO.read(ActivityIndicator) />
		<cfreturn ActivityIndicator />
	</cffunction>

	<cffunction name="getActivityIndicators" access="public" output="false" returntype="array">
		<cfargument name="ActivityIndicatorID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfreturn instance.ActivityIndicatorGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getActivityIndicatorsQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityIndicatorID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfreturn instance.ActivityIndicatorGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityIndicator" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityIndicator" type="ActivityIndicator" required="true" />

		<cfreturn instance.ActivityIndicatorDAO.save(ActivityIndicator) />
	</cffunction>

	<cffunction name="deleteActivityIndicator" access="public" output="false" returntype="boolean">
		
		<cfset var ActivityIndicator = createActivityIndicator(argumentCollection=arguments) />
		<cfreturn instance.ActivityIndicatorDAO.delete(ActivityIndicator) />
	</cffunction>
	
	<cffunction name="deleteActivityIndicators" access="public" output="false" returntype="array">
		<cfargument name="ActivityIndicatorID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfreturn instance.ActivityIndicatorGateway.deleteByAttributes(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="updateActivityIndicators" access="public" output="true" returntype="void">
		<cfargument name="ActivityID" type="string" required="true">
		<cfargument name="IndicatorIDList" type="string" required="true">
		
		<!--- get all current relationships for this activity --->
		<cfset var qCurrentRelationships = instance.ActivityIndicatorGateway.getByAttributesQuery(activityid=arguments.activityid)>
		
		<!--- if list being passed in is blank, then remove all ActivityIndicator relationships --->
		<cfif listlen(arguments.IndicatorIDList) eq 0>
			<cfset instance.ActivityIndicatorGateway.deleteByAttributesQuery(activityid=arguments.ActivityID)>
			<cfoutput>list of current ids after purge: #arguments.ActivityID#<br></cfoutput>
		<cfelse>
			<cfset var listCurrentIDs = valuelist(qCurrentRelationships.IndicatorID)>
			<!--- loop through current relationships and remove any that are no longer valid --->
			<cfloop query="qCurrentRelationships">
				<cfif listfind(arguments.IndicatorIDList,IndicatorID) eq 0>
					<cfset instance.ActivityIndicatorGateway.deleteByAttributesQuery(ActivityIndicatorID=ActivityIndicatorID)>
					<!--- remove this indicatorid from the list of current id's --->
					<cfset listCurrentIDs = listDeleteAt(listCurrentIDs,listfind(listCurrentIDs,IndicatorID))>
				</cfif>
			</cfloop>
			<cfoutput>list of current ids after purge: #listCurrentIDs#<br></cfoutput>
			
			<!--- loop through new list and add any that don't already exist --->
			<cfloop list="#arguments.IndicatorIDList#" index="thisIndicatorID">
				<cfif listFind(listCurrentIDs,thisIndicatorID) eq 0>
					<cfset var newRelationship = instance.ActivityIndicatorDAO.new()>
					<cfset newRelationship.setActivityID(arguments.activityID)>
					<cfset newRelationship.setIndicatorID(thisIndicatorID)>
					<cfset instance.ActivityIndicatorDAO.save(newRelationship)>
				</cfif>
			</cfloop>
		</cfif>
		
	</cffunction>

</cfcomponent>
