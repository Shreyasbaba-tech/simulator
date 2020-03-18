<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
 <form validate="true" id="taskForm2" action="AddService.action" >
<center>BUS SERVICE</center>
<s:hidden name="serviceInfo.serviceType" id="serviceType2" value="bus"/>
        <table>
        
         <tR><td> <s:textfield id="serviceName2" label="Service Name(Adhering wild card mapping Q.*.*.*.*.PROBH119.* )" key="serviceInfo.serviceName"  size="65"/> </td></tR>         
		   
		    <tR><td> <s:textarea id="requestXml2" label="Sample Request XML" key="serviceInfo.requestXML" rows="5" cols="50" /></td></tR>         
		       		    		
          <tr><tD><s:textfield id="xpath2" label="Action Xpath" key="serviceInfo.actionXPath"  size="65"/> </tD></tr>  
          
					<tr><td><font color="blue">Please select check box <br>if action XPath value check required</font><s:checkbox label="Is XPath Check" key="serviceInfo.isXPathCheck" />
						</td></tr>
 
					 <tr><td><s:textfield id="requestParameter2" label="Reuqest paramater separated by #" key="serviceInfo.requestParams"  size="65"/></td></tr>    
 <tr><td><s:file label="Search XSD file" id="fileUpload2"></s:file></td></tr>	
					<tr><td ><s:submit/></td></tr>
                      
       </table>
</form>
</body>
</html>