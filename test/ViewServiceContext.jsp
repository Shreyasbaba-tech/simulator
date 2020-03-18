<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<jsp:useBean id="myBean" class="com.ctl.app.virtual.util.CommonUtility" scope="request"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>window.dhx_globalImgPath = "imgs/";</script>
<link rel="STYLESHEET" type="text/css" href="css/dhtmlxcombo.css">
<script  src="js/dhtmlxcommon.js"></script>
<script  src="js/dhtmlxcombo.js"></script>

</head>
<%
List<String> fileList =myBean.getContextFileList();

%>
<body>
<div class="ui-widget ui-widget-content ui-corner-all">
	<s:form action="showContextDetail" method="post" name="formPage">
		<table align="center">
			<tr>
				<td colspan=2><h3 align="center"><b>Select the file to view content</b></h3></td>
				<td></td>
			</tr>
			<tr>
				<td colspan=2>
				<select style='width:400px;'  id="combo_zone1" name="fileName">
					<option value=""></option>
		        <%for(String name:fileList){ %>
		            <option value="<%=name%>"><%=name %></option>
		        <%} %>
		        </select>
				</td>
				<td><s:submit></s:submit></td>
			</tr>
		</table>
		
	</s:form>
</div>
</body>
<script type="text/javascript">
var z = dhtmlXComboFromSelect("combo_zone1");
z.enableFilteringMode(true);
</script>
</html>