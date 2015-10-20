
<cfcomponent name="DisaggService" output="false">

	<cfproperty name="userGateway" inject="model" scope="instance" />
	<cfproperty name="userDAO" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="DisaggService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createDisagg" access="public" output="false" returntype="Disagg">
		<cfargument name="DisaggID" type="numeric" required="true" />
		<cfargument name="DisaggSetID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		
			
		<cfset var Disagg = createObject("component","Disagg").init(argumentCollection=arguments) />
		<cfreturn Disagg />
	</cffunction>

	<cffunction name="getDisagg" access="public" output="false" returntype="Disagg">
		<cfargument name="DisaggID" type="numeric" required="true" />
		
		<cfset var Disagg = createDisagg(argumentCollection=arguments) />
		<cfset instance.DisaggDAO.read(Disagg) />
		<cfreturn Disagg />
	</cffunction>

	<cffunction name="getDisaggs" access="public" output="false" returntype="array">
		<cfargument name="DisaggID" type="numeric" required="false" />
		<cfargument name="DisaggSetID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		
		<cfreturn instance.DisaggGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveDisagg" access="public" output="false" returntype="boolean">
		<cfargument name="Disagg" type="Disagg" required="true" />

		<cfreturn instance.DisaggDAO.save(Disagg) />
	</cffunction>

	<cffunction name="deleteDisagg" access="public" output="false" returntype="boolean">
		<cfargument name="DisaggID" type="numeric" required="true" />
		
		<cfset var Disagg = createDisagg(argumentCollection=arguments) />
		<cfreturn instance.DisaggDAO.delete(Disagg) />
	</cffunction>
</cfcomponent>
