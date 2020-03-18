<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:useBean id="myBean" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>
<%
String cuid=(String)session.getAttribute("UserName");
//out.println(cuid);

RxContextPathDeploymentUtil util = new RxContextPathDeploymentUtil();
String path=util.getConfigItPath().replace("it", "VirtualConfig.properties");

String pathUser=util.getConfigItPath().replace("it", "VirtualAppUser.properties");
Properties pro = new Properties();
try {
    FileInputStream f = new FileInputStream(path);
     pro.load(f);
    } catch (Exception e) {
    
	}

String[] list1 = myBean.getAppIds(pro.getProperty("ResponeFilePath"));

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>createUserAccessPermission</title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8; IE=9; IE=10; IE=EDGE; chrome=1">

<style type="text/css">
.add_button{
background-image:url('images/Add-icon.png');background-repeat: no-repeat;background-color: transparent;background-position: 0px 0px;background-size:15px;
}
.del_button{
background-image:url('images/Math-minus-icon.png');background-repeat: no-repeat;background-color: transparent;background-position: 0px 0px;background-size:15px;
}
</style>
<SCRIPT type="text/javascript">
var obj = document.getElementById("form1");
function createSelectElements()
{
	
	  obj = document.getElementById("form1");
	 <% 
	  for(int i=0;i<list1.length;i++)
	  {
	 %>
       var opt=document.createElement('option');            
       opt.text='<%=list1[i]%>';
       opt.value='<%=list1[i]%>'; 
       document.getElementById("drop0").options.add(opt);
    <% }%>  
    //alert(  document.getElementById("drop0").options.length);
     
}
///////////

</script>
</head>

<body onload="createSelectElements()">
<div class="ui-widget ui-widget-content ui-corner-all">

<%-- <s:property value="#session.UserName" /> --%>
<s:form id="frmLogin"  action="updateProperties.action" method="post">
 <table align="center">
	<tr>
		<td colspan=5><h3 align="center"><b>ADD APP-ID TO THE USER</b></h3></td>
		<td></td>
	</tr>
	<tr>
	<s:if test="hasActionMessages()">
         <td colspan=2 style="font-size: 15px;"><s:actionmessage/></td>
   </s:if>
	</tr>
	<tr>
	 	<td >
			<label id="User">User(Please Enter Cuid of the User) : </label>
		</td>
		<td>
			<input type="text" name="userId" id="userId"></input>
		</td>
		<td></td>
		
	</tr>
	<tr></tr>
	<tr>
	
	<td >
			<label id="APP-ID">APP-ID : </label>
		</td>
		<td>
			<select  id="drop0" name="drop0" multiple="multiple" style={width:400px} >
			<option>select from below</option>
			</select>
			
		</td>
	<tr>
	<td>If you want to make any user as admin</td>
	</tr>
	<tr>
		<td>Please Enter his/her userId </td>
		<td> <input type="text" name="adminId" id="adminId"></input></td>
	</tr>
	
	<tr>
		
		<td align="center"> 
			<input type="Submit" name="Submit" value="Submit" onclick="return validateForm();"/>
		</td>
	</tr>
</table>

<s:hidden id="selectedAppId" value="" key="selectedAppId"/>
</s:form>
</div>
</body>
<script type="text/javascript">
function validateForm(){
	if(document.frmLogin.userId.value=="")
    {
      alert("Please enter userId");
      document.frmLogin.userId.focus();
      return false;
    }
    else if (document.frmLogin.drop0.selectedIndex ==  -1 )  
    {
    	alert("Please select AppId");
      document.frmLogin.drop0.focus();
      return false;
    }
}

</script>
</html>