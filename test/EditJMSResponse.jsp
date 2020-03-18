<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="com.ctl.app.virtual.AddResponseInfo" %>
<%
String contextPath = request.getContextPath();
String msg = (String)request.getAttribute("content");

String searchTags = (String)request.getAttribute("searchTags");
AddResponseInfo responseInfo = (AddResponseInfo)request.getSession().getAttribute("response_Data");
System.out.println("====>>>>"+request.getSession().getAttribute("response_Data"));
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="<%=contextPath%>/css/style.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"> </script>
<script type="text/javascript" src="<%=contextPath%>/ui/script.js"></script>
<SCRIPT type="text/javascript">


function goToNewResponsePage() {
	var content = document.getElementById('content').value;
	//alert(content);
	document.addResponseForm.action='ShowSaveResponseAsNewAction.action';
	document.addResponseForm.submit();
	
}

function goToUploadExcellPage() {
	var bulkAppId = "<%=responseInfo.getAppId()%>";
	var bulkSystem = "<%=responseInfo.getSystem()%>";
	var bulkSubSystem = "<%=responseInfo.getSubSystem()%>";
	var bulkKey = "<%=responseInfo.getKey()%>";
	if(document.getElementById("xslFile").value == ""){
		alert("Please select a xsl file!");
		return false;
	}
	
	document.addResponseForm.action='UploadXSLFileInput.action?appId='+bulkAppId+'&serviceName='+bulkSystem+'&oper='+bulkSubSystem+'&key='+bulkKey;
	document.addResponseForm.submit();
}
function goToBulkResponsePage() {
	var bulkAppId = "<%=responseInfo.getAppId()%>";
	var bulkSystem = "<%=responseInfo.getSystem()%>";
	var bulkSubSystem = "<%=responseInfo.getSubSystem()%>";
	var bulkKey = "<%=responseInfo.getKey()%>";
	//var content = document.getElementById('content').value;
	//alert(bulkAppId);
	document.addResponseForm.action='AddBulkFileInput.action?appId='+bulkAppId+'&serviceName='+bulkSystem+'&oper='+bulkSubSystem+'&key='+bulkKey;
	document.addResponseForm.submit();
	//return false;
}


</SCRIPT>
</head>
<body>
<s:form action="EditResponseAction.action" id="addResponseForm" name="addResponseForm" theme="simple" method="post" enctype="multipart/form-data">
<table align="center">

<h3 align="center"><b>
ADD/EDIT JMS RESPONSE
</b></h3>
<tr>
<td>App ID:</td>
<td><b><s:property  value="responseInfo.appId" /></b></td>
</tr>

<tr>
<td>Service Name</td>
<td><b><s:property  value="responseInfo.system"/></b></td>
</tr>

<tr>
<td>Operation Name:</td>
<td><b><s:property  value="responseInfo.subSystem"/></b></td>
</tr>

<tr>
<td>Response Identifier:</td>
<td><b><s:property  value="responseInfo.key"/></b></td>
</tr>






<tr><td><label>Response Contents:</label></td><td><s:textarea label="Response Contents" id="content" name="content" key="content" rows="6" cols="35"></s:textarea></td></tr>
<tr><td><label>Search tags(Seperated by #):</label></td><td><s:textarea label="Search tags(Seperated by #)" id="searchTags" name="searchTags" key="searchTags" rows="6" cols="35"></s:textarea></td></tr>
<tr><td><button value="Save As New" onclick="goToNewResponsePage();">Save As New</button></td><td><s:submit label="Edit Response"></s:submit></td>
<td><button value="Upload Excell" class="topopup">Upload Excell</button><br><button value="Save As New" onclick="goToBulkResponsePage();">Save Bulk Response</button></td></tr>
</table>

    <div id="toPopup">

        <div class="close"></div>
       	<span class="ecs_tooltip">Press Esc to close <span class="arrow"></span></span>
		<div id="popup_content"> <!--your content start-->
			<h3 align="center">Upload Excell</h3><a href="<%=contextPath%>/docs/bulk_upload.xls">Sample<img src="<%=contextPath%>/images/Excel.png" style="width: 20px;height: 20px;border: none;" alt="Sample"/></a>
            <p align="center"><s:file label="Upload excell file" key="xslFile" id="xslFile"/></p>
            
         <p align="center"><button value="Go" onclick="goToUploadExcellPage();">Go</button></p>
        </div> <!--your content end-->

    </div> <!--toPopup end-->

	<div class="loader"></div>
   	<div id="backgroundPopup"></div>

</s:form>
</body>
<SCRIPT type="text/javascript">


	document.getElementById("content").value='<%=msg %>';
	document.getElementById("searchTags").value='<%=searchTags %>';


</SCRIPT>
</html>