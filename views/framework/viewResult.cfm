<!--- 
    Needs a query each to populate selects for:

       rc.Activity = instance.activityService.getActivity(activityid=rc.activityID);
       rc.Sector = instance.activityService.getAllSectors();
       rc.Org = instance.orgService.getOrgs();
       rc.ParentGrant = instance.activityService.getAllActivities();
--->

    <!-- AJAX SUCCESS TEST FONCTION 
      <script>function callSuccessFunction(){alert("success executed")}
          function callFailFunction(){alert("fail executed")}
      </script>
    -->
    
<script>  
$(document).ready(function() {
  
  $("#grantform").validationEngine()

  
  //$.validationEngine.loadValidation("#date")
  //alert($("#formID").validationEngine({returnIsValid:true}))
  //$.validationEngine.buildPrompt("#date","This is an example","error")       // Exterior prompt build example
  //$.validationEngine.closePrompt(".formError",true)               // CLOSE ALL OPEN PROMPTS
});
function selectAll(selectBox,selectAll) {
    // have we been passed an ID
    if (typeof selectBox == "string") {
        selectBox = document.getElementById(selectBox);
    }

    // is the select box a multiple select box?
    if (selectBox.type == "select-multiple") {
        for (var i = 0; i < selectBox.options.length; i++) {
            selectBox.options[i].selected = selectAll;
        }
    }
}




function fieldfiller() {
	var formObj = document.grantForm;
	formObj.file_title.value = formObj.u_path.value
	}
	
function changer() {
	var formObj = document.grantForm;
	if (formObj.doc_type.value != 0) {
		formObj.currentversion.disabled = false}
	if (formObj.doc_type.value != 11) {
		formObj.currentversion.disabled = false}
	if (formObj.doc_type.value == 0) {
		formObj.currentversion.disabled = true}
	if (formObj.doc_type.value == 11) {
		formObj.currentversion.disabled = true}
		}
	
function ValidateForm() {
	var formObj = document.grantForm;
	
	if (formObj.doc_type.value == 0) {
	alert("You must select a document type if you want to upload a document.");
	formObj.doc_type.focus();
	return false;
	}
	
		
	if (formObj.u_path.value.length == 0) {
	alert("Please select a document to upload.");
	formObj.u_path.focus();
	return false;
	}
	return true;
	}


</script>
<style>


table {
	border:hidden;
}
</style>
	
<cfif structKeyExists(rc,"ResultsFrameworkElementID")>
    <cfquery name="qListChildren" dbtype="query">
    SELECT * FROM rc.resultRelations where ParentResultsFrameworkElementID = <cfqueryparam value="#rc.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
    </cfquery>
    <cfquery name="qListParents" dbtype="query">
    SELECT * FROM rc.resultRelations where childResultsFrameworkElementID = <cfqueryparam value="#rc.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
    </cfquery>
</cfif>


<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<table width="100%" id="msiheadertable">
  <tr>	
    <td>
			<h1>Details for Result</h1>
    </td>
 
	</tr>
</table>
<cfif (isUserInRole('edit results'))>

    <table width=100%>
    <tr>
    <td>
    <FORM METHOD="LINK" ACTION="#event.buildLink("framework.editResult.resultsFrameworkElementID." & rc.resultsFrameworkElementID)#">
    <INPUT TYPE="submit" VALUE="Edit Result">
    </FORM>
    </td>
    <td style="text-align:right">
    <FORM METHOD="LINK" ACTION="#event.buildLink('framework.editResult')#">
    <INPUT TYPE="submit" VALUE="Add Result">
    </FORM>
    </td>
    </tr></table>
</cfif>

<table width="100%" cellspacing="0" cellpadding="2" border="0">
    <tr><td width="100" class="msiFormLabel">Result</td><td class="msiFormInput"><strong>#rc.getResult.getName()#</strong></td></tr>
    <tr><td width="100" class="msiFormLabel">Related Program</td><td class="msiFormInput">#rc.program.getDescription()# [#rc.program.getName()#] </td></tr>
 
 
 
 
<!---   <tr>
        <td width="100" class="msiFormLabel">Display Number</td>
        <td class="msiFormInput">#rc.getResult.getDisplayNumber()#</td>
    </tr>    
    <tr>
        <td width="100" class="msiFormLabel">Description</td>
        <td class="msiFormInput">#rc.getResult.getDescription()#</td>
    </tr>    
    
        <tr>
        <td width="100" class="msiFormLabel">Abbreviation</td>
        <td class="msiFormInput">#rc.getResult.getAbbreviation()#</td>
    </tr>    
    --->
<tr><td colspan=2>
<div class="footerBar">
<strong>Result within Framework</strong>


        <table width="100%" cellspacing="0" cellpadding="2" style="font-size:12px;">
        <tr><td>
        <center>
        <cfif qListParents.recordcount is "0"> 
		       <!---  <em>This is top level for <strong>#rc.Getresult.getNAME()#</strong> framework. There are no parents</em> --->
        <cfelse>
        
      
                <table cellspacing="2" cellpadding="2" border="0">
                <tr>
                <cfloop query="qListParents">
                    <td style="background-color:##fff; border: solid; border-color: ##666; border-width: 1px;"><a href=" #event.buildLink('framework.viewResult.resultsFrameworkElementID.#qListParents.parentresultsFrameworkElementID#')#">#qListParents.parentName#</a></td>
              <td>&nbsp;</td>

                    
                </cfloop>
                </tr>
                </table>
        </cfif>
        
        <table width="200" cellspacing="0" cellpadding="2" border="0">
         
        <tr>
        <td style="background-color:##002657; color:##FFF; text-align:center;">#rc.getResult.getName()#</td>
        </tr>
        </table>
        
        <cfif qListchildren.recordcount is "0"> 
    		  <!---  <em>There are no children for this Result</em> --->
        <cfelse>
        
                <table cellspacing="2" cellpadding="2" border="0">
                <tr>
                <cfloop query="qListChildren">
                <td  style="background-color:##fff; border: solid; border-color: ##666; border-width: 1px;"><a href=" #event.buildLink('framework.viewResult.resultsFrameworkElementID.#qListchildren.ChildresultsFrameworkElementID#')#">#qListChildren.childName#</a></td>
                <td>&nbsp;</td>
                </cfloop>
                </tr>
                </table>	
        </cfif>   
        </center>
        </td>
        </tr>
        </table>

</div>
</td></tr>

</table>
<table width="100%">


<cfif (isUserInRole('edit indicators'))>
     
 <tr>    <td class="msiFormLabel" style="text-align:right">
    	<FORM METHOD="LINK" ACTION="#event.buildLink("indicator.editor.resultsFrameworkElementID." & rc.resultsFrameworkElementID)#">
		<INPUT TYPE="submit" VALUE="Add New Indicator">
	</FORM>
  
</cfif>

</td></tr>

  <tr><td class="msiFormInput"><strong>Results Indicators	</strong>
<ul>
 <cfloop query="rc.resultsIndicators">
    <li><a href=" #event.buildLink('indicator.viewindicator.indicatorID.#IndicatorID#')#">#indicatorName#</a></li>
</cfloop>
</ul>
 
  
 </td></tr>    
    
  
 <tr><td class="msiFormLabel"><strong>Supporting Primary Activities</strong>
	<ul>  
  <cfloop query="rc.resultsActivities">
	  <li><a href=" #event.buildLink('proposal.review.activityID.#activityID#')#">#Name#</a></li>
  </cfloop>
  </ul>
   
  
</td></tr> 
 <tr><td class="msiFormLabel"><strong>Supporting Secondary Activities</strong>
</td></tr>       
</table>
 </cfoutput>
 



