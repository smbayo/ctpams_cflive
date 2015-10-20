
<cfcomponent name="DisaggSetIndicatorService" output="false">

	<cfproperty name="DisaggSetIndicatorGateway" inject="model" scope="instance" />
	<cfproperty name="DisaggSetIndicatorDAO" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="DisaggSetIndicatorService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createDisaggSetIndicator" access="public" output="false" returntype="DisaggSetIndicator">
		<cfargument name="DisaggSetID" type="numeric" required="true" />
		<cfargument name="IndicatorID" type="numeric" required="true" />
		
			
		<cfset var DisaggSetIndicator = createObject("component","DisaggSetIndicator").init(argumentCollection=arguments) />
		<cfreturn DisaggSetIndicator />
	</cffunction>

	<cffunction name="getDisaggSetIndicator" access="public" output="false" returntype="DisaggSetIndicator">
		<cfargument name="DisaggSetID" type="numeric" required="true" />
		<cfargument name="IndicatorID" type="numeric" required="true" />
		
		<cfset var DisaggSetIndicator = createDisaggSetIndicator(argumentCollection=arguments) />
		<cfset instance.DisaggSetIndicatorDAO.read(DisaggSetIndicator) />
		<cfreturn DisaggSetIndicator />
	</cffunction>

	<cffunction name="getDisaggSetIndicators" access="public" output="false" returntype="array">
		<cfargument name="DisaggSetID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfreturn instance.DisaggSetIndicatorGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>
    
	<cffunction name="getDisaggSetIndicatorIDs" access="public" output="false" returntype="query">
	<cfargument name="IndicatorID" type="numeric" required="false" />
		
		<cfreturn instance.DisaggSetIndicatorGateway.getDisaggSetIndicatorIDs(argumentCollection=arguments) />
	</cffunction>
	<cffunction name="saveDisaggSetIndicator" access="public" output="false" returntype="boolean">
		<cfargument name="DisaggSetIndicator" type="DisaggSetIndicator" required="true" />

		<cfreturn instance.DisaggSetIndicatorDAO.save(DisaggSetIndicator) />
	</cffunction>



	<cffunction name="deleteDisaggSetIndicators" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorID" type="numeric" required="true" />
		
		<cfreturn instance.disaggSetIndicatorGateway.deleteDisaggSetIndicators(IndicatorID=arguments.indicatorID)>        
	</cffunction>




	<cffunction name="deleteDisaggSetIndicator" access="public" output="false" returntype="boolean">
		<cfargument name="DisaggSetID_List" type="string" required="true" />
		<cfargument name="oldDisaggSetID_list" type="string" required="true" />
		<cfargument name="IndicatorID" type="numeric" required="true" />

		<cfloop index="newID" list="#disaggSetID_List#">
        
        <cfset DisaggSetIndicator=arraynew(1)>
        <cfset disaggsetIndicator.indicatorID=#arguments.indicatorID#>
        <cfset disaggsetIndicator.disaggSetID=#NewID#>
		<cfset findDisaggSet=instance.disaggSetIndicatorDAO.read(disaggsetIndicator=disaggsetIndicator)>        
        
        
        
        
            
        </cfloop>
        
		
		<cfset var DisaggSetIndicator = createDisaggSetIndicator(argumentCollection=arguments) />
		<cfreturn instance.DisaggSetIndicatorDAO.delete(DisaggSetIndicator) />
	</cffunction>
</cfcomponent>
