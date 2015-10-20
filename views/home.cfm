<br>
<cfoutput>
<h1>Home</h1>
<br>
<table width="80%">
  <tr >
    <th colspan="3" >
      <h1>Latest Grant Updates</h1>
    </th>
  </tr>
    <tr style="color:white;background:black">
	   <td>Updated</td>
	   <td>Organization</td>
       <td>Grant</td>
	</tr>
  <cfloop query="rc.qGrants">
  <tr <cfif currentRow mod 2 eq 0>class="altrow"</cfif>>
   <td>
     #dateformat(lastUpdated,"mmm dd yyyy")# 
   </td>
    <td><a href="#event.buildLink('org.vieworg.orgid.#orgid#')#">#orgname#</a></td>
	<td><a href="#event.buildLink('grant.viewgrant.activityid.#activityid#')#">#name#</a></td>
  </tr>
  </cfloop>
</table>

<p>&nbsp;</p>
<table width="80%">
  <tr>
    <td>
      <h1>Reports</h1>
    </td>
  </tr>
  <tr>
   <td>
     <a href="#event.buildLink("reports.IndicatorsToDate")#">Indicator Report (Rollup of Actuals To-date Across Grants)</a>
   </td>
  </tr>
  <tr class="altrow">
   <td>
     <a href="#event.buildLink("reports.MeasurementRollup")#">Indicator Report (Rollup of Actuals To-date for one Grant)</a>
   </td>
  </tr>
  <tr>
   <td>
     <a href="#event.buildLink("reports.GranteesByOrgType")#">Number of Unique Grantee Organizations by Organization Type</a>
   </td>
  </tr>
  <tr>
   <td>
     <a href="#event.buildLink("reports.GrantsByOrgType")#">Number of Grants by Organization Type</a>
   </td>
  </tr>
  <tr>
   <td>
     <a href="#event.buildLink("reports.viewBudgetBySector")#">Portfolio Budget Allocation by Sector (Active Grants)</a>
   </td>
  </tr>

</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</cfoutput>