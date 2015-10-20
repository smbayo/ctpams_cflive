<cfoutput>
<H1>Result-Specific Indicator</h1>
<br>

<form name="searchform" method="post" action="#event.buildLink('indicator.saveIndicator')#">
<input type="hidden" name="event" value="#event.buildLink('indicator.saveIndicator')#">
<cfif event.valueExists("indicatorID")>
	<input type="hidden" name="indicatorid" value="#rc.indicatorID#">
</cfif>
<input type="hidden" name="resultsFrameworkElementID" value="#rc.resultsFrameworkElementID#" />

<table width="100%" cellpadding="2" border="0" cellspacing="1">
	<tr>
		<td width="100" class="msiFormLabel">Name</td>
		<td colspan="2" class="msiFormInput"><input type="text" name="Name" size="120" value="#rc.Indicator.getName()#"></td>
	</tr>
	<tr>
		<td valign="top" class="msiFormLabel">Definition</td>
		<td width="350" class="msiFormInput"><textarea name="definition" cols="50" rows="7">#rc.Indicator.getDefinition()#</textarea></td>
		<td rowspan=5 style="padding: 5px;" valign="top">
	
    
    
    
    
    		<table width="100%" cellpadding="3" border="0" cellspacing="1">
				<tr>
					<td width="170" valign="top" class="msiFormLabel">Intended Change Dir</td>
					<td class="msiFormInput">
						<input type="radio" name="IntendedChangeDirection" value="1" <cfif rc.Indicator.getIntendedChangeDirection() eq "1">selected</cfif> /> Positive
						<input type="radio" name="IntendedChangeDirection" value="-1" <cfif rc.Indicator.getIntendedChangeDirection() eq "-1">selected</cfif> /> Negative
					</td>
				</tr>
				<tr>
					<td valign="top" class="msiFormLabel">Unit of Measure</td>
					<td class="msiFormInput"><input type="text" name="UnitOfMeasure" value="#rc.Indicator.getUnitOfMeasure()#"></td>
				</tr>
				<tr>
					<td valign="top" class="msiFormLabel">External Code</td>
					<td class="msiFormInput"><input type="text" name="externalCode" ></td>
				</tr>


						<tr>
							<td valign="top" class="msiFormLabel">Disaggregate By</td>
							<td class="msiFormInput">
								<!---<select name="disaggsetID" MULTIPLE size="#iif(rc.disaggsetarraylen lt 10, de(rc.disaggsetarraylen),de(10))#" <cfif event.valueExists("indicatorID")>disabled="true"</cfif>>--->
							<cfloop from=1 to="#rc.disaggsetarraylen#" index="i" >



								<input type="checkbox" name="disaggsetID" value="#rc.disaggsetarray[i].getdisaggsetid()#" <cfif listcontainsnocase(rc.DisaggSetIndicatorsList,rc.disaggsetarray[i].getdisaggsetid())> checked="yes" </cfif> />#rc.disaggsetarray[i].getname()#</input><br />
                                
                                </cfloop>
                                
                                
                                
                                
<!---                                         <option value="#rc.disaggsetarray[i].getdisaggsetid()#" <cfif listcontainsnocase(rc.DisaggSetIndicatorsList,rc.disaggsetarray[i].getdisaggsetid())>selected</cfif>>#rc.disaggsetarray[i].getname()#</option>
									</cfloop>
								</select>
	--->						</td>
						</tr>	







			</table>
		</td>
	</tr>








	<tr>
		<td valign="top" class="msiFormLabel">Justification</td>
		<td class="msiFormInput"><textarea name="justification" cols="50" rows="7">#rc.Indicator.getJustification()#</textarea></td>
	</tr>

	<tr>
		<td valign="top" class="msiFormLabel">Data Source</td>
		<td class="msiFormInput"><textarea name="dataSource" cols="50" rows="6">#rc.Indicator.getdataSource()#</textarea></td>
	</tr>
    	<tr>
		<td valign="top" class="msiFormLabel">Reporting Frequency</td>
		<td class="msiFormInput"><textarea name="justification" cols="50" rows="3">#rc.Indicator.getdataFreq()#</textarea></td>
	</tr>

    	<tr>
		<td valign="top" class="msiFormLabel">Collection Method</td>
		<td class="msiFormInput"><textarea name="collectionMethod" cols="50" rows="3">#rc.Indicator.getcollectionMethod()#</textarea></td>
	</tr>



	<tr>
		<td colspan="3" align="right" class="msiFormLabel">
			<!---<input type="submit" name="btnSaveAdd" value="Save & Add" />&nbsp;&nbsp;&nbsp;&nbsp;--->
			
				<cfif event.valueExists("indicatorID")>
                   <input type="submit" name="btnUpdate" value="Save" />
                <cfelse>
                    <input type="submit" name="btnSave" value="Save New Indicator" />
                </cfif>
                    
            
			<input type="submit" name="btnCancel" value="Cancel" />
		</td>
	</tr>
</table>
</form>
</cfoutput>
