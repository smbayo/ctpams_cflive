<cfcomponent name="ProgramService" output="false">
	
	<cfproperty name="ProgramDAO" inject="model" scope="instance" />
	<cfproperty name="ProgramGateway" inject="model" scope="instance" />
			
	<cffunction name="init" access="public" output="false" returntype="ProgramService">

		<cfreturn this/>
	</cffunction>

	<cffunction name="createProgram" access="public" output="false" returntype="Program">
		<cfargument name="ProgramID" type="numeric" required="true" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Address1" type="string" required="false" />
		<cfargument name="Address2" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="PostalCode" type="numeric" required="false" />
		<cfargument name="CountryID" type="numeric" required="false" />
		<cfargument name="Telephone" type="numeric" required="false" />
		
			
		<cfset var Program = createObject("component","Program").init(argumentCollection=arguments) />
		<cfreturn Program />
	</cffunction>

	<cffunction name="getProgram" access="public" output="false" returntype="Program">
		<cfargument name="ProgramID" type="numeric" required="true" />
		
		<cfset var Program = createProgram(argumentCollection=arguments) />
		<cfset instance.ProgramDAO.read(Program) />
		<cfreturn Program />
	</cffunction>

	<cffunction name="getPrograms" access="public" output="false" returntype="array">
		<cfargument name="ProgramID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Address1" type="string" required="false" />
		<cfargument name="Address2" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="PostalCode" type="numeric" required="false" />
		<cfargument name="CountryID" type="numeric" required="false" />
		<cfargument name="Telephone" type="numeric" required="false" />
		
		<cfreturn instance.ProgramGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getProgramsQuery" access="public" output="false" returntype="query">
		<cfargument name="ProgramID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Address1" type="string" required="false" />
		<cfargument name="Address2" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="PostalCode" type="numeric" required="false" />
		<cfargument name="CountryID" type="numeric" required="false" />
		<cfargument name="Telephone" type="numeric" required="false" />
		
		<cfreturn instance.ProgramGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveProgram" access="public" output="false" returntype="boolean">
		<cfargument name="Program" type="Program" required="true" />

		<cfreturn instance.ProgramDAO.save(Program) />
	</cffunction>

	<cffunction name="deleteProgram" access="public" output="false" returntype="boolean">
		<cfargument name="ProgramID" type="numeric" required="true" />
		
		<cfset var Program = createProgram(argumentCollection=arguments) />
		<cfreturn instance.ProgramDAO.delete(Program) />
	</cffunction>
</cfcomponent>
