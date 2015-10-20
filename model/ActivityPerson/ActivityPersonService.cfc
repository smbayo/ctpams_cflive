<cfcomponent name="ActivityPersonService" output="false">
	<cfproperty name="ActivityPerson" inject="model" scope="instance" />
	<cfproperty name="ActivityPersonGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityPersonDAO" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ActivityPersonService">

		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="ActivityPerson">
		<cfreturn instance.ActivityPerson.init() />
	</cffunction>

	<cffunction name="createActivityPerson" access="public" output="false" returntype="ActivityPerson">
		<cfargument name="ActivityPersonID" type="numeric" required="true" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="LastName" type="string" required="false" />
		<cfargument name="FirstName" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Office" type="string" required="false" />


		<cfset var ActivityPerson = createObject("component","ActivityPerson").init(argumentCollection=arguments) />
		<cfreturn ActivityPerson />
	</cffunction>

	<cffunction name="getActivityPerson" access="public" output="false" returntype="ActivityPerson">
		<cfargument name="ActivityPersonID" type="numeric" required="true" />

		<cfset var ActivityPerson = createActivityPerson(argumentCollection=arguments) />
		<cfset instance.ActivityPersonDAO.read(ActivityPerson) />
		<cfreturn ActivityPerson />
	</cffunction>

	<cffunction name="getActivityPersons" access="public" output="false" returntype="array">
		<cfargument name="ActivityPersonID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="LastName" type="string" required="false" />
		<cfargument name="FirstName" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Office" type="string" required="false" />

		<cfreturn instance.ActivityPersonGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityPerson" access="public" output="false" returntype="numeric">
		<cfargument name="ActivityPerson" type="ActivityPerson" required="true" />

		<cfreturn instance.ActivityPersonDAO.save(ActivityPerson) />
	</cffunction>

	<cffunction name="deleteActivityPerson" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityPersonID" type="numeric" required="true" />

		<cfset var ActivityPerson = createActivityPerson(argumentCollection=arguments) />
		<cfreturn instance.ActivityPersonDAO.delete(ActivityPerson) />
	</cffunction>

</cfcomponent>
