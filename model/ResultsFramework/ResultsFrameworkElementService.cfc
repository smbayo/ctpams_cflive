
<cfcomponent name="ResultsFrameworkElementService" output="false">
	<cfproperty name="resultsFrameworkGateway" inject="model" scope="instance" />
	<cfproperty name="resultsFrameworkDAO" inject="model" scope="instance" />
	<cfproperty name="ResultsFrameworkElement" inject="model" scope="instance" />
    
	<cfproperty name="activityService" inject="model" scope="instance" />
	<cfproperty name="indicatorService" inject="model" scope="instance" />
    
	<cfproperty name="orgGateway" inject="model" scope="instance" />
	<cfproperty name="orgDAO" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ResultsFrameworkElementService">
		<cfreturn this/>
	</cffunction>
	
    <cffunction name="new" access="public" output="false"  returntype="ResultsFrameworkElement">
		<cfset var ResultsFrameworkElement = createObject("component","ResultsFrameworkElement").init() />
        <cfreturn resultsFrameworkElement>
	</cffunction>

	<cffunction name="createResultsFrameworkElement" access="public" output="false" returntype="ResultsFrameworkElement">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="ProgramID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="DisplayNumber" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="LevelDescription" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
        
		
			
		<cfset var ResultsFrameworkElement = createObject("component","ResultsFrameworkElement").init(argumentCollection=arguments) />
		<cfreturn ResultsFrameworkElement />
	</cffunction>

	<cffunction name="getResultsFrameworkElement" access="public" output="false" returntype="ResultsFrameworkElement">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfset var ResultsFrameworkElement="">
		<cfif structKeyExists(arguments,"ResultsFrameworkElementID")>
			<cfset var ResultsFrameworkElement = createResultsFrameworkElement(argumentCollection=arguments) />
            <cfset instance.ResultsFrameworkDAO.read(ResultsFrameworkElement) />
		<cfelse>	
			<cfset ResultsFrameworkElement = instance.ResultsFrameworkElement.init()>	
        </cfif>

        <cfreturn ResultsFrameworkElement />
	</cffunction>

	<cffunction name="getResultsFrameworkElements" access="public" output="false" returntype="array">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ProgramID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="DisplayNumber" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="LevelDescription" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
		
		<cfreturn instance.ResultsFrameworkGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveResultsFrameworkElement" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElement" type="ResultsFrameworkElement" required="true" />

		<cfreturn instance.ResultsFrameworkDAO.save(ResultsFrameworkElement) />
	</cffunction>

	<cffunction name="deleteResultsFrameworkElement" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		
		<cfset var ResultsFrameworkElement = createResultsFrameworkElement(argumentCollection=arguments) />
		<cfreturn instance.ResultsFrameworkDAO.delete(ResultsFrameworkElement) />
	</cffunction>
 
   	<cffunction name="getPrograms" access="public" output="false" returntype="query">
		<cfset getPrograms=instance.resultsFrameworkGateway.getPrograms()>
		<cfreturn getPrograms>
    </cffunction>
    

 
   	<cffunction name="getFullFramework" access="public" output="false" returntype="query">
		<cfset getJSONelement=instance.resultsFrameworkGateway.getFullFrameworkQuery()>
		<cfreturn getJSONelement>
    </cffunction>
    
	<cffunction name="getJSONElement" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
    	<cfset getJSONelement=instance.resultsFrameworkGateway.getElementQuery(resultsFrameworkElementID=resultsFrameworkElementID)>
		  	<cfreturn getJSONelement>
      </cffunction>
    
    <cffunction name="topView" access="public" output="false" returntype="query">
		<cfset getTopView=instance.resultsFrameworkGateway.getTopView()>
		<cfreturn getTopView>
    </cffunction>

    
    	<cffunction name="getResultActivity" access="public" output="false" returntype="array">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfset getResultActivity=instance.resultsFrameworkGateway.getActivityIDarray(resultsFrameworkElementID=resultsFrameworkElementID)>
		<cfreturn getResultActivity>
    </cffunction>
    
	<cffunction name="getJSONChildren" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfset getJSONChidren=instance.resultsFrameworkGateway.getResultQueryChildren(resultsFrameworkElementID=resultsFrameworkElementID)>
		<cfreturn getJSONChidren>
    </cffunction>
	<cffunction name="getJSONparents" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfset getJSONparents=instance.resultsFrameworkGateway.getResultQueryParents(resultsFrameworkElementID=resultsFrameworkElementID)>
		<cfreturn getJSONparents>
    </cffunction>
	<cffunction name="getJSONActivity" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfset getJSONActivity=instance.resultsFrameworkGateway.getResultQueryActivity(resultsFrameworkElementID=resultsFrameworkElementID)>
        
		<cfreturn getJSONActivity>
    </cffunction>
	<cffunction name="getJSONIndicator" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfset getJSONIndicator=instance.resultsFrameworkGateway.getResultQueryIndicator(resultsFrameworkElementID=resultsFrameworkElementID)>
		<cfreturn getJSONIndicator>
	</cffunction>
 
 	<cffunction name="getResultsIndicatorsQuery" access="public" output="false" returntype="Query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfset getResultIndicators=instance.resultsFrameworkGateway.qResultIndicatorsQuery(resultsFrameworkElementID=resultsFrameworkElementID)>
		<cfreturn getResultIndicators>
	</cffunction>	


	<cffunction name="getAvailableChildren" access="public" output="false" returntype="Query">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="true">
	    <cfset rc.qallResults = getFullFramework() />
	    <cfset rc.qChildren = getJSONchildren(resultsFrameworkElementID=resultsFrameworkElementID) />
	    <cfset rc.lstchild = IIF(rc.qChildren.recordCount EQ 0,DE("0"),DE("#valueList(rc.qChildren.ChildresultsFrameworkElementID)#")) />
	    <cfquery name="qavailableChildren" dbtype="query">
		    SELECT resultsFrameworkElementID,Name
		      FROM rc.qallResults
		     WHERE resultsFrameworkElementID NOT IN (#rc.lstChild#)		
		</cfquery>
		<cfreturn qavailableChildren  />
	</cffunction>	
    <cffunction name="getAvailableparents" access="public" output="false" returntype="Query">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="true">
	    <cfset rc.qallResults = getFullFramework() />
	    <cfset rc.qparents = getJSONparents(resultsFrameworkElementID=resultsFrameworkElementID) />
	    <cfset rc.1stParent = IIF(rc.qparents.recordCount EQ 0,DE("0"),DE("#valueList(rc.qparents.ParentresultsFrameworkElementID)#")) />
	    <cfquery name="qavailableparents" dbtype="query">
		    SELECT resultsFrameworkElementID,Name
		      FROM rc.qallResults
		     WHERE resultsFrameworkElementID NOT IN (#rc.lstParent#)		
		</cfquery>
		<cfreturn qavailableparents  />
	</cffunction>	
	 
 
 
 	<cffunction name="createJson" access="public" output="false" returntype="string">

		<cfargument name="numericList" type="string" required="true" />
		<cfargument name="dateList" type="string" required="true" />
		<cfargument name="stringList" type="string" required="true" />
		<cfargument name="lastCol" type="string" required="true" />
		<cfargument name="jv" type="string" required="true" />
        

       <cfset startBracket='{'>
        <cfset endBracket='}'>
        <cfset jsonElement="">
        <cfset jsonActivity=(#jsonElement# & #startBracket#)>
        <cfif arguments.jv is 'Y'>
	            <cfset jsonElement=(#jsonElement# & '<br>')>
        </cfif>

		<cfloop list="arguments.numericlist,arguments.dateList,arguement.stringList" index="listType">
       

            <cfloop list="#evaluate('#listType#')#" index="columnVAR">
                <cfif evaluate("activity." & columnVAR) is ''>
                    <cfif listType is not 'stringList'>
                         <cfset #jline#=('"' & columnVAR & '": ' & 'NULL')>
                    <cfelse>
                         <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("activity." & columnVAR) & '"')>
                    </cfif>
               <cfelse>
                    <cfif listType is 'numericList'>
                       <cfset #jline#=('"' & columnVAR & '": ' & evaluate("activity." & columnVAR))>
                    <cfelseif listType is "dateList">
                        <cfset #jline#=('"' & columnVAR & '":' & '"' & dateformat(evaluate("activity." & columnVAR), "mmddyyyy") & '"')>
                   <cfelse>
                      <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("activity." & columnVAR) & '"')>
                   </cfif>
                </cfif>
                <cfset jsonElement=(#jsonElement# & #jline#)>
                <cfif columnvar is not #lastcol#>
                      <cfset jsonElement=(#jsonElement# & ',')>
                </cfif>
                <cfif arguments.jv is 'Y'>
                    <cfset jsonElement=(#jsonElement# & '<br>')>
                </cfif>
            </cfloop>
      	  
		</cfloop>
            
        <cfset jsonElement=(#jsonElement# & #endBracket#)>
        <cfset createJson=(#jsonElement#)>
        
        <cfreturn createJson>
        </cffunction>
 
 
 	<cffunction name="createJsonArray" access="public" output="false" returntype="string">

		<cfargument name="numericList" type="string" required="true" />
		<cfargument name="dateList" type="string" required="true" />
		<cfargument name="stringList" type="string" required="true" />
		<cfargument name="lastCol" type="string" required="true" />
		<cfargument name="jv" type="string" required="true" />
        

       <cfset startBracket='{'>
        <cfset endBracket='}'>
        <cfset jsonElement="">
        <cfset jsonActivity=(#jsonElement# & #startBracket#)>
        <cfif arguments.jv is 'Y'>
	            <cfset jsonElement=(#jsonElement# & '<br>')>
        </cfif>

		<cfloop list="arguments.numericlist,arguments.dateList,arguement.stringList" index="listType">
       

            <cfloop list="#evaluate('#listType#')#" index="columnVAR">
                <cfif evaluate("activity." & columnVAR) is ''>
                    <cfif listType is not 'stringList'>
                         <cfset #jline#=('"' & columnVAR & '": ' & 'NULL')>
                    <cfelse>
                         <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("activity." & columnVAR) & '"')>
                    </cfif>
               <cfelse>
                    <cfif listType is 'numericList'>
                       <cfset #jline#=('"' & columnVAR & '": ' & evaluate("activity." & columnVAR))>
                    <cfelseif listType is "dateList">
                        <cfset #jline#=('"' & columnVAR & '":' & '"' & dateformat(evaluate("activity." & columnVAR), "mmddyyyy") & '"')>
                   <cfelse>
                      <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("activity." & columnVAR) & '"')>
                   </cfif>
                </cfif>
                <cfset jsonElement=(#jsonElement# & #jline#)>
                <cfif columnvar is not #lastcol#>
                      <cfset jsonElement=(#jsonElement# & ',')>
                </cfif>
                <cfif arguments.jv is 'Y'>
                    <cfset jsonElement=(#jsonElement# & '<br>')>
                </cfif>
            </cfloop>
      	  
		</cfloop>
            
        <cfset jsonElement=(#jsonElement# & #endBracket#)>
        <cfset createJson=(#jsonElement#)>
        
        <cfreturn createJson>
        </cffunction>
 
 
    <cffunction name="listOrphans" access="public" output="false" returntype="string">
    
    <cfset var qOrphans = instance.resultsFrameworkGateway.getOrphans()>
	<cfset listOrphans=valuelist(qOrphans.resultsFrameworkElementID)>
    <cfreturn listOrphans>
  </cffunction>
 
 
   <cffunction name="getAttachedChildrenQuery" access="public" output="false" returntype="query">
    <cfargument name="resultsFrameworkElementID" type="numeric" required="true" />
    
    <cfset var qAttachedChildren = instance.resultsFrameworkGateway.getAttachedChildrenQuery(resultsFrameworkElementID=arguments.resultsFrameworkElementID)>
    
    <cfreturn qAttachedChildren />
  </cffunction>

  <cffunction name="getAvailableChildrenQuery" access="public" output="false" returntype="query">
    <cfargument name="resultsFrameworkElementID" type="numeric" required="true" />
    
    <cfset var qAvailableChildren = instance.resultsFrameworkGateway.getAvailableChildrenQuery(resultsFrameworkElementID=arguments.resultsFrameworkElementID)>
    
    <cfreturn qAvailablechildren />
  </cffunction>
    
</cfcomponent>
	