


<cfcomponent extends="coldbox.system.EventHandler" output="false" hint="I am a new handler">

	<!--- Inject Dependencies --->

    <cfproperty name="ResultsFrameworkService" inject="model" scope="instance">
	 <cfproperty name="ResultsFrameworkGateway" inject="model" scope="instance">
    <cfproperty name="ResultsFramework" inject="model" scope="instance">
    <cfproperty name="ResultsIndicatorService" inject="model" scope="instance">
    <cfproperty name="ResultsFrameworkExternalRelation" inject="model" scope="instance">
    <cfproperty name="ResultsFrameworkExternalRelationService" inject="model" scope="instance">
    <cfproperty name="ActivityResultsFrameworkElementService" inject="model" scope="instance">

	<cfproperty name="Indicators" inject="model" scope="instance">
	<cfproperty name="programService" inject="model" scope="instance" />
 	<cfproperty name="program" inject="model" scope="instance" />

	<cfproperty name="activityService" inject="model" scope="instance" />
	<cfproperty name="indicatorService" inject="model" scope="instance" />

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		// REST HTTP Methods Allowed for actions.
		// Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods 	= {};
	</cfscript>

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" output="false" hint="index">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

		<cfset event.setView("Indicator/index")>
	</cffunction>



<!------------------------------------------- Delete Result ------------------------------------------>


<cffunction name="deleteResult" output="false" hint=" delete Result">

		<cfargument name="event">
		<cfset var rc = event.getCollection()>
	    <cfscript>
		    	/* instantiate indicator object and new activityIndicator from service layer */
				retDeleteResultsFrameworkExternalRelation = instance.ResultsFrameworkExternalRelationService.deleteResultRelations(resultsFrameworkElementID=rc.resultsFrameworkElementID);
				retDeleteResultsIndicator = instance.resultsIndicatorService.deleteAllResultsIndicators(resultsFrameworkElementID=rc.resultsFrameworkElementID);
			    retDeleteResult = instance.resultsFrameworkService.deleteResultsFrameworkElement(resultsFrameworkElementID=rc.resultsFrameworkElementID);
		</cfscript>


				 <cfset getPlugin("MessageBox").setMessage("info","Result Deleted") />
				<cfset setNextEvent(event='framework/visualization')>

		<cfabort>

	</cffunction>












<cffunction name="saveResult" output="false" hint=" saveIndicator">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
   		 <cfset var newResultsFrameworkElement = "">
	    <cfset var newResultsFrameworkElementID = "">

	    <cfset var newResultsFrameworkElementSaved = "">


	<cfif (structKeyExists(rc,"btnUpdate"))>

		<cfset rc.ResultsFrameworkElement = instance.ResultsFrameworkService.new()>
		<cfset populatemodel(rc.ResultsFrameworkElement) />


		<cfset retResultsFrameworkElementID = instance.ResultsFrameworkService.saveResultsFrameworkElement(rc.ResultsFrameworkElement) />


    <cfelse>
    <cfif structKeyExists(rc,"btnCancel")>

        <cfset getColdboxOcm().clearEvent("indicators.saveIndicator")>
		<cfset setNextEvent(event='framework/viewresult',queryString='resultsframeworkelementid/#rc.resultsframeworkelementid#')>

    <cfelse>

        <cfset newResultsFrameworkElement = instance.ResultsFrameworkService.getResultsFrameworkElement()>

        <!---<cfset newResultsFrameworkElement = instance.ResultsIndicatorService.createResultsFrameworkElement()>--->



        <cfset populateModel(newResultsFrameworkElement)>
        <!---<cfset populateModel(newResultsFrameworkExternalRelation)>--->


        <cfset rc.newResultsFrameworkElementID = instance.ResultsFrameworkService.saveResultsFrameworkElement(newResultsFrameworkElement)>

    </cfif>
    </cfif>

<cfif structKeyExists(rc,"newresultsFrameworkElementID")>
<cfset rc.resultsFrameworkElementID=rc.newResultsFrameworkElementID>
</cfif>


		<cfset instance.ResultsFrameworkExternalRelationService.deleteParents(childResultsFrameworkElementID=rc.ResultsFrameworkElementID)>

		<cfloop list="#rc.parent#" index="vparent">

			<cfset rc.ResultsFrameworkExternalRelation = instance.ResultsFrameworkExternalRelationService.new()>

            <cfset populatemodel(rc.ResultsFrameworkExternalRelation) />
			<cfset rc.ResultsFrameworkExternalRelation.setParentResultsFrameworkElementID(evaluate("#vparent#"))>
			<cfset rc.ResultsFrameworkExternalRelation.setChildResultsFrameworkElementID(rc.ResultsFrameworkElementID)>


          <cfset retResultsFrameworkElementID =
			instance.ResultsFrameworkExternalRelationService.saveResultsFrameworkExternalRelation(ResultsFrameworkExternalRelation=rc.ResultsFrameworkExternalRelation)>
		</cfloop>


   		 <cfset getPlugin("MessageBox").setMessage("info","Result saved") />
		<cfset setNextEvent(event='framework/viewResult',queryString='resultsFrameworkElementID/#rc.resultsFrameworkElementID#')>



		<cfabort>

	</cffunction>






	<cffunction name="errorGrab" output="false" hint=" saveIndicator">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>


 	<cfmail subject="Error Capture" from="PAMS" to="smetzger@msi-inc.com" cc="" type="html">
    <cfdump var="#rc#">
    <cfdump var="#getAuthUser()#">
	</cfmail>



    	<cfset rc.CTprograms = instance.resultsFrameworkService.getPrograms()>
		<cfset rc.PageTitle = "Results Framework-Programs" />
        <cfset event.setView("framework/programList") />
	</cffunction>










<!------------------------------------------- HTML view for Framework ------------------------------------------>




	<cffunction name="programList" output="false" hint=" saveIndicator">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
    	<cfset rc.CTprograms = instance.resultsFrameworkService.getPrograms()>
		<cfset rc.PageTitle = "Results Framework-Programs" />
        <cfset event.setView("framework/programList") />
	</cffunction>





	<cffunction name="viewTop" output="false" hint=" saveIndicator">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
		<cfset rc.getTopView = instance.resultsFrameworkService.topView()>
		<cfset rc.PageTitle = "Results Frameworks" />
        <cfset event.setView("framework/viewTop") />
	</cffunction>

	<cffunction name="viewFamily" output="false" hint=" saveIndicator">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
		<cfset rc.getResult = instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />
		<cfset rc.resultRelations = instance.resultsFrameworkExternalRelationService.getResultRelations(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />
		<cfset rc.PageTitle = "Result Family" />
        <cfset event.setView("framework/viewFamily") />
	</cffunction>




	<cffunction name="resultsList" output="false" hint=" saveIndicator">
	     <cfscript>
			var rc = event.getCollection();
			rc.vFullFrame=this.getFullFamily(1);
			rc.listOrphans=instance.resultsFrameworkService.listOrphans();

        </cfscript>
	  	<cfif rc.listorphans is not ''>
		    <cfset RC.qOrphans=this.getAllOrphans(listOrphans=rc.listOrphans)>
		</cfif>
		<cfset rc.PageTitle = "Results Framework Elements" />
	    <cfset event.setView("framework/resultsList") />
	</cffunction>


	<cffunction name="primaryResult" output="false" hint="">
	     <cfscript>
			var rc = event.getCollection();
			rc.getActivityResults = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=1);

			rc.primaryList=valuelist(rc.getActivityResults.resultsFrameworkElementID);

			rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID);

			rc.vFullFrame=this.getFullFamily(21);

	    </cfscript>
		<cfset rc.PageTitle = "Primary Results Framework Elements" />
	    <cfset event.setView("proposal/editPrimaryResult") />
	</cffunction>


	<cffunction name="secondaryResult" output="false" hint="">
	     <cfscript>
			var rc = event.getCollection();
			rc.getPrimaryResults = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=1);

			rc.primaryList=valuelist(rc.getPrimaryResults.resultsFrameworkElementID);

			rc.getActivityResults = instance.activityResultsFrameworkElementService.getActivityResultsQuery(activityID=rc.ActivityID,isPrimary=0);

			rc.secondaryList=valuelist(rc.getActivityResults.resultsFrameworkElementID);

			rc.proposal = instance.activityService.getActivitysQuery(activityid=rc.activityID);

			rc.vFullFrame=this.getFullFamily(21);

	    </cfscript>
		<cfset rc.PageTitle = "Secondary Results Framework Elements" />
	    <cfset event.setView("proposal/editSecondaryResult") />
	</cffunction>









	<cffunction name="viewResult" output="false" hint=" viewresult">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>

		<cfif structKeyExists(rc,"ResultsFrameworkElementID")>
			<cfset rc.getResult = instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />

			<!--- ... place of implementation --->
			<cfif rc.getResult.getProgramID() is not ''>
				<cfset rc.Program = instance.programService.getprogram(programID=rc.getResult.getProgramID())>
			<cfelse>
				<cfset rc.Program = instance.programService.getprogram(programID=0)>
			</cfif>
			<cfset rc.resultRelations = instance.resultsFrameworkExternalRelationService.getResultRelations(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />
			<cfset rc.availableChildren = instance.resultsFrameworkService.getAvailableChildren(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />
          	<cfset rc.resultsIndicators = instance.resultsFrameworkService.getResultsIndicatorsQuery(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />

          	<cfset rc.resultsActivities = instance.activityService.getActivitysQuery(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />
			<!---<cfset rc.availableParents = instance.resultsFrameworkService.getAvailableParents(ResultsFrameworkElementID=rc.ResultsFrameworkElementID) />--->
            <cfdump var="#rc.resultRelations#">
           <!--- <cfdump var="#rc.resultsParents#">--->
            <!---<cfdump var="#rc.availableChildren#">--->
          <!---  <cfdump var="#rc.availableParents#">--->
			<cfset event.setView(name="framework/viewResult",layout="Layout.Main") />
		</cfif>
	</cffunction>





<cffunction name="visualization" output="false" hint=" viewresult">
    <cfargument name="event">
    <cfset rc.pageTitle = "Framwework Visualization">
    <cfsetting showdebugoutput="false">
	<cfset event.setView(name="framework/visualFramework") />
    <cfsetting showdebugoutput="true">
</cffunction>




<cffunction name="vis0619a" output="false" hint=" viewresult">
    <cfargument name="event">
    <cfset rc.pageTitle = "Framwework Visualization version0619a">
    <cfset event.setView(name="framework/dev1_0619a_index") />
</cffunction>
<cffunction name="vis0618" output="false" hint=" viewresult">
    <cfargument name="event">
    <cfset rc.pageTitle = "Framwework Visualization version0618">
    <cfset event.setView(name="framework/dev1_0618_index") />
</cffunction>
<cffunction name="vis0620" output="false" hint=" viewresult">
    <cfargument name="event">
    <cfset rc.pageTitle = "Framwework Visualization version0618">
    <cfset event.setView(name="framework/dev1_0620_index") />
</cffunction>








<cffunction name="editResult" output="false" hint=" viewresult">
    <cfargument name="event">
		<cfset var rc = event.getCollection()>
    <cfscript>

		rc.availableIndicators = arraynew(1);
		rc.attachedIndicators = arraynew(1);
		rc.availableActivities = "";
		rc.attachedActivities = arraynew(1);
		event.paramValue("rc.resultsFrameworkElementID","");

		if(structKeyExists(rc,"ResultsFrameworkElementID")) {
		//rc.getResult = instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);

			rc.ResultsFrameworkElement = instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);


			rc.Programs = instance.programService.getprogramsQuery();

			rc.resultRelations = instance.resultsFrameworkExternalRelationService.getResultRelations(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);
			rc.attachedParents = instance.resultsFrameworkService.getJSONParents(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);
			rc.attachedChildren = instance.resultsFrameworkService.getJSONChildren(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);
			//rc.AlljsonQuery=instance.resultsFrameworkService.getFullFramework();

			rc.vFullFrame=this.getFullFamily(1);

			rc.listOrphans=instance.resultsFrameworkService.listOrphans();


			rc.resultsIndicators = instance.indicatorService.getIndicatorsQuery(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);
			rc.resultsActivities = instance.activityService.getActivitysQuery(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);

		}
	    else {


			rc.Programs = instance.programService.getprogramsQuery();
			rc.ResultsFrameworkElement = instance.resultsFrameworkService.new();
			rc.attachedChildren = querynew("resultsFrameworkElementID,Name");
			rc.listOrphans=instance.resultsFrameworkService.listOrphans();
			//rc.availableChildren = instance.resultsFrameworkService.getChildrenQuery();
			rc.vFullFrame=this.getFullFamily(1);
			rc.resultsFrameworkElementID=0;
			rc.attachedParents = instance.resultsFrameworkService.getJSONParents(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);
		}
    </cfscript>

	<cfif structKeyExists(rc,"ResultsFrameworkElementID")>
        <CFIF rc.attachedParents.recordcount is not 0>
          <cfset RC.vparents=valuelist(rc.attachedParents.PARENTRESULTSFRAMEWORKELEMENTID, ",")>
        <cfelse>
          <cfset RC.vparents="">
        </CFIF>
        <CFIF rc.attachedChildren.recordcount is not 0>
            <cfset RC.vChildren=valuelist(rc.attachedchildren.ChildRESULTSFRAMEWORKELEMENTID, ",")>
        <cfelse>
            <cfset RC.vChildren="">
        </CFIF>
    </cfif>
        <cfif rc.listorphans is not ''>
      	  <cfset RC.qOrphans=this.getAllOrphans(listOrphans=rc.listOrphans)>
        </cfif>

        <cfset rc.pageTitle = "Edit Results information">




        <cfset event.setView(name="framework/editResult",layout="Layout.Main") />


    </cffunction>

	<cffunction name="startHTMLview" output="false" returntype="string" hint="JSON service call for one result">
 		<cfset easysee='<font size=+1><strong>Format Version (line breaks and periods are for display only</strong></font><br><span style="font-family:courier">'>
    	<cfreturn easysee>
	</cffunction>


	<cffunction name="getJsonResult" output="false" hint="JSON service call for one result">
        <cfargument name="event">
  		<cfset var rc = event.getCollection()>

        <cfparam name="rc.jv" default="N">
		<cfset jv="#rc.jv#">

         <cfset jstring="">
        <cfif jv is 'Y'><cfset jstring=(#jstring# & startHTMLview())></cfif>
		<cfset jstring=(#jstring# & '{')>
		<cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '<br>')>
        </cfif>

		<cfset jsonQuery=instance.resultsFrameworkService.getJSONelement(resultsFrameworkElementID=rc.resultsFrameworkElementID)>
        <cfset jsonColumns = #jsonQuery.columnlist# />

        <cfloop index="strColumnName" list="#jsonColumns#" delimiters=",">
        	<cfset jstring=#jstring# & jsonLine(strColumnName=#strColumnName#)>
            <cfset jstring=jstring & ','>

           <cfif jv is 'Y'>
                <cfset jstring=(#jstring# & '<br>')>
            </cfif>
		</cfloop>

        <cfset subarrays=getJsonResultsArrays(resultsFrameworkElementID=rc.resultsFrameworkElementID)>

	   <cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '}<br></span>')>
        <cfelse>
            <cfset jstring=(#jstring# & '}')>
        </cfif>
		<cfset rc.jstring=#jstring#>

	   <cfif jv is 'Y'>
   		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSONreadable") />
		<cfelse>
    		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSON") />
		</cfif>
	</cffunction>



 <!------------------------------------------- json data for ALL results ------------------------------------------>
   <cffunction name="getJsonAllResults" output="false" hint="JSON service call for one result">
		<cfargument name="event">
  		<cfset var rc = event.getCollection()>
		<cfset jstring="">
		<cfset jstring=(jstring & '{"FullFramework" : [')>
		<cfset AlljsonQuery=instance.resultsFrameworkGateway.getFrameworkTree()>

		<cfloop query="AlljsonQuery">
			<cfif AlljsonQuery.currentRow gt 1>
				<cfset jstring=jstring & ']},'>
			</cfif>
			<cfset jstring=(jstring & '{')>
			<cfset jstring=jstring & '"NAME":"' & NAME & '",'>
			<cfset jstring=jstring & '"PARENTID":null,'>
			<cfset jstring=jstring & '"RESULTSFRAMEWORKELEMENTID":' & RESULTSFRAMEWORKELEMENTID & ','>
			<cfset jstring=jstring & '"Children":[' & Children & '],'>
			<cfset jstring=jstring & '"Parents":[' & Parents & '],'>
			<cfset jstring=jstring & '"Activities":[' & Activities & '],'>
			<cfset jstring=jstring & '"Indicators":[' & Indicators>
		</cfloop>
		<cfset jstring=jstring & ']}]}'>
		<cfset rc.jstring=jstring>


		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSON") />
	</cffunction>

<!---     	<cffunction name="getJsonAllResults" output="false" hint="JSON service call for one result">
		<cfargument name="event">
  		<cfset var rc = event.getCollection()>
		 <cfparam name="rc.jv" default="N">
		<cfset jv="#rc.jv#">

         <cfset jstring="">
   		 <cfif jv is 'Y'><cfset jstring=(#jstring# & startHTMLview())></cfif>

		<cfset jstring=(#jstring# & '{"FullFramework" : [')>
		<cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '<br>')>
        </cfif>

		<cfset AlljsonQuery=instance.resultsFrameworkService.getFullFramework()>

   		 <cfloop query="AlljsonQuery">

    	<cfset rfe=#AlljsonQuery.resultsFrameworkElementID#>

        <cfquery dbtype="query" name="jsonQuery">
        Select * from alljsonQuery where resultsFrameworkElementID=#rfe#
        </cfquery>

        <cfset jstring=(#jstring# & '{')>
		<cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '<br>')>
        </cfif>

	     <cfset jsonColumns = #jsonQuery.columnlist# />

        <cfloop index="strColumnName" list="#jsonColumns#" delimiters=",">
        	<cfset jstring=#jstring# & jsonLine(strColumnName=#strColumnName#)>
            <cfset jstring=jstring & ','>
           <cfif jv is 'Y'>
                <cfset jstring=(#jstring# & '<br>')>
            </cfif>
		</cfloop>

		<cfset subarrays=getJsonResultsArrays(resultsFrameworkElementID=rfe)>
		<cfif alljsonQuery.recordcount is alljsonQuery.currentrow>
                <cfset jstring=(#jstring# & '}')>
		<cfelse>
                <cfset jstring=(#jstring# & '},')>
        </cfif>
		<cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '<br>')>
        </cfif>

        </cfloop>
	   <cfif jv is 'Y'>
            <cfset jstring=(#jstring# & ']}<br></span>')>
        <cfelse>
            <cfset jstring=(#jstring# & ']}')>
        </cfif>
		<cfset rc.jstring=#jstring#>

			   <cfif jv is 'Y'>
   		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSONreadable") />
		<cfelse>
    		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSON") />
		</cfif>
	</cffunction>




      <cffunction name="getJsonResultsArrays" returntype="string" output="false" hint="JSON service call for one result">
		<cfargument name="resultsFrameworkElementID" required="yes">
		<cfset subarrays="">
   		<cfset jsonChildren = instance.resultsFrameworkService.getJSONchildren(resultsFrameworkElementID=arguments.resultsFrameworkElementID)>
        <cfset jstring=jstring & '"Children":['>
        <cfset listid=valuelist(jsonChildren.childresultsframeworkelementID, ",")>
        <cfset jstring=(jstring & #listid# & '],')>
        <cfif jv is 'Y'>
	        <cfset jstring=(#jstring# & '<br>')>
        </cfif>

		<cfset jsonParents = instance.resultsFrameworkService.getJSONparents(resultsFrameworkElementID=arguments.resultsFrameworkElementID)>
        <cfset jstring=jstring & '"Parents":['>
        <cfset listid=valuelist(jsonparents.parentresultsframeworkelementID, ",")>
        <cfset jstring=(jstring & #listid# & '],')>
        <cfif jv is 'Y'>
	        <cfset jstring=(#jstring# & '<br>')>
        </cfif>
		<cfset jsonActivities = instance.resultsFrameworkService.getJSONactivity(resultsFrameworkElementID=arguments.resultsFrameworkElementID)>
        <cfset jstring=jstring & '"Activities":['>
        <cfset listid=valuelist(jsonActivities.activityID, ",")>
        <cfset jstring=(jstring & #listid# & '],')>
        <cfif jv is 'Y'>
	        <cfset jstring=(#jstring# & '<br>')>
        </cfif>


		<cfset jsonindicators = instance.resultsFrameworkService.getJSONIndicator(resultsFrameworkElementID=arguments.resultsFrameworkElementID)>
        <cfset jstring=jstring & '"Indicators":['>
        <cfset listid=valuelist(jsonIndicators.indicatorID, ",")>
        <cfset jstring=(jstring & #listid# & ']')>
        <cfif jv is 'Y'>
	        <cfset jstring=(#jstring# & '<br>')>
        </cfif>


    	<cfreturn subarrays>
   </cffunction> --->







<!------------------------------------------- json data for one INDICATOR with dependents ------------------------------------------>

	<cffunction name="getJsonIndicator" output="false" hint="JSON service call for one indicator">
		<cfargument name="event">
  		<cfset var rc = event.getCollection()>


        <cfparam name="rc.jv" default="N">
		<cfset jv="#rc.jv#">

         <cfset jstring="">
        <cfif jv is 'Y'><cfset jstring=(#jstring# & startHTMLview())></cfif>

		<cfset jstring=(#jstring# & '{')>
		<cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '<br>')>
        </cfif>

		<cfset jsonIndQueryPRE=instance.indicatorService.getIndicatorWithSource(indicatorID=rc.indicatorID)>

    	<cfquery name="jsonQuery" dbtype="query">
        Select indicatorID, name from jsonIndQueryPRE
        </cfquery>



        <cfset jsonColumns = #jsonQuery.columnlist# />

        <cfloop index="strColumnName" list="#jsonColumns#" delimiters=",">
        	<cfset jstring=#jstring# & jsonLine(strColumnName=#strColumnName#)>


		   <cfif listlast(jsonColumns) is not #strColumnName#>
		   <cfset jstring=(#jstring# & ',')>
          </cfif>



		   <cfif jv is 'Y'>
                <cfset jstring=(#jstring# & '<br>')>
            </cfif>
		</cfloop>

	   <cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '}<br></span>')>
        <cfelse>
            <cfset jstring=(#jstring# & '}')>
        </cfif>
		<cfset rc.jstring=#jstring#>



	   <cfif jv is 'Y'>
   		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSONreadable") />
		<cfelse>
    		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSON") />
		</cfif>
        </cffunction>
<!------------------------------------------- json data for one ACTIVITY with dependents ------------------------------------------>

	<cffunction name="getJsonActivity" output="false" hint="JSON service call for one indicator">
		<cfargument name="event">
  		<cfset var rc = event.getCollection()>
        <cfparam name="rc.jv" default="N">
		<cfset jv="#rc.jv#">

         <cfset jstring="">
        <cfif jv is 'Y'><cfset jstring=(#jstring# & startHTMLview())></cfif>


		<cfset jstring=(#jstring# & '{')>
		<cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '<br>')>
        </cfif>

		<cfset jsonQueryPRE=instance.activityService.getActivitysQuery(activityID=rc.activityID)>
    	<cfquery name="jsonQuery" dbtype="query">
        Select activityID, resultsFrameworkElementID, name from jsonQueryPRE
        </cfquery>


        <cfset jsonColumns = #jsonQuery.columnlist# />

        <cfloop index="strColumnName" list="#jsonColumns#" delimiters=",">
        	<cfset jstring=#jstring# & jsonLine(strColumnName=#strColumnName#)>
			<cfif strColumnName is not listlast(#jsonColumns#)>
                <cfset jstring=(#jstring# & ',')>
            </cfif>
           <cfif jv is 'Y'>
                <cfset jstring=(#jstring# & '<br>')>
            </cfif>
		</cfloop>
  		<cfif jv is 'Y'>
            <cfset jstring=(#jstring# & '}<br></span>')>
        <cfelse>
            <cfset jstring=(#jstring# & '}')>
        </cfif>
		<cfset rc.jstring=#jstring#>



	   <cfif jv is 'Y'>
   		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSONreadable") />
		<cfelse>
    		<cfset event.setView(name="framework/viewJSON",layout="Layout.JSON") />
		</cfif>       </cffunction>





	<cffunction name="getJsonChildren" output="false" hint="JSON service call for one result">
		<cfargument name="event">
		 <cfset var rc = event.getCollection()>
		<cfset jv='Y'>
		<cfset jsonQuery=instance.resultsFrameworkService.getJSONchildren(resultsFrameworkElementID=rc.resultsFrameworkElementID)>


	   <cfset jsonColumns = #jsonQuery.columnlist# />
	<cfset jsonElement=this.jsonMatrixEngine(jsonColumns=jsonColumns,jsonQuery=jsonQuery,jv=jv,classname="children")>

		<cfreturn jsonElement>
	</cffunction>

	<cffunction name="getJsonParents" output="false" hint="JSON service call for one result">
		<cfargument name="event">
		 <cfset var rc = event.getCollection()>
		<cfset jv='Y'>
		<cfset jsonQuery=instance.resultsFrameworkService.getJSONparents(resultsFrameworkElementID=rc.resultsFrameworkElementID)>


	   <cfset jsonColumns = #jsonQuery.columnlist# />
	<cfset jsonElement=this.jsonMatrixEngine(jsonColumns=jsonColumns,jsonQuery=jsonQuery,jv=jv,classname="parents")>

		<cfreturn jsonElement>
	</cffunction>


 <cffunction name="jsonLine" access="public" output="false" returntype="string">
   	<cfargument name="strColumnName" type="string" required="true" />

	<cfset intColumn =jsonQuery.FindColumn(JavaCast( "string", arguments.strColumnName )) />
    <cfset vtype=#jsonQuery.GetMetaData().GetColumnTypeName(JavaCast( 'int', intColumn ))#>

     <cfif evaluate("jsonQuery." & arguments.strColumnName) is ''>
           <cfif vtype contains 'char'>
                 <cfset #jline#=('"' & arguments.strColumnName & '":' & '"' & evaluate("jsonQuery." & arguments.strColumnName) & '"')>
            <cfelse>
                 <cfset #jline#=('"' & arguments.strColumnName & '": ' & 'null')>
            </cfif>
     <cfelse>
			<cfif evaluate("jsonQuery." & arguments.strColumnName) is '[]'>
                <cfset #jline#=('"' & arguments.strColumnName & '": ' & 'null')>
            <cfelseif evaluate("jsonQuery." & arguments.strColumnName) contains '[' and evaluate("jsonQuery." & arguments.strColumnName) contains ']'>
               <cfset #jline#=('"' & arguments.strColumnName & '": ' & evaluate("jsonQuery." & arguments.strColumnName))>
            <cfelseif vType contains 'int' or vtype contains 'bit'>
               <cfset #jline#=('"' & arguments.strColumnName & '": ' & evaluate("jsonQuery." & arguments.strColumnName))>
            <cfelseif vType contains "date">
                <cfset #jline#=('"' & arguments.strColumnName & '":' & '"' & dateformat(evaluate("jsonQuery." & arguments.strColumnName), "mmddyyyy") & '"')>
            <cfelse>
				<!--- <cfset jtext=rereplace('#evaluate("jsonQuery." & arguments.strColumnName)#', "'", "''", "All")>
				<cfset #jline#=('"' & arguments.strColumnName & '":' & serializeJSON(jtext) )>
--->

			   <cfset #jline#=('"' & arguments.strColumnName & '":' & serializeJSON(#evaluate("jsonQuery." & arguments.strColumnName)#) )>


			 </cfif>
	    </cfif>

		<cfreturn jline>
</cffunction>


<cffunction name="jsonMatrixEngine" access="public" output="false" returntype="string">

    <cfargument name="jsonQuery" type="query" required="true" />
    <cfargument name="jv" type="string" required="true" />
    <cfargument name="className" type="string" required="true" />

    <cfset jsonColumns = #jsonQuery.columnlist# />
    <cfset startBracket='{'>
    <cfset endBracket='}'>
    <cfset jsonElement="">
    <cfset jsonElement=(#jsonElement# & #startBracket#)>
    <cfif arguments.jv is 'Y'>
            <cfset jsonElement=(#jsonElement# & '<br>')>
    </cfif>

    <cfset jsonElement=(#jsonElement# & '"' & #className# & '":[')>
    <cfif arguments.jv is 'Y'>
       <cfset jsonElement=(#jsonElement# & '<br>')>
     </cfif>


    <cfloop query="jsonQuery">
        <cfset jsonElement=(#jsonElement# & #startbracket#)>
        <cfif arguments.jv is 'Y'>
            <cfset jsonElement=(#jsonElement# & '<br>')>
        </cfif>

        <cfloop list="#jsonColumns#" index="strColumnName">
            <cfset intColumn =jsonQuery.FindColumn(JavaCast( "string", strColumnName )) />
            <cfset vtype=#jsonQuery.GetMetaData().GetColumnTypeName(JavaCast( 'int', intColumn ))#>

            <cfif evaluate("jsonQuery." & strColumnName) is ''>
                <cfif vtype contains 'char'>
                    <cfset #jline#=('"' & strColumnName & '":' & '"' & evaluate("jsonQuery." & strColumnName) & '"')>
                <cfelse>
                    <cfset #jline#=('"' & strColumnName & '": ' & 'null')>
                </cfif>
            <cfelse>

				<cfif evaluate("jsonQuery." & strColumnName) is '[]'>
                    <cfset #jline#=('"' & strColumnName & '": ' & 'null')>
                <cfelseif evaluate("jsonQuery." & strColumnName) contains '[' and evaluate("jsonQuery." & strColumnName) contains ']'>
                    <cfset #jline#=('"' & strColumnName & '": ' & evaluate("jsonQuery." & strColumnName))>
                <cfelseif vType contains 'int' or vtype contains 'bit'>
                    <cfset #jline#=('"' & strColumnName & '": ' & evaluate("jsonQuery." & strColumnName))>
                <cfelseif vType contains "date">
                    <cfset #jline#=('"' & strColumnName & '":' & '"' & dateformat(evaluate("jsonQuery." & strColumnName), "mmddyyyy") & '"')>
                <cfelse>
                    <cfset #jline#=('"' & strColumnName & '":' & '"' & evaluate("jsonQuery." & strColumnName) & '"')>
                </cfif>
            </cfif>
            <cfset jsonElement=(#jsonElement# & #jline#)>
            <cfif strColumnName is not listlast(jsonColumns)>
                <cfset jsonElement=(#jsonElement# & ',')>
            </cfif>
            <cfif arguments.jv is 'Y'>
                <cfset jsonElement=(#jsonElement# & '<br>')>
            </cfif>
        </cfloop>
        <cfset jsonElement=(#jsonElement# & #endbracket#)>
        <cfif jsonQuery.recordcount is not #jsonQuery.currentrow#>
            <cfset jsonElement=(#jsonElement# & ',')>
        </cfif>
        <cfif arguments.jv is 'Y'>
            <cfset jsonElement=(#jsonElement# & '<br>')>
        </cfif>

    </cfloop>
    <cfset jsonElement=(#jsonElement# & ']')>
    <cfif arguments.jv is 'Y'>
        <cfset jsonElement=(#jsonElement# & '<br>')>
    </cfif>

		<cfreturn jsonElement>

</cffunction>


<cffunction name="frameRow" output="false" hint="JSON service call for one result" returntype="query">
    <cfargument name="vFrame" type="query" required="true" />
    <cfargument name="rfeID" type="numeric" required="true" />
    <cfargument name="levelID" type="numeric" required="true" />
    <cfargument name="rfeName" type="string" required="true" />

	<cfset temp = QueryAddRow(vFrame)>
    <cfset Temp = QuerySetCell(vFrame, "levelID", #arguments.levelID#)>
    <cfset Temp = QuerySetCell(vFrame, "resultsframeworkelementID", #arguments.rfeID#)>
    <cfset Temp = QuerySetCell(vFrame, "name",	"#rfeName#")>

	<cfreturn vframe>
</cffunction>


<cffunction name="frameBuilder" output="false" hint="JSON service call for one result" returntype="query">
    <cfargument name="rfeID" type="numeric" required="true" />
    <cfargument name="vFrame" type="query" required="true" />
   	<cfset q1=instance.resultsFrameworkService.getJSONelement(resultsFrameworkElementID=arguments.rfeID)>
	<cfset vframe=this.frameRow(vframe=arguments.vframe,rfeID=arguments.rfeID,levelid=1,rfeName=q1.Name)>
    <cfset q2=instance.resultsFrameworkService.getattachedChildrenQuery(resultsFrameworkElementID=rfeID)>

    <cfloop query="q2">
		<cfset vframe=this.frameRow(vframe=arguments.vframe,rfeID=q2.childresultsframeworkElementID,levelid=2,rfeName=q2.childName)>
        <cfset q3=instance.resultsFrameworkService.getattachedChildrenQuery(resultsFrameworkElementID=q2.childresultsframeworkElementID)>
        <cfloop query="q3">
			<cfset vframe=this.frameRow(vframe=arguments.vframe,rfeID=q3.childresultsframeworkElementID,levelid=3,rfeName=q3.childName)>
            <cfset q4=instance.resultsFrameworkService.getattachedChildrenQuery(resultsFrameworkElementID=q3.childresultsframeworkElementID)>
            <cfloop query="q4">
				<cfset vframe=this.frameRow(vframe=arguments.vframe,rfeID=q4.childresultsframeworkElementID,levelid=4,rfeName=q4.childName)>
                <cfset q5=instance.resultsFrameworkService.getattachedChildrenQuery(resultsFrameworkElementID=q4.childresultsframeworkElementID)>
                <cfloop query="q5">
					<cfset vframe=this.frameRow(vframe=arguments.vframe,rfeID=q5.childresultsframeworkElementID,levelid=5,rfeName=q5.childName)>
                    <cfset q6=instance.resultsFrameworkService.getattachedChildrenQuery(resultsFrameworkElementID=q5.childresultsframeworkElementID)>
                    <cfloop query="q6">
	                    <cfset vframe=this.frameRow(vframe=arguments.vframe,rfeID=q6.childresultsframeworkElementID,levelid=6,rfeName=q6.childName)>
					</cfloop>
                </cfloop>
            </cfloop>
       </cfloop>
	</cfloop>

	<cfreturn vframe>
</cffunction>


<cffunction name="getFullFamily" output="false" hint="JSON service call for one result" returntype="query">
    <cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
	<cfset vFrame=querynew("levelid,resultsframeworkelementID,name", "integer,integer,varchar")>


 	<cfset vframe=frameBuilder(rfeID=arguments.resultsFrameworkElementID,vframe=#vframe#)>
	<cfreturn vframe>
</cffunction>

<cffunction name="getAllOrphans" output="false" hint="JSON service call for one result" returntype="query">
    <cfargument name="listOrphans" type="string" required="true" />
    <cfset vFrame=querynew("levelid,resultsframeworkelementID,name", "integer,integer,varchar")>
	<cfloop list="arguments.listOrphans" index="orphanid">

   		<cfset vframe=this.frameBuilder(vframe=vframe,rfeID=#val(evaluate("#orphanid#"))#)>
	</cfloop>

    <cfreturn vframe>
</cffunction>






<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

