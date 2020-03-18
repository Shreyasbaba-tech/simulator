<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<title>Application Virtualization</title>
</head>
<body >
<div class="ui-widget ui-widget-content ui-corner-all">
<br></br>
<br></br>

<table align="center" >
<tr>
<td><b>Failed to create virtual service </b></td>
<td>Service Name:</td>
<td><b><s:property value="serviceInfo.serviceName" /></b></td>
</tr>
<tr>
<td>Service Type:</td>
<td><b><s:property value="serviceInfo.serviceType"/></b></td>
</tr>
</table>
</div>
</body>
</html>