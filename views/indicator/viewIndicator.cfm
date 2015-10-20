<cfoutput>
<H1>Result-Specific Indicator</h1>
<br>
<cfif (isUserInRole('edit indicators'))>
	<FORM METHOD="LINK" ACTION="#event.buildLink("indicator.editor.indicatorID/#rc.indicatorID#." & rc.indicatorID)#">
		<INPUT TYPE="submit" VALUE="Edit">
	</FORM>

</cfif>


<table width="100%" cellpadding="2" border="0" cellspacing="1">
	<tr>
		<td valign="top" class="msiFormLabel" colspan=2>Indicator<br />
		
        <span style="font-size:16px; font-weight:bold;">#rc.Indicator.getName()#</span>
		</td>
	</tr>
</table>
<table width="100%">
<tr><td width=60%>

<table width="100%" cellpadding="2" border="0" cellspacing="1">
	<tr>
		<td width="100" class="msiFormLabel">Framework Result</td>
		<td colspan="2" class="msiFormInput">#rc.getresult.getName()#</td>
	</tr>
	<tr>
		<td valign="top" class="msiFormLabel">Definition</td>
		<td width="350" class="msiFormInput">#rc.Indicator.getDefinition()#</td>
     </tr>   
	<tr>
		<td width="100" class="msiFormLabel">Justification</td>
		<td colspan="2" class="msiFormInput">#rc.Indicator.getJustification()#</td>
	</tr>	<tr>
		<td width="100" class="msiFormLabel">Data Source</td>
		<td colspan="2" class="msiFormInput">#rc.Indicator.getdatasource()#</td>
	</tr>
    	<tr>
		<td width="100" class="msiFormLabel">Reporting Frequency</td>
		<td colspan="2" class="msiFormInput">#rc.Indicator.getdataFreq()#</td>
	</tr>
     	<tr>
		<td width="100" class="msiFormLabel">Collection Method</td>
		<td colspan="2" class="msiFormInput">#rc.Indicator.getcollectionMethod()#</td>
	</tr>


</table>

</td>
<td style="padding: 5px; top:">

			<table width="100%" cellpadding="3" cellspacing="1">
				<tr>
					<td width="170" valign="top" class="msiFormLabel">Intended Change Dir</td>
					<td class="msiFormInput">
                    <cfif rc.Indicator.getIntendedChangeDirection() eq "1">
                    Positive
                    <cfelseif rc.Indicator.getIntendedChangeDirection() eq "-1">
                    Negative
					</cfif>
					</td>
				</tr>
				<tr>
					<td valign="top" class="msiFormLabel">Unit of Measure</td>
					<td class="msiFormInput">#rc.Indicator.getUnitOfMeasure()#</td>
				</tr>


   						<tr>
							<td valign="top" class="msiFormLabel">Disaggregate By</td>
							<td class="msiFormInput">
                            <cfloop query="rc.disaggsets">
                            	#rc.disaggsets.name#<br />
                            </cfloop>
								</td>
						</tr>	
			</table>
		</td>
	</tr>




</table>
<cfif (isUserInRole('edit indicators'))>
	<FORM METHOD="LINK" ACTION="#event.buildLink("indicator.deleteIndicator.indicatorID." & rc.indicatorID)#">
		<INPUT TYPE="submit" VALUE="Delete">
	</FORM>
</cfif>


</cfoutput>
