
<cfcomponent name="AttachedFileService" output="false">
	<cfproperty name="AttachedFileGateway" inject="model" scope="instance" />
	<cfproperty name="AttachedFileDAO" inject="model" scope="instance" />
	<!---<cfproperty name="ActivityAttachedFileService" inject="model" scope="instance" />
    <cfproperty name="ActivityAttachedFileDAO" inject="model" scope="instance" />--->
    <cfproperty name="AttachedFile" inject="model" scope="instance" />
    <cfproperty name="SessionStorage" type="coldbox:plugin:sessionstorage" scope="instance" />
	
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN">

	<cffunction name="init" access="public" output="false" returntype="AttachedFileService">
		
		<cfreturn this/>
	</cffunction>
    
	<cffunction name="new" access="public" output="false" returntype="AttachedFile">
		<cfset var AttachedFile = instance.AttachedFile.init()>
		<cfreturn AttachedFile />
	</cffunction>

	<cffunction name="createAttachedFile" access="public" output="false" returntype="AttachedFile">
		<cfargument name="AttachedFileID" type="numeric" required="true" />
  		<cfargument name="objectTableName" type="string" required="false" />
  		<cfargument name="objectTableID" type="numeric" required="false" />
        <cfargument name="Name" type="string" required="false" />
		<cfargument name="LongDescription" type="string" required="false" />
		<cfargument name="AttachedFileName" type="string" required="false" />
		<cfargument name="UploadedFileName" type="string" required="false" />
		<cfargument name="AttachedFileDate" type="date" required="false" />
		
			
		<cfset var AttachedFile = createObject("component","AttachedFile").init(argumentCollection=arguments) />
		<cfreturn AttachedFile />
	</cffunction>

	<cffunction name="getAttachedFile" access="public" output="false" returntype="AttachedFile">
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		
		<cfset var AttachedFile = createAttachedFile(argumentCollection=arguments) />
		<cfset instance.AttachedFileDAO.read(AttachedFile) />
		<cfreturn AttachedFile />
	</cffunction>

	<cffunction name="getAttachedFiles" access="public" output="false" returntype="array">
		<cfargument name="AttachedFileID" type="numeric" required="false" />
  		<cfargument name="objectTableName" type="string" required="false" />
   		<cfargument name="objectTableID" type="numeric" required="false" />
 		<cfargument name="Name" type="string" required="false" />
		<cfargument name="LongDescription" type="string" required="false" />
		<cfargument name="AttachedFileName" type="string" required="false" />
		<cfargument name="UploadedFileName" type="string" required="false" />
		<cfargument name="AttachedFileDate" type="date" required="false" />
		
		<cfreturn instance.AttachedFileGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFile" type="AttachedFile" required="true" />

		<cfreturn instance.AttachedFileDAO.save(AttachedFile) />
	</cffunction>

	<cffunction name="archiveAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />

		<cfreturn instance.AttachedFileDAO.archive(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="deactivateAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />

		<cfreturn instance.AttachedFileDAO.deactivate(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="renameAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		<cfargument name="name" type="string" required="true" />

		<cfreturn instance.AttachedFileDAO.rename(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="unarchiveAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />

		<cfreturn instance.AttachedFileDAO.unarchive(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="deleteAttachedFile" access="public" output="false" returntype="boolean">
		<cfargument name="AttachedFileID" type="numeric" required="true" />
		
		<cfset var AttachedFile = createAttachedFile(argumentCollection=arguments) />
		<cfreturn instance.AttachedFileDAO.delete(AttachedFile) />
	</cffunction>

    <cffunction name="getActivityFilesQuery" access="public" output="false" returntype="Query">
   		<cfargument name="ActivityID" type="numeric" required="true" />

  	 	<cfset var qFiles = "" />
   
  	 	<cfset qFiles = instance.attachedFileGateway.getByAttributesQuery(activityID=arguments.activityID,objectTableName='activity')>
   
 	  <cfreturn qFiles>
    </cffunction>

    <cffunction name="processupload" access="public" output="false" returntype="numeric">
        <cfargument name="u_path" type="string" required="true" />
        <cfargument name="activityID" type="string" required="true" />
       <!--- <cfdump var="#arguments#"><cfabort>--->
    	<!---<cfargument name="ActivityID" type="numeric" required="false" />--->
        <cfset vdest="c:\coldfusion9\wwwroot\egyptcss\attachedFiles">
  		<cffile action="UPLOAD" filefield="u_path" destination="#vdest#" nameconflict="OVERWRITE">
       	
		<cfset newfile = new()>
 		<cfset var attachedfileName = (CFFILE.ClientFileName & "." & CFFILE.ClientFileExt)>
 		<cfset var attachedfiledate = (now())>
        
            <cfset newfile.setAttachedFileName(attachedfilename)>
            <cfset newfile.setAttachedFiledate(attachedfiledate)>
            <cfset newfile.setObjectTableID(arguments.activityID)>
            <cfset newfile.setobjectTableName('activity')>
            
       
         <cfset var maxid = instance.attachedfileDAO.save(attachedfile=newfile)>
         
        <cfreturn maxid />
	</cffunction>
    
</cfcomponent>
