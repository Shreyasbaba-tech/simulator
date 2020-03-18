<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Web Service</title>

</head>
<body>

<form validate="true"  action="AddService.action" >
<center>WEB SERVICE</center>
<s:hidden name="serviceInfo.serviceType" id="serviceType" value="web"/>
<table align="center" >

  <tR><td> <s:textfield label="Service Name" key="serviceInfo.serviceName" id="serviceName" size="65"/> </td></tR>         
                 
<tr><td><s:textarea label="Sample Request XML" key="serviceInfo.requestXML" id="requestXml" rows="5" cols="50"/>  </td></tr>            
   
                  
 <tr><tD><s:textfield label="Action Xpath" key="serviceInfo.actionXPath"  id="xpath" size="65"/> </tD></tr>               
					
 
		<tr><td><font color="blue">Please select check box <br>if action XPath value check required</font><s:checkbox label="Is XPath Check" key="serviceInfo.isXPathCheck" />
						</td></tr>				 
					
			
      <tr><td><s:textfield label="Reuqest paramater separated by #" id="requestParameter" key="serviceInfo.requestParams"  size="65"/></td></tr>    
		
			<tr><td><s:file label="Search XSD file" id="fileUpload"></s:file></td></tr>			
		<tr><td ><s:submit/></td></tr>	
              
    </table>	
  </form>

</body>
</html>