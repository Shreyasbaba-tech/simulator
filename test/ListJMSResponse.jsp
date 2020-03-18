<%@page import="java.util.ArrayList"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.ctl.app.virtual.util.CommonUtility"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="myBean2" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>
<%
File[] list = (File[]) request.getSession().getAttribute("fileList");
String appId = (String)request.getAttribute("appId");
String srvcName = (String)request.getAttribute("srvcName");
String operName = (String)request.getAttribute("operName");
List<String> fileContent = new ArrayList<String>();
for(int i = 0; i<list.length;i++){
	fileContent.add(CommonUtility.fileToString(list[i]));
}
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="createSelectElements()">
<div class="ui-widget ui-widget-content ui-corner-all">
<s:form action="loadSelectedJMSResponse.action" id="addResponseForm" name="addResponseForm" method="post" enctype="multipart/form-data">
<table align="center" id="main">
<%-- <tr><td><s:textfield label="Response identifier" key="responseInfo.key" id="key"></s:textfield></td></tr> --%>
<h3 align="center"><b>
Load JMS RESPONSE
</b></h3>
<tr><td>&nbsp;</td></tr>
<tr><td><b>Application ID </b></td><td>: <%=appId%></td></tr>
<tr><td><b>Service Name </b></td><td>: <%=srvcName%></td></tr>
<tr><td><b>Queue Name </b></td><td>: <%=operName%></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan="2"><font color="blue">Note<font color="red">*</font>: Select files to be uploaded to the queue.</font></td></tr>
<tr><td colspan="2">
		<table align="center" id="mainReport" style="width: 100%;">
		<tr><td>Sl.No.</td><td>&#10004;</td><td>File Name</td></tr>
			<%for(int i = 0; i<list.length;i++){%>
			<tr><td><%=(i+1)%>.</td><td><input type="checkbox" name="fileSelected" value="false" onclick="changeVal(this,'<%=i%>');"/></td><td><a id="xml_det<%=i%>" href='#' style="color: blue;"><%=list[i].getName()%></a></td></tr>
			<%}%>
		</table>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan="2" align="center"><input type="button" value="Upload" onclick="submitForm();"/></td></tr>
</table>
<input type="hidden" name="appId" value="<%=appId%>"/>
<input type="hidden" name="srvcName" value="<%=srvcName%>"/>
<input type="hidden" name="operName" value="<%=operName%>"/>
<%for(int i = 0; i<list.length;i++){%>
<div id="tip2<%=i%>_down" style="display:none;width: 420px">
<textarea rows="15" cols="50"><%=CommonUtility.fileToString(list[i]) %></textarea><br>
</div>
<%}%>
</s:form>
</div>
</body>
<script type="text/javascript">
var obj = document.getElementById("addResponseForm");
function changeVal(field,field1){
	//alert(field.value);
	if(field.checked){
		field.value=field1;
	}else{
		field.value="false";
	}
	
	//alert(field.value);
}
function submitForm(){
	obj.action = "loadSelectedJMSResponse.action";
	obj.submit();
}

<%for(int i = 0; i<list.length;i++){%>
listen("load", window, function() {
	$(document).ready(function() {
		/*$('#a1_up').bubbletip($('#tip1_up'));*/
		$('#xml_det<%=i%>').bubbletip($('#tip2<%=i%>_down'), {
			deltaDirection: 'down',
			deltaPosition: 30,
			offsetTop: 2
		});
	});
	});
<%}%>
function listen(evnt, elem, func) {
if (elem.addEventListener)  // W3C DOM
elem.addEventListener(evnt,func,false);
else if (elem.attachEvent) { // IE DOM
var r = elem.attachEvent("on"+evnt, func);
return r;
}
else window.alert('Oops!! Something Went wrong!!');
}
</script>
</html>