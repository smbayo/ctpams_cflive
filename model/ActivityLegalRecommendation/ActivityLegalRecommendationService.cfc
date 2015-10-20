<cfcomponent name="ActivityLegalRecommendationService" output="false">
	<cfproperty name="ActivityLegalRecommendation" inject="model" scope="instance" />
	<cfproperty name="ActivityLegalRecommendationDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityLegalRecommendationGateway" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ActivityLegalRecommendationService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="ActivityLegalRecommendation">
		<cfreturn instance.ActivityLegalRecommendation.init() />
	</cffunction>

	<cffunction name="createActivityLegalRecommendation" access="public" output="false" returntype="ActivityLegalRecommendation">
		<cfargument name="ActivityRecommID" type="numeric" required="true" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="ActivityStatusID" type="numeric" required="false" />
		<cfargument name="Sender" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="commentType" type="string" required="false" />
		<cfargument name="commentDate" type="date" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />


		<cfset var ActivityLegalRecommendation = createObject("component","ActivityLegalRecommendation").init(argumentCollection=arguments) />
		<cfreturn ActivityLegalRecommendation />
	</cffunction>

	<cffunction name="getActivityLegalRecommendation" access="public" output="false" returntype="ActivityLegalRecommendation">
		<cfargument name="ActivityRecommID" type="numeric" required="true" />

		<cfset var ActivityLegalRecommendation = createActivityLegalRecommendation(argumentCollection=arguments) />
		<cfset instance.ActivityLegalRecommendationDAO.read(ActivityLegalRecommendation) />
		<cfreturn ActivityLegalRecommendation />
	</cffunction>

	<cffunction name="getActivityLegalRecommendations" access="public" output="false" returntype="array">
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

		<cfreturn instance.ActivityLegalRecommendationGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityLegalRecommendation" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityLegalRecommendation" type="ActivityLegalRecommendation" required="true" />

		<cfreturn instance.ActivityLegalRecommendationDAO.save(ActivityLegalRecommendation) />
	</cffunction>

	<cffunction name="deleteActivityLegalRecommendation" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityRecommID" type="numeric" required="true" />

		<cfset var ActivityLegalRecommendation = createActivityLegalRecommendation(argumentCollection=arguments) />
		<cfreturn instance.ActivityLegalRecommendationDAO.delete(ActivityLegalRecommendation) />
	</cffunction>
</cfcomponent>
