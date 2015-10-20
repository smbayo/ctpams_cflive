
<cfcomponent displayname="ResultsFrameworkElementGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	<cfproperty name="activityService" inject="model" scope="instance" />
	<cfproperty name="resultsFrameworkDAO" inject="model" scope="instance" />
    
    	<cfproperty name="activityGateway" inject="model" scope="instance" />
        	
	<cffunction name="init" access="public" output="false" returntype="ResultsFrameworkElementGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="activityID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="DisplayNumber" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="LevelDescription" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
		<cfargument name="programID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="programonly" type="boolean" required="false" default="true" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ResultsFrameworkElementID,
				Name,
				Description,
				DisplayNumber,
				Abbreviation,
				LevelDescription,
				ExternalCode,
				ExternalCodeDescription,
                programID
			FROM	ResultsFrameworkElement
			WHERE	0=0
		<cfif arguments.programonly>

				AND	ResultsFrameworkElementID not in (select childResultsFrameworkElementID from resultsFrameworkExternalRelation where parentResultsFrameworkElementID = 71)
		</cfif>
		<cfif structKeyExists(arguments,"ResultsFrameworkElementID") and len(arguments.ResultsFrameworkElementID)>
			AND	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ParentID") and len(arguments.ParentID)>
			AND	ResultsFrameworkElementID  in (select childResultsFrameworkElementID from ResultsFrameworkExternalRelation where parentResultsFrameworkElementID = <cfqueryparam value="#arguments.ParentID#" CFSQLType="cf_sql_integer" />)
		</cfif>
		<cfif structKeyExists(arguments,"activityID") and len(arguments.activityID)>
			AND	ResultsFrameworkElementID  in (select ResultsFrameworkElementID from ActivityResultsFrameworkElement where activityID = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />)
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
			AND	Description = <cfqueryparam value="#arguments.Description#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"DisplayNumber") and len(arguments.DisplayNumber)>
			AND	DisplayNumber = <cfqueryparam value="#arguments.DisplayNumber#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Abbreviation") and len(arguments.Abbreviation)>
			AND	Abbreviation = <cfqueryparam value="#arguments.Abbreviation#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"LevelDescription") and len(arguments.LevelDescription)>
			AND	LevelDescription = <cfqueryparam value="#arguments.LevelDescription#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ExternalCode") and len(arguments.ExternalCode)>
			AND	ExternalCode = <cfqueryparam value="#arguments.ExternalCode#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ExternalCodeDescription") and len(arguments.ExternalCodeDescription)>
			AND	ExternalCodeDescription = <cfqueryparam value="#arguments.ExternalCodeDescription#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"programID") and len(arguments.programID)>
			AND	programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
		</cfif>
        <cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>


	<cffunction name="getProjectObjectives" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="activityID" type="numeric" required="false" />
		<cfargument name="indicatorID" type="string" required="false" />
		<cfargument name="indicatorsOnly" type="string" required="false" />

		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ResultsFrameworkElementID,
				IndicatorID,
				activityID,
				ProjectResultsObjective,
				ProjectResultsIndicator,
				unitofmeasure,
				datasource,
				datafreq,
				collectionmethod, 
				definition,
				actual,
				target,
				measurementID
			FROM	vw_projectObjectivesIndicators
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ResultsFrameworkElementID") and len(arguments.ResultsFrameworkElementID)>
			AND	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"activityID") and len(arguments.activityID)>
			AND	activityID = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"indicatorID") and len(arguments.indicatorID)>
			AND	indicatorID = <cfqueryparam value="#arguments.indicatorID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"indicatorsOnly") and arguments.indicatorsOnly is "true">
			AND	indicatorid is not null
		</cfif>

		</cfquery>
		
		<cfreturn qList />
	</cffunction>





	<cffunction name="deleteProjectObjective" access="public" output="false" returntype="string">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />


		<cfset var delIndicators = "" />		
		<cfquery name="delIndicators" datasource="#dsn.getName()#">
			delete
			FROM	indicator
			WHERE	indicatorid in (select indicatorid from resultsindicator where ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />)
		</cfquery>
		
		<cfset var delIndicatorLinks = "" />		
		<cfquery name="delIndicatorLinks" datasource="#dsn.getName()#">
			delete
			FROM	resultsindicator
			WHERE	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		
		<cfset var delRelation = "" />		
		<cfquery name="delRelation" datasource="#dsn.getName()#">
			delete
			FROM	resultsframeworkexternalrelation
			WHERE	childResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		
		<cfset var delElement = "" />		
		<cfquery name="delElement" datasource="#dsn.getName()#">
			delete
			FROM	resultsframeworkelement
			WHERE	ResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		
		<cfreturn "true" />
	</cffunction>


	<cffunction name="deleteProjectIndicator" access="public" output="false" returntype="string">
		<cfargument name="IndicatorID" type="numeric" required="true" />


		<cfset var delIndicators = "" />		
		<cfquery name="delIndicators" datasource="#dsn.getName()#">
			delete
			FROM	indicator
			WHERE	indicatorid  = <cfqueryparam value="#arguments.IndicatorID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		
		<cfset var delIndicatorLinks = "" />		
		<cfquery name="delIndicatorLinks" datasource="#dsn.getName()#">
			delete
			FROM	resultsindicator
			WHERE	indicatorID = <cfqueryparam value="#arguments.indicatorID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		

		
		<cfreturn "true" />
	</cffunction>	
	
	<cffunction name="getRSIResults" access="public" output="false" returntype="query">

		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ResultsFrameworkElementID,
				ParentID,
				Name,
				Description,
				DisplayNumber,
				Abbreviation,
				LevelDescription,
				ExternalCode,
				ExternalCodeDescription,
                programID,
				program
			FROM	vw_RSIResults
			order by program, name
		
		</cfquery>
		
		<cfreturn qList />
	</cffunction>



	<cffunction name="getFullFrameworkQuery" access="public" output="false" returntype="query">
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ResultsFrameworkElementID,
				ParentID,
				Name
			FROM	ResultsFrameworkElement
			ORDER BY ResultsFrameworkElementID

		</cfquery>
		
		<cfreturn qList />
	</cffunction>



<cffunction name="getFrameworkTree" access="public" output="false" returntype="query">
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ResultsFrameworkElementID, ParentID,
				Name, Children, Parents, Activities, Indicators
			FROM	vw_frameworkTree
			ORDER BY ResultsFrameworkElementID

		</cfquery>
		
		<cfreturn qList />
	</cffunction>











	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="DisplayNumber" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="LevelDescription" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
		<cfargument name="programID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ResultsFrameworkElement").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>



	<cffunction name="getElementQuery" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
        <cfquery name="getElementQuery" datasource="#dsn.getName()#">
		SELECT ABBREVIATION, DESCRIPTION, DISPLAYNUMBER, EXTERNALCODE, EXTERNALCODEDESCRIPTION, LEVELDESCRIPTION, NAME, RESULTSFRAMEWORKELEMENTID
        FROM resultsFrameworkElement where resultsFrameworkElementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		<cfreturn getElementQuery>
	</cffunction>
    
    
 	<cffunction name="getTopView" access="public" output="false" returntype="query">
 		<cfquery name="getTopView" datasource="#dsn.getName()#">
		SELECT * from vw_parentChild where parentResultsFrameworkElementID=<cfqueryparam value="0" CFSQLType="cf_sql_integer" />
		</cfquery>
 		<cfreturn getTopView>
	</cffunction>     
    
	<cffunction name="getResultQueryActivity" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfquery name="getResultQueryActivityID" datasource="#dsn.getName()#">
		SELECT ActivityID FROM activityResultsFrameworkElement where resultsFrameworkElementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
 		<cfreturn getResultQueryActivityID>
	</cffunction>  
	<cffunction name="getResultQueryIndicator" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfquery name="getResultQueryIndicatorID" datasource="#dsn.getName()#">
		SELECT IndicatorID FROM vw_resultsAndindicators where resultsFrameworkElementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
 		<cfreturn getResultQueryIndicatorID>
	</cffunction>  
 	<cffunction name="getResultQueryChildren" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfquery name="getResultQueryChildren" datasource="#dsn.getName()#">
		SELECT childResultsFrameworkelementID FROM vw_parentchild where parentResultsFrameworkElementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
 		<cfreturn getResultQueryChildren>
	</cffunction>  
  	<cffunction name="getResultQueryParents" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfquery name="getResultQueryParents" datasource="#dsn.getName()#">
		SELECT ParentResultsFrameworkelementID FROM vw_parentchild where childresultsFrameworkElementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
 		<cfreturn getResultQueryParents>
	</cffunction>   
    
	<cffunction name="getResultActivityIDs" access="public" output="false" returntype="Query">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfset var qReturn = "">
		
		<cfquery name="qReturn" datasource="#dsn.getName()#">
			SELECT activityID
			FROM Activity
			where resultsframeworkElementID=<cfqueryparam value="#arguments.resultsframeworkelementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		<cfreturn qReturn>
	</cffunction>



    
 	<cffunction name="getActivityIDarray" access="public" output="false" returntype="array">
      	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
       
   		<cfset var qList = getResultQueryActivityID(ResultsFrameworkElementID=11) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ActivityID").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
        
		<cfreturn resultActivities>
	</cffunction>
    
    
	<cffunction name="getAttachedChildrenQuery" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
        <cfquery name="getAttachedChildrenQuery" datasource="#dsn.getName()#">
        SELECT CHILDRESULTSFRAMEWORKELEMENTID, childName FROM vw_parentchild where ParentresultsframeworkelementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
        </cfquery>
		<cfreturn getAttachedChildrenQuery>
	</cffunction>    
   
   
   <cffunction name="getAvailableChildrenQuery" access="public" output="false" returntype="query">
   <cfargument name="ResultsFrameworkElementID" type="numeric" required="true">
   
   <cfset var availablechildren = "">
           <cfquery name="availableChildren" datasource="#dsn.getName()#">

  	SELECT resultsFrameworkElementID, name
	FROM resultsFrameworkElement
	WHERE resultsFrameworkElementID not in (
		SELECT childresultsFrameworkElementID
		FROM ResultsFrameworkExternalRelation
		WHERE parentResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
        )
	</cfquery>
   <cfreturn availableChildren>
  </cffunction>
    
    
    
	<cffunction name="getElementChildrenQuery" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
        <cfquery name="getElementChildrenQuery" datasource="#dsn.getName()#">
        SELECT CHILDRESULTSFRAMEWORKELEMENTID, childName FROM vw_parentchild where ParentresultsframeworkelementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
        </cfquery>
		<cfreturn getElementChildrenQuery>
	</cffunction>
	<cffunction name="getElementParentsQuery" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
        <cfquery name="getElementParentsQuery" datasource="#dsn.getName()#">
        SELECT ParentRESULTSFRAMEWORKELEMENTID, parentName FROM vw_parentchild where ChildResultsframeworkelementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
        </cfquery>
		<cfreturn getElementParentsQuery>
	</cffunction>
	<cffunction name="getActivityQuery" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfquery name="getActivityQuery" datasource="#dsn.getName()#">
		        SELECT activityID from activity where resultsframeworkelementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		<cfreturn getActivityQuery>
	</cffunction>
	<cffunction name="getIndicatorQuery" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfquery name="getIndicatorsQuery" datasource="#dsn.getName()#">
		        SELECT indicatorID from indicator where resultsframeworkelementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		<cfreturn getIndicatorsQuery>
	</cffunction>

	<cffunction name="qResultIndicatorsQuery" access="public" output="false" returntype="query">
    	<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfquery name="qResultIndicatorsQuery" datasource="#dsn.getName()#">
		        SELECT * from vw_resultsAndIndicators where resultsframeworkelementID=<cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfquery>
		<cfreturn qResultIndicatorsQuery>
	</cffunction>
    
	<cffunction name="getOrphans" access="public" output="false" returntype="query">
        <cfquery name="getOrphans" datasource="#dsn.getName()#">
        SELECT * FROM resultsANDparents where withParent is NULL and resultsFrameworkElementID <> 1
        </cfquery>
        
		<cfreturn getOrphans>
	</cffunction>

   <cffunction name="getResultsQtrs" access="public" output="false" returntype="Query">
	    <cfargument name="resultsframeworkelementID" type="numeric" required="true" />
	    
	    <cfset var qQuarterly = "" />
	    <cfquery name="qQuarterly" datasource="#dsn.getName()#">
			SELECT DISTINCT
				   /*--[MeasurementID] */
			       resultsframeworkelementID
			      ,StartDate
			      ,EndDate
			      ,(SELECT min(StartDate) FROM Measurement WHERE ActivityID = msmt.ActivityID GROUP BY ActivityID)  min_startDate 
			      ,(SELECT max(EndDate) FROM Measurement WHERE ActivityID = msmt.ActivityID GROUP BY ActivityID)  max_endDate
			  FROM Measurement msmt
			WHERE ActivityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.activityid#" />
	    </cfquery>  
	  
	    <cfreturn qQuarterly />
    </cffunction>


</cfcomponent>
