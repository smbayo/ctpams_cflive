<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
	#getPlugin("MessageBox").renderit()#
</cfif>
<div>
<h1>Results Framework</h1>

<cfif IsUserInRole("administer users")>
	<button id="addResultlink" class="right" onclick="window.location='#event.buildLink("framework.editResult")#';">Add Result Framework Element</button>
</cfif>
<br />

<table border=1>
 <tr style="font-weight:bold"><td>Result Name</td></tr>
    
<cfloop list="F,O" index="viewtab">
	<cfif viewtab is "F">
        <cfquery name="frameSet" dbtype="query">
        SELECT * from rc.vFullFrame where resultsFrameworkelementID <> 0
        </cfquery>
        <cfinclude template="frameworkList.cfm">
    <cfelse>
	    <cfif rc.listorphans is not ''>
			<cfif rc.qOrphans.recordcount is not 0>
            
                <cfquery name="frameSet" dbtype="query">
                SELECT * from rc.qOrphans
                </cfquery>
            
            
                <tr><td colspan=2>Results without Parent Relationships</td></tr>
                <cfinclude template="frameworkList.cfm">
            </cfif>
  	  </cfif>
   </cfif>
</cfloop>

<!---
<table>
<thead>
<tr>
<th>Number</th>
<th>Name</th>
<th>Description</th>
<th>Delete</th>
</tr>
</thead>
<tbody>		

<cfloop query="rc.fullResults">
<tr <cfif currentRow mod 2 eq 0>id="altrow"</cfif>>
<td>#displayNumber#</a></td>
<td><a href="#event.buildLink('framework.viewResult.resultsFrameworkElementID.#resultsFrameworkElementID#')#">#name#</a></td>
<td>#Description#</td>
<td><a href="#event.buildLink('framework.predeleteResult.resultsFramworkElementID.#resultsFrameworkElementID#')#">Delete</a></td>
</tr>
</cfloop>
</table>--->
</table>
</div>
</cfoutput>