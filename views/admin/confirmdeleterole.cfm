

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

</script>

<br>
<h1>Delete Role Confirmation</h1>

<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<form name="Roleform" id="roleform" class="formular" method="post" action="#event.buildLink('admin/RoleList')#">
<table width="100%" id="msiheadertable">
  <tr>
    <td>

<input type="hidden" name="event" value="#event.buildLink('admin.deleteRole')#">
role Deleted<br />
<INPUT TYPE="submit" VALUE="Continue">
		</td>
	</tr>
</table>
</form>
 </cfoutput>



