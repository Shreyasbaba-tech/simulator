<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<script type="text/javascript">
function load(){
	var obj=document.getElementById("initForm");
	 obj.action='login.action';
     obj.submit();	
}

</script>
<title>Struts 2 - Login Application</title>
</head>

<body onload="load()">
<div class="ui-widget ui-widget-content ui-corner-all">
<s:actionerror />

<s:form id="initForm" action="login.action" method="post">	
	
</s:form>
</div>
</body>
</html>
