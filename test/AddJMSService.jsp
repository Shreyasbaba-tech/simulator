<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<jsp:useBean id="myBean" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>

<%
String cuid=(String)session.getAttribute("UserName");
//out.println(cuid);
RxContextPathDeploymentUtil util = new RxContextPathDeploymentUtil();
String path=util.getConfigItPath().replace("it", "VirtualConfig.properties");

String pathUser=util.getConfigItPath().replace("it", "VirtualAppUser.properties");
Properties pro = new Properties();
try {
    FileInputStream f = new FileInputStream(path);
    FileInputStream f1= new FileInputStream(pathUser);
    pro.load(f);
    pro.load(f1);
} catch (Exception e) {
    
}

String[] list1 = myBean.getAppIds(pro.getProperty("ResponeFilePath"));

String users=pro.getProperty("virApp.users");
String admins=pro.getProperty("virApp.admin");

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
.add_button{
background-image:url('images/Add-icon.png');background-repeat: no-repeat;background-color: transparent;background-position: 0px 0px;background-size:15px;
}
.del_button{
background-image:url('images/Math-minus-icon.png');background-repeat: no-repeat;background-color: transparent;background-position: 0px 0px;background-size:15px;
}
.copy_button{
background-image:url('images/copy.png');background-repeat: no-repeat;background-color: transparent;background-position: 0px 0px;background-size:15px;border: 0px;
}
</style>
<title>Application Virtualization</title>
</head>

<body onload="createSelectElements();">
<div class="ui-widget ui-widget-content ui-corner-all">
	<s:form action="AddJMSService.action" method="post" id="form1" name="form1" enctype="multipart/form-data">
		<table align=center>
			<tr>
				<td colspan="4">
					<h3 align="center">
						<b>ADD JMS SERVICE</b>
					</h3>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<label>APP-ID : </label>
				</td>
				<td>
					<select name="applicationId" id="drop0" onchange="getSystemSelectOptions();">
						<option value="">Select from below</option>
					</select>
				</td>
				<td></td>				
			</tr>
			<tr>
				<td></td>
				<td>
					<label id="appIdLabel">New App Id : </label>
				</td>
				<td>
					<input type="text" name="appId" id="appId"></input>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<label>Service Name : </label>
				</td>
				<td>
					<select name="serviceName" id="drop1" onchange="getSubSystemSelectOptions();" disabled="true">
						<option value="">Select from below</option>
					</select>
				</td>
				<td></td>				
			</tr>
			<tr>
				<td></td>
				<td>
					<label id="serviceNameLabel">New Service Name : </label>
				</td>
				<td>
					<input type="text" name="srvcName" id="serviceName"></input>
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="4">
					<table border="0" style="background-color: white;border-color: green;" id="mainTable">
						<tr>
							<th><span style="float:left">Queue Name&nbsp;&nbsp;&nbsp;</span><span style="float:right" title="Generate queue name"><input type="button" name="copySizeToAll" value="" alt="Copy Size To All" class="copy_button" onclick="copyToAll('queueName');"/></span></th>
							<th><span style="float:left">Queue Size&nbsp;&nbsp;&nbsp;</span><span style="float:left" title="Copy to all"><input type="button" name="copySizeToAll" value="" alt="Copy Size To All" class="copy_button" onclick="copyToAll('queueSize');"/></span></th>
							<th><span style="float:left">Delivery Mode&nbsp;&nbsp;&nbsp;</span><span style="float:left" title="Copy to all"><input type="button" name="copySizeToAll" value="" alt="Copy Size To All" class="copy_button" onclick="copyToAll('delMode');"/></span></th>
							<th>Upload XSD</th>
							<th>
								<input type="button" name="addRows" value="" alt="Add Row" class="add_button" onclick="addRow('mainTable');"/>
							</th>
						</tr>
						<tr>
							<td><input type='text' name='queueName' id='queueName'></input></td>
							<td><input type="text" name="queueSize" id="queueSize" value=""/></td>
							<td><select name="delMode" id="delMode"><option value="">Select Delivery Mode</option><option value="PERSISTENT">Persistent</option><option value="NON_PERSISTENT">Non-Persistent</option></select></td>
							<td><input type="file" name="fileField" value="" id="fileField"/></td>
							<td><input type="button" disabled="disabled" name="delRow" class="del_button" value=""></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td colspan="4"></td></tr>
			<tr><td colspan="4"></td></tr>
			<tr><td colspan="4"></td></tr>
			<tr align="center"><td colspan="4"><input type="button" value="Submit" onclick="validateForm();"/></td></tr>
		</table>
	</s:form>
</div>
</body>
<script type="text/javascript">

var obj = document.getElementById("form1");

function validateForm(){
	if(obj.applicationId.value==""){
		alert("Please select an APP-ID.");
		obj.applicationId.focus();
		return false;
	}
	if(obj.applicationId.value=="Create new application" && obj.appId.value==""){
		alert("Please provide New App Id value.");
		obj.appId.focus();
		return false;
	}
	for(var i=0;i<=totalRowCount;i++){
		if(document.getElementById("queueName"+i)){
			if(document.getElementById("queueName"+i).value==""){
				alert("Please provide Queue Name.");
				document.getElementById("queueName"+i).focus();
				return false;
			}
		}
		if(document.getElementById("queueSize"+i)){
			if(document.getElementById("queueSize"+i).value==""){
				alert("Please provide Queue Size.");
				document.getElementById("queueSize"+i).focus();
				return false;
			}
		}
		if(document.getElementById("delMode"+i)){
			if(document.getElementById("delMode"+i).selectedIndex==0){
				alert("Please select Delivery Mode.");
				document.getElementById("delMode"+i).focus();
				return false;
			}
		}
	}
	obj.action = "addJMSServiceAction.action";
	obj.submit();
}

function hide(labelId,textBoxId) {
	
	var l = document.getElementById(labelId);
		  l.style.visibility = "hidden";
	  var t = document.getElementById(textBoxId);
	  t.style.visibility = "hidden";
	}

function show(labelId,textBoxId) {
	var l = document.getElementById(labelId);
	  l.style.visibility = "visible";
	  var t = document.getElementById(textBoxId);
	  t.style.visibility = "visible";
	}

function createSelectElements( )
{
	  obj = document.getElementById("form1");
	  obj.drop0.disabled=false;
	  hide("appIdLabel","appId");
	  hide("serviceNameLabel","serviceName");
	 
	 <%
	 if(admins.contains(cuid))
	 {
		 for(int i=0;i<list1.length;i++)
		  {
	 %>
		 var opt=document.createElement('option');
		 opt.text='<%=list1[i]%>';
	     opt.value='<%=list1[i]%>'; 
	     document.getElementById("drop0").options.add(opt);
		<%  } %>
		var lastOpt=document.createElement('option');
	    lastOpt.text="Create new application";
	    lastOpt.value="Create new application";
	    document.getElementById("drop0").options.add(lastOpt);
	 <%   
	 }
	 else{
	 
	 if(users.contains(cuid))
	 {
		String appIdsPerUser=pro.getProperty(cuid);
		String[] appIdPerUser=appIdsPerUser.split(",");
	  for(int i=0;i<list1.length;i++)
	  {
		  for(int j=0;j<appIdPerUser.length;j++)
		  {
			  if(list1[i].equals(appIdPerUser[j]))
			  {
	%>
       var opt=document.createElement('option');            
       opt.text='<%=appIdPerUser[j]%>';
       opt.value='<%=appIdPerUser[j]%>'; 
       document.getElementById("drop0").options.add(opt);
    <%} } }%>  
    var lastOpt=document.createElement('option');
    lastOpt.text="Create new application";
    lastOpt.value="Create new application";
    document.getElementById("drop0").options.add(lastOpt);
    <%}else {%>
    
    var lastOpt=document.createElement('option');
    lastOpt.text="Create new application";
    lastOpt.value="Create new application";
    document.getElementById("drop0").options.add(lastOpt);
    <%} }%>
    
}

function getSystemSelectOptions() {
	 var f=document.getElementById("drop0");	   
	 var appId=f.options[f.selectedIndex].text; 	 
	 if(appId=="Create new application")
		 {
		 show("appIdLabel","appId");
		 obj.drop1.disabled=true;
		 show("serviceNameLabel","serviceName");
		 }
	 else
		 {	
		 hide("appIdLabel","appId");
		 hide("serviceNameLabel","serviceName");
		 obj.drop1.disabled=false;
		 makeRequest1();
		 }	
}

function makeRequest1() {  
	var xmlHttpRequest8 = getXMLHttpRequestA();
	
    xmlHttpRequest8.onreadystatechange = getReadyStateHandler(xmlHttpRequest8,"drop1");
   
    var f=document.getElementById("drop0");
   
    var appId=f.value; 
    var url="GetSystemTokensAction.action?appId="+appId; 
    xmlHttpRequest8.open("GET", url , true);  
    xmlHttpRequest8.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest8.send(null);
    
}

function getXMLHttpRequestA()
{  
	var xmlHttpReq = false; 
       if (window.XMLHttpRequest)
   {  
	xmlHttpReq = new XMLHttpRequest(); 
   } 
       else if (window.ActiveXObject) 
     {  
		      try {       
			       xmlHttpReq = new ActiveXObject("Msxml2.XMLHTTP");   
	                  }
		         catch (exp1)
                 {    
			           try {          
				                  xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");   
				         }
				          catch (exp2)
				           {       
					            xmlHttpReq = false;    
  	          			   }   
	           }
      }
      return xmlHttpReq;
 }

function getReadyStateHandler(xmlHttpRequest,drop)
{ 
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4)
		  {      
			  if (xmlHttpRequest.status == 200)
			  {
				  document.getElementById(drop).options.length=1;
				  var temp=[];
				  temp=(xmlHttpRequest.responseText).split(',');
				  // alert(temp);
				  for(var i=0; i<temp.length-1; i++) {
					  var opt=document.createElement('option');
					  opt.text=temp[i];
					  opt.value=temp[i];
					  document.getElementById(drop).options.add(opt);
					}
				  var lastOpt=document.createElement('option');
				  lastOpt.text="Create new service";
				  lastOpt.value="Create new service";
				  document.getElementById(drop).options.add(lastOpt);
				} else {	
					alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText);
					} 
	   		}
     };
}

function getSubSystemSelectOptions() {
	 var f=document.getElementById("drop1");
	   
	 var serviceName=f.value; 
	 if(serviceName=="Create new service")
		 {
		  show("serviceNameLabel","serviceName");
		 }
	 else{
		 hide("serviceNameLabel","serviceName");
		 }
	 //obj.drop2.disabled=false;
	 //makeRequest3();
} 

var totalRowCount=0;
function addRow(tableID) {
	totalRowCount++;
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var colCount = table.rows[1].cells.length;
    var row = table.insertRow(rowCount);
    for(var i = 0; i < colCount; i++) {
        var newcell = row.insertCell(i);
        if(i==colCount-1){
        	newcell.innerHTML = "<input type=\"button\" name=\"delRow\" alt=\"Delete Row\" class=\"del_button\" value=\"\" onclick=\"removeRow(this,'"+tableID+"')\">";
        }else{
        	newcell.innerHTML = table.rows[1].cells[i].innerHTML;
        	if(i==0){
        		newcell.childNodes[0].id="queueName"+totalRowCount;
        	}if(i==1){
        		newcell.childNodes[0].id="queueSize"+totalRowCount;
        	}if(i==2){
        		newcell.childNodes[0].id="delMode"+totalRowCount;
        	}if(i==3){
        		newcell.childNodes[0].id="fileField"+totalRowCount;
        	}
        }        
        //alert(newcell.childNodes[0].type);
	//alert(newcell.innerHTML);
    }
	//alert("Rows :"+rowCount+" Columns :"+colCount);
}
function removeRow(src,tableID) {

    var oRow = src.parentElement.parentElement;
    document.getElementById(tableID).deleteRow(oRow.rowIndex);
    
}

function copyToAll(idField){
	if(idField=='queueName'){
		for(var i=0;i<=totalRowCount;i++){
			if(document.getElementById("queueName"+i)){
				document.getElementById("queueName"+i).value = document.getElementById("queueName").value+""+i;
			}
		}
	}if(idField=='queueSize'){
		for(var i=0;i<=totalRowCount;i++){
			if(document.getElementById("queueSize"+i)){
				document.getElementById("queueSize"+i).value = document.getElementById("queueSize").value;
			}
		}
	}if(idField=='delMode'){
		for(var i=0;i<=totalRowCount;i++){
			if(document.getElementById("delMode"+i)){
				document.getElementById("delMode"+i).options[document.getElementById("delMode").selectedIndex].selected='selected';
			}
		}
	}
}
</script>
</html>