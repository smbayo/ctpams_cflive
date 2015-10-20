

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
<h1>Delete Permission Confirmation</h1>

<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<table width="100%">
  <tr>
  
    <td>


 <cfif rc.qActivePermission.recordcount is not 0>

     The Following Roles still access these permissions. Edit the Roles and remove theis permission before deleting. <br />
     <cfloop query="rc.qActivePermission">
     Role: #name# Permission: #permissionName#<br />
     </cfloop>
     <form name="Permissionform" id="Permissionform" class="formular" method="post" action="#event.buildLink('admin.Permissionslist')#">
    <input class="submit" name="btnSubmit" type="submit" value="Return to Permissions List"/>
    <INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
    </form>
     
<cfelse>

    <form name="Permissionform" id="Permissionform" class="formular" method="post" action="#event.buildLink('admin.deletePermission')#">
    <input name="sysPermissionID" type="hidden" value="#rc.qPermission.getSysPermissionID()#" />
    Delete Permission #rc.qPermission.getName()# from database?<br />
    <input class="submit" name="btnSubmit" type="submit" value="Confirm"/>
    <INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
    </form>

</cfif>

		</td>
	</tr>
    
</table>

 </cfoutput>



