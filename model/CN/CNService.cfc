
<cfcomponent name="CNService" output="false">

	<cfproperty name="CNGateway" inject="model" scope="instance" />
	<cfproperty name="CNDAO" inject="model" scope="instance" />
	<cfproperty name="CN" inject="model" scope="instance" />

	
	
	<cffunction name="init" access="public" output="false" returntype="CNService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="CN">
		<cfset var CN = instance.CN.init()>
		<cfreturn CN />
	</cffunction>

	<cffunction name="createCN" access="public" output="false" returntype="Activity">
		<cfargument name="CNID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="CNNumber" type="string" required="false" default="" />
		<cfargument name="BudgetSubmitDate" type="date" required="false" default="" />
		<cfargument name="CongressSubmitDate" type="date" required="false" default="" />
		<cfargument name="ApprovedDate" type="date" required="false" default="" />
		<cfargument name="CNType" type="string" required="false" default="" />
		

			
		<cfset var CN = createObject("component","CN").init(argumentCollection=arguments) />
		<!--- <cfset var ActivityOrg = instance.Org.init() />
		
		<cfset structInsert(Activity,"ImplementerOrg",ActivityOrg)> --->
		
		<cfreturn CN />
	</cffunction>

	<cffunction name="getCN" access="public" output="false" returntype="CN">
		<cfargument name="CNID" type="numeric" required="true" />
		
		<cfset var CN = createCN(argumentCollection=arguments) />
		
		<cfset instance.CNDAO.read(CN) />
		
		<!--- <cfset Activity.ImplementerOrg = instance.Org.init(orgID=Activity.getImplementorOrgID())>
		<cfset instance.OrgDAO.read(Activity.ImplementerOrg)> --->
		
		<cfreturn CN />
	</cffunction>



	<cffunction name="saveCN" access="public" output="false" returntype="numeric">
		<cfargument name="CN" type="CN" required="true" />
		
		<cfreturn instance.CNDAO.save(CN) />
	</cffunction>

	<cffunction name="deleteCN" access="public" output="false" returntype="boolean">
		<cfargument name="CNID" type="numeric" required="true" />
		
		<cfset var CN = createCN(argumentCollection=arguments) />
		<cfreturn instance.ActivityDAO.delete(CN) />
	</cffunction>
	



</cfcomponent>
