<cfcomponent extends="coldbox.system.EventHandler" output="false" hint="I am a new handler">
	<cfproperty name="logger" inject="logbox:logger:Indicator" />

	<!--- Inject Dependencies --->
	<cfproperty name="indicatorService" inject="model" scope="instance">
	<cfproperty name="indicator" inject="model" scope="instance">
	<cfproperty name="resultsFrameworkService" inject="model" scope="instance">
	<cfproperty name="resultsIndicatorService" inject="model" scope="instance">
	<cfproperty name="resultsIndicator" inject="model" scope="instance">
	<cfproperty name="resultsIndicatorDAO" inject="model" scope="instance">
	<cfproperty name="DisAggSetService" inject="model" scope="instance">
	<cfproperty name="DisaggSetIndicatorGateway" inject="model" scope="instance">
	<cfproperty name="disAggSetIndicatorService" inject="model" scope="instance">
	<cfproperty name="DisAggSet" inject="model" scope="instance">

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

<cffunction name="new" output="false" hint="edit">
		<cfargument name="event">

		<cfset rc = event.getCollection() />

		<cftrace abort="false" inline="true" type="information" text="new indicator">

		<cfscript>
			//var rc = event.getCollection();
			var rc.DisaggSetIndicatorsList="";
			var disaggsets = "";
			var rc.availableFrameworkIndicators = arraynew(1);
			var rc.attachedFrameworkIndicators = arraynew(1);
			var rc.activityIndicators = arrayNew(1);
			event.paramValue("rc.isGrantNew","false");

			if(event.valueExists("indicatorID")){
				rc.Indicator = instance.indicatorService.getIndicator(rc.indicatorid);
				disaggsets= instance.DisaggSetIndicatorGateway.getByAttributesQuery(indicatorID=rc.indicatorid);
				rc.DisaggSetIndicatorsList=valuelist(disaggsets.disaggsetid);
			} else {
				rc.Indicator = instance.indicatorService.new();
			}

			rc.grantList = instance.activityService.getActivityNames();
			rc.disaggSetArray = instance.disaggSetService.getdisaggSets();
			rc.disaggsetarraylen=arraylen(rc.disaggsetarray);

			//event.paramValue("rc.activityID","");
			//rc.qActivityIndicators = querynew("activityIndicatorID,ActivityID,IndicatorID,resultsFrameworkElementID,IntendedChangeDirection,name");

			// Get all the activityIndicator objects for this Grant as a query
			rc.qActivityIndicators = instance.activityIndicatorService.getActivityIndicatorsQuery(activityid=rc.activityid);


			// Get all available indicators as an array of objects
			rc.qIndicatorList = instance.indicatorService.getIndicators();
		</cfscript>

		<!--- Loop through all indicators and put any already attached indicators into a separate array --->
		<cfloop array="#rc.qIndicatorList#" index="currIndicator">
			<cfif len(currIndicator.getResultsFrameworkElementID())>
				<cfquery name="rc.checkIfFrameworkIndicatorIsAttached" dbtype="query">
                    SELECT ActivityID
                    FROM rc.qActivityIndicators
                    WHERE
                       resultsframeworkelementID is not null
                       AND indicatorID = <cfqueryparam cfsqltype="cf_sql_integer" value="#currIndicator.getIndicatorID()#"> and activityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#rc.activityID#">
                </cfquery>
                <cfif rc.checkIfFrameworkIndicatorIsAttached.recordcount >
                    <cfset arrayAppend(rc.attachedFrameworkIndicators,currIndicator)>
                <cfelse>
                	<cfset arrayAppend(rc.availableFrameworkIndicators,currIndicator)>
				</cfif>
             <cfelse>
				<!--- TODO: Populate available framework indicators
				    <cfset arrayAppend(rc.availableFrameworkIndicators,currIndicator)>
				--->
				<cfquery name="rc.checkIfActivityIndicatorIsAttached" dbtype="query">
				    SELECT ActivityID
				    FROM rc.qActivityIndicators
				    WHERE
				       resultsframeworkelementID is null
				       AND indicatorID = <cfqueryparam cfsqltype="cf_sql_integer" value="#currIndicator.getIndicatorID()#"> and activityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#rc.activityID#">
				</cfquery>
				<cfif rc.checkIfActivityIndicatorIsAttached.recordcount>
				    <cfset arrayAppend(rc.activityIndicators,currIndicator)>
				</cfif>
			</cfif>
		</cfloop>

			<cfset event.setView("Indicator/indicator") />
	</cffunction>

<cffunction name="viewindicator" output="false" hint="edit">
		<cfargument name="event">

		<cfscript>
			var rc = event.getCollection();
			var rc.DisaggSetIndicatorsList="";
			var disaggsets = "";

			if(event.valueExists("indicatorID")){

				rc.Indicator = instance.indicatorService.getIndicator(rc.indicatorid);
				rc.resultIndicator = instance.REsultsindicatorService.getresultsIndicatorsByIndicatorID(rc.indicatorid);
				//writedump(rc.getResultindicator.getResultsFrameworkElementID()); abort;
				rc.getResult=instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.resultIndicator.ResultsFrameworkElementID);
				//rc.getResult=instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);
				//rc.ResultName=rc.resultsFrameworkElement.getName();

				if (not StructkeyExists(rc, "resultsFrameworkElementID")) {
					rc.resultsFrameworkElementID=rc.indicator.getResultsFrameworkElementID();
					}

				rc.disaggsets= instance.DisaggSetIndicatorGateway.getByAttributesQuery(indicatorID=rc.indicatorid);
				rc.DisaggSetIndicatorsList=valuelist(rc.disaggsets.disaggsetid);
			} else {
				//rc.Indicator = instance.indicatorService.new();
				//rc.getResult=instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);

			}

			rc.disaggSetArray = instance.disaggSetService.getdisaggSets();
			rc.disaggsetarraylen=arraylen(rc.disaggsetarray);

			event.setView("Indicator/viewIndicator");
		</cfscript>
</cffunction>

<cffunction name="editor" output="false" hint="edit">

        <cfargument name="event">

		<cfscript>
			var rc = event.getCollection();
			var rc.DisaggSetIndicatorsList="";
			var disaggsets = "";

			if(event.valueExists("indicatorID")){

				rc.Indicator = instance.indicatorService.getIndicator(rc.indicatorid);
				rc.resultIndicator = instance.REsultsindicatorService.getresultsIndicatorsByIndicatorID(rc.indicatorid);
				rc.getResult=instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.resultIndicator.ResultsFrameworkElementID);
				//rc.getResult=instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);
				//rc.ResultName=rc.resultsFrameworkElement.getName();

				if (not StructkeyExists(rc, "resultsFrameworkElementID")) {
					rc.resultsFrameworkElementID=rc.indicator.getResultsFrameworkElementID();
					}

				disaggsets= instance.DisaggSetIndicatorGateway.getByAttributesQuery(indicatorID=rc.indicatorid);
				rc.DisaggSetIndicatorsList=valuelist(disaggsets.disaggsetid);
			} else {
				rc.Indicator = instance.indicatorService.new();
				rc.getResult=instance.resultsFrameworkService.getResultsFrameworkElement(ResultsFrameworkElementID=rc.ResultsFrameworkElementID);

			}

			rc.disaggSetArray = instance.disaggSetService.getdisaggSets();
			rc.disaggsetarraylen=arraylen(rc.disaggsetarray);


			event.setView("Indicator/editor");
		</cfscript>
	</cffunction>

	<cffunction name="saveIndicator" output="false" hint=" saveIndicator">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
	    <cfset var newIndicator = "">
	    <cfset var newIndicatorID = "">
	    <cfset var newResultsIndicator = "">
	    <cfset var newResultsIndicatorSaved = "">

		<!--- grab user --->
		<!---<cfset var rc.updatedBy = getPlugin("SessionStorage").getVar("updatedby") />--->

	    <cfscript>

			if(structKeyExists(rc,"btnUpdate"))
				{
		  		/* instantiate indicator object and new activityIndicator from service layer */
			    rc.indicatorObj = instance.indicatorService.new();
			    /* get current indocator info */
			    curIndicator = instance.indicatorService.getIndicator(rc.indicatorID);
			    rc.resultIndicator = instance.REsultsindicatorService.getresultsIndicatorsByIndicatorID(rc.indicatorid);

			    /* populate new indicator instance */
		  		populateModel(rc.indicatorObj);
	  			/* preserve "IntendedChangeDirection" data (cannot be updated in form) */
	  			//rc.indicatorObj.setIntendedChangeDirection(curIndicator.getIntendedChangeDirection());

		    	/* Save indicator  */


		    	retIndicatorID = instance.indicatorService.saveIndicator(indicator=rc.indicatorObj);

				var disaggsetid_list = iif(isDefined('rc.disaggsetid'),Evaluate(DE('rc.disaggsetid')),DE(''));
		    	var disaggsetid_listlen = listlen(disaggsetid_list);




				//drop previous disaggsets
				instance.disAggSetIndicatorService.deleteDisAggSetIndicators(indicatorid=IndicatorID);

				//loop over selected disaggsets, saving as you go
				for(i=1;i lte disaggsetid_listlen; i++ )
					{
					// logger.info("disaggsetid["& i & "]=" & listgetat(disaggsetid_list,i));
					newDisaggSetIndicator = instance.disAggSetIndicatorService.createDisAggSetIndicator(disaggsetid=listgetat(disaggsetid_list,i), indicatorid=IndicatorID);
					instance.disaggSetIndicatorService.saveDisaggSetIndicator(newDisaggSetIndicator);
					}
		   		setNextEvent(event='indicator.viewIndicator',queryString='indicatorID/#rc.indicatorID#');

		    }  else {

				//var disaggsetid_list = iif(isDefined('rc.disaggsetid'),Evaluate(DE('rc.disaggsetid')),DE(''));
		    	//var disaggsetid_listlen = listlen(disaggsetid_list);

		    	// Check to see if user is cancelling
				if(structKeyExists(rc,"btnCancel"))
					{
						/* Clear events */
						getColdboxOcm().clearEvent("indicators.saveIndicator");
						setNextEvent(event='framework.viewResult',queryString='resultsFrameworkElementID/#rc.resultsFrameworkElementID#');
					}
		    	else {
			    	/* Get new indicator and new activityIndicator from service layer */
			    	rc.newIndicator = instance.indicatorService.getIndicator();


			    	/* Populate indicator */
			    	populateModel(rc.newIndicator);
					//populateModel(rc.newResultsIndicator);
		 			/* Save indicator. Get  */
			    	newIndicatorID = instance.indicatorService.saveIndicator(rc.newIndicator);
					rc.newResultsIndicator = instance.ResultsIndicatorService.createResultsIndicator(indicatorID=newindicatorID,resultsFrameworkElementID=rc.resultsFrameworkElementID);
					newResultsIndicatorSaved = instance.ResultsIndicatorService.saveREsultsIndicator(rc.newResultsIndicator);



					var disaggsetid_list = iif(isDefined('rc.disaggsetid'),Evaluate(DE('rc.disaggsetid')),DE(''));
		    		var disaggsetid_listlen = listlen(disaggsetid_list);


					//instance.disAggSetIndicatorService.deleteDisAggSetIndicators(indicatorid=newIndicatorID);

				//loop over selected disaggsets, saving as you go
				for(i=1;i lte disaggsetid_listlen; i++ )
					{
					// logger.info("disaggsetid["& i & "]=" & listgetat(disaggsetid_list,i));
					newDisaggSetIndicator = instance.disAggSetIndicatorService.createDisAggSetIndicator(disaggsetid=listgetat(disaggsetid_list,i), indicatorid=newIndicatorID);
					instance.disaggSetIndicatorService.saveDisaggSetIndicator(newDisaggSetIndicator);
					}



					/* Clear events */
			    	getColdboxOcm().clearEvent("indicators.saveIndicator");

			    	/* Re-Route */
					if(structKeyExists(rc,"btnSave")) {
				    	setNextEvent(event='indicator.viewIndicator',queryString='indicatorID/#newIndicatorID#');
					}
					else {
						setNextEvent(event='framework.viewResults',queryString='resultsFrameworkElementID/#rc.resultsFrameworkElementID#');
						}
				}

		    }




	    </cfscript>
		<cfabort>

	</cffunction>

	<cffunction name="addIndicator" output="false" hint=" saveIndicator">
		<cfargument name="event" />

		<cfset var rc = event.getCollection()>
	    <cfset var newIndicator = "">
	    <cfset var newIndicatorID = "">
	    <cfset var newActivityIndicator = "">
	    <cfset var newActivityIndicatorSaved = "">
		<!--- grab user --->
		<cfset var rc.updatedBy = getPlugin("SessionStorage").getVar("updatedby") />
		<!--- save  common indicators --->
    	<cfif not structKeyExists(rc,"activityIndicators")>
        	<cfset rc.activityIndicators="">
      	</cfif>
      	<cfif len(trim(rc.activityIndicators))>
      		<cfset instance.ActivityIndicatorService.updateActivityIndicators(ActivityID=rc.activityid,IndicatorIDList=rc.activityIndicators) />
        </cfif>

	    <!--- save grant specific indicator --->
	    <cfscript>
		    if(structKeyExists(rc,"btnUpdate")){
		  		/* instantiate indicator object and new activityIndicator from service layer */
			    indicatorObj = instance.indicatorService.new();
			    /* get current indocator info */
			    curIndicator = instance.indicatorService.getIndicator(rc.indicatorID);

			    /* populate new indicator instance */
		  		populateModel(indicatorObj);

	  			/* preserve "IntendedChangeDirection" data (cannot be updated in form) */
	  			indicatorObj.setIntendedChangeDirection(curIndicator.getIntendedChangeDirection());

		    	/* Save indicator  */
		    	indicatorObj = instance.indicatorService.saveIndicator(indicatorObj);

		   		setNextEvent(event='grant.viewGrant',queryString='activityid/#rc.activityID#');

		    } else {
				var disaggsetid_list = iif(isDefined('rc.disaggsetid'),Evaluate(DE('rc.disaggsetid')),DE(''));
		    	var disaggsetid_listlen = listlen(disaggsetid_list);
		    	// Check to see if user is cancelling
				if(structKeyExists(rc,"btnCancel")){
					/* Clear events */
			    	getColdboxOcm().clearEvent("indicators.saveIndicator");
					setNextEvent(event='grant.viewGrant',queryString='activityID/#rc.activityID#');
				}
		    	else {
			    	/* Get new indicator and new activityIndicator from service layer */
			    	newIndicator = instance.indicatorService.getIndicator();
					newActivityIndicator = instance.activityIndicatorService.createActivityIndicator();

			    	/* Populate indicator */
			    	populateModel(newIndicator);
					populateModel(newActivityIndicator);

			    	/* Save indicator. Get  */
			    	newIndicatorID = instance.indicatorService.saveIndicator(newIndicator);

					/* Add disaggsets to the indicator*/
		    		if(isdefined('rc.indicatorID')){//an existing indicator
						//drop previous disaggsets
						instance.disAggSetIndicatorService.deleteDisAggSetIndicator(indicatorid=newIndicatorID);
		    		}
	    			//loop over selected disaggsets, saving as you go
					for(i=1;i lte disaggsetid_listlen; i++ ){
						logger.info("disaggsetid["& i & "]=" & listgetat(disaggsetid_list,i));
						newDisaggSetIndicator = instance.disAggSetIndicatorService.createDisAggSetIndicator(disaggsetid=listgetat(disaggsetid_list,i), indicatorid=newIndicatorID);
						instance.disaggSetIndicatorService.saveDisaggSetIndicator(newDisaggSetIndicator);
					}

					/* Link the Indicator to the Activity */
					newActivityIndicator.setIndicatorID(newIndicatorID);
					newActivityIndicatorSaved = instance.activityIndicatorService.saveActivityIndicator(newActivityIndicator);

					/* Clear events */
			    	getColdboxOcm().clearEvent("indicators.saveIndicator");

			    	/* Re-Route */


					setNextEvent(event='grant.Measurements',queryString='activityID/#rc.activityID#/isGrantNew/#rc.isGrantNew#');

				}

		    }
	    </cfscript>
		<cfabort>

	</cffunction>


	<cffunction name="deleteIndicator" output="false" hint=" saveIndicator">

		<cfargument name="event">
		<cfset var rc = event.getCollection()>
	    <cfscript>
		    	/* instantiate indicator object and new activityIndicator from service layer */
			    retDeleteIndicator = instance.indicatorService.deleteIndicator(indicatorID=rc.indicatorID);
			    retDeleteIndicator = instance.resultsIndicatorService.deleteResultsIndicator(indicatorID=rc.indicatorID);

				setNextEvent(event='framework.viewResult',queryString='resultsFrameworkElementID/#rc.resultsFrameworkElementID#');

		</cfscript>
		<cfabort>

	</cffunction>

<cffunction name="qrtlyMeasurements" output="false" hint=" measurements">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>
		<cfset rc.pageTitle = "Measurements for Result Framework Element">

		<cfif not structKeyExists(rc,"resultsFrameworkElementid")>
		    <cfset getPlugin("MessageBox").setMessage("info","Results details saved") />
		    <cfset getPlugin("Logger").logEntry("information","Result #retResultsFrameworkElement# #ResultsFrameworkElement.getName()# saved.") />
		   <cfset  setNextEvent(event='framework.viewResult',queryString='resultsFrameworkElementID/#resultsFrameworkElementID#') />
		<cfelse>

			<!--- get activity quarters start and end dates --->
			<cfset rc.qtrlyDates = instance.ActivityService.getActivityQtrs(activityID=rc.activityid) />

			<!--- default start and end dates --->
			<cfif rc.qtrlyDates.recordCount>

				<cfif NOT structKeyExists(rc,"qtrStartDate")>
					<cfset var curDate = now() />

					<cfloop query="rc.qtrlyDates">
						<cfif len(trim(rc.qtrlyDates.StartDate))>
							<!--- before programs begins --->
							<cfif dateCompare(curDate,rc.qtrlyDates.min_startDate) EQ -1 and dateCompare(rc.qtrlyDates.StartDate,rc.qtrlyDates.min_startDate) EQ 0>
								<cftrace abort="false" inline="true" type="information" text="min_start_date eq -1">
								<cfset rc.qStartDate = rc.qtrlyDates.StartDate />
								<cfset rc.qEndDate = rc.qtrlyDates.EndDate />
							<!--- after progam ends --->
							<cfelseif dateCompare(curDate,rc.qtrlyDates.max_endDate) EQ 1 and dateCompare(rc.qtrlyDates.EndDate,rc.qtrlyDates.max_endDate) EQ 0>
								<cftrace abort="false" inline="true" type="information" text="max_end_date eq 1">
								<cfset rc.qStartDate = rc.qtrlyDates.StartDate />
								<cfset rc.qEndDate = rc.qtrlyDates.EndDate />
							<!--- or else --->
							<cfelseif (dateCompare(curDate,rc.qtrlyDates.StartDate,"d") GTE 0 and dateCompare(curDate,rc.qtrlyDates.EndDate,"d") LTE 0 and dateCompare(rc.qtrlyDates.StartDate,rc.qtrlyDates.min_startDate) EQ 0)
										OR (dateCompare(curDate,dateAdd("d",1,rc.qtrlyDates.EndDate),"d") GTE 0 and dateCompare(curDate,dateAdd("m",3,rc.qtrlyDates.EndDate),"d") LTE 0)>
									<cfset rc.qStartDate = rc.qtrlyDates.StartDate />
									<cfset rc.qEndDate = rc.qtrlyDates.EndDate />
							</cfif>
						</cfif>
					</cfloop>

				<cfelse>

					<cfloop query="rc.qtrlyDates">
						<cfif len(trim(rc.qtrlyDates.StartDate))>
							<cfif dateCompare(rc.qtrStartDate,rc.qtrlyDates.StartDate) EQ 0>
								<cfset rc.qStartDate = rc.qtrlyDates.StartDate />
								<cfset rc.qEndDate = rc.qtrlyDates.EndDate />
							</cfif>
						</cfif>
					</cfloop>

				</cfif>

				<!--- call measures for quarter --->
				<cfset rc.qMeasurements = instance.ActivityService.getMeasurementQtrly(activityid=rc.activityid,startDate=rc.qStartDate,endDate=rc.qEndDate) />

				<!--- get quarterly start and end dates --->
				<cfset rc.activity = instance.ActivityService.getActivity(activityid=rc.activityID) />
				<cfset rc.qActivityLocations = instance.ActivityLocationService.getActivityLocationNamesQuery(activityid=rc.activityid) />
				<cfset rc.activityLocationList = valueList(rc.qActivityLocations.name,";") />
		      	<cfset event.setView("Grant/measurements")>

			<cfelse>
				<!--- no measurements created --->
		    	<cfset getPlugin("MessageBox").setMessage("error","No measurements exist for this Grant") />
				<cfset  setNextEvent(event='Grant.viewgrant',queryString='activityid/#rc.activityID#') />
			</cfif>

    	</cfif>
	</cffunction>


	<cffunction name="manageDisaggSets" output="false" hint=" saveIndicator">

		<cfargument name="event">
		<cfset var rc = event.getCollection()>
	    <cfscript>
		    	/* instantiate indicator object and new activityIndicator from service layer */
			   	rc.disaggsets= instance.DisaggSetService.disaggSetList();

			event.setView("Indicator/viewDisaggSets");

		</cfscript>


	</cffunction>


<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>

