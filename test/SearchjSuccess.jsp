<%@page import="com.ctl.app.virtual.SearchPojo"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html >
<html>
<head>
<%ArrayList<SearchPojo> list=(ArrayList<SearchPojo>)request.getAttribute("result"); %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>

<body>
<div class="ui-widget ui-widget-content ui-corner-all">
<h3 align="center"><b>
Search Results
</b></h3>

 <%
  for(SearchPojo ele:list)
 {
	 
	 %>
<div>
<table>
<tr><td><b>  <%=  ele.getKey()%> </b></td>  </tr>
<tr><td><b>SYSTEM : </b> <%= ele.getSystem() %> <br>  <b>  SUB-SYSTEM : </b><%= ele.getSubSystem() %></td>  </tr>
<tr><td><%= ele.getDescription() %> </td> </tr> </br></br>
</table>
</div>
<%} %>
</div>

</body>
</html>