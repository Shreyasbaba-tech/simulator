<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="/struts-tags" prefix="s" %>
<% String data =(String) request.getAttribute("data");

System.out.println("data = "+data);

 String[] rowData = data.split("@@");
 
 for(String row:rowData)
 {
     System.out.println("row = "+row);
 }
 
 String appId = (String)request.getAttribute("appId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Repository Summary</title>
<script type="text/javascript">

function generateSubSystemsReport(appId,system) {
    
   // alert("generateSubSystemsReport for "+system +appId);
    document.SystemReport.action = "GenerateSubSystemReportsAction.action?appId="+appId+"&system="+system;
    document.SystemReport.submit();
}



function generateResponsesReport(appId,system,respCount) {
    
	// alert("generateResponsesReport" + appId +"-"+system);
	    document.SystemReport.action = "GenerateResponseReportsAction.action?appId="+appId+"&system="+system+"&respCount="+respCount;
	    document.SystemReport.submit();
}
</script>
</head>
<body>

<s:form action="" name="SystemReport">
<table id="mainReport" border="1" cellpadding="10" title=" ">
<tr><td colspan="4"><h2>Application : <%=appId%></h2></td></tr>
<tr><th>Services Name</th><th>Number Of Operations</th><th>Number Of Responses</th><th>Complexity</th></tr>
<%
for(int i = 0;i < rowData.length ;i++)
{
%>
<tr>  <td><%=rowData[i].split("\\|")[0]%></td>   <td> <a href="#" onclick="generateSubSystemsReport('<%=appId%>','<%=rowData[i].split("\\|")[0]%>')"> <%=rowData[i].split("\\|")[1]%></a></td>  <td><a href="#" onclick="generateResponsesReport('<%=appId%>','<%=rowData[i].split("\\|")[0]%>','<%=rowData[i].split("\\|")[2]%>')"><%=rowData[i].split("\\|")[2]%></a></td><td><%=rowData[i].split("\\|")[3]%></td>
    </tr>
    
<%
//id=<%=rowData[i].split("|")[0]
}
%>

</table>

</s:form>

</body>
</html>