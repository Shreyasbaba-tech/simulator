<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="com.ctl.app.virtual.AddResponseInfo"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customize Responses</title>
<script type="text/javascript">
function submitForm() {

	 document.getElementById('customizeResponsesForm2').submit();

}


</script>
</head>
<body>
<div class="ui-widget ui-widget-content ui-corner-all">
<s:form action="SaveResponseMappingAction" id="customizeResponsesForm2" name="customizeResponsesForm2" method="post" enctype="multipart/form-data" theme="simple">
<h3 align="center"><b>
Enter the TN to which selected Responses are to be mapped
</b></h3>

<div align="center"><input id = "TN" name = "TN"></input> </div>
<br></br>
<div align="center"><button onclick="submitForm()">Save UseCase</button></div>

<br></br>





</s:form>
</div>
</body>
</html>