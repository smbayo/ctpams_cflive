<cfcomponent name="ActivityObligationService" output="false">
	<cfproperty name="ActivityObligation" inject="model" scope="instance" />
	<cfproperty name="ActivityObligationDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityObligationGateway" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityObligationService">
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="new" access="public" output="false" returntype="ActivityObligation">
		<cfset var activityObligation = instance.ActivityObligation.init()>
		<cfreturn activityObligation />
	</cffunction>	

	<cffunction name="createActivityObligation" access="public" output="false" returntype="ActivityObligation">
		<cfargument name="ActivityObligateID" type="numeric" required="true" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="Amount" type="numeric" required="false" />
		<cfargument name="obligationDate" type="date" required="false" />
		<cfargument name="ObligationFYyearSource" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="obligationNumber" type="string" required="false" />
			
		<cfset var ActivityObligation = createObject("component","ActivityObligation").init(argumentCollection=arguments) />
		<cfreturn ActivityObligation />
	</cffunction>

	<cffunction name="getActivityObligation" access="public" output="false" returntype="ActivityObligation">
		<cfargument name="ActivityObligateID" type="numeric" required="true" />
		
		<cfset var ActivityObligation = createActivityObligation(argumentCollection=arguments) />
		<cfset instance.ActivityObligationDAO.read(ActivityObligation) />
		<cfreturn ActivityObligation />
	</cffunction>

	<cffunction name="getActivityObligations" access="public" output="false" returntype="array">
		<cfargument name="ActivityObligateID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="Amount" type="numeric" required="false" />
		<cfargument name="obligationDate" type="date" required="false" />
		<cfargument name="ObligationFYyearSource" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="obligationNumber" type="string" required="false" />
		
		<cfreturn instance.ActivityObligationGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityObligation" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityObligation" type="ActivityObligation" required="true" />

		<cfreturn instance.ActivityObligationDAO.save(ActivityObligation) />
	</cffunction>

	<cffunction name="deleteActivityObligation" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityObligateID" type="numeric" required="true" />
		
		<cfset var ActivityObligation = createActivityObligation(argumentCollection=arguments) />
		<cfreturn instance.ActivityObligationDAO.delete(ActivityObligation) />
	</cffunction>
</cfcomponent>
