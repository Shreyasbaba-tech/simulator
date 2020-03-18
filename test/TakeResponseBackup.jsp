<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="myBean2" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>
<%
RxContextPathDeploymentUtil util = new RxContextPathDeploymentUtil();
String path=util.getConfigItPath().replace("it", "VirtualConfig.properties");
Properties pro = new Properties();
try {
    FileInputStream f = new FileInputStream(path);
    pro.load(f);
} catch (Exception e) {
    
}

String[] list2 = myBean2.getAppIds(pro.getProperty("ResponeFilePath"));
%>
<head>
<SCRIPT type="text/javascript">

function createSelectElements( )
{

    obj = document.getElementById("TakeBackupForm");
     // obj.appId.disabled=false;
     // document.form1.drop1.options.length=0;
     <% 
      for(int i=0;i<list2.length;i++)
      {//System.out.println("-->"+list2.length);
        %>
       var opt=document.createElement('option');            
      opt.text='<%=list2[i]%>';
       opt.value='<%=list2[i]%>'; 
       document.getElementById("appId").options.add(opt);
    <%} %>  
   // alert(document.form1.drop1.options[document.form1.drop1.selectedIndex].value);    
}

function selectModeOfBackup() {
     
       obj = document.getElementById("TakeBackupForm");
     if(obj.modeOfBackup[1].checked)
    	 {
    	 
    	 obj.appId.disabled=false;
    	 }
     else
    	 {
    	 obj.appId.disabled=true;
    	 }
   //  alert(obj.modeOfBackup[0].checked);
}
</SCRIPT>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="layout/style.css">
<title>Application Virtualization</title>
</head>
<body onload="createSelectElements()">
<div class="ui-widget ui-widget-content ui-corner-all">

<h3 align="center"><b>
Select the mode of backup
</b></h3>
<s:form name="TakeBackupForm" id="TakeBackupForm" action="TakeResponseBackupAction.action" >

<s:radio id="modeOfBackup" key="modeOfBackup" name="modeOfBackup" list="{'Backup of whole Repository','Application Level Backup'}"  onchange="selectModeOfBackup()"></s:radio>



<tr><td><s:select label="Application Id "  id="appId" name="appId" key="appId" list="{'Select from below'}" disabled="true" onchange="getSystemSelectOptions()"></s:select>


<s:submit value="Take Backup" align="center"></s:submit>
</s:form>


</div>
</body>
</html>