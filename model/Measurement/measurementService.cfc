
<cfcomponent name="measurementService" output="false">

	<cfproperty name="measurementGateway" inject="model" scope="instance" />
  <cfproperty name="measurementDAO" inject="model" scope="instance" />
  <cfproperty name="measurement" inject="model" scope="instance" />

  <cffunction name="init" access="public" output="false" returntype="measurementService">
    <cfreturn this/>
  </cffunction>

  <cffunction name="new" access="public" output="false" returntype="measurement">
    <cfreturn instance.measurement.init() />
  </cffunction>

	<cffunction name="createmeasurement" access="public" output="false" returntype="measurement">
		<cfargument name="MeasurementID" type="numeric" required="true" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="DisaggID" type="numeric" required="false" />
		<cfargument name="isBaseline" type="boolean" required="false" />
		<cfargument name="Actual" type="numeric" required="false" />
		<cfargument name="ActualNotes" type="string" required="false" />
		<cfargument name="Target" type="numeric" required="false" />
		<cfargument name="TargetNotes" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="ReportDate" type="date" required="false" />
		<cfargument name="ReviewedBy" type="string" required="false" />
		<cfargument name="ReviewDate" type="string" required="false" />
		<cfargument name="ReviewType" type="string" required="false" />
		<cfargument name="ReviewNotes" type="string" required="false" />
		
			
		<cfset var measurement = createObject("component","measurement").init(argumentCollection=arguments) />
		<cfreturn measurement />
	</cffunction>

	<cffunction name="getmeasurement" access="public" output="false" returntype="measurement">
		<cfargument name="MeasurementID" type="numeric" required="false" />
		
		<cfset var measurement = "">
			
		<cfif structKeyExists(arguments,"MeasurementID")>
			<cfset measurement = createmeasurement(argumentCollection=arguments) />
		
			<cfset instance.measurementDAO.read(measurement) />
			
		<cfelse>
			<cfset measurement = instance.measurement.init()>
		</cfif>
		
		
		<!--- <cfset var measurement = createmeasurement(argumentCollection=arguments) />
		<cfset instance.measurementDAO.read(measurement) /> --->
		<cfreturn measurement />
	</cffunction>

	<cffunction name="getmeasurements" access="public" output="false" returntype="array">
		<cfargument name="MeasurementID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="DisaggID" type="numeric" required="false" />
		<cfargument name="isBaseline" type="boolean" required="false" />
		<cfargument name="Actual" type="numeric" required="false" />
		<cfargument name="ActualNotes" type="string" required="false" />
		<cfargument name="Target" type="numeric" required="false" />
		<cfargument name="TargetNotes" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="ReportDate" type="date" required="false" />
		<cfargument name="ReviewedBy" type="string" required="false" />
		<cfargument name="ReviewDate" type="string" required="false" />
		<cfargument name="ReviewType" type="string" required="false" />
		<cfargument name="ReviewNotes" type="string" required="false" />
		
		<cfreturn instance.measurementGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="savemeasurement" access="public" output="false" returntype="boolean">
		<cfargument name="measurement" type="measurement" required="true" />

		<cfreturn instance.measurementDAO.save(measurement) />
	</cffunction>

	<cffunction name="deletemeasurement" access="public" output="false" returntype="boolean">
		<cfargument name="MeasurementID" type="numeric" required="true" />
		
		<cfset var measurement = createmeasurement(argumentCollection=arguments) />
		<cfreturn instance.measurementDAO.delete(measurement) />
	</cffunction>
</cfcomponent>
