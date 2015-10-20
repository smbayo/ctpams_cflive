
<cfcomponent name="ActivityAttachedFileService" output="false">

	<cfproperty name="ActivityAttachedFileGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityAttachedFileDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityAttachedFile" inject="model" scope="instance" />
    
	<cfproperty name="SessionStorage" type="coldbox:plugin:sessionstorage" scope="instance" />
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN">

	<cffunction name="init" access="public" output="false" returntype="ActivityAttachedFileService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="ActivityAttachedFile">
		<cfset var ActivityAttachedFile = instance.ActivityAttachedFile.init()>
		<cfreturn ActivityAttachedFile />
	</cffunction>

	<cffunction name="createActivityAttachedFile" access="public" output="false" returntype="ActivityAttachedFile">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		
			
		<cfset var ActivityAttachedFile = createObject("component","ActivityAttachedFile").init(argumentCollection=arguments) />
		<cfreturn ActivityAttachedFile />
	</cffunction>

	<cffunction name="getActivityAttachedFile" access="public" output="false" returntype="ActivityAttachedFile">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		
		<cfset var ActivityAttachedFile = createActivityAttachedFile(argumentCollection=arguments) />
		<cfset instance.ActivityAttachedFileDAO.read(ActivityAttachedFile) />
		<cfreturn ActivityAttachedFile />
	</cffunction>

	<cffunction name="getActivityAttachedFilesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="AttachedFileID" type="numeric" required="false" />
		
		<cfreturn instance.ActivityAttachedFileGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getActivityFilesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="AttachedFileID" type="numeric" required="false" />
		
		<cfreturn instance.ActivityAttachedFileGateway.getActivityFilesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getActivityAttachedFiles" access="public" output="false" returntype="array">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="AttachedFileID" type="numeric" required="false" />
		
		<cfreturn instance.ActivityAttachedFileGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityAttachedFile" type="ActivityAttachedFile" required="true" />

		<cfreturn variables.ActivityAttachedFileDAO.save(ActivityAttachedFile) />
	</cffunction>

  	<cffunction name="processupload" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		<cfargument name="ActivityID" type="numeric" required="true" />
        
       <cfset newlink = new()>  
	    <cfset newlink.setAttachedFileID(attachedfileID)>
        <cfset newlink.setActivityID(activityID)>
 
          
		<cfreturn instance.ActivityAttachedFileDAO.save(ActivityAttachedFile=newlink) />
        <cfreturn true />
	</cffunction>

	<cffunction name="deleteActivityAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		
		<cfset var ActivityAttachedFile = createActivityAttachedFile(argumentCollection=arguments) />
		<cfreturn instance.ActivityAttachedFileDAO.delete(ActivityAttachedFile) />
	</cffunction>
	
</cfcomponent>
