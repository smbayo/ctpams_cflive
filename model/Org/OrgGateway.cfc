
<cfcomponent displayname="OrgGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="OrgGateway">
		<cfreturn this />
	</cffunction>

	<cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
		<cfargument name="OrgID" type="numeric" required="false" />
		<cfargument name="OrgIDList" type="string" required="false" />
			
		<cfquery name="qList" datasource="#dsn.getName()#">
			DELETE
			FROM	Org
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"OrgID") and len(arguments.OrgID)>
			AND	OrgID = <cfqueryparam value="#arguments.OrgID#" CFSQLType="cf_sql_integer" />
		</cfif>		
		<cfif structKeyExists(arguments,"OrgIDList") and listlen(arguments.OrgIDList)>
			AND	OrgID IN (#arguments.OrgIDList#)
		</cfif>	
		</cfquery>
		
		<cfreturn />
	</cffunction>		
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="OrgID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Fax" type="string" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="URL" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="LegalRegistrationStatus" type="string" required="false" />
		<cfargument name="DUNSCode" type="string" required="false" />
		<cfargument name="implementingPartner" type="string" required="false" />
		<cfargument name="pocFirstname" type="string" required="false" />
		<cfargument name="pocLastName" type="string" required="false" />
		<cfargument name="pocEmail" type="string" required="false" />
		<cfargument name="pocPhone" type="string" required="false" />		
		<cfargument name="SectorID" type="string" required="false" />
		<cfargument name="activitiesIn" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="likeSearchTerms" type="string" required="false" />
		<cfargument name="OrgIDList" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				OrgID,
				Name,
				Abbreviation,
				Email,
				Phone,
				Fax,
				Address,
				City,
				Province,
				PostalCode,
				Country,
				URL,
				Notes,
				LegalRegistrationStatus,
				DUNSCode,
				implementingPartner,
				pocFirstname,
				pocLastName,
				pocEmail,
				pocPhone
			FROM	Org
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"OrgID") and len(arguments.OrgID)>
			AND	OrgID = <cfqueryparam value="#arguments.OrgID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			<cfif isDefined("arguments.likeSearchTerms") and listFind(arguments.likeSearchTerms,"Name")>
			AND	Name LIKE <cfqueryparam value="%#arguments.Name#%" CFSQLType="cf_sql_varchar" />
			<cfelse>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
			</cfif>
		</cfif>
		<cfif structKeyExists(arguments,"Abbreviation") and len(arguments.Abbreviation)>
			AND	Abbreviation = <cfqueryparam value="#arguments.Abbreviation#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Email") and len(arguments.Email)>
			AND	Email = <cfqueryparam value="#arguments.Email#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Phone") and len(arguments.Phone)>
			AND	Phone = <cfqueryparam value="#arguments.Phone#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Fax") and len(arguments.Fax)>
			AND	Fax = <cfqueryparam value="#arguments.Fax#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Address") and len(arguments.Address)>
			AND	Address = <cfqueryparam value="#arguments.Address#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"City") and len(arguments.City)>
			AND	City = <cfqueryparam value="#arguments.City#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Province") and len(arguments.Province)>
			AND	Province = <cfqueryparam value="#arguments.Province#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"PostalCode") and len(arguments.PostalCode)>
			AND	PostalCode = <cfqueryparam value="#arguments.PostalCode#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Country") and len(arguments.Country)>
			AND	Country = <cfqueryparam value="#arguments.Country#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"URL") and len(arguments.URL)>
			AND	URL = <cfqueryparam value="#arguments.URL#" CFSQLType="cf_sql_longvarchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Notes") and len(arguments.Notes)>
			AND	Notes = <cfqueryparam value="#arguments.Notes#" CFSQLType="cf_sql_longvarchar" />
		</cfif>
		<cfif structKeyExists(arguments,"LegalRegistrationStatus") and len(arguments.LegalRegistrationStatus)>
			AND	LegalRegistrationStatus = <cfqueryparam value="#arguments.LegalRegistrationStatus#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"DUNSCode") and len(arguments.DUNSCode)>
			AND	DUNSCode = <cfqueryparam value="#arguments.DUNSCode#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"implementingPartner") and len(arguments.implementingPartner)>
			AND	implementingPartner = <cfqueryparam value="#arguments.implementingPartner#" CFSQLType="cf_sql_varchar" />
		</cfif>	
		<cfif structKeyExists(arguments,"pocFirstname") and len(arguments.pocFirstname)>
			AND	pocFirstname = <cfqueryparam value="#arguments.pocFirstname#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"pocLastName") and len(arguments.pocLastName)>
			AND	pocLastName = <cfqueryparam value="#arguments.pocLastName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"pocEmail") and len(arguments.pocEmail)>
			AND	pocEmail = <cfqueryparam value="#arguments.pocEmail#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"pocPhone") and len(arguments.pocPhone)>
			AND	pocPhone = <cfqueryparam value="#arguments.pocPhone#" CFSQLType="cf_sql_varchar" />
		</cfif>			
		<cfif structKeyExists(arguments,"sectorID") and len(arguments.sectorID)>
			AND OrgID IN
                ((SELECT     ImplementorOrgID
                  FROM         Activity
                  WHERE     (ActivityID IN
                                (SELECT     ObjectID
                                  FROM          ObjectCategory
                                  WHERE      (ClassName = 'Activity') AND (CategoryID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.sectorID#">)))))
		</cfif>
		<cfif structKeyExists(arguments,"activitiesIn") and len(arguments.activitiesIn)>
			AND OrgID in (
				(	SELECT DISTINCT Org.OrgID
					FROM         Org INNER JOIN
	                      Activity ON Org.OrgID = Activity.ImplementorOrgID INNER JOIN
	                      ActivityLocation ON Activity.ActivityID = ActivityLocation.ActivityID
					WHERE     (ActivityLocation.LocationID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.activitiesIn#">))
				) 	
		</cfif>
		<cfif structKeyExists(arguments,"OrgIDList") and listlen(arguments.OrgIDList)>
			AND	OrgID IN (#arguments.OrgIDList#)
		</cfif>		
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getOrgNames" access="public" output="false" returntype="query">
		<cfset var qreturn = "">
		
		<cfquery name="getOrgTitles" datasource="#dsn.getName()#">
			SET CONCAT_NULL_YIELDS_NULL OFF --Otherwise nulls in abbrev will mess up sort
  
			SELECT orgid, name, abbreviation
			FROM Org
			ORDER BY Abbreviation + Name 
		</cfquery>
		
		<cfreturn getOrgTitles>
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="OrgID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Fax" type="string" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="URL" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="LegalRegistrationStatus" type="string" required="false" />
		<cfargument name="DUNSCode" type="string" required="false" />
		<cfargument name="implementingPartner" type="string" required="false" />
		<cfargument name="pocFirstname" type="string" required="false" />
		<cfargument name="pocLastName" type="string" required="false" />
		<cfargument name="pocEmail" type="string" required="false" />
		<cfargument name="pocPhone" type="string" required="false" />		
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","Org").init(argumentCollection=queryRowToStruct(qList,i)) />
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

</cfcomponent>
