<cfcomponent name="ProposalGateway" output="false">

	<!--- Dependencies --->
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<cffunction name="init" access="public" output="false" returntype="ProposalGateway">
		<cfreturn this>
	</cffunction>

	<cffunction name="getRegionCountryByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="CategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="RegionID" type="numeric" required="false" />
		<cfargument name="Region" type="string" required="false" />
		<cfargument name="CountryID" type="numeric" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<!---
		<cfargument name="InOperator" type="numeric" required="false" />
		<cfargument name="NotInOperator" type="numeric" required="false" />
		 --->
		<cfargument name="orderby" type="string" required="false" default="Country" />
		<cfset var qList = "" />

		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				/* CategoryToCategoryID,
				SuperCategoryID As RegionID,
			    Region, */
			    DISTINCT
			    SubCategoryID As categoryID,
			    Country as Name
			  FROM vw_regionCountry
			WHERE	0=0
		<cfif structKeyExists(arguments,"CategoryToCategoryID") and len(arguments.CategoryToCategoryID)>
			AND	CategoryToCategoryID = <cfqueryparam value="#arguments.CategoryToCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"RegionID") and len(arguments.RegionID)>
			AND	SuperCategoryID = <cfqueryparam value="#arguments.RegionID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Region") and len(arguments.Region)>
			AND	Region = <cfqueryparam value="#arguments.Region#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"CountryID") and len(arguments.CountryID)>
			AND	SubCategoryID = <cfqueryparam value="#arguments.CountryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Country") and len(arguments.Country)>
			AND	Country = <cfqueryparam value="#arguments.Country#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<!--- //////// --->
		<!--- <cfif structKeyExists(arguments,"InOperator") and len(arguments.InOperator)>
			AND	CategoryToCategoryID IN (SELECT CategoryToCategoryID FROM ActivityCategoryToCategory WHERE ActivityID  = <cfqueryparam value="#arguments.InOperator#" CFSQLType="cf_sql_integer" />)
		</cfif> --->
		<!--- <cfif structKeyExists(arguments,"InOperator") and len(arguments.InOperator)>
			AND	SubCategoryID IN (SELECT CategoryToCategoryID FROM ActivityCategoryToCategory WHERE ActivityID  = <cfqueryparam value="#arguments.InOperator#" CFSQLType="cf_sql_integer" />)
		</cfif>
		<cfif structKeyExists(arguments,"NotInOperator") and len(arguments.NotInOperator)>
			AND	CategoryToCategoryID NOT IN (SELECT CategoryToCategoryID FROM ActivityCategoryToCategory WHERE ActivityID  = <cfqueryparam value="#arguments.NotInOperator#" CFSQLType="cf_sql_integer" />)
		</cfif> --->
		<!--- //////// --->
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>

		<cfreturn qList />
	</cffunction>


	<cffunction name="getActivityCountryRegionsQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityID" type="numeric" required="true" />

		<cfset var qList = "" />

		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				distinct
			    Region as Name, regionID
			  FROM vw_activityCountryRegions
			WHERE	activityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />

		</cfquery>

		<cfreturn qList />
	</cffunction>

	<cffunction name="getActivityCountryRSIRegionsQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityID" type="numeric" required="true" />

		<cfset var qList = "" />

		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				distinct
			    Region as Name, regionID
			  FROM vw_activityCountryRSIRegions
			WHERE	activityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />

		</cfquery>

		<cfreturn qList />
	</cffunction>

	<cffunction name="getWorkloadSummary" access="public" output="false" returntype="Query">
		<cfargument name="programid" type="string" required="false">
		<cfargument name="regionID" type="string" required="false">
		<cfargument name="regionList" type="string" required="false">
		<cfargument name="sysuserID" type="string" required="false">
		<cfargument name="implementingPartner" type="string" required="false">
		<cfargument name="workload" type="boolean" required="false">
		<cfargument name="statusReview" type="boolean" required="false">
		<cfargument name="statusCN" type="boolean" required="false">
		<cfargument name="statusFund" type="boolean" required="false">
		<cfargument name="statusOblig" type="boolean" required="false">
		<cfargument name="roleName" type="string" required="false">

		<cfquery name="qreviewWS" datasource="#dsn.getName()#">
			SELECT
				ActivityID, ParentID, projectTitle, Description, StartDate
				,EndDate, projectAmount, Currency, lastUpdated
				,programID, programName, fundMechName, ProposalNumber, projectObjective, interestSpecification
				,lawEnforcementSpecification, coordinationSpecification, programAudience
				,fundImpMechanismID, ActivityStatusID, isActive, sysUserID, proposalSubmitDate
				,clearedPrelegalDate ,proposalApprovedDate, AMCNBudgetSubmitDate, AMCNCongressSubmitDate
				,AMCNnumber, AMCNApprovedDate, FundApprovedDate ,BudgetFundRequestDate, BudgetFundApprovalDate
				,activityStatusCode, Statusname, obAmount, progress_status, progress_status_code, implementingPartner, age, cnid, cntitle, questions, daysInactive,
				FiscalYear, implementationStatus, reprogramfunds
			FROM
			(
			SELECT act.ActivityID
				  ,act.ParentID
				  ,act.Name as projectTitle
				  ,act.Description
				  ,act.StartDate
				  ,act.EndDate
				  ,act.BudgetCeilingAmount as projectAmount
				  ,act.Currency
				  ,act.lastUpdated
				  ,actx.programID
				  ,prgm.name programName
				  ,fund.name fundMechName
				  ,actx.ProposalNumber
				  ,actx.projectObjective
				  ,actx.implementingPartner
				  ,actx.interestSpecification
				  ,actx.lawEnforcementSpecification
				  ,actx.coordinationSpecification
				  ,actx.programAudience
				  ,actx.fundImpMechanismID
				  ,actx.ActivityStatusID
				  ,actx.isActive
				  ,actx.ctex
				  ,actx.sysUserID
				  ,actx.proposalSubmitDate
				  ,actx.clearedPrelegalDate
				  ,actx.proposalApprovedDate
				  ,actx.AMCNBudgetSubmitDate
				  ,actx.AMCNCongressSubmitDate
				  ,actx.AMCNnumber
				  ,actx.AMCNApprovedDate
				  ,actx.FundApprovedDate
				  ,actx.BudgetFundRequestDate
				  ,actx.BudgetFundApprovalDate
				  ,actx.cnid
				  ,actx.cntitle
				  ,actx.fiscalyear
				  ,actx.implementationStatus
				  ,actx.reprogramfunds
				  ,vas.ExternalCode as activityStatusCode
				  ,vas.Name as Statusname
				  ,(SELECT SUM(Amount) FROM ActivityObligation WHERE ActivityID = act.ActivityID) obAmount
				  ,CASE WHEN (select max(statusdate) from activitystatuslog where ActivityID = act.ActivityID) is not null then
				  	(select DateDiff(day,(select max(statusdate) from activitystatuslog where ActivityID = act.ActivityID),GetDate()))
				  	ELSE
				  		0
				  	END daysInactive
				  ,CASE WHEN vas.ExternalCode IN ('100') THEN
					'Proposal In Progress'
					WHEN vas.ExternalCode IN ('101') THEN
					'More Information Requested'
					WHEN vas.ExternalCode IN ('180','181') THEN
					'Regional Review Pending'
					WHEN vas.ExternalCode IN ('200','203') THEN
					'Program Review Pending'
					WHEN vas.ExternalCode IN ('201') THEN
					'Pre-Legal Clearance Pending'
					WHEN vas.ExternalCode IN ('202') THEN
					'Pre-Legal Comment/Question'
					WHEN vas.ExternalCode IN ('205') THEN
					'Cleared Pre-Legal'
					WHEN vas.ExternalCode IN ('210') THEN
					'Proposal On Hold'
					WHEN vas.ExternalCode IN ('250') THEN
					'Proposal Reactivated'
					WHEN vas.ExternalCode IN ('300') THEN
					'Awaiting CN to Budget'
					WHEN vas.ExternalCode IN ('301','302','303','305','306') THEN
					'CN Clearance Pending'
					WHEN vas.ExternalCode IN ('308') THEN
					'CN Congressional Approval Pending'
					WHEN vas.ExternalCode IN ('310','320','330') THEN
					'CN Withdrawn, On Hold, Denied'
					WHEN vas.ExternalCode IN ('350') THEN
					'CN Reactivated'
					WHEN vas.ExternalCode IN ('400') THEN
					'Funding Type Confirmation Pending'
					WHEN vas.ExternalCode IN ('401','402') THEN
					'Funding Clearance Pending'
					WHEN vas.ExternalCode IN ('410','420') THEN
					'Funding On Hold, Denied'
					WHEN vas.ExternalCode IN ('450') THEN
					'Funding Reactivated'
					WHEN vas.ExternalCode IN ('500') THEN
					'Funding Approved for Obligation'
					WHEN vas.ExternalCode IN ('600') THEN
					'Funding Fully Obligated'
					WHEN vas.ExternalCode IN ('700') THEN
					'Closed'
				   ELSE
					'Status Undefined'
				   END progress_status
				  ,CASE WHEN vas.ExternalCode IN ('100') THEN
					10
					WHEN vas.ExternalCode IN ('101') THEN
					11
					WHEN vas.ExternalCode IN ('180','181') THEN
					18
					WHEN vas.ExternalCode IN ('200','203') THEN
					20
					WHEN vas.ExternalCode IN ('201') THEN
					21
					WHEN vas.ExternalCode IN ('202') THEN
					22
					WHEN vas.ExternalCode IN ('205') THEN
					23
					WHEN vas.ExternalCode IN ('210') THEN
					24
					WHEN vas.ExternalCode IN ('250') THEN
					25
					WHEN vas.ExternalCode IN ('300') THEN
					30
					WHEN vas.ExternalCode IN ('301','302','303','305','306') THEN
					31
					WHEN vas.ExternalCode IN ('308') THEN
					32
					WHEN vas.ExternalCode IN ('310','320','330') THEN
					33
					WHEN vas.ExternalCode IN ('305') THEN
					34
					WHEN vas.ExternalCode IN ('400') THEN
					29
					WHEN vas.ExternalCode IN ('401','402') THEN
					40
					WHEN vas.ExternalCode IN ('410','420') THEN
					41
					WHEN vas.ExternalCode IN ('500') THEN
					50
					WHEN vas.ExternalCode IN ('600') THEN
					60
					WHEN vas.ExternalCode IN ('700') THEN
					70
				   ELSE
					0
				   END progress_status_code
				  ,CASE WHEN vas.ExternalCode IN ('180','181','200','201','202','205','203') THEN
						DATEDIFF (day,actx.proposalSubmitDate,GETDATE())
					WHEN vas.ExternalCode IN ('300','301','302','303','305','306') THEN
						DATEDIFF (day,actx.proposalApprovedDate,GETDATE())
					WHEN vas.ExternalCode IN ('307','308') THEN
						DATEDIFF (day,actx.AMCNCongressSubmitDate,GETDATE())
					WHEN vas.ExternalCode IN ('400','401','402') THEN
						DATEDIFF (day,actx.AMCNCongressSubmitDate,GETDATE())
				   ELSE
					0
				   END age
				   ,CASE
				   WHEN cnid in (select activityid from activityclearance where clearancestatus = 'Questions for Both') or (cnid in (select activityid from activityclearance where clearancestatus = 'Questions for Program') and cnid in (select activityid from activityclearance where clearancestatus = 'Questions for Budget')) THEN
						3
				   WHEN cnid in (select activityid from activityclearance where clearancestatus = 'Questions for Program') THEN
						1
					WHEN cnid in (select activityid from activityclearance where clearancestatus = 'Questions for Budget') THEN
						2

				   ELSE
					0
				   END questions
			  FROM Activity AS act
	     LEFT JOIN ActivityExtendedGrant AS actx on (act.ActivityID = actx.ActivityID)
			  JOIN vw_activityStatus vas  on (actx.ActivityStatusID = vas.CategoryID)
			  LEFT JOIN program prgm on (prgm.ProgramID = actx.programID)
			  LEFT JOIN category fund on (fund.categoryID = actx.fundImpMechanismID)
			  ) v1
		 	WHERE
		 	isActive = 1 and ctex = 0


		 	  <cfif structKeyExists(arguments,"workload") and arguments.workload>
		 	  	 <cfif structKeyExists(arguments,"programid") and len(arguments.programid)>
						and (<cfif arguments.programid is 5>programid in (1,3,4,5)<cfelse>programid = #arguments.programid#</cfif>
<!--- 						<cfif isUserInRole('extended partner')>
							or activityid in (select objectid from vw_activityFundingSources where name like '%' + (select name from program where programid = #arguments.programid#) and programID <> #arguments.programid# )
						</cfif> --->
						 or
					 	 (activityid in (select activityid from activitystatuslog where sysuserid = #arguments.sysuserID# and (lognote = 'proposal submitted for review' or lognote = 'proposal submitted for regional review' or lognote = 'proposal saved'  or lognote = 'user added to proposal'))
					 	or activityid in (select activityid from activityperson where email = '#GetAuthUser()#')
					 	or sysuserid = #arguments.sysuserID#
					 	)
						)
				  </cfif>
				  <cfif structKeyExists(arguments,"implementingPartner") and len(arguments.implementingPartner) and not isUserInRole('extended partner')>
						and implementingPartner = #arguments.implementingPartner#
				  </cfif>
				  <cfif structKeyExists(arguments,"regionlist") and len(arguments.regionlist)>
						and ((activityID in (select activityID from vw_activityCountryRegions where regionID in (#arguments.regionlist#)) or (activityID in (select activityID from vw_activityCountryRSIRegions where regionID in (#arguments.regionlist#))) or (activityID in (select objectID from objectcategory where categoryID in (select categoryid from category where parentid in   (#arguments.regionlist#)))))
						or
						(activityid in (select activityid from activitystatuslog where sysuserid = #arguments.sysuserID# and (lognote = 'proposal submitted for review' or lognote = 'proposal submitted for regional review' or lognote = 'proposal saved'  or lognote = 'user added to proposal'))
					 	or activityid in (select activityid from activityperson where email = '#GetAuthUser()#')
					 	or sysuserid = #arguments.sysuserID#
					 	)
						)
				  </cfif>
		 	  		AND (progress_status_code IN (0)
			 	  <cfif isUserInRole('create activity') or isUserInRole('create activity all programs')>
			 	  	or  (progress_status_code IN (10,11)
			 	  	<cfif not isUserInRole('review activity')>
			 	  		and (activityid in (select activityid from activitystatuslog where sysuserid = #arguments.sysuserID# and (lognote = 'proposal submitted for review' or lognote = 'proposal submitted for regional review' or lognote = 'proposal saved'  or lognote = 'user added to proposal'))
					 	or activityid in (select activityid from activityperson where email = '#GetAuthUser()#')
					 	or sysuserid = #arguments.sysuserID#
					 	)
					 </cfif>
			 	  	)
			 	  </cfif>

			 	  <cfif isUserInRole('review activity')>
				 	  or  progress_status_code IN (18,20,21,22,23,24,25,30,29)
				 	 <!---  or cnid in (select activityid from activityclearance where clearancestatus = 'Questions for Program') --->
				 	  or (progress_status_code in (60) and startdate > getdate() and (implementationStatus is null or implementationStatus <> 'Pre-Implementation'))
				 	  or (progress_status_code in (60) and startdate < getdate() and enddate > getDate() and (implementationStatus is null or implementationStatus <> 'Active'))
				 	  or (progress_status_code in (60) and enddate < getdate() and (implementationStatus is null or implementationStatus <> 'Completed'))
				  </cfif>
				  <cfif isUserInRole('regional review')>
				 	  or  progress_status_code IN (11,18,20)
				  </cfif>
				  <cfif isUserInRole('administer budget') or isUserInRole('administer am/cn')>
				 	  or  ((progress_status_code > 30 and progress_status_code <> 60) or progress_status_code = 29) or
				 	  (implementationStatus = 'MOU Modification')
				  </cfif>
<!--- 				  <cfif isUserInRole('f clearance')>
				 	  or  (progress_status_code > 30
				 	  and amcnapproveddate is null
				 	  and cnid in (select activityid from activityclearance where clearanceagencyname = 'Foreign Assist' and clearancestatus = 'Pending'))
				  </cfif>
				  <cfif isUserInRole('h clearance')>
				 	  or  (progress_status_code > 30
				 	  and amcnapproveddate is null
				 	  and cnid in (select activityid from activityclearance where clearanceagencyname = 'Congressional Affairs' and clearancestatus = 'Pending'))
				  </cfif>
				  <cfif isUserInRole('s/p clearance')>
				 	  or  (progress_status_code > 30
				 	  and amcnapproveddate is null
				 	  and cnid in (select activityid from activityclearance where clearanceagencyname = 'Policy Planning' and clearancestatus = 'Pending'))
				  </cfif>
				  <cfif isUserInRole('fo clearance')>
				 	  or  (progress_status_code > 30
				 	  and amcnapproveddate is null
				 	  and cnid in (select activityid from activityclearance where clearanceagencyname = 'AMCN Front Office' and clearancestatus = 'Pending'))
				  </cfif> --->
				  <cfif isUserInRole('pre-legal review activity')>
				 	  or (
		 	 		   (activityStatusCode IN ('201','202') and v1.clearedPrelegalDate IS NULL)
		 	 		OR (activityStatusCode IN ('302','303','305','306','307','308','350') and cnid in (SELECT activityid FROM ActivityClearance WHERE ClearanceAgencyName = 'Legal' AND ClearanceStatus = 'Pending'))
		 	 		OR (activityStatusCode IN ('400','401','402') and activityid in (SELECT activityid FROM ActivityClearance WHERE ClearanceAgencyName = 'f-Legal' AND ClearanceStatus = 'Pending'))
		 	 		OR (implementationStatus = 'MOU Modification' and activityid in (SELECT activityid FROM ActivityClearance WHERE ClearanceAgencyName = 'f-Legal' AND ClearanceStatus = 'Pending'))
		 	 		)
				  </cfif>
				  )
			  </cfif>
			 <cfif structKeyExists(arguments,"statusReview") and arguments.statusReview>
				AND  progress_status_code IN (18,20,21,22,23,24,25)
			</cfif>
			<cfif structKeyExists(arguments,"statusCN") and arguments.statusCN>
				AND  progress_status_code IN (30,31,32,33,34)
			</cfif>
			<cfif structKeyExists(arguments,"statusFund") and arguments.statusFund>
				AND  (progress_status_code IN (29,40,41) or
				 	  (implementationStatus = 'MOU Modification') )
			</cfif>
			<cfif structKeyExists(arguments,"statusOblig") and arguments.statusOblig>
				AND  progress_status_code IN (50,60,70)
			</cfif>
			<cfif structKeyExists(arguments,"implementingPartner") and len(arguments.implementingPartner)>
						and implementingPartner = #arguments.implementingPartner#
				  </cfif>
			<!--- <cfif not isUserInRole('review activity') and not isUserInRole('administer am/cn')and not isUserInRole('regional review') and isUserInRole('create activity') and structKeyExists(arguments,"programid") and structKeyExists(arguments,"sysuserid") and len(arguments.sysuserid) gt 0>
			    and activityid in (select activityid from ActivityStatusLog where sysuserid = #arguments.sysuserID# and (lognote = 'proposal submitted for review' or lognote = 'proposal submitted for regional review'  or lognote = 'proposal saved'))
			</cfif> --->
			ORDER BY progress_status_code ASC, cnid, activityid ASC /*proposalSubmitDate*/
		</cfquery>

		<cfreturn qreviewWS />
	</cffunction>

	<cffunction name="getOwnedProjectSummary" access="public" output="false" returntype="Query">
		<cfargument name="sysuserID" type="string" required="true">

		<cfquery name="ProjQ" datasource="#dsn.getName()#">
			select activityid, projecttitle, startdate, enddate, projectamount, proposalnumber, statusname, implementationstatus, fiscalyear from vw_fullactivities
			where isactive = 1
			and (activityid in (select activityid from activitystatuslog where sysuserid = <cfqueryparam value="#arguments.sysuserID#" CFSQLType="cf_sql_integer" /> and (lognote = 'proposal saved' or lognote = 'proposal submitted for review' or lognote='proposal submitted for regional review' or lognote='proposal submitted with no approval required' or lognote='proposal submitted with no pre-legal review required'))
				or activityid in (select activityid from activityperson where email = '#GetAuthUser()#'))
			order by implementationStatus
		</cfquery>
		<cfreturn ProjQ />
	</cffunction>



	<cffunction name="getCNWorkloadSummary" access="public" output="false" returntype="Query">
		<cfargument name="type" type="string" required="false">
		<cfargument name="programid" type="string" required="false">
		<cfargument name="sysuserID" type="string" required="false">
		<cfargument name="regionList" type="string" required="false">

		<cfquery name="qreviewWScn" datasource="#dsn.getName()#">
			select cntitle, cnnumber, budgetsubmitdate, congresssubmitdate, approveddate, proposalnumber, projecttitle, activityid, cnid, reprogramfunds, implementationstatus, budgetceilingamount, pendingwith,
				CASE
				   WHEN cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Both') or (cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Program') and cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Budget'))  THEN
						3
				   WHEN cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Program') THEN
						1
					WHEN cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Budget') THEN
						2
				  ELSE
					0
				  END questions,
				  CASE
				   WHEN cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Both') or (cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Program') and cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Budget'))  THEN
						'Questions for Both'
				   WHEN cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Program') THEN
						'Questions for Program'
					WHEN cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Budget') THEN
						'Questions for Budget'
				  ELSE
					'N/A'
				  END questionstext,
				  case
				  	when congresssubmitdate is null and approveddate is null
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress')
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress') then
							'CN Clearance Pending'
				  	when congresssubmitdate is not null and approveddate is null
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress')
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress')
						<!--- <cfif isUserInRole('review activity') and not isUserInRole('administer am/cn') and structKeyExists(arguments,"workload") and arguments.workload is "true">
							and cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Program')
						</cfif> ---> then
							'CN Congressional Approval Pending'
				  	when (cnid in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress')
						<!--- or cnid in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress') --->
						or implementationstatus = 'CN Partial Hold') then
							'CN On-Hold'
				  end progress_status,
				  case
				  	when congresssubmitdate is null and approveddate is null
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress')
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress') then
							777
				  	when congresssubmitdate is not null and approveddate is null
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress')
						and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress')
						<!--- <cfif isUserInRole('review activity') and not isUserInRole('administer am/cn') and structKeyExists(arguments,"workload") and arguments.workload is "true">
							and cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Program')
						</cfif> ---> then
							888
				  	when (cnid in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress')
						or cnid in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress')
						or implementationstatus = 'CN Partial Hold') then
							999
				  end activityStatusCode,
				  CASE WHEN (select max(statusdate) from activitystatuslog where ActivityID = ActivityID) is not null then
				  	(select DateDiff(day,(select max(statusdate) from activitystatuslog where ActivityID = ActivityID),GetDate()))
				  	ELSE
				  		0
				  	END daysInactive
			from vw_cnactivities
			where approveddate is null and ctex = 0
			<cfif structKeyExists(arguments,"type") and len(arguments.type)>
				<cfif arguments.type is 'clearancepending'>
					and congresssubmitdate is null and approveddate is null
					and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress')
					and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress')
				<cfelseif arguments.type is 'congresspending'>
					and congresssubmitdate is not null and approveddate is null
					and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress')
					and cnid not in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress')
					<!--- <cfif isUserInRole('review activity') and not isUserInRole('administer am/cn')>
						and cnid in (select cnid from cnclearance where clearancestatus = 'Questions for Program')
					</cfif> --->
				<cfelseif arguments.type is 'holdwithdrawn'>
					and (cnid in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='On-Hold' and clearanceagencyname='Congress')
						<!--- or cnid in (select cnid from cnclearance where cnid = vw_cnactivities.cnid and clearancestatus='Withdrawn' and clearanceagencyname='Congress') --->
						or implementationstatus = 'CN Partial Hold')
				</cfif>
			</cfif>
			 <cfif structKeyExists(arguments,"programid") and len(arguments.programid)>
					and (<cfif arguments.programid is 5>programid in (1,3,4,5)<cfelse>programid = #arguments.programid#</cfif> or
					(activityid in (select activityid from activitystatuslog where sysuserid = #arguments.sysuserID# and (lognote = 'proposal submitted for review'  or lognote='proposal submitted for regional review' or lognote='proposal submitted with no approval required' or lognote='proposal submitted with no pre-legal review required' or lognote = 'proposal saved'  or lognote = 'user added to proposal'))
					 	or activityid in (select activityid from activityperson where email = '#GetAuthUser()#')
					 	or sysuserid = #arguments.sysuserID#
					 	)
					)
			</cfif>
			<cfif structKeyExists(arguments,"regionlist") and len(arguments.regionlist)>
						and ((activityID in (select activityID from vw_activityCountryRegions where regionID in (#arguments.regionlist#)) or (activityID in (select activityID from vw_activityCountryRSIRegions where regionID in (#arguments.regionlist#))) or (activityID in (select objectID from objectcategory where categoryID in (select categoryid from category where parentid in   (#arguments.regionlist#)))))
						or
						(activityid in (select activityid from activitystatuslog where sysuserid = #arguments.sysuserID# and (lognote = 'proposal submitted for review' or lognote = 'proposal submitted for regional review' or lognote = 'proposal saved'  or lognote = 'user added to proposal'))
					 	or activityid in (select activityid from activityperson where email = '#GetAuthUser()#')
					 	or sysuserid = #arguments.sysuserID#
					 	)
						)
				  </cfif>
			<cfif isUserInRole('f clearance') and not isUserInRole('administer am/cn')>
				and cnid in (select cnid from cnclearance where clearanceagencyname = 'Foreign Assist' and clearancestatus = 'Pending')
			</cfif>
			<cfif isUserInRole('h clearance') and not isUserInRole('administer am/cn')>
				 and cnid in (select cnid from cnclearance where clearanceagencyname = 'Congressional Affairs' and clearancestatus = 'Pending')
			</cfif>
			<cfif isUserInRole('s/p clearance') and not isUserInRole('administer am/cn')>
				and cnid in (select cnid from cnclearance where clearanceagencyname = 'Policy Planning' and clearancestatus = 'Pending')
			</cfif>
			<cfif isUserInRole('fo clearance') and not isUserInRole('administer am/cn')>
				and cnid in (select cnid from cnclearance where clearanceagencyname = 'AMCN Front Office' and clearancestatus = 'Pending')
			</cfif>
			<cfif isUserInRole('pre-legal review activity') and not isUserInRole('administer am/cn')>
				and cnid in (SELECT cnid FROM cnclearance WHERE ClearanceAgencyName = 'Legal' AND ClearanceStatus = 'Pending')
			</cfif>
			<cfif not (isUserInRole('administer am/cn') or isUserInRole('review activity') or isUserInRole('f clearance') or isUserInRole('h clearance') or isUserInRole('s/p clearance') or isUserInRole('fo clearance') or isUserInRole('pre-legal review activity') or isUserInRole('extended partner') or isUserInRole('view approval status'))>
				and cnid = 0
			</cfif>

			order by cnid, budgetsubmitdate desc, cnnumber, proposalnumber
		</cfquery>
		<cfreturn qreviewWScn />
	</cffunction>

	<cffunction name="reportSearch" access="public" output="false" returntype="Query">
		<cfargument name="all" type="string" required="false">
		<cfargument name="CNNumber" type="string" required="false">
		<cfargument name="Country" type="string" required="false">
		<cfargument name="ProgramTitle" type="string" required="false">
		<cfargument name="Region" type="string" required="false">
		<cfargument name="SystemID" type="string" required="false">
		<cfargument name="userprogramID" type="string" required="false">

		<!--- <cfset rc.userProgramID = #getPlugin("SessionStorage").getVar("curUserAuth.programID")# />
		<cfset rc.roleName = #getPlugin('SessionStorage').getVar('curUserAuth.roleName')# /> --->

		<cfquery name="qSearch" datasource="#dsn.getName()#">
		SELECT DISTINCT ActivityID,ProposalNumber,ProgramName,ProjectTitle,projectAmount,proposalSubmitDate,clearedPrelegalDate
						,proposalApprovedDate,AMCNBudgetSubmitDate,AMCNApprovedDate,activityStatusCode
		  FROM (SELECT
					Activity.ActivityID,
					Activity.ParentID,
					Activity.Name ProjectTitle,
					Activity.Description,
				 	Activity.StartDate,
					Activity.EndDate,
					Activity.BudgetCeilingAmount projectAmount,
					Activity.Currency,
	        		Activity.lastUpdated,
					ActivityExtendedGrant.TotalCostShare,
					ActivityExtendedGrant.SectorID,
	        		ActivityExtendedGrant.CostShareToDate,
					ActivityExtendedGrant.programID,
					Program.Name as ProgramName,
					ActivityExtendedGrant.projectObjective,
					ActivityExtendedGrant.interestSpecification,
					ActivityExtendedGrant.lawEnforcementSpecification,
					ActivityExtendedGrant.coordinationSpecification,
					ActivityExtendedGrant.programAudience,
					ActivityExtendedGrant.fundImpMechanismID,
					ActivityExtendedGrant.activityStatusID,
					CategoryStatus.name as activityStatus,
					CategoryStatus.ExternalCode as activityStatusCode,
					ActivityExtendedGrant.ProposalNumber,
					ActivityExtendedGrant.AMCNnumber,
					ActivityExtendedGrant.proposalSubmitDate,
					ActivityExtendedGrant.clearedPrelegalDate,
					ActivityExtendedGrant.proposalApprovedDate,
					ActivityExtendedGrant.AMCNBudgetSubmitDate,
					ActivityExtendedGrant.AMCNCongressSubmitDate,
					ActivityExtendedGrant.AMCNApprovedDate,
					ActivityExtendedGrant.FundApprovedDate,
					ActivityExtendedGrant.BudgetFundRequestDate,
					ActivityExtendedGrant.BudgetFundApprovalDate,
					ActivityExtendedGrant.placeOfImplementation,
					ActivityExtendedGrant.isActive,
					ActivityExtendedGrant.sysUserID,
					Category.Name country
				FROM Activity
				LEFT OUTER JOIN ActivityExtendedGrant ON (Activity.ActivityID = ActivityExtendedGrant.ActivityID)
				LEFT OUTER JOIN Program ON (Program.programID=ActivityExtendedGrant.programID)
				LEFT OUTER JOIN Category CategoryStatus ON (CategoryStatus.CategoryID = ActivityExtendedGrant.activityStatusID)
				LEFT JOIN ObjectCategory on (ObjectCategory.ObjectID = Activity.ActivityID AND ClassName = 'ActivityPlace')
				LEFT JOIN Category on (Category .CategoryID = ObjectCategory.CategoryID)
				WHERE 0=0
				  AND ActivityExtendedGrant.isActive = 1
				 <cfif NOT isUserinRole("create activity")>
				  AND ActivityExtendedGrant.activityStatusID NOT IN (100,101)
				</cfif>
				<cfif structKeyExists(arguments,"userprogramID") and len(arguments.userprogramID)>
				  AND ActivityExtendedGrant.programID = #arguments.userprogramID#
				</cfif>
				<cfif structKeyExists(arguments,"All") and len(arguments.All)>
				  AND (ActivityExtendedGrant.AMCNnumber LIKE '%#uCase(arguments.All)#%'
							OR upper(Category.Name) LIKE '%#uCase(arguments.All)#%'
							OR upper(Activity.Name) LIKE '%#uCase(arguments.All)#%'
							OR upper(ActivityExtendedGrant.ProposalNumber) LIKE '%#uCase(arguments.All)#%')
				</cfif>
				<cfif structKeyExists(arguments,"CNNumber") and len(arguments.CNNumber)>
				  AND upper(ActivityExtendedGrant.AMCNnumber) LIKE '%#uCase(arguments.CNNumber)#%'
				</cfif>
				<cfif structKeyExists(arguments,"ProgramTitle") and len(arguments.ProgramTitle)>
				  AND upper(Activity.Name) LIKE '%#uCase(arguments.ProgramTitle)#%'
				</cfif>
				<cfif structKeyExists(arguments,"SystemID") and len(arguments.SystemID)>
				  AND upper(ActivityExtendedGrant.ProposalNumber) LIKE '%#uCase(arguments.SystemID)#%'
				</cfif>
				<cfif ( structKeyExists(arguments,"Country") and len(arguments.Country) ) OR ( structKeyExists(arguments,"Region") and len(arguments.Region) ) >
				  AND upper(Category.Name) LIKE '%#uCase(arguments.Country)#%'
				</cfif>
			    ) v1
		</cfquery>

		<cfreturn qSearch />
	</cffunction>

	<cffunction name="getReportSummary" access="public" output="false" returntype="query">
		<cfargument name="programID" type="string" required="false" default="0" />
		<cfargument name="all" type="string" required="false">
		<cfargument name="CNNumber" type="string" required="false">
		<cfargument name="Country" type="string" required="false">
		<cfargument name="ProgramTitle" type="string" required="false">
		<cfargument name="Region" type="string" required="false">
		<cfargument name="SystemID" type="string" required="false">
		<cfargument name="userprogramID" type="string" required="false">

		<cfquery name="qSummary" datasource="#dsn.getName()#">
			SELECT distinct act.ActivityID
				  ,act.ParentID
				  ,act.Name as projectTitle
				  ,act.Description
				  ,act.StartDate
				  ,act.EndDate
				  ,act.BudgetCeilingAmount as projectAmount
				  ,act.Currency
				  ,act.lastUpdated
				  ,actx.programID
				  ,prgm.name programName
<!--- 				  ,obg.obligationdate
				  ,obg.obligationfyyearsource --->
				  ,upper(actx.ProposalNumber) ProposalNumber
				  ,actx.projectObjective
				  ,actx.interestSpecification
				  ,actx.lawEnforcementSpecification
				  ,actx.coordinationSpecification
				  ,actx.programAudience
				  ,actx.fundImpMechanismID
				  ,implementCat.Name implementMethod
				  ,actx.ActivityStatusID
				  ,actx.isActive
				  ,actx.sysUserID
				  ,actx.proposalSubmitDate
				  ,actx.clearedPrelegalDate
				  ,actx.proposalApprovedDate
				  ,actx.AMCNBudgetSubmitDate
				  ,actx.AMCNCongressSubmitDate
				  ,actx.AMCNnumber
				  ,actx.AMCNApprovedDate
				  ,actx.FundApprovedDate
				  ,actx.BudgetFundRequestDate
				  ,actx.BudgetFundApprovalDate
				  ,actx.placeOfImplementation
				  ,actx.relatedProjects
				  ,actx.fiscalyear
				  ,actx.implementationStatus
				  ,vas.ExternalCode as activityStatusCode
				  <!--- ,vas.Name as Statusname   --->
				  ,CASE WHEN vas.ExternalCode IN ('100') THEN
					'Proposal In Progress'
					WHEN vas.ExternalCode IN ('101') THEN
					'More Information Requested'
					WHEN vas.ExternalCode IN ('180','181') THEN
					'Regional Review Pending'
					WHEN vas.ExternalCode IN ('200','203') THEN
					'Program Review Pending'
					WHEN vas.ExternalCode IN ('201') THEN
					'Pre-Legal Clearance Pending'
					WHEN vas.ExternalCode IN ('202') THEN
					'Pre-Legal Comment/Question'
					WHEN vas.ExternalCode IN ('205') THEN
					'Cleared Pre-Legal'
					WHEN vas.ExternalCode IN ('210') THEN
					'Proposal On Hold'
					WHEN vas.ExternalCode IN ('220') THEN
					'Proposal Denied'
					WHEN vas.ExternalCode IN ('250') THEN
					'Proposal Reactivated'
					WHEN vas.ExternalCode IN ('300') THEN
					'Awaiting CN to Budget'
					WHEN vas.ExternalCode IN ('301','302','303','305','306') THEN
					'CN Clearance Pending'
					WHEN vas.ExternalCode IN ('308') THEN
					'CN Congressional Approval Pending'
					WHEN vas.ExternalCode IN (',310','320','330') THEN
					'CN Withdrawn, On Hold, Denied'
					WHEN vas.ExternalCode IN ('350') THEN
					'CN Reactivated'
					WHEN vas.ExternalCode IN ('400') THEN
					'Funding Type Confirmation Pending'
					WHEN vas.ExternalCode IN ('401','402') THEN
					'Funding Clearance Pending'
					WHEN vas.ExternalCode IN ('410','420') THEN
					'Funding On Hold, Denied'
					WHEN vas.ExternalCode IN ('450') THEN
					'Funding Reactivated'
					WHEN vas.ExternalCode IN ('500') THEN
					'Funding Approved for Obligation'
					WHEN vas.ExternalCode IN ('600') THEN
					'Funding Fully Obligated'
					WHEN vas.ExternalCode IN ('700') THEN
					'Closed'
				   ELSE
					'Status Undefined'
				   END Statusname
				  ,(SELECT SUM(Amount) FROM ActivityObligation WHERE ActivityID = act.ActivityID) obAmount
			  FROM Activity AS act
	     LEFT JOIN ActivityExtendedGrant AS actx on (act.ActivityID = actx.ActivityID)
			  JOIN vw_activityStatus vas  on (actx.ActivityStatusID = vas.CategoryID)
		 LEFT JOIN program prgm on (prgm.ProgramID = actx.programID)
<!--- 		 LEFT JOIN activityobligation obg on (obg.ActivityID = actx.activityID) --->
		 LEFT JOIN Category implementCat on (implementCat.CategoryID = actx.fundImpMechanismID and implementCat.ParentID = (SELECT CategoryID FROM dbo.Category WHERE (Name = 'Funding Mechanism Type')))
		 	 WHERE actx.isActive = 1
		 	   <!--- AND actx.proposalSubmitDate IS NOT NULL --->
		 	   AND actx.programID IS NOT NULL
			<cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID GT 0>
			   AND actx.programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
			</cfif>

				<cfif structKeyExists(arguments,"userprogramID") and len(arguments.userprogramID)>
				  AND actx.programID = #arguments.userprogramID#
				</cfif>
				<cfif structKeyExists(arguments,"All") and len(arguments.All)>
					<cfif isnumeric(arguments.all)>
						and act.ActivityID = #arguments.all#
					<cfelse>
				  AND (actx.AMCNnumber LIKE '%#uCase(arguments.All)#%'
							OR upper(implementCat.Name) LIKE '%#uCase(arguments.All)#%'
							OR upper(act.Name) LIKE '%#uCase(arguments.All)#%'
							OR upper(act.Description) LIKE '%#uCase(arguments.All)#%'
							OR upper(actx.ProposalNumber) = '#uCase(arguments.All)#'
							OR upper(actx.relatedProjects) LIKE '%#uCase(arguments.All)#%'
							OR upper(actx.ProjectObjective) LIKE '%#uCase(arguments.All)#%'
							or act.ActivityID in (select distinct activityid from view_pivot where upper(objectname) = '#uCase(arguments.All)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(country) = '#uCase(arguments.All)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(region) = '#uCase(arguments.All)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(rsiregion) = '#uCase(arguments.All)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(regioncode) = '#uCase(arguments.All)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(budgetitem) like '%#uCase(arguments.All)#%')
							or  act.ActivityID in (select distinct activityid from activityobligation where upper(obligationnumber) like '%#uCase(arguments.All)#%')
							or  act.ActivityID in (select distinct activityid from vw_cnactivities where upper(cnnumber) like '%#uCase(arguments.All)#%')
							)
						</cfif>
				</cfif>
				<cfif structKeyExists(arguments,"CNNumber") and len(arguments.CNNumber)>
				  AND upper(actx.AMCNnumber) LIKE '%#uCase(arguments.CNNumber)#%'
				</cfif>
				<cfif structKeyExists(arguments,"ProgramTitle") and len(arguments.ProgramTitle)>
				  AND upper(act.Name) LIKE '%#uCase(arguments.ProgramTitle)#%'
				</cfif>
				<cfif structKeyExists(arguments,"SystemID") and len(arguments.SystemID)>
				  AND upper(actx.ProposalNumber) LIKE '%#uCase(arguments.SystemID)#%'
				</cfif>
				<cfif ( structKeyExists(arguments,"Country") and len(arguments.Country) )  >
				  AND (
				  act.ActivityID in (select distinct activityid from view_pivot where upper(objectname) = '#uCase(arguments.Country)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(country) = '#uCase(arguments.Country)#')
				   )
				</cfif>
				<cfif ( structKeyExists(arguments,"Region") and len(arguments.Region) ) >
				  AND (
				  act.ActivityID in (select distinct activityid from view_pivot where upper(objectname) = '#uCase(arguments.region)#')
				  			or act.ActivityID in (select distinct activityid from view_pivot where upper(regionname) = '#uCase(arguments.region)#')
				 			 or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(region) = '#uCase(arguments.region)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(rsiregion) = '#uCase(arguments.region)#')
							or  act.ActivityID in (select distinct activityid from vw_activityProgramBudget where upper(regioncode) = '#uCase(arguments.region)#')
				  )
				</cfif>
		</cfquery>

		<!--- owners --->
		<cfquery name="qowners" datasource="#dsn.getName()#">
			SELECT
				ActivityPerson.ActivityPersonID,
				ActivityPerson.ActivityID,
				ActivityPerson.FirstName + ' ' + ActivityPerson.LastName owners,
				ActivityPerson.Email,
				ActivityPerson.Phone,
				ActivityExtendedGrant.programID,
				ActivityExtendedGrant.ActivityID
			FROM	ActivityPerson
			JOIN ActivityExtendedGrant on (ActivityExtendedGrant.ActivityID = ActivityPerson.ActivityID )
		   WHERE 0=0
			<cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID GT 0>
			 AND ActivityExtendedGrant.programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>

		<!--- funding sources --->
		<cfquery name="qfundSources" datasource="#dsn.getName()#">
			SELECT
				ObjectCategory.ClassName,
				ObjectCategory.ObjectID,
				ObjectCategory.CategoryID,
				Category.Name,
				ActivityExtendedGrant.programID,
				ActivityExtendedGrant.ActivityID
			FROM	ObjectCategory
			JOIN  Category ON (Category.CategoryID = ObjectCategory.CategoryID)
			JOIN  ActivityExtendedGrant on (ActivityExtendedGrant.ActivityID = ObjectCategory.ObjectID)
			WHERE ObjectCategory.ClassName = 'ActivityFundingSource'
			<cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID GT 0>
			   AND ActivityExtendedGrant.programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>

		<!--- place of implementation --->
		<cfquery name="qPlace" datasource="#dsn.getName()#">
			SELECT
				ObjectCategory.ClassName,
				ObjectCategory.ObjectID,
				ObjectCategory.CategoryID,
				ObjectCategory.isPrimary,
				Category.Name,
				Category.ParentID,
				countryAndRegion.Name countryOrRegion,
				ActivityExtendedGrant.programID,
				ActivityExtendedGrant.ActivityID,
				v1.country,
				<!--- /*v1.region,
				v2.country rCountry,
				CASE
					When (v1.country IS NULL) Then
						v2.country
					Else
						v1.country
				END theCountry,
				CASE
					When (v1.region IS NULL) Then
						v2.region
					Else
						v1.region
				END theRegion */ --->
				CASE
					When (countryAndRegion.Name = 'Region') Then
						Category.Name
					ELSE
						v1.region
				END region
			FROM	ObjectCategory
			JOIN  Category ON (Category.CategoryID = ObjectCategory.CategoryID)
			JOIN  ActivityExtendedGrant on (ActivityExtendedGrant.ActivityID = ObjectCategory.ObjectID)
			JOIN  Category countryAndRegion on (countryAndRegion.CategoryID = Category.ParentID)
			LEFT JOIN (SELECT Category.CategoryID
			      ,Category.ParentID
			      ,Category.Name country
			      ,Category.Description
			      ,Category.ExternalCode
			      ,CategoryToCategory.SuperCategoryID
			      ,region.Name region
			  FROM Category
			JOIN CategoryToCategory on (CategoryToCategory.SubCategoryID = Category.CategoryID)
			JOIN Category region on (region.CategoryID  = CategoryToCategory.SuperCategoryID)
			) v1 on (v1.CategoryID = ObjectCategory.CategoryID and countryAndRegion.Name = 'Country')
			<!--- /*LEFT JOIN (SELECT Category.CategoryID
			      ,Category.ParentID
			      ,Category.Name country
			      ,Category.Description
			      ,Category.ExternalCode
			      ,CategoryToCategory.SuperCategoryID regionID
			      ,region.Name region
			  FROM Category
			JOIN CategoryToCategory on (CategoryToCategory.SubCategoryID = Category.CategoryID)
			JOIN Category region on (region.CategoryID  = CategoryToCategory.SuperCategoryID)
			) v2 on (v2.regionID = ObjectCategory.CategoryID and countryAndRegion.Name = 'Region')*/ --->
			WHERE ObjectCategory.ClassName = 'ActivityPlace'
			<cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID GT 0>
			  AND ActivityExtendedGrant.programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>

	    <!--- build matrix query --->
	   	<cfset var qMatrix = querynew("ProposalNumber,subAccount,projectTitle,implementationCountry,implementationRegion,projectAmount,owners,obAmount,implementMethod,proposalSubmitDate,clearedPrelegalDate,proposalApprovedDate,AMCNCongressSubmitDate,AMCNApprovedDate,projectObjective,Description,ActivityID,Statusname,activitystatuscode,programname,AMCNBudgetSubmitDate,amcnnumber,implementationStatus,fiscalyear") />

	   	<cfloop query="qSummary">
			<cfset QueryAddRow(qMatrix) />

			<cfset QuerySetCell(qMatrix,"ProposalNumber",qSummary.ProposalNumber) />


			<cfset var lstFundSource = "" />
			<cfloop query="qfundSources">
				<cfif qfundSources.ActivityID EQ qSummary.ActivityID>
					<cfset lstFundSource = listAppend(lstFundSource,qfundSources.Name,',') />
				</cfif>
			</cfloop>
			<cfset QuerySetCell(qMatrix,"subAccount",lstFundSource) />

			<cfset QuerySetCell(qMatrix,"projectTitle",qSummary.projectTitle) />
			<cfset QuerySetCell(qMatrix,"projectObjective",qSummary.projectObjective) />
			<cfset QuerySetCell(qMatrix,"Description",qSummary.Description) />

			<cfset var lstCountries = "" />
			<cfloop query="qPlace">
				<cfif qPlace.ObjectID EQ qSummary.ActivityID>
					<cfif len(trim(qPlace.country))>
						<cfif NOT ListFindNoCase(lstCountries,' ' & qPlace.country,",")>
							<cfset lstCountries = listAppend(lstCountries,' ' & qPlace.country,',') />
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
			<cfset QuerySetCell(qMatrix,"implementationCountry",lstCountries) />

			<cfset var lstRegions = "" />
			<cfloop query="qPlace">
				<cfif qPlace.ObjectID EQ qSummary.ActivityID>
					<cfif len(trim(qPlace.region))>
						<cfif NOT ListFindNoCase(lstRegions,' ' & qPlace.region,",")>
							<cfset lstRegions  = listAppend(lstRegions,' ' & qPlace.region,',') />
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
			<cfset QuerySetCell(qMatrix,"implementationRegion",lstRegions ) />

			<cfset QuerySetCell(qMatrix,"projectAmount",qSummary.projectAmount) />

			<cfset var lstOwners = "" />
			<cfloop query="qowners">
				<cfif qowners.ActivityID EQ qSummary.ActivityID>
					<cfset lstOwners = listAppend(lstOwners,qowners.owners) />
				</cfif>
			</cfloop>


			<cfset QuerySetCell(qMatrix,"owners",lstOwners) />

			<cfset QuerySetCell(qMatrix,"implementMethod",qSummary.implementMethod) />

			<cfif len(trim(qSummary.proposalSubmitDate))>
				<cfset QuerySetCell(qMatrix,"proposalSubmitDate",dateFormat(CreateODBCDateTime(qSummary.proposalSubmitDate),"mm/dd/yyyy")) />
					<cfelse>
				<cfset QuerySetCell(qMatrix,"proposalSubmitDate",qSummary.proposalSubmitDate) />
			</cfif>

			<cfif len(trim(qSummary.clearedPrelegalDate))>
				<cfset QuerySetCell(qMatrix,"clearedPrelegalDate",dateFormat(CreateODBCDateTime(qSummary.clearedPrelegalDate),"mm/dd/yyyy")) />
					<cfelse>
				<cfset QuerySetCell(qMatrix,"clearedPrelegalDate",qSummary.clearedPrelegalDate) />
			</cfif>

			<cfif len(trim(qSummary.proposalApprovedDate))>
				<cfset QuerySetCell(qMatrix,"proposalApprovedDate",dateFormat(CreateODBCDateTime(qSummary.proposalApprovedDate),"mm/dd/yyyy")) />
					<cfelse>
				<cfset QuerySetCell(qMatrix,"proposalApprovedDate",qSummary.proposalApprovedDate) />
			</cfif>

			<cfif len(trim(qSummary.AMCNCongressSubmitDate))>
				<cfset QuerySetCell(qMatrix,"AMCNCongressSubmitDate",dateFormat(CreateODBCDateTime(qSummary.AMCNCongressSubmitDate),"mm/dd/yyyy")) />
					<cfelse>
				<cfset QuerySetCell(qMatrix,"AMCNCongressSubmitDate",qSummary.AMCNCongressSubmitDate) />
			</cfif>

			<cfif len(trim(qSummary.AMCNBudgetSubmitDate))>
				<cfset QuerySetCell(qMatrix,"AMCNBudgetSubmitDate",dateFormat(CreateODBCDateTime(qSummary.AMCNBudgetSubmitDate),"mm/dd/yyyy")) />
					<cfelse>
				<cfset QuerySetCell(qMatrix,"AMCNBudgetSubmitDate",qSummary.AMCNBudgetSubmitDate) />
			</cfif>

			<cfif len(trim(qSummary.AMCNApprovedDate))>
				<cfset QuerySetCell(qMatrix,"AMCNApprovedDate",dateFormat(CreateODBCDateTime(qSummary.AMCNApprovedDate),"mm/dd/yyyy")) />
					<cfelse>
				<cfset QuerySetCell(qMatrix,"AMCNApprovedDate",qSummary.AMCNApprovedDate) />
			</cfif>

			<cfset QuerySetCell(qMatrix,"obAmount",qSummary.obAmount) />
			<cfset QuerySetCell(qMatrix,"ActivityID",qSummary.ActivityID) />
			<cfset QuerySetCell(qMatrix,"StatusName",qSummary.Statusname) />
			<cfset QuerySetCell(qMatrix,"implementationStatus",qSummary.implementationStatus) />

			<cfset QuerySetCell(qMatrix,"activitystatuscode",qSummary.activitystatuscode) />
			<cfset QuerySetCell(qMatrix,"programname",qSummary.programname) />
			<cfset QuerySetCell(qMatrix,"amcnnumber",qSummary.amcnnumber) />
			<cfset QuerySetCell(qMatrix,"fiscalyear",qSummary.fiscalyear) />



		</cfloop>

		<cfreturn qMatrix>
	</cffunction>


	<cffunction name="getManagerReport" access="public" output="false" returntype="query">
		<cfargument name="ProgramID" type="string" required="false" />
		<cfargument name="countryID" type="string" required="false">
		<cfargument name="regionID" type="string" required="false">
		<cfargument name="orgID" type="string" required="false">
		<cfargument name="stateregionID" type="string" required="false">
		<cfargument name="fundingsourceID" type="string" required="false">
		<cfargument name="themeID" type="string" required="false">
		<cfargument name="fundingmechID" type="string" required="false">
		<cfargument name="implementerID" type="string" required="false">
		<cfargument name="statusID" type="string" required="false">
		<cfargument name="reprogramFunds" type="string" required="false">
		<cfargument name="ctex" type="string" required="false">
		<cfargument name="keyword" type="string" required="false">
		<cfargument name="fy" type="string" required="false">
		<cfargument name="activityIDs" type="string" required="false">
		<cfargument name="impStatus" type="string" required="false">

		<cfquery name="qSummary" datasource="#dsn.getName()#">
			select ProposalNumber, fundingSources, fiscalyear, projectTitle, Country, region, implementingOrgs, implementingPartners,
			implementMethod, projectAmount, totObAmount, CONVERT(VARCHAR(10), AMCNApprovedDate, 101) as AMCNApprovedDate, CONVERT(VARCHAR(10),
			budgetfundapprovaldate, 101) as budgetfundapprovaldate, description, CONVERT(VARCHAR(10), clearedprelegaldate, 101) as clearedprelegaldate,
			CONVERT(VARCHAR(10), proposalApprovedDate, 101) as proposalApprovedDate, CONVERT(VARCHAR(10), amcnbudgetsubmitdate, 101) as amcnbudgetsubmitdate,
			CONVERT(VARCHAR(10), amcncongresssubmitdate, 101) as amcncongresssubmitdate, implementmethod, programAudience, startDate, endDate,
			projectObjective, implementationStatus, activityid, amcnnumber, primaryResult, secondaryResults, obligationNumbers, cnnumbers,
			(select name from category where categoryid = implementingpartner) as ctfpartner, implementingpartner, reprogramfunds,
			(select count(activityid) from activitycn where activityid = vw_fullActivities.activityid) as cncount, ctex, programname,
			CASE WHEN activitystatuscode IN ('100') THEN
					'Proposal In Progress'
					WHEN activitystatuscode IN ('101') THEN
					'More Information Requested'
					WHEN activitystatuscode IN ('180','181') THEN
					'Regional Review Pending'
					WHEN activitystatuscode IN ('200','203') THEN
					'Program Review Pending'
					WHEN activitystatuscode IN ('201') THEN
					'Pre-Legal Clearance Pending'
					WHEN activitystatuscode IN ('202') THEN
					'Pre-Legal Comment/Question'
					WHEN activitystatuscode IN ('205') THEN
					'Cleared Pre-Legal'
					WHEN activitystatuscode IN ('210') THEN
					'Proposal On Hold'
					WHEN activitystatuscode IN ('220') THEN
					'Proposal Denied'
					WHEN activitystatuscode IN ('250') THEN
					'Proposal Reactivated'
					WHEN activitystatuscode IN ('300') THEN
					'Awaiting CN to Budget'
					WHEN activitystatuscode IN ('301','302','303','305','306') THEN
					'CN Clearance Pending'
					WHEN activitystatuscode IN ('308') THEN
					'CN Congressional Approval Pending'
					WHEN activitystatuscode IN (',310','320','330') THEN
					'CN Withdrawn, On Hold, Denied'
					WHEN activitystatuscode IN ('350') THEN
					'CN Reactivated'
					WHEN activitystatuscode IN ('400') THEN
					'Funding Type Confirmation Pending'
					WHEN activitystatuscode IN ('401','402') THEN
					'Funding Clearance Pending'
					WHEN activitystatuscode IN ('410','420') THEN
					'Funding On Hold, Denied'
					WHEN activitystatuscode IN ('450') THEN
					'Funding Reactivated'
					WHEN activitystatuscode IN ('500') THEN
					'Funding Approved for Obligation'
					WHEN activitystatuscode IN ('600') THEN
					'Funding Fully Obligated'
					WHEN activitystatuscode IN ('700') THEN
					'Closed'
				   ELSE
					'Status Undefined'
				   END Statusname
			from vw_fullActivities
		 	 WHERE isActive = 1
		 	   AND programID IS NOT NULL
		 	   <cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID is not '0'>
			  	 AND programID in (#arguments.programID#)
				</cfif>
				<cfif structKeyExists(arguments,"countryID") and len(arguments.countryID) and arguments.countryID is not '0'>
			  	 AND (activityID in (select objectID from objectCategory where categoryID in (#arguments.countryID#)) or activityID in (select activityID from activitybudget where countryID in (#arguments.countryID#)))
				</cfif>
				<cfif structKeyExists(arguments,"regionID") and len(arguments.regionID) and arguments.regionID is not '0'>
			  	 AND (activityID in (select objectID from objectCategory where categoryID in (#arguments.regionID#)) or activityID in (select objectID from objectCategory where categoryID in (select subcategoryid from categorytocategory where supercategoryid in (#arguments.regionID#)) ))
				</cfif>
				<cfif structKeyExists(arguments,"orgID") and len(arguments.orgID) and arguments.orgID is not '0'>
			  	 AND activityID in (select activityID from activitybudget where countryID in (#arguments.orgID#))
				</cfif>
				<cfif structKeyExists(arguments,"stateregionID") and len(arguments.stateregionID) and arguments.stateregionID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (select subcategoryid from categorytocategory where supercategoryid in (#arguments.stateregionID#)))
				</cfif>
				<cfif structKeyExists(arguments,"fundingSourceID") and len(arguments.fundingSourceID) and arguments.fundingSourceID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.fundingSourceID#))
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID is not '0'>
			  	  AND activitystatusID in (#arguments.statusID#)
			  	 <cfelseif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID is '0'>
			  	  AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
				<cfif structKeyExists(arguments,"reprogramFunds") and len(arguments.reprogramFunds)>
			  	  AND reprogramFunds = <cfqueryparam value="#arguments.reprogramFunds#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"ctex") and len(arguments.ctex)>
			  	  AND ctex = <cfqueryparam value="#arguments.ctex#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"fundingmechID") and len(arguments.fundingmechID) and arguments.fundingmechID is not '0'>
			  	  AND fundimpmechanismid in (#arguments.fundingmechID#)
				</cfif>
				<cfif structKeyExists(arguments,"implementerID") and len(arguments.implementerID) and arguments.implementerID is not '0'>
			  	  AND implementingpartner in (#arguments.implementerID#)
				</cfif>
				 <cfif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "Not Set">
					and implementationstatus is null
				<cfelseif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "CN Re-notification">
					AND (implementationStatus = '#arguments.impstatus#' or (select count(activityid) from activitycn where activityid = vw_fullActivities.activityid) > 1)
				<cfelseif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "MOU Modification">
					AND (implementationStatus = '#arguments.impstatus#' or previousFClearances is not null)
				<cfelseif  structKeyExists(arguments,"impStatus") and len(arguments.impStatus)>
			  	  AND implementationStatus = '#arguments.impstatus#'
				</cfif>
<!--- 				<cfif structKeyExists(arguments,"impStatus") and len(arguments.impStatus)>
					AND (implementationStatus = '#arguments.impstatus#'
					<cfif arguments.impstatus is "CN Re-notification">
						or ((select count(activityid) from activitycn where activityid = vw_fullActivities.activityid) > 1)
					</cfif>
					<cfif arguments.impstatus is "MOU Modification">
						or previousFClearances is not null
					</cfif>
					<cfif arguments.impstatus is "Not Set">
						or implementationstatus is null
					</cfif>
					)
				</cfif> --->
				<cfif structKeyExists(arguments,"keyword") and len(arguments.keyword)>
				  AND (AMCNnumber LIKE '%#uCase(arguments.keyword)#%'
							OR upper(projecttitle) LIKE '%#uCase(arguments.keyword)#%'
							OR upper(ProposalNumber) LIKE '%#uCase(arguments.keyword)#%'
							OR upper(description) LIKE '%#uCase(arguments.keyword)#%'
							or activityID in (select activityid from vw_fullActivityOrg where upper(orgname) LIKE '%#uCase(arguments.keyword)#%' or upper(implementingpartner) LIKE '%#uCase(arguments.keyword)#%')
							 or  ActivityID in (select activityid from activityobligation where upper(obligationnumber) like '%#uCase(arguments.keyword)#%')
							)
				</cfif>
				<cfif structKeyExists(arguments,"fy") and len(arguments.fy) and arguments.fy is not '0'>
			  	  AND fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif structKeyExists(arguments,"activityIDs") and len(arguments.activityIDs) and arguments.fundingSourceID is not '0'>
					AND activityID in (#arguments.activityIDs#)
				</cfif>
				order by activityid
		</cfquery>



		<cfreturn qSummary>
	</cffunction>

	<cffunction name="getManagerReportPivot" access="public" output="false" returntype="query">

		<cfquery name="qSummary" datasource="#dsn.getName()#">
			select activityid, proposalnumber, projecttitle, description, startdate, enddate, budgetceilingamount, projectObjective, interestspecification,
			lawenforcementspecification, coordinationspecification, programaudience, placeofimplementation, activitystatus, objectname, externalcode, objecttype,
			fundingmechanism, programaccount, numberofcountries, ObligationAmount, obligationfyyearsource, obligationdate, regionname from view_pivot where isactive = 1 order by activityid
		</cfquery>



	   	<cfset var qreport = querynew("activityid, proposalnumber, projecttitle, obligationfyyearsource, placeofimplementation, objectname, objecttype, budgetceilingamount, obligationamount, startdate, enddate,  activitystatus, fundingmechanism, programaccount, numberofcountries, obligationdate, regionname, description, projectObjective, interestspecification,lawenforcementspecification, coordinationspecification, programaudience") />
	   	<cfloop query="qSummary">
			<cfset QueryAddRow(qreport) />
			<cfset QuerySetCell(qreport,"activityid",qSummary.activityid) />
			<cfset QuerySetCell(qreport,"proposalnumber",qSummary.proposalnumber) />
			<cfset QuerySetCell(qreport,"projecttitle",qSummary.projecttitle) />
			<cfset QuerySetCell(qreport,"description",qSummary.description) />
			<cfset QuerySetCell(qreport,"startdate",dateformat(qSummary.startdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"enddate",dateformat(qSummary.enddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"budgetceilingamount",qSummary.budgetceilingamount) />
			<cfset QuerySetCell(qreport,"projectObjective",qSummary.projectObjective) />
			<cfset QuerySetCell(qreport,"interestspecification",qSummary.interestspecification) />
			<cfset QuerySetCell(qreport,"lawenforcementspecification",qSummary.lawenforcementspecification) />
			<cfset QuerySetCell(qreport,"coordinationspecification",qSummary.coordinationspecification) />
			<cfset QuerySetCell(qreport,"programaudience",qSummary.programaudience) />
			<cfset QuerySetCell(qreport,"placeofimplementation",qSummary.placeofimplementation) />
			<cfset QuerySetCell(qreport,"activitystatus",qSummary.activitystatus) />
			<cfset QuerySetCell(qreport,"objectname",qSummary.objectname) />
			<cfset QuerySetCell(qreport,"objecttype",qSummary.objecttype) />
			<cfset QuerySetCell(qreport,"fundingmechanism",qSummary.fundingmechanism) />
			<cfset QuerySetCell(qreport,"programaccount",qSummary.programaccount) />
			<cfset QuerySetCell(qreport,"numberofcountries",qSummary.numberofcountries) />
			<cfset QuerySetCell(qreport,"obligationamount",qSummary.obligationamount) />
			<cfset QuerySetCell(qreport,"obligationfyyearsource",qSummary.obligationfyyearsource) />
			<cfset QuerySetCell(qreport,"obligationdate",dateformat(qSummary.obligationdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"regionname",qSummary.regionname) />

		</cfloop>

		<cfreturn qreport>
	</cffunction>

	<cffunction name="getManagerReportBudget" access="public" output="false" returntype="query">
		<cfargument name="ProgramID" type="string" required="false" />
		<cfargument name="countryID" type="string" required="false">
		<cfargument name="regionID" type="string" required="false">
		<cfargument name="orgID" type="string" required="false">
		<cfargument name="stateregionID" type="string" required="false">
		<cfargument name="fundingsourceID" type="string" required="false">
		<cfargument name="themeID" type="string" required="false">
		<cfargument name="statusID" type="string" required="false">
		<cfargument name="reprogramFunds" type="string" required="false">
		<cfargument name="ctex" type="string" required="false">
		<cfargument name="keyword" type="string" required="false">
		<cfargument name="fy" type="string" required="false">
		<cfargument name="impStatus" type="string" required="false">
		<cfargument name="implementerID" type="string" required="false">
		<cfargument name="fundingmechID" type="string" required="false">

		<cfquery name="qSummary" datasource="#dsn.getName()#">
			select activityid, proposalnumber, proposalname, fy, program, budgetceilingamount, country, implementer, organization, budgetitem, budgetamount, region, rsiregion,
			startdate, enddate, programaudience, amcnnumber, fundingmechanism,
			description, projectObjective, interestspecification, lawenforcementspecification, coordinationspecification,
			proposalsubmitdate, proposalapproveddate, clearedprelegaldate, amcnbudgetsubmitdate, amcncongresssubmitdate, amcnapproveddate, fundapproveddate,
			budgetfundrequestdate, budgetfundapprovaldate,
			reprogramfunds, activitystatusid, fiscalyear, totalobligated
			 from vw_activityProgramBudget

			 WHERE isActive = 1
		 	   <!--- AND actx.proposalSubmitDate IS NOT NULL --->
		 	   AND programID IS NOT NULL
		 	   <cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID is not '0'>
			  	 AND programID in (#arguments.programID#)
				</cfif>
				<cfif structKeyExists(arguments,"countryID") and len(arguments.countryID) and arguments.countryID is not '0'>
			  	 AND countryid in (#arguments.countryID#)
				</cfif>
				<cfif structKeyExists(arguments,"regionID") and len(arguments.regionID) and arguments.regionID is not '0'>
			  	 AND rsiregionid in (#arguments.regionID#)
				</cfif>
				<cfif structKeyExists(arguments,"orgID") and len(arguments.orgID) and arguments.orgID is not '0'>
			  	 AND activityID in (select activityID from activitybudget where countryID in (#arguments.orgID#))
				</cfif>
				<cfif structKeyExists(arguments,"stateregionID") and len(arguments.stateregionID) and arguments.stateregionID is not '0'>
			  	 AND stateregionid in (#arguments.stateregionID#)
				</cfif>
				<cfif structKeyExists(arguments,"fundingSourceID") and len(arguments.fundingSourceID) and arguments.fundingSourceID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.fundingSourceID#))
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID is not '0'>
			  	  AND activitystatusID in (#arguments.statusID#)
			  	 <cfelseif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID is  '0'>
			  	  AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
				<cfif structKeyExists(arguments,"reprogramFunds") and len(arguments.reprogramFunds)>
			  	  AND reprogramFunds = <cfqueryparam value="#arguments.reprogramFunds#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"ctex") and len(arguments.ctex)>
			  	  AND ctex = <cfqueryparam value="#arguments.ctex#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"implementerID") and len(arguments.implementerID) and arguments.implementerID is not '0'>
			  	  AND implementingpartner in (#arguments.implementerID#)
				</cfif>
				<cfif structKeyExists(arguments,"fundingmechID") and len(arguments.fundingmechID) and arguments.fundingmechID is not '0'>
			  	  AND fundimpmechanismid in (#arguments.fundingmechID#)
				</cfif>
				<cfif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "Not Set">
					and implementationstatus is null
				<cfelseif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "CN Re-notification">
					AND (implementationStatus = '#arguments.impstatus#' or (select count(activityid) from activitycn where activityid = vw_activityProgramBudget.activityid) > 1)
				<cfelseif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "MOU Modification">
					AND (implementationStatus = '#arguments.impstatus#' or previousFClearances is not null)
				<cfelseif  structKeyExists(arguments,"impStatus") and len(arguments.impStatus)>
			  	  AND implementationStatus = '#arguments.impstatus#'
				</cfif>
				<cfif structKeyExists(arguments,"keyword") and len(arguments.keyword)>
				  AND (AMCNnumber LIKE '%#uCase(arguments.keyword)#%'
							OR upper(proposalname) LIKE '%#uCase(arguments.keyword)#%'
							OR upper(ProposalNumber) LIKE '%#uCase(arguments.keyword)#%'
							OR upper(description) LIKE '%#uCase(arguments.keyword)#%'
							or activityID in (select activityid from vw_fullActivityOrg where upper(orgname) LIKE '%#uCase(arguments.keyword)#%' or upper(implementingpartner) LIKE '%#uCase(arguments.keyword)#%')
							)

				</cfif>
				<cfif structKeyExists(arguments,"fy") and len(arguments.fy) and arguments.fy is not '0'>
			  	  AND fiscalyear in (#arguments.fy#)
				</cfif>
		</cfquery>

 		<cfset var qreport = querynew("activityid, proposalnumber, proposalname, fy, program, budgetceilingamount, totalobligated, country, implementer, organization, budgetitem, budgetamount, region, rsiregion,
			startdate, enddate, programaudience, amcnnumber, fundingmechanism,
			description, projectObjective, interestspecification, lawenforcementspecification, coordinationspecification,
			proposalsubmitdate, proposalapproveddate, clearedprelegaldate, amcnbudgetsubmitdate, amcncongresssubmitdate, amcnapproveddate, fundapproveddate,
			budgetfundrequestdate, budgetfundapprovaldate,
			reprogramfunds, activitystatusid") />
		   	<cfloop query="qsummary">
				<cfset QueryAddRow(qreport) />
				<cfset QuerySetCell(qreport,"activityid",qSummary.activityid) />
				<cfset QuerySetCell(qreport,"proposalnumber",qSummary.proposalnumber) />
				<cfset QuerySetCell(qreport,"proposalname",qSummary.proposalname) />
				<cfset QuerySetCell(qreport,"fy",qSummary.fiscalyear) />
				<cfset QuerySetCell(qreport,"program",qSummary.program) />
				<cfset QuerySetCell(qreport,"budgetceilingamount",qSummary.budgetceilingamount) />
				<cfset QuerySetCell(qreport,"totalobligated",qSummary.totalobligated) />
				<cfset QuerySetCell(qreport,"country",qSummary.country) />
				<cfset QuerySetCell(qreport,"implementer",qSummary.implementer) />
				<cfset QuerySetCell(qreport,"organization",qSummary.organization) />
				<cfset QuerySetCell(qreport,"budgetitem",qSummary.budgetitem) />
				<cfset QuerySetCell(qreport,"budgetamount",qSummary.budgetamount) />
				<cfset QuerySetCell(qreport,"region",qSummary.region) />
				<cfset QuerySetCell(qreport,"rsiregion",qSummary.rsiregion) />
				<cfset QuerySetCell(qreport,"startdate",dateformat(qSummary.startdate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"enddate",dateformat(qSummary.enddate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"programaudience",qSummary.programaudience) />
				<cfset QuerySetCell(qreport,"amcnnumber",qSummary.amcnnumber) />
				<cfset QuerySetCell(qreport,"fundingmechanism",qSummary.fundingmechanism) />
				<cfset QuerySetCell(qreport,"description",qSummary.description) />
				<cfset QuerySetCell(qreport,"projectObjective",qSummary.projectObjective) />
				<cfset QuerySetCell(qreport,"interestspecification",qSummary.interestspecification) />
				<cfset QuerySetCell(qreport,"lawenforcementspecification",qSummary.lawenforcementspecification) />
				<cfset QuerySetCell(qreport,"coordinationspecification",qSummary.coordinationspecification) />
				<cfset QuerySetCell(qreport,"proposalsubmitdate",dateformat(qSummary.proposalsubmitdate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"proposalapproveddate",dateformat(qSummary.proposalapproveddate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"clearedprelegaldate",dateformat(qSummary.clearedprelegaldate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"amcnbudgetsubmitdate",dateformat(qSummary.amcnbudgetsubmitdate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"amcncongresssubmitdate",dateformat(qSummary.amcncongresssubmitdate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"amcnapproveddate",dateformat(qSummary.amcnapproveddate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"fundapproveddate",dateformat(qSummary.fundapproveddate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"budgetfundrequestdate",dateformat(qSummary.budgetfundrequestdate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"budgetfundapprovaldate",dateformat(qSummary.budgetfundapprovaldate, "mm/dd/yyyy")) />
				<cfset QuerySetCell(qreport,"reprogramfunds",qSummary.reprogramfunds) />
				<cfset QuerySetCell(qreport,"activitystatusid",qSummary.activitystatusid) />

			</cfloop>



	   <!--- 	<cfset var qreport = querynew("activityid, proposalnumber, proposalname, fy, program, budgetceilingamount, country, organization, budgetitem, budgetamount, region, rsiregion,
			startdate, enddate, programaudience, amcnnumber, fundingmechanism,
			description, projectObjective, interestspecification, lawenforcementspecification, coordinationspecification,
			proposalsubmitdate, proposalapproveddate, clearedprelegaldate, amcnbudgetsubmitdate, amcncongresssubmitdate, amcnapproveddate, fundapproveddate,
			budgetfundrequestdate, budgetfundapprovaldate,
			reprogramfunds, activitystatusid") />
	   	<cfloop query="qSummary">
			<cfset QueryAddRow(qreport) />
			<cfset QuerySetCell(qreport,"activityid",qSummary.activityid) />
			<cfset QuerySetCell(qreport,"proposalnumber",qSummary.proposalnumber) />
			<cfset QuerySetCell(qreport,"proposalname",qSummary.proposalname) />
			<cfset QuerySetCell(qreport,"fy",qSummary.fy) />
			<cfset QuerySetCell(qreport,"program",qSummary.program) />
			<cfset QuerySetCell(qreport,"budgetceilingamount",qSummary.budgetceilingamount) />
			<cfset QuerySetCell(qreport,"country",qSummary.country) />
			<cfset QuerySetCell(qreport,"organization",qSummary.organization) />
			<cfset QuerySetCell(qreport,"budgetitem",qSummary.budgetitem) />
			<cfset QuerySetCell(qreport,"budgetamount",qSummary.budgetamount) />
			<cfset QuerySetCell(qreport,"region",qSummary.region) />
			<cfset QuerySetCell(qreport,"rsiregion",qSummary.rsiregion) />
			<cfset QuerySetCell(qreport,"startdate",dateformat(qSummary.startdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"enddate",dateformat(qSummary.enddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"programaudience",qSummary.programaudience) />
			<cfset QuerySetCell(qreport,"amcnnumber",qSummary.amcnnumber) />
			<cfset QuerySetCell(qreport,"fundingmechanism",qSummary.fundingmechanism) />
			<cfset QuerySetCell(qreport,"description",qSummary.description) />
			<cfset QuerySetCell(qreport,"projectObjective",qSummary.projectObjective) />
			<cfset QuerySetCell(qreport,"interestspecification",qSummary.interestspecification) />
			<cfset QuerySetCell(qreport,"lawenforcementspecification",qSummary.lawenforcementspecification) />
			<cfset QuerySetCell(qreport,"coordinationspecification",qSummary.coordinationspecification) />
			<cfset QuerySetCell(qreport,"proposalsubmitdate",dateformat(qSummary.proposalsubmitdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"proposalapproveddate",dateformat(qSummary.proposalapproveddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"clearedprelegaldate",dateformat(qSummary.clearedprelegaldate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"amcnbudgetsubmitdate",dateformat(qSummary.amcnbudgetsubmitdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"amcncongresssubmitdate",dateformat(qSummary.amcncongresssubmitdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"amcnapproveddate",dateformat(qSummary.amcnapproveddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"fundapproveddate",dateformat(qSummary.fundapproveddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"budgetfundrequestdate",dateformat(qSummary.budgetfundrequestdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"budgetfundapprovaldate",dateformat(qSummary.budgetfundapprovaldate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"reprogramfunds",qSummary.reprogramfunds) />
			<cfset QuerySetCell(qreport,"activitystatusid",qSummary.activitystatusid) />

		</cfloop>	 --->

		<cfreturn qreport>
	</cffunction>

	<cffunction name="getManagerReportObligation" access="public" output="false" returntype="query">
		<cfargument name="ProgramID" type="numeric" required="false" />
		<cfargument name="countryID" type="string" required="false">
		<cfargument name="regionID" type="string" required="false">
		<cfargument name="stateregionID" type="string" required="false">
		<cfargument name="fundingsourceID" type="string" required="false">
		<cfargument name="statusID" type="string" required="false">
		<cfargument name="reprogramFunds" type="string" required="false">
		<cfargument name="fy" type="string" required="false">

		<cfquery name="qSummary" datasource="#dsn.getName()#">
			select activityid, proposalnumber, proposalname, fy, obligationamount, obligationdate, program, budgetceilingamount,
			startdate, enddate, programaudience, amcnnumber, fundingmechanism,
			description, projectObjective, interestspecification, lawenforcementspecification, coordinationspecification,
			proposalsubmitdate, proposalapproveddate, clearedprelegaldate, amcnbudgetsubmitdate, amcncongresssubmitdate, amcnapproveddate, fundapproveddate,
			budgetfundrequestdate, budgetfundapprovaldate,
			reprogramfunds, reprogramcomments, activitystatus, fiscalyear
			 from vw_activityObligation

			 WHERE isActive = 1
		 	   <!--- AND actx.proposalSubmitDate IS NOT NULL --->
		 	   AND programID IS NOT NULL
		 	   <cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID GT 0>
			  	 AND programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"countryID") and len(arguments.countryID) and arguments.countryID GT 0>
			  	 AND activityID in (select objectID from objectCategory where categoryID = <cfqueryparam value="#arguments.countryID#" CFSQLType="cf_sql_integer" />)
				</cfif>
				<cfif structKeyExists(arguments,"regionID") and len(arguments.regionID) and arguments.regionID GT 0>
			  	  AND (activityID in (select objectID from objectCategory where categoryID = <cfqueryparam value="#arguments.regionID#" CFSQLType="cf_sql_integer" />) or activityID in (select objectID from objectCategory where categoryID in (select subcategoryid from categorytocategory where supercategoryid = <cfqueryparam value="#arguments.regionID#" CFSQLType="cf_sql_integer" />) ))
				</cfif>
				<cfif structKeyExists(arguments,"stateregionID") and len(arguments.stateregionID) and arguments.stateregionID GT 0>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (select subcategoryid from categorytocategory where supercategoryid = <cfqueryparam value="#arguments.stateregionID#" CFSQLType="cf_sql_integer" />))
				</cfif>
				<cfif structKeyExists(arguments,"fundingSourceID") and len(arguments.fundingSourceID) and arguments.fundingSourceID GT 0>
			  	 AND activityID in (select objectID from objectCategory where categoryID = <cfqueryparam value="#arguments.fundingSourceID#" CFSQLType="cf_sql_integer" />)
				</cfif>
				<cfif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID GT 0>
			  	  AND activitystatusID = <cfqueryparam value="#arguments.statusID#" CFSQLType="cf_sql_integer" />
				<cfelseif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID is 0>
			  	  AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
				<cfif structKeyExists(arguments,"reprogramFunds") and len(arguments.reprogramFunds)>
			  	  AND reprogramFunds = <cfqueryparam value="#arguments.reprogramFunds#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"fy") and len(arguments.fy)>
			  	  AND fiscalyear = <cfqueryparam value="#arguments.fy#" CFSQLType="cf_sql_integer" />
				</cfif>
		</cfquery>



	   	<cfset var qreport = querynew("activityid, proposalnumber, proposalname, fy, obligationamount, obligationdate, program, budgetceilingamount,
			startdate, enddate, programaudience, amcnnumber, fundingmechanism,
			description, projectObjective, interestspecification, lawenforcementspecification, coordinationspecification,
			proposalsubmitdate, proposalapproveddate, clearedprelegaldate, amcnbudgetsubmitdate, amcncongresssubmitdate, amcnapproveddate, fundapproveddate,
			budgetfundrequestdate, budgetfundapprovaldate,
			reprogramfunds, reprogramcomments, activitystatus") />
	   	<cfloop query="qSummary">
			<cfset QueryAddRow(qreport) />
			<cfset QuerySetCell(qreport,"activityid",qSummary.activityid) />
			<cfset QuerySetCell(qreport,"proposalnumber",qSummary.proposalnumber) />
			<cfset QuerySetCell(qreport,"proposalname",qSummary.proposalname) />
			<cfset QuerySetCell(qreport,"fy",qSummary.fy) />
			<cfset QuerySetCell(qreport,"obligationamount",qSummary.obligationamount) />
			<cfset QuerySetCell(qreport,"obligationdate",qSummary.obligationdate) />
			<cfset QuerySetCell(qreport,"program",qSummary.program) />
			<cfset QuerySetCell(qreport,"budgetceilingamount",qSummary.budgetceilingamount) />
			<cfset QuerySetCell(qreport,"startdate",dateformat(qSummary.startdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"enddate",dateformat(qSummary.enddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"programaudience",qSummary.programaudience) />
			<cfset QuerySetCell(qreport,"amcnnumber",qSummary.amcnnumber) />
			<cfset QuerySetCell(qreport,"fundingmechanism",qSummary.fundingmechanism) />
			<cfset QuerySetCell(qreport,"description",qSummary.description) />
			<cfset QuerySetCell(qreport,"projectObjective",qSummary.projectObjective) />
			<cfset QuerySetCell(qreport,"interestspecification",qSummary.interestspecification) />
			<cfset QuerySetCell(qreport,"lawenforcementspecification",qSummary.lawenforcementspecification) />
			<cfset QuerySetCell(qreport,"coordinationspecification",qSummary.coordinationspecification) />
			<cfset QuerySetCell(qreport,"proposalsubmitdate",dateformat(qSummary.proposalsubmitdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"proposalapproveddate",dateformat(qSummary.proposalapproveddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"clearedprelegaldate",dateformat(qSummary.clearedprelegaldate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"amcnbudgetsubmitdate",dateformat(qSummary.amcnbudgetsubmitdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"amcncongresssubmitdate",dateformat(qSummary.amcncongresssubmitdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"amcnapproveddate",dateformat(qSummary.amcnapproveddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"fundapproveddate",dateformat(qSummary.fundapproveddate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"budgetfundrequestdate",dateformat(qSummary.budgetfundrequestdate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"budgetfundapprovaldate",dateformat(qSummary.budgetfundapprovaldate, "mm/dd/yyyy")) />
			<cfset QuerySetCell(qreport,"reprogramfunds",qSummary.reprogramfunds) />
			<cfset QuerySetCell(qreport,"reprogramcomments",qSummary.reprogramcomments) />
			<cfset QuerySetCell(qreport,"activitystatus",qSummary.activitystatus) />

		</cfloop>

		<cfreturn qreport>
	</cffunction>

	<cffunction name="expManagerReport" access="public" output="false" returntype="query">

		<cfset var qreport = getManagerReport() />
		<cfquery name="qmgrSummary" dbtype="query">
			 SELECT
					proposalNumber
					,fundingSources
					,projectTitle
					,Description
					,projectAmount
					,country
					,region
					,implementMethod
					,proposalSubmitDate
					,clearedPrelegalDate
					,proposalApprovedDate
					,AMCNBudgetSubmitDate
					,AMCNCongressSubmitDate
					,AMCNApprovedDate
					,obligationDate
					,totObAmount
					,ObligationFYyearSource
			FROM qreport
		</cfquery>

		<cfreturn qmgrSummary>
	</cffunction>

	<cffunction name="getRegionByProgramReport" access="public" output="false" returntype="query">
		<cfargument name="fiscalyear" default="0" required="false">
		<cfargument name="mapid" default="" required="false">
		<cfargument name="program" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			 SELECT
					ActivityID, BudgetCeilingAmount, NumberofCountries, activitystatus, externalcode, RegionName, amountper, ProgramAccount, ObjectName,
                      projectTitle, proposalnumber,  ObligationAmount, obfy, obamountper, mapid, programID
			FROM vw_stateRegionAmounts
			WHERE 1=1
				<cfif arguments.mapid is not "">
					and mapid in (#arguments.mapid#)
				</cfif>
				<cfif arguments.program is not "">
					and programid in (#arguments.program#)
				</cfif>
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getMapReport" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="themeID" default="" required="false">
		<cfargument name="resultsFrameworkElementID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			 SELECT
					sum(budgetamount) as totalbudget, mapid, country, externalcode, type, coordinates
			FROM vw_activityProgramBudget
			WHERE country is not null and ctex = 0
				<cfif arguments.program is not "">
					and program in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif arguments.region is not "">
					and region in ('#REReplace(arguments.region,",","','","ALL")#')
				</cfif>
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID in (#arguments.statusID#)
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
				<cfif arguments.resultsFrameworkElementID is not "">
					and activityID in (select activityID from ActivityResultsFrameworkElement where resultsFrameworkElementID = #arguments.ResultsFrameworkElementID# or (resultsFrameworkElementID  in (select childResultsFrameworkElementID as resultsFrameworkElementID from dbo.fxnframeworkDescendants(#arguments.ResultsFrameworkElementID#))))
				</cfif>
			group by mapid, country, externalcode, type, coordinates
			order by country
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getDashboard" access="public" output="false" returntype="query">

		<cfquery name="dash"  datasource="#dsn.getName()#">
			 SELECT
			country, externalcode, budgetitem, budgetamount, proposalnumber, proposalname, activityid, startdate, enddate,
			fiscalyear, program, region, fundingmechanism
			FROM vw_activityProgramBudget
			WHERE country is not null
			and budgetamount is not null
			and startdate is not null
			and enddate is not null
			and fiscalyear > 2009
			AND activitystatusID not in (266, 267, 273, 274)
			order by region, country, program, proposalnumber
		</cfquery>

		<cfreturn dash>
	</cffunction>

	<cffunction name="getMultiStacked" access="public" output="false" returntype="query">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    program, region, fy, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			GROUP BY program, region, fy
			ORDER BY program, region, fy
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getactivityBudget" access="public" output="false" returntype="query">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT   activityid, programid, fy, countryid, budgetamount, externalcode, mapid, budgetitem, rsiregion, region, country, program, proposalname, proposalnumber
			FROM         dbo.vw_activityProgramBudget
			ORDER BY program, region, fy
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getProgramSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="implementer" default="" required="false">
		<cfargument name="countryname" default="" required="false">
		<cfargument name="programname" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="themeID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    program, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			WHERE ctex = 0
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.region is not "">
					and region in ('#REReplace(arguments.region,",","','","ALL")#')
				</cfif>
				<cfif arguments.countryname is not "">
					and country  in ('#REReplace(arguments.countryname,",","','","ALL")#')
				</cfif>
				<cfif arguments.programName is not "">
					and program in ('#REReplace(arguments.programname,",","','","ALL")#')
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif arguments.implementer is not "">
					and implementer = '#arguments.implementer#'
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID in (#arguments.statusID#)
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY program
			ORDER BY program
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getImplementerSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="umbrella" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="themeID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    implementer, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			WHERE implementer is not null and ctex = 0
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.region is not "">
					and region in ('#REReplace(arguments.region,",","','","ALL")#')
				</cfif>
				<cfif arguments.program is not "">
					and program in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif arguments.umbrella is not "">
					and umbrella in ('#REReplace(arguments.umbrella,",","','","ALL")#')
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID in (#arguments.statusID#)
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY implementer
			ORDER BY implementer
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getImpUmbrellaSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="themeID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    umbrella as implementer, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			WHERE implementer is not null and ctex = 0
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.region is not "">
					and region in ('#REReplace(arguments.region,",","','","ALL")#')
				</cfif>
				<cfif arguments.program is not "">
					and program in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID in (#arguments.statusID#)
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY umbrella
			ORDER BY umbrella
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getProgramOrgSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="organization" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="statusID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    program, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_OrgBudget
			WHERE ctex = 0
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.organization is not "">
					and organization = '#arguments.organization#'
				</cfif>
				<cfif arguments.program is not "">
					and program in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY program
			ORDER BY program
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getFYSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="implementer" default="" required="false">
		<cfargument name="countryname" default="" required="false">
		<cfargument name="programname" default="" required="false">
		<cfargument name="statusID" default="" required="false">

		<cfquery name="rgFY"  datasource="#dsn.getName()#">
			SELECT    fiscalyear as fy, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			WHERE ctex = 0
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.region is not "">
					and region in ('#REReplace(arguments.region,",","','","ALL")#')
				</cfif>
				<cfif arguments.implementer is not "">
					and implementer='#arguments.implementer#'
				</cfif>
				<cfif arguments.countryname is not "">
					and country in ('#REReplace(arguments.countryname,",","','","ALL")#')
				</cfif>
				<cfif arguments.programName is not "">
					and program in ('#REReplace(arguments.programname,",","','","ALL")#')
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY fiscalyear
			ORDER BY fiscalyear
		</cfquery>

		<cfreturn rgFY>
	</cffunction>

	<cffunction name="getFYOrgSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="organization" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="statusID" default="" required="false">

		<cfquery name="rgFY"  datasource="#dsn.getName()#">
			SELECT    fiscalyear as fy, SUM(BudgetAmount) AS totalbudget
			FROM         vw_ctebudgetorgs
			WHERE 1=1
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.organization is not "">
					and orgname = '#arguments.organization#'
				</cfif>
				<cfif arguments.program is not "">
					and programname in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY fiscalyear
			ORDER BY fiscalyear
		</cfquery>

		<cfreturn rgFY>
	</cffunction>

	<cffunction name="getRegionSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="countryname" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="themeID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    region, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			WHERE country is not null and ctex = 0
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.program is not "">
					and program  in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif arguments.region is not "">
					and region in ('#REReplace(arguments.region,",","','","ALL")#')
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif arguments.countryname is not "">
					and country  in ('#REReplace(arguments.countryname,",","','","ALL")#')
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY region
			ORDER BY region
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getCountrySums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="themeID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    country, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			WHERE country is not null and ctex = 0
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.program is not "">
					and program  in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif arguments.region is not "">
					and region  in ('#REReplace(arguments.region,",","','","ALL")#')
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY country
			ORDER BY country
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getOrgSums" access="public" output="false" returntype="query">
		<cfargument name="fy" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="themeID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    organization, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_OrgBudget
			WHERE 1=1
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.program is not "">
					and program in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<cfif structKeyExists(arguments,"themeID") and len(arguments.themeID) and arguments.themeID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.themeID#))
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			GROUP BY organization
			ORDER BY organization
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getMapIDs" access="public" output="false" returntype="query">

		<cfset var countryList = "">

		<cfquery name="countryList"  datasource="#dsn.getName()#">
			SELECT 	mapids.mapid, mapids.externalcode, Category.Name
			FROM 	mapids INNER JOIN
            		Category ON mapids.externalcode = Category.ExternalCode
            ORDER BY name
		</cfquery>

		<cfreturn countryList>
	</cffunction>

	<cffunction name="getMapList" access="public" output="false" returntype="query">

		<cfargument name="fy" default="" required="false">
		<!--- <cfargument name="mapid" default="" required="false"> --->
		<cfargument name="countryname" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="programname" default="" required="false">
		<cfargument name="statusID" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			 SELECT
					ActivityID, proposalnumber, proposalname, program, country, budgetitem, budgetamount, fiscalyear as fy, budgetceilingamount, activitystatus
			FROM vw_activityProgramBudget
			WHERE 1=1
				<!--- <cfif arguments.mapid is not "">
					and mapid in (#arguments.mapid#)
				</cfif> --->
				<cfif arguments.countryname is not "">
					and country = '#arguments.countryname#'
				</cfif>
				<cfif arguments.region is not "">
					and region = '#arguments.region#'
				</cfif>
				<cfif arguments.programname is not "">
					and program = '#arguments.programname#'
				</cfif>
				<cfif arguments.program is not "">
					and programid in (#arguments.program#)
				</cfif>
				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			ORDER BY ActivityID
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getProfile" access="public" output="false" returntype="query">

		<cfargument name="fy" default="" required="false">
		<cfargument name="countryname" default="" required="false">
		<cfargument name="region" default="" required="false">
		<cfargument name="implementer" default="" required="false">
		<cfargument name="umbrella" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="programname" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="sortby" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			 SELECT
					ActivityID, proposalnumber, proposalname, countries, regions, countryIDs, regionIDs, projectobjective, implementationstatus, implementer,
					CASE WHEN fiscalyear is null THEN
						'TBD'
					ELSE
						convert(varchar, fiscalyear)
					END fy,
					CASE WHEN ((program = 'RSI' or program = 'CTE') OR (select count(distinct countryid) from activitybudget where activityid = v.activityid and budgetamount > 0) > 1) THEN
						'Multilateral'
					ELSE
						'Bilateral'
					END fundstype,
					budgetceilingamount, activitystatus,
					(select sum(budgetamount) from vw_activityProgramBudget where activityid = v.activityid
					<cfif arguments.countryname is not "">
						and country  in ('#REReplace(arguments.countryname,",","','","ALL")#')
					</cfif>
					<cfif arguments.region is not "">
						and region in ('#REReplace(arguments.region,",","','","ALL")#')
					</cfif>
					<cfif arguments.program is not "">
						and program in ('#REReplace(arguments.program,",","','","ALL")#')
					</cfif>

					<!--- <cfif arguments.program is not "">
						and programid in (#arguments.program#)
					</cfif> --->
					<cfif arguments.fy is not "">
						and fiscalyear in (#arguments.fy#)
					</cfif>
					<cfif arguments.statusID is not "">
						and ActivityStatusID = #arguments.statusID#
					<cfelse>
						AND activitystatusID not in (266, 267, 273, 274)
					</cfif>
					) as budgetAmount
			FROM vw_LocationProfiles v
			WHERE (ctex is null or ctex = 0)
				<cfif arguments.countryname is not "">
					<!--- and v.countries like '%#arguments.countryname#%' --->
					and exists (select * from vw_activityCountryRegions where activityid = v.activityid and country in ('#REReplace(arguments.countryname,",","','","ALL")#'))
				</cfif>
				<cfif arguments.region is not "">
					<!--- and regions like '%#arguments.region#%' --->
					and activityid in (select activityid from vw_activitycountryregions where region in ('#REReplace(arguments.region,",","','","ALL")#'))
				</cfif>

				<cfif arguments.program is not "">
					and program in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>

				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>

				<cfif arguments.implementer is not "">
						and implementer = '#arguments.implementer#'
					</cfif>

				<cfif arguments.umbrella is not "">
						and umbrella = '#arguments.umbrella#'
					</cfif>

				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>


				<cfif arguments.sortby is not "">
					ORDER BY #arguments.sortby#
				<cfelse>
					ORDER BY program, fy desc, proposalnumber
				</cfif>
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="getOrgProfile" access="public" output="false" returntype="query">

		<cfargument name="fy" default="" required="false">
		<cfargument name="organization" default="" required="false">
		<cfargument name="program" default="" required="false">
		<cfargument name="programname" default="" required="false">
		<cfargument name="statusID" default="" required="false">
		<cfargument name="sortby" default="" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			 SELECT
					ActivityID, organizations as organization, proposalnumber, proposalname as name, projectobjective, implementationstatus, implementer,
					CASE WHEN fiscalyear is null THEN
						'TBD'
					ELSE
						convert(varchar, fiscalyear)
					END fy,
					budgetceilingamount, activitystatus,
					(select sum(budgetamount) from vw_ctebudgetorgs where activityid = v.activityid
					<cfif arguments.organization is not "">
						and orgname = '#arguments.organization#'
					</cfif>
					<cfif arguments.program is not "">
						and program in ('#REReplace(arguments.program,",","','","ALL")#')
					</cfif>
					<!--- <cfif arguments.program is not "">
						and programid in (#arguments.program#)
					</cfif> --->
					<cfif arguments.fy is not "">
						and fiscalyear in (#arguments.fy#)
					</cfif>
					<cfif arguments.statusID is not "">
						and ActivityStatusID = #arguments.statusID#
					<cfelse>
						AND activitystatusID not in (266, 267, 273, 274)
					</cfif>
					) as budgetAmount
			FROM vw_LocationProfiles v
			WHERE
				(ctex is null or ctex = 0)

				<cfif arguments.organization is not "">
					and exists (select * from vw_ctebudgetorgs where activityid = v.activityid and orgname = '#arguments.organization#')
				<cfelse>
					exists (select * from vw_ctebudgetorgs where activityid = v.activityid)
				</cfif>
				<cfif arguments.program is not "">
					and program in ('#REReplace(arguments.program,",","','","ALL")#')
				</cfif>
				<!--- <cfif arguments.program is not "">
					and programid  = #arguments.program#
				</cfif> --->

				<cfif arguments.fy is not "">
					and fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif arguments.statusID is not "">
					and ActivityStatusID = #arguments.statusID#
				<cfelse>
					AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
			<cfif arguments.sortby is not "">
					ORDER BY #arguments.sortby#
				<cfelse>
					ORDER BY program, fiscalyear desc, proposalnumber
				</cfif>
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

	<cffunction name="expMatrixReport" access="public" output="false" returntype="query">
		<cfargument name="programID" type="string" required="false" />

		<cfset qsummary = getReportSummary(argumentCollection=arguments) />
		<cfquery name="qmatrix" dbtype="query">
			SELECT
					ProposalNumber,
					subAccount,
					projectTitle,
					projectObjective,
					description,
					implementationCountry,
					implementationRegion,
					projectAmount,
					owners,
					implementMethod,
					proposalSubmitDate,
					clearedPrelegalDate,
					proposalApprovedDate,
					AMCNCongressSubmitDate,
					AMCNApprovedDate,
					obAmount
			FROM qsummary
		</cfquery>

		<cfreturn qmatrix>
	</cffunction>

	<cffunction name="getUserEmail" access="public" output="false" returntype="query">
		<cfargument name="programID" type="string" required="true" />
		<cfargument name="activityID" type="string" required="true" />

		<cfquery name="qUsers" datasource="#dsn.getName()#">

			<cfif structKeyExists(arguments, "programID") and len(arguments.programID)>
				SELECT srle.SysRoleID
				      ,srle.Name roleName
				      ,srle.Description
				      ,surle.SysUserID
				      ,susr.Email
				      ,susr.isActive
				      ,susr.programID
				  FROM SysRole srle
				  JOIN SysUserRole surle ON (srle.SysRoleID = surle.SysRoleID)
				  JOIN SysUser susr ON (susr.SysUserID = surle.SysUserID)
				 WHERE susr.programID = #arguments.programID#
				   AND ((srle.Name = 'Submitter/Program'

				   <cfif structKeyExists(arguments, "activityID") and len(arguments.activityID)>
					   and surle.SysUserID in (select sysuserid from SysUserCategory where categoryid in (select supercategoryid from categorytocategory where subcategoryid in (select countryid from activitybudget where activityid = #arguments.activityID#) or subcategoryid in (select categoryid from objectcategory where objectid = #arguments.activityID#))))
				   		or (surle.SysUserID in (select sysuserid from ActivityStatusLog where activityid = #arguments.activityID#  and (lognote = 'proposal submitted for review' or lognote = 'proposal submitted for regional review' or lognote = 'proposal saved')))
				   <cfelse>
				   	)
					</cfif>
				   )
				   AND susr.isActive = 1
				UNION
			</cfif>
				SELECT srle.SysRoleID
				      ,srle.Name roleName
				      ,srle.Description
				      ,surle.SysUserID
				      ,susr.Email
				      ,susr.isActive
				      ,susr.programID
				  FROM SysRole srle
				  JOIN SysUserRole surle ON (srle.SysRoleID = surle.SysRoleID)
				  JOIN SysUser susr ON (susr.SysUserID = surle.SysUserID)
				 WHERE (srle.Name = 'Legal' or srle.Name = 'Budget' or srle.Name = 'F Clearance' or srle.Name = 'H Clearance' or srle.Name = 'S/P Clearance'  or srle.Name = 'FO Clearance')
				   AND susr.isActive = 1
		</cfquery>

		<cfreturn qUsers />
	</cffunction>

	<cffunction name="getUserEditable" access="public" output="false" returntype="string">
		<cfargument name="sysuserID" type="string" required="true" />


		<cfquery name="qEditable" datasource="#dsn.getName()#">


				   select activityid from activity where activityid in (SELECT activityID
				  FROM activitystatuslog
				 WHERE (lognote = 'proposal submitted for review' or lognote = 'proposal saved' or lognote='proposal submitted for regional review' or lognote='proposal submitted with no approval required' or lognote='proposal submitted with no pre-legal review required')
				   AND sysuserID = #arguments.sysuserid#) or
				   activityid in (select activityid from activityperson where email = (select email from sysuser where sysuserid = #arguments.sysuserid#))
		</cfquery>

		<cfset editableList = valuelist(qEditable.activityID)>

		<cfreturn editableList />
	</cffunction>

	<cffunction name="getCNActivities" access="public" output="false" returntype="query">
		<cfargument name="cnid" required="true">


		<cfquery name="cnAct"  datasource="#dsn.getName()#">
			SELECT    proposalnumber, activityid, projecttitle
			FROM         vw_activities
			WHERE cnid = #arguments.cnid#
			order by activityid
		</cfquery>

		<cfreturn cnAct>
	</cffunction>

	<cffunction name="getProjectCountryIDs" access="public" output="false" returntype="query">
		<cfargument name="activityid" required="true">


		<cfquery name="cIDs"  datasource="#dsn.getName()#">
			SELECT    categoryid
			FROM         ObjectCategory
			WHERE objectid = #arguments.activityid# and classname = 'ActivityPlace'
		</cfquery>

		<cfreturn cIDs>
	</cffunction>

	<cffunction name="getProjectCountryDisaggIDs" access="public" output="false" returntype="query">
		<cfargument name="activityid" required="true">


		<cfquery name="cIDs"  datasource="#dsn.getName()#">
			SELECT    disaggid
			FROM         disagg
			WHERE externalcode in  (select externalcode from vw_activityCountries where activityid = #arguments.activityid#)
		</cfquery>

		<cfreturn cIDs>
	</cffunction>

	<cffunction name="getFilteredProgramSums" access="public" output="false" returntype="query">
		<cfargument name="ProgramID" type="string" required="false" />
		<cfargument name="countryID" type="string" required="false">
		<cfargument name="regionID" type="string" required="false">
		<cfargument name="orgID" type="string" required="false">
		<cfargument name="stateregionID" type="string" required="false">
		<cfargument name="fundingsourceID" type="string" required="false">
		<cfargument name="fundingmechID" type="string" required="false">
		<cfargument name="implementerID" type="string" required="false">
		<cfargument name="statusID" type="string" required="false">
		<cfargument name="reprogramFunds" type="string" required="false">
		<cfargument name="keyword" type="string" required="false">
		<cfargument name="fy" type="string" required="false">
		<cfargument name="activityIDs" type="string" required="false">
		<cfargument name="impStatus" type="string" required="false">

		<cfquery name="rgProgram"  datasource="#dsn.getName()#">
			SELECT    program, SUM(BudgetAmount) AS totalbudget
			FROM         dbo.vw_activityProgramBudget
			WHERE 1=1
				<cfif structKeyExists(arguments,"programID") and len(arguments.programID) and arguments.programID is not '0'>
			  	 AND programID in (#arguments.programID#)
				</cfif>
				<cfif structKeyExists(arguments,"countryID") and len(arguments.countryID) and arguments.countryID is not '0'>
			  	 AND (activityID in (select objectID from objectCategory where categoryID in (#arguments.countryID#)) or activityID in (select activityID from activitybudget where countryID in (#arguments.countryID#)))
				</cfif>
				<cfif structKeyExists(arguments,"regionID") and len(arguments.regionID) and arguments.regionID is not '0'>
			  	 AND (activityID in (select objectID from objectCategory where categoryID in (#arguments.regionID#)) or activityID in (select objectID from objectCategory where categoryID in (select subcategoryid from categorytocategory where supercategoryid in (#arguments.regionID#)) ))
				</cfif>
				<cfif structKeyExists(arguments,"orgID") and len(arguments.orgID) and arguments.orgID is not '0'>
			  	 AND activityID in (select activityID from activitybudget where countryID in (#arguments.orgID#))
				</cfif>
				<cfif structKeyExists(arguments,"stateregionID") and len(arguments.stateregionID) and arguments.stateregionID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (select subcategoryid from categorytocategory where supercategoryid in (#arguments.stateregionID#)))
				</cfif>
				<cfif structKeyExists(arguments,"fundingSourceID") and len(arguments.fundingSourceID) and arguments.fundingSourceID is not '0'>
			  	 AND activityID in (select objectID from objectCategory where categoryID in (#arguments.fundingSourceID#))
				</cfif>
				<cfif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID is not '0'>
			  	  AND activitystatusID in (#arguments.statusID#)
			  	 <cfelseif structKeyExists(arguments,"statusID") and len(arguments.statusID) and arguments.statusID is '0'>
			  	  AND activitystatusID not in (266, 267, 273, 274)
				</cfif>
				<cfif structKeyExists(arguments,"reprogramFunds") and len(arguments.reprogramFunds)>
			  	  AND reprogramFunds = <cfqueryparam value="#arguments.reprogramFunds#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"fundingmechID") and len(arguments.fundingmechID) and arguments.fundingmechID is not '0'>
			  	  AND fundimpmechanismid in (#arguments.fundingmechID#)
				</cfif>
				<cfif structKeyExists(arguments,"implementerID") and len(arguments.implementerID) and arguments.implementerID is not '0'>
			  	  AND implementingpartner in (#arguments.implementerID#)
				</cfif>
				<cfif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "Not Set">
					and implementationstatus is null
				<cfelseif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "CN Re-notification">
					AND (implementationStatus = '#arguments.impstatus#' or (select count(activityid) from activitycn where activityid = vw_fullActivities.activityid) > 1)
				<cfelseif structKeyExists(arguments,"impStatus") and len(arguments.impStatus) and arguments.impstatus is "MOU Modification">
					AND (implementationStatus = '#arguments.impstatus#' or previousFClearances is not null)
				<cfelseif  structKeyExists(arguments,"impStatus") and len(arguments.impStatus)>
			  	  AND implementationStatus = '#arguments.impstatus#'
				</cfif>
				<cfif structKeyExists(arguments,"keyword") and len(arguments.keyword)>
				  AND (AMCNnumber LIKE '%#uCase(arguments.keyword)#%'
							OR upper(proposalname) LIKE '%#uCase(arguments.keyword)#%'
							OR upper(ProposalNumber) LIKE '%#uCase(arguments.keyword)#%'
							OR upper(description) LIKE '%#uCase(arguments.keyword)#%'
							or activityID in (select activityid from vw_fullActivityOrg where upper(orgname) LIKE '%#uCase(arguments.keyword)#%' or upper(implementingpartner) LIKE '%#uCase(arguments.keyword)#%')
							 or  ActivityID in (select activityid from activityobligation where upper(obligationnumber) like '%#uCase(arguments.keyword)#%')
							)
				</cfif>
				<cfif structKeyExists(arguments,"fy") and len(arguments.fy) and arguments.fy is not '0'>
			  	  AND fiscalyear in (#arguments.fy#)
				</cfif>
				<cfif structKeyExists(arguments,"activityIDs") and len(arguments.activityIDs) and arguments.fundingSourceID is not '0'>
					AND activityID in (#arguments.activityIDs#)
				</cfif>
			GROUP BY program
			ORDER BY program
		</cfquery>

		<cfreturn rgProgram>
	</cffunction>

</cfcomponent>