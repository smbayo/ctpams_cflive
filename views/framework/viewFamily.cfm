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


<cfquery name="qListChildren" dbtype="query">
SELECT * FROM rc.resultRelations where ParentResultsFrameworkElementID = <cfqueryparam value="#rc.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
</cfquery>
<cfquery name="qListParents" dbtype="query">
SELECT * FROM rc.resultRelations where childResultsFrameworkElementID = <cfqueryparam value="#rc.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
</cfquery>


<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<table width="100%" id="msiheadertable">
  <tr>	
    <td>
			<h1>Results Framwork Element - Family</h1>
    </td>
 
	</tr>
</table>


<table width="100%" cellspacing="0" cellpadding="2" border="0">
    <tr><td>
    <center>
	<cfif qListParents.recordcount is "0"> 
	    <em>This is top level for <strong>#rc.Getresult.getNAME()#</strong> framework. There are no parents</em>
    <cfelse>
      
    
        <table cellspacing="0" cellpadding="2" border="0">
        <tr>
        <cfloop query="qListParents">
        <td style="background-color:##0FC; border:##39F; width:150;">#qListParents.ParentresultsFrameworkElementID#:  <a href=" #event.buildLink('framework.viewFamily.resultsFrameworkElementID.#qListParents.parentresultsFrameworkElementID#')#">#qListParents.parentName#</a></td>
        <td style="width:5px; background-color:##FFF">&nbsp;</td>
        
        </cfloop>
        </tr>
        </table>
    </cfif>
    
	<table width="200" cellspacing="0" cellpadding="2" border="0" style="background-color:##0C0">
    <tr>
 	<td>#rc.getresult.getResultsFrameworkElementID()#: <a href=" #event.buildLink('framework.viewResult.resultsFrameworkElementID.#rc.getResult.getResultsFrameworkElementID()#')#">#rc.getResult.getName()#</a>---></td>
	</table>

	<cfif qListchildren.recordcount is "0"> 
	    <em>There are no children for this Result</em>
    <cfelse>

        <table ellspacing="0" cellpadding="2" border="0">
        <tr>
        <cfloop query="qListChildren">
        <td style="background-color:##0FC; border:##039 width:150;">#qListchildren.ChildresultsFrameworkElementID#:  <a href=" #event.buildLink('framework.viewFamily.resultsFrameworkElementID.#qListchildren.ChildresultsFrameworkElementID#')#">#qListChildren.childName#</a></td>
             <td style="width:5px; background-color:##FFF">&nbsp;</td>
       </cfloop>
		</tr>
	</table>	
</cfif>   
 
</td>
 </tr>
 

			</table>

 </cfoutput>



