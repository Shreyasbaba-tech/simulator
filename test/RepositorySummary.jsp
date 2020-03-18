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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Repository Summary</title>
<script type="text/javascript">

function generateSystemsReport(appId) {
    
    //alert("generateSystemsReport for "+appId);
    document.MainReport.action = "GenerateSystemReportsAction.action?appId="+appId;
    document.MainReport.submit();
}

function generateSubSystemsReport(appId) {
    
    //alert("generateSubSystemsReport for "+appId);
    document.MainReport.action = "GenerateSubSystemReportsAction.action?appId="+appId;
    document.MainReport.submit();
}


function generateResponsesReport(appId,respCount) {
    
  //  alert("generateResponsesReport" + appId);
    document.MainReport.action = "GenerateResponseReportsAction.action?appId="+appId+"&respCount="+respCount;
    document.MainReport.submit();
}
</script>
</head>
<body>

<s:form action="" name="MainReport">
<table id="mainReport" border="" cellpadding="10">
<tr><th>Application Name</th><th>Number Of Services</th><th>Number Of Operations</th><th>Number Of Responses</th></tr>
<%
for(int i = 0;i < rowData.length ;i++)
{
%>
<tr>  <td><%=rowData[i].split("\\|")[0]%></td> <td><a href="#" onclick="generateSystemsReport('<%=rowData[i].split("\\|")[0]%>')"><%=rowData[i].split("\\|")[1]%></a></td>  <td> <a href="#" onclick="generateSubSystemsReport('<%=rowData[i].split("\\|")[0]%>')"> <%=rowData[i].split("\\|")[2]%></a></td>  <td><a href="#" onclick="generateResponsesReport('<%=rowData[i].split("\\|")[0]%>','<%=rowData[i].split("\\|")[3]%>')"><%=rowData[i].split("\\|")[3]%></a></td>
    </tr>
    
<%
//id=<%=rowData[i].split("|")[0]
}
%>



</table>
<br></br>
 <label style = "font-size: 1.5em; text-align: left;">&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;Number of Applications : <%=rowData.length %></label>
 <label style = "font-size: 1.5em; text-align: left;">&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;Number of Apps Virtualized : 18</label>
  <label style = "font-size: 1.5em; text-align: left;">&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;Number of Operations Virtualized : 26</label>
<br></br>
</s:form>

</body>
</html>