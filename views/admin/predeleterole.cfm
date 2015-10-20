

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
<table width="100%">
  <tr>
  
    <td>
 
 
 
  <cfif rc.qActiveRole.recordcount is not 0>

     The Following Users still access these Roles. Edit the Users and remove this Role before deleting. <br />
     <cfloop query="rc.qActiveRole">
     User: #name# Role: #RoleName#<br />
     </cfloop>
     <form name="roleform" id="roleform" class="formular" method="post" action="#event.buildLink('admin.Rolelist')#">
    <input class="submit" name="btnSubmit" type="submit" value="Return to Role List"/>
    <INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
    </form>
     
<cfelse>


   
<form name="Roleform" id="Roleform" class="formular" method="post" action="#event.buildLink('admin.deleteRole')#">
<input name="sysRoleID" type="hidden" value="#rc.qRole.getSysRoleID()#" />
Delete Role #rc.qRole.getName()# from database?<br />
<input class="submit" name="btnSubmit" type="submit" value="Confirm"/>
<INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
</form>
</cfif>
 
 
 
 
 
 
 
 
 
 
 
		</td>
	</tr>
    
</table>

 </cfoutput>



