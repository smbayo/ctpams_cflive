
<cfcomponent name="DisaggSetService" output="false">

	<cfproperty name="DisaggSetGateway" inject="model" scope="instance" />
	<cfproperty name="DisaggSetDAO" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="DisaggSetService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createDisaggSet" access="public" output="false" returntype="DisaggSet">
		<cfargument name="DisaggSetID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCodeURL" type="string" required="false" />
		
			
		<cfset var DisaggSet = createObject("component","DisaggSet").init(argumentCollection=arguments) />
			
        
        <cfreturn DisaggSet />
	</cffunction>

	<cffunction name="getDisaggSet" access="public" output="false" returntype="DisaggSet">
		<cfargument name="DisaggSetID" type="numeric" required="true" />
		
		<cfset var DisaggSet = createDisaggSet(argumentCollection=arguments) />
		<cfset instance.DisaggSetDAO.read(DisaggSet) />
		<cfreturn DisaggSet />
	</cffunction>


	<cffunction name="DisaggSetList" access="public" output="false" returntype="query">
		<cfset disaggsetlist = instance.DisaggSetGateway.getDisaggListquery() />
        <cfreturn DisaggSetList />
	</cffunction>


	<cffunction name="getDisaggSets" access="public" output="false" returntype="array">
		<cfargument name="DisaggSetID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCodeURL" type="string" required="false" />

		<cfreturn instance.DisaggSetGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveDisaggSet" access="public" output="false" returntype="boolean">
		<cfargument name="DisaggSet" type="DisaggSet" required="true" />

		<cfreturn instance.DisaggSetDAO.save(DisaggSet) />
	</cffunction>

	<cffunction name="deleteDisaggSet" access="public" output="false" returntype="boolean">
		<cfargument name="DisaggSetID" type="numeric" required="true" />
		
		<cfset var DisaggSet = createDisaggSet(argumentCollection=arguments) />
		<cfreturn instance.DisaggSetDAO.delete(DisaggSet) />
	</cffunction>



</cfcomponent>
