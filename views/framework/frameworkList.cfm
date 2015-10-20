<cfoutput>
<cfloop query="frameset">




	<cfif frameset.levelid gt 0 OR viewtab is "O">
   		<cfset vspace=(frameset.levelid -1)>
    </cfif>
   	<tr> 

	<!---<td>#frameSet.resultsFrameworkElementID#</td>--->
    <cfif rc.event is 'framework.PrimaryResult'>     
   	<td>
    	<cfif listFind(rc.primaryList,frameset.resultsFrameworkElementID) is not 0> 
    		<input type="radio" name="resultsFrameworkelementID" value="#frameset.resultsFrameworkElementID#" checked="checked" />
 		<cfelse>
     		<input type="radio" name="resultsFrameworkelementID" value="#frameset.resultsFrameworkElementID#" />
		</cfif>
	</td>
	</cfif>
    
    <cfif rc.event is 'framework.secondaryResult'>     
   	<td>
    	<cfif listFind(rc.primaryList,frameset.resultsFrameworkElementID) is 0> 
			<cfif listFind(rc.secondaryList,frameset.resultsFrameworkElementID) is not 0> 
                <input type="checkbox" name="SecondaryResultsList" value="#frameset.resultsFrameworkelementID#" checked="checked" />
            <cfelse>
                <input type="checkbox" name="SecondaryResultsList" value="#frameset.resultsFrameworkelementID#" />
            </cfif>
		<cfelse>
        <strong>Primary Result</strong>
        </cfif>
    </td>
	</cfif>




    
    <td> 
    <cfif frameSet.levelid gt 0>
		<cfloop step="1" from="1" to="#vspace#" index="fill">
       <img src="views/framework/levelbox.png" />
        </cfloop>
    </cfif>
    
        <a href="#event.buildLink('framework.viewResult.resultsFrameworkElementID.#resultsFrameworkElementID#')#">#frameSet.name#</a>
        </td>

    </tr>
</cfloop>
</cfoutput>
