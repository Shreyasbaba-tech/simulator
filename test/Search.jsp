<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
<title>Search Responses</title>
</head>
<body>
<div class="ui-widget ui-widget-content ui-corner-all">
<h1>Search in Responses</h1>
<s:form action="SearchKeyAction">
 <s:textfield id="inputString" name="inputString"></s:textfield>
 <s:submit labelSeparator="Search" ></s:submit>
 </s:form>
 </div>
</body>
</html>