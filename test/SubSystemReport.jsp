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
function generateResponsesReport(appId,system,respCount) {
    
  //  alert("generateResponseReport for "+system +appId);
    document.SubSystemReport.action = "GenerateResponseReportsAction.action?appId="+appId+"&system="+system+"&respCount="+respCount;
    document.SubSystemReport.submit();
}
</script>
</head>
<body>

<s:form action="" name="SubSystemReport">

<table id="mainReport" border="1" cellpadding="10" title=" ">
<tr><td colspan="4"><h2>Application : <%=appId%></h2></td></tr>
<tr><th>Operation</th><th>From Service</th><th>Number Of Responses</th></tr>
<%
for(int i = 0;i < rowData.length ;i++)
{
%>
<tr>  <td><%=rowData[i].split("\\|")[1]%></td> <td><%=rowData[i].split("\\|")[0]%> </td>   <td><a href="#" onclick="generateResponsesReport('<%=appId%>','<%=rowData[i].split("\\|")[0]%>','<%=rowData[i].split("\\|")[2]%>')"><%=rowData[i].split("\\|")[2]%></a></td>
    </tr>
    
<%
//id=<%=rowData[i].split("|")[0]
}
%>

</table>

</s:form>

</body>
</html>