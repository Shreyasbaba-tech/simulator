<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="/struts-tags" prefix="s" %>
<% String data =(String) request.getAttribute("data");

System.out.println("data = "+data);

 String[] rowData = data.split("@@");
 
 for(String row:rowData)
 {
	 if(row!=null)
     System.out.println("row = "+row);
 }
 
 String appId = (String)request.getAttribute("appId");
 String system = (String)request.getAttribute("system");
 String respCount = request.getAttribute("respCount")==null?"0":(String)request.getAttribute("respCount");
 int rCount = Integer.parseInt(respCount);
 int noOfPages = 0;
 if(rCount%10>0)noOfPages = (rCount/10)+1;
 else noOfPages = (rCount/10);
 System.out.println("No of Rec : "+respCount);
 System.out.println("No of Pages : "+noOfPages);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Repository Summary</title>
<script type="text/javascript">

</script>
</head>
<body>

<s:form action="" name="ResponseReport" id="responseReport">

<table  id="mainReport" border="1" cellpadding="10" title=" ">
<tr><td colspan="4"><h2>Application : <%=appId%></h2></td></tr>
<tr><th>Response Name</th><th>From Service</th><th>Search Tags</th></tr>
<%
for(int i = 0;i < rowData.length ;i++)
{
%>
<tr>  <td><a href="#" onclick="addOrEditSelection('<%=appId%>','<%=rowData[i].split("\\|")[1]%>','<%=rowData[i].split("\\|")[3]%>','<%=rowData[i].split("\\|")[0]%>')"><%=rowData[i].split("\\|")[0].replace(".vm", "")%></a></td> <td><%=rowData[i].split("\\|")[1]%></td> <td><%=rowData[i].split("\\|")[2]%></td>
    </tr>
    
<%
//id=<%=rowData[i].split("|")[0]
}
%>
<tr>
	<td colspan="3">
		<%for(int i = 1; i <= noOfPages; i++) {%>
		<a href="#" onclick="generateResponsesReport('<%=appId%>','<%=system%>','<%=i%>','<%=rCount%>')"><%=i%></a>&nbsp;&nbsp;&nbsp;
		<%}%>
	</td>
</tr>
</table>
<input type="hidden" name="pageNo" value=""/>
<input type="hidden" name="responseInfo.appId" id="appId" value=""/>
<input type="hidden" name="responseInfo.system" id="system" value=""/>
<input type="hidden" name="responseInfo.subSystem" id="subSystem" value=""/>
<input type="hidden" name="responseInfo.key" id="key" value=""/>
</s:form>
</body>
<script type="text/javascript">
var obj = document.getElementById("responseReport");
function generateResponsesReport(appId,system,pNo,respCount) {
	obj.pageNo.value = pNo;
	obj.action = "GenerateResponseReportsAction.action?appId="+appId+"&system="+system+"&respCount="+respCount;
	obj.submit();
}
function addOrEditSelection(appId, system, subSystem, resName){
	//alert(appId+"||"+system+"||"+subSystem+"||"+resName);
	document.getElementById("appId").value = appId;
	document.getElementById("system").value = system;
	document.getElementById("subSystem").value = subSystem;
	document.getElementById("key").value = resName;
	obj.action='ShowEditResponsePageAction.action';
	obj.submit();
}
</script>
</html>