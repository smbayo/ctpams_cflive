<cfquery name="getimps" datasource="sctdb">
	select email from sysuser where isactive = 1
	<!--- and (sysuserid in (select sysuserid from sysuserrole where sysroleid in (2,3,4,5,6,7,9,10,13,14))
	or sysuserid in (select sysuserid from activitystatuslog where
	(select count(*) from activitystatuslog where sysuserid = sysuserid and statusdate > '1/1/2015') > 5)) --->
</cfquery>

<cfoutput query="getimps">


	<!--- <cfif getimpid.recordcount is 0> --->
		#email#;
	<!--- </cfif> --->
</cfoutput>