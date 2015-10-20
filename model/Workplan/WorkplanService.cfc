<cfcomponent name="WorkplanService" output="false">

	<cfproperty name="WorkplanGateway" inject="model" scope="instance" />
	<cfproperty name="WorkplanDAO" inject="model" scope="instance" />
	<cfproperty name="Workplan" inject="model" scope="instance" />

	
	
	<cffunction name="init" access="public" output="false" returntype="WorkplanService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="Workplan">
		<cfset var Workplan = instance.Workplan.init()>
		<cfreturn Workplan />
	</cffunction>

	<cffunction name="createWorkplan" access="public" output="false" returntype="Workplan">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="CompleteDate" type="date" required="false" />

			
		<cfset var Workplan = createObject("component","Workplan").init(argumentCollection=arguments) />

		
		<cfreturn Workplan />
	</cffunction>


	
	<cffunction name="getWorkplan" access="public" output="false" returntype="Workplan">
		<cfargument name="WorkplanID" type="numeric" required="false" />
		<cfset var Workplan="">
		<cfif structKeyExists(arguments,"WorkplanID")>
			<cfset var Workplan = createWorkplan(argumentCollection=arguments) />
            <cfset instance.WorkplanDAO.read(Workplan) />
		<cfelse>	
			<cfset Workplan = instance.Workplan.init()>	
        </cfif>

        <cfreturn Workplan />
	</cffunction>
   

	<cffunction name="getWorkplansQuery" access="public" output="false" returntype="query">

		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="workplanID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
	    <cfargument name="StartDate" type="date" required="false" />
	    <cfargument name="EndDate" type="date" required="false" />
		<cfargument name="orderBy" type="string" required="false" default="name" />

        
		<cfreturn instance.WorkplanGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveWorkplan" access="public" output="false" returntype="numeric">
		<cfargument name="Workplan" type="Workplan" required="true" />
		
		<cfreturn instance.WorkplanDAO.save(Workplan) />
	</cffunction>

	<cffunction name="deleteWorkplan" access="public" output="false" returntype="boolean">
		<cfargument name="WorkplanID" type="numeric" required="true" />
		
		<cfset var Workplan = createWorkplan(argumentCollection=arguments) />
		<cfreturn instance.WorkplanDAO.delete(Workplan) />
	</cffunction>
	


</cfcomponent>
