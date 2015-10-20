
<cfcomponent displayname="OrgDAO" hint="table ID column = OrgID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="OrgDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="numeric">
		<cfargument name="Org" type="Org" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Org
					(
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
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Org.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getName())#" />,
					<cfqueryparam value="#arguments.Org.getAbbreviation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getAbbreviation())#" />,
					<cfqueryparam value="#arguments.Org.getEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getEmail())#" />,
					<cfqueryparam value="#arguments.Org.getPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getPhone())#" />,
					<cfqueryparam value="#arguments.Org.getFax()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getFax())#" />,
					<cfqueryparam value="#arguments.Org.getAddress()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getAddress())#" />,
					<cfqueryparam value="#arguments.Org.getCity()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getCity())#" />,
					<cfqueryparam value="#arguments.Org.getProvince()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getProvince())#" />,
					<cfqueryparam value="#arguments.Org.getPostalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getPostalCode())#" />,
					<cfqueryparam value="#arguments.Org.getCountry()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getCountry())#" />,
					<cfqueryparam value="#arguments.Org.getURL()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Org.getURL())#" />,
					<cfqueryparam value="#arguments.Org.getNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Org.getNotes())#" />,
					<cfqueryparam value="#arguments.Org.getLegalRegistrationStatus()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getLegalRegistrationStatus())#" />,
					<cfqueryparam value="#arguments.Org.getDUNSCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getDUNSCode())#" />,
					<cfqueryparam value="#arguments.Org.getimplementingPartner()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getimplementingPartner())#" />,
					<cfqueryparam value="#arguments.Org.getpocFirstname()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocFirstname())#" />,
					<cfqueryparam value="#arguments.Org.getpocLastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocLastName())#" />,
					<cfqueryparam value="#arguments.Org.getpocEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocEmail())#" />,
					<cfqueryparam value="#arguments.Org.getpocPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocPhone())#" />
					)

					SELECT @@Identity as orgid
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn qCreate.orgid />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Org" type="Org" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
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
				WHERE	OrgID = <cfqueryparam value="#arguments.Org.getOrgID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Org.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Org" type="Org" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Org
				SET
					Name = <cfqueryparam value="#arguments.Org.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getName())#" />,
					Abbreviation = <cfqueryparam value="#arguments.Org.getAbbreviation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getAbbreviation())#" />,
					Email = <cfqueryparam value="#arguments.Org.getEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getEmail())#" />,
					Phone = <cfqueryparam value="#arguments.Org.getPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getPhone())#" />,
					Fax = <cfqueryparam value="#arguments.Org.getFax()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getFax())#" />,
					Address = <cfqueryparam value="#arguments.Org.getAddress()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getAddress())#" />,
					City = <cfqueryparam value="#arguments.Org.getCity()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getCity())#" />,
					Province = <cfqueryparam value="#arguments.Org.getProvince()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getProvince())#" />,
					PostalCode = <cfqueryparam value="#arguments.Org.getPostalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getPostalCode())#" />,
					Country = <cfqueryparam value="#arguments.Org.getCountry()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getCountry())#" />,
					URL = <cfqueryparam value="#arguments.Org.getURL()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Org.getURL())#" />,
					Notes = <cfqueryparam value="#arguments.Org.getNotes()#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Org.getNotes())#" />,
					LegalRegistrationStatus = <cfqueryparam value="#arguments.Org.getLegalRegistrationStatus()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getLegalRegistrationStatus())#" />,
					DUNSCode = <cfqueryparam value="#arguments.Org.getDUNSCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getDUNSCode())#" />,
					implementingPartner = <cfqueryparam value="#arguments.Org.getimplementingPartner()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getimplementingPartner())#" />,
					pocFirstname = <cfqueryparam value="#arguments.Org.getpocFirstname()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocFirstname())#" />,
					pocLastName = <cfqueryparam value="#arguments.Org.getpocLastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocLastName())#" />,
					pocEmail = <cfqueryparam value="#arguments.Org.getpocEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocEmail())#" />,
					pocPhone = <cfqueryparam value="#arguments.Org.getpocPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Org.getpocPhone())#" />
				WHERE	OrgID = <cfqueryparam value="#arguments.Org.getOrgID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn arguments.Org.getOrgID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Org" type="Org" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	Org 
				WHERE	OrgID = <cfqueryparam value="#arguments.Org.getOrgID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Org" type="Org" required="true" />

		<cfset var qExists = "">
		<cfif arguments.org.getOrgID() is not "">
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	Org
				WHERE	OrgID = <cfqueryparam value="#arguments.Org.getOrgID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
	
			<cfif qExists.idexists>
				<cfreturn true />
			<cfelse>
				<cfreturn false />
			</cfif>
		<cfelse>
      <cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="numeric">
		<cfargument name="Org" type="Org" required="true" />
		
		<cfset var success = "" />
		<cfif exists(arguments.Org)>
			<cfset success = update(arguments.Org) />
		<cfelse>
			<cfset success = create(arguments.Org) />
		</cfif>
		
		<cfreturn success />
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
