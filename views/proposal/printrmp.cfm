<cfscript>
/**
* Fixes text using Microsoft Latin-1 &quot;Extentions&quot;, namely ASCII characters 128-160.
*
* @param text      Text to be modified. (Required)
* @return Returns a string.
* @author Shawn Porter (sporter@rit.net)
* @version 1, June 16, 2004
*/
function DeMoronize (text) {
    var i = 0;

// map incompatible non-ISO characters into plausible
    // substitutes
    text = Replace(text, Chr(128), "&euro;", "All");

    text = Replace(text, Chr(130), ",", "All");
    text = Replace(text, Chr(131), "<em>f</em>", "All");
    text = Replace(text, Chr(132), ",,", "All");
    text = Replace(text, Chr(133), "...", "All");
        
    text = Replace(text, Chr(136), "^", "All");

    text = Replace(text, Chr(139), ")", "All");
    text = Replace(text, Chr(140), "Oe", "All");

    text = Replace(text, Chr(145), "`", "All");

	text = Replace(text, Chr(145), "â€™", "All");
	text = Replace(text, Chr(149), "â¢", "All");
	text = Replace(text, "•", "*", "All");
	text = Replace(text, "–", "-", "All");
	text = Replace(text, "—", "-", "All");
    text = Replace(text, Chr(146), "'", "All");
    text = Replace(text, Chr(147), """", "All");
    text = Replace(text, Chr(148), """", "All");
    text = Replace(text, Chr(149), "*", "All");
    text = Replace(text, Chr(150), "-", "All");
    text = Replace(text, Chr(151), "--", "All");
    text = Replace(text, Chr(152), "~", "All");
    text = Replace(text, Chr(153), "&trade;", "All");

    text = Replace(text, Chr(155), ")", "All");
    text = Replace(text, Chr(156), "oe", "All");

    // remove any remaining ASCII 128-159 characters
    for (i = 128; i LTE 159; i = i + 1)
        text = Replace(text, Chr(i), "", "All");

    // map Latin-1 supplemental characters into
    // their &name; encoded substitutes
    text = Replace(text, Chr(160), "&nbsp;", "All");

    text = Replace(text, Chr(163), "&pound;", "All");

    text = Replace(text, Chr(169), "&copy;", "All");

    text = Replace(text, Chr(176), "&deg;", "All");

    // encode ASCII 160-255 using Ï§ format
    for (i = 160; i LTE 255; i = i + 1)
        text = REReplace(text, "(#Chr(i)#)", "&###i#;", "All");
    
// supply missing semicolon at end of numeric entities
    text = ReReplace(text, "&##([0-2][[:digit:]]{2})([^;])", "&##\1;\2", "All");
    
// fix obscure numeric rendering of &lt; &gt; &amp;
    text = ReReplace(text, "&##038;", "&amp;", "All");
    text = ReReplace(text, "&##060;", "&lt;", "All");
    text = ReReplace(text, "&##062;", "&gt;", "All");

    // supply missing semicolon at the end of &amp; &quot;
    text = ReReplace(text, "&amp(^;)", "&amp;\1", "All");
    text = ReReplace(text, "&quot(^;)", "&quot;\1", "All");


	text = Replace(text, "’", "'", "All");
	text = Replace(text, "“", """", "All");
	text = Replace(text, "”", """", "All");
    return text;
}
</cfscript>

	
					<h3>Program-Level Results  </h3>				
					
						<table class="table table-striped">	
							<thead>
							<tr>
								<th align="left">Primary
								</th>
							</tr>
						</thead>					
						<cfif rc.primaryResult.recordcount gt 0>
		 					<cfoutput query="rc.primaryResult">	
								<tr>
									<td>#Demoronize(resultName)# 
										
									</td>
								</tr>
	
							</cfoutput>	 					
						<cfelse>
								<tr>
									<td><i>No Primary Result Selected</i> 
										
									</td>
								</tr>
						</cfif>
						</table>
						


					
					
						<table class="table table-striped">	
							<thead>
							<tr>
								<th align="left">Secondary
								</th>
							</tr>
						</thead>					
						<cfif rc.secondaryResult.recordcount gt 0>
		 					<cfoutput query="rc.secondaryResult">	
								<tr>
									<td>#Demoronize(resultName)# 
										
									</td>
								</tr>
	
							</cfoutput>	 					
						<cfelse>
								<tr>
									<td><i>No Secondary Results Selected</i> 
										
									</td>
								</tr>
						
						</cfif>
						</table>

		
					<h3>Project-Level Objectives and Indicators </h3>	
					<table class="table table-striped">	
						<thead>
						<tr>
							<th>

							</th>
						</tr>
					</thead>					
					<cfif rc.rmp.recordcount gt 0>
	 					<cfoutput query="rc.rmp" group="ResultsFrameworkElementID">	
							<tr>
								<td><strong>#Demoronize(ProjectResultsObjective)# </strong>


									<cfif len(ProjectResultsIndicator) gt 0>
										<br><br><ul>
										<cfoutput>
											<li>#Demoronize(ProjectResultsIndicator)#

											<small><br>&nbsp;&nbsp;&nbsp;&nbsp;Unit of Measure: #Demoronize(unitofmeasure)#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Data Source: #Demoronize(datasource)#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Collection Method: #Demoronize(collectionmethod)#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Data Frequency: #Demoronize(datafreq)#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Definition: #Demoronize(definition)#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Baseline Actual: #Demoronize(actual)#
											<br>&nbsp;&nbsp;&nbsp;&nbsp;Baseline Target: #Demoronize(target)#
											</small>
											</li>
										</cfoutput>
										</ul>
									</cfif>
								</td>
							</tr>

						</cfoutput>	 					
					<cfelse>
								<tr>
									<td><i>No Objectives or Indicators Entered</i> 
										
									</td>
								</tr>
					</cfif>
					</table>
					

			<cfif rc.indicators.recordcount gt 0>
				

					<h3>Project Monitoring Measurements</h3>	
					
					
					<cfif rc.measurements.recordcount gt 0>

						<cfoutput query="rc.measurements" group="startdate">
							<span class="span9">
								<strong>Reporting Period:</strong> #dateformat(StartDate,"MM/DD/YYYY")# - #dateformat(endDate,"MM/DD/YYYY")#
							</span>
							<div class="span9 reportdiv" id="#measurementid#review">
							<ul class="unstyled">
							<cfoutput group="objective">
								<li>&nbsp;&nbsp;&nbsp;<strong>Objective:</strong> #Demoronize(objective)#
								<ul class="unstyled">
								<cfoutput group="indicatorname">
									<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Indicator:</strong> #Demoronize(indicatorname)#<br>
									<span class="span9">
									<table class="table table-condensed">
										<tr>
											<th>Disaggregation</th>
											<th>Actual</th>
											<th>Target</th>
											<th></th>
										</tr>
									<cfoutput>
										<tr>
											<td>
												<cfif not len(disaggid)>
													<cfset disaggtype = 'Total'>
												<cfelse>
													<cfset disaggtype = #disaggsetname# & ' - ' & #disaggname#>
												</cfif>
												#disaggType#
											</td>
											<td>#actual#</td>
											<td>#target#</td>
											<td>

											</td>
										</tr>
									</cfoutput>
									</table>
									</span>
									</li>
								</cfoutput>
								</ul></li>
							</cfoutput>
							</ul>
							</div>
							<span class="span9">&nbsp;</span>
						</cfoutput>


					</cfif>
					
					

	</cfif>
			
			
				


			
			
				

