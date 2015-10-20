<cfoutput>
<cfloop query="frameset">

	<cfif frameset.levelid gt 0 OR viewtab is "O">
   		<cfset vspace=(frameset.levelid -1)>
    </cfif>
 
<cfif frameSet.resultsFrameworkElementID is #rc.resultsFrameworkElementID#>
	   <tr style="background-color: ##039; color: ##FFF">
       <!---	<td>#frameSet.resultsFrameworkElementID#</td>--->
        <td style="color:##FFF;"><em>Result</em></td>
        <td>
        <cfif frameSet.levelid gt 0>
			<cfloop step="1" from="1" to="#vspace#" index="fill">
              <img src="views/framework/levelbox.png" />
                </cfloop>
        </cfif>
        #frameSet.name#</td>
         <td>&nbsp;</td>
         </tr>
	<cfelse>
    	<cfif listFIND(#RC.vchildren#, frameSet.resultsFrameworkElementID) is not 0>
    	<tr style="background-color:##3FC">
        <cfelseIf listFIND(#RC.vPARENTS#, frameSet.resultsFrameworkElementID) is not 0>
   		 <tr style="background-color: ##C99">
        <cfelse>
        	<tr> 
       </cfif>
       
		<!---<td>#frameSet.resultsFrameworkElementID#</td>--->
       <td>
		<cfif listFIND(#RC.vchildren#, frameSet.resultsFrameworkElementID) is 0>
			<cfif listFIND(#RC.vPARENTS#, frameSet.resultsFrameworkElementID) is 0>
                <input type="checkbox" name="parent" value="#frameSet.resultsFrameworkElementID#" />
            <cfelse>
                <input type="checkbox" checked="checked" name="parent" value="#frameSet.resultsFrameworkElementID#" />
            </cfif>
		<cfelse>
        	<em>Child</em>
  		</cfif>
        </td>      

        <td> 
    	<cfif frameSet.levelid gt 0>
			<cfloop step="1" from="1" to="#vspace#" index="fill">
            <img src="views/framework/levelbox.png" />
            </cfloop>
        </cfif>
        #frameSet.name#
        </td>

	    </tr>
    </cfif>
</cfloop>
</cfoutput>
