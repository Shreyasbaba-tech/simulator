<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="layout/style.css">
<title>Application Virtualization</title>
</head>
<body>
<div class="ui-widget ui-widget-content ui-corner-all">

<h3 align="center"><b>
Service already present with following details
</b></h3>
<table align="center">
<tr>
<td width="20%">Service Name:</td>
<td ><b><s:property value="serviceInfo.serviceName" /></b></td>
</tr>
<tr>
<td width="20%">Operation Name</td>
<td><b><s:property value="serviceInfo.operName"/></b></td>
</tr>
<tr>
<td width="20%">Service Type:</td>
<td><b><s:property value="serviceInfo.serviceType"/></b></td>
</tr>
<tr>
<td width="20%">Service URI:</td>
<td><b><s:property value="serviceInfo.serviceURI"/></b></td>
</tr>
</table>

</div>
</body>
</html>