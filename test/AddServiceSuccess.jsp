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
Successfully created service. Please check service details
</b></h3>
<table align="center">
<tr>
<td>Service Name:</td>
<td><b><s:property value="serviceInfo.serviceName" /></b></td>
</tr>
<tr>
<td>Service Type:</td>
<td><b><s:property value="serviceInfo.serviceType"/></b></td>
</tr>
<tr>
<td>Service Location:</td>
<td><b><s:property value="serviceInfo.serviceLocation"/></b></td>
</tr>
<tr>
<td>Service URI:</td>
<td><b><s:property value="serviceInfo.serviceURI"/></b></td>
</tr>
</table>

</div>
</body>
</html>