<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<head>
<title>Application Virtualization</title>
<script>
    function trim(s) 
    {
        return s.replace( /^s*/, "" ).replace( /s*$/, "" );
    }
    function validate()
    {
        if(trim(document.frmLogin.UserName.value)=="")
        {
          alert("UserName can not be blank");
          document.frmLogin.UserName.focus();
          return false;
        }
        else if(trim(document.frmLogin.Password.value)=="")
        {
          alert("Password can not be blank");
          document.frmLogin.Password.focus();
          return false;
        }
    }  
</script>

<style type="text/css">
#logo{
	max-width:100%;
	height:70px;
	width:auto\9;
   	background-image: url("images/header_centre.png");
   	background-repeat: no-repeat;
}  
</style>
</head>
<body>
<%-- <div><s:actionerror /></div> --%>
<div class="login-container">
<marquee>This application is currently IE supported.IE users please turn off the IE compatibility mode by pressing F12 and selecting Browser Mode:IE9</marquee>
<div id="logo"></div>

	
	

    <h2 align="center" style="color: #006600;font-size: 25px;"> Login </h2>
	<s:form id="frmLogin" onSubmit="return validate();" action="login.action" method="post">

        <div style="padding: 2px;">
            <table style="border-spacing:10px; padding: 5px;" align="center">
            	 <tr>
              	 <s:if test="hasActionErrors()"> 
       			<td colspan=3 style="color: #CA2514;font-size: 20px;"> <s:actionerror/></td>
        		
   				 </s:if>
               </tr>
                <tr align="center">
                    <td width="80px;">
                        <label for="UserName" style="color: #006600;font-size: 20px;">UserName</label>
                    </td>
                    <td width="100px;">
                        <input type="text" name="UserName" id="UserName" style="width: 200px;">
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr align="center">
                    <td width="80px;">
                        <label for="Password" style="color: #006600;font-size: 20px;">Password</label>
                    </td>
                    <td width="100px;"><input type="password" name="Password" id="Password" style="width: 200px;"></td>
                    <td></td>
                    <td></td>
                </tr>

                <tr align="center">
                    <td colspan="4" align="center">
                        <input type="submit" value="login" style="float: left;margin-left: 100px;color: #006600;width: 80px "
                           id="login-form-submit-button">
                        <br/>
                        <br/>

                    </td>
                </tr>
                <tr align="center">
                    <td colspan="4" style="color: #CA2514;font-weight: bold;">
                        NOTE: Please use your LDAP credentials to login
                    </td>
                </tr>
            </table>
        </div>
        
</s:form>
</div>

</body>
</html>