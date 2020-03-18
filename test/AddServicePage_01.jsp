<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>

<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="myBean" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>
<%
String contextPath = request.getContextPath();
// This line has also been commented since we are not using LDAP authentication and are passing true in the struts execute method.
String cuid=(String)session.getAttribute("UserName");
//UNCOMMENT THE BELOW LINE WHEN RUNNING ON LOCAL ECLIPSE
//String cuid="ac42933";

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
<meta http-equiv="X-UA-Compatible" content="IE=8; IE=9; IE=10; IE=EDGE; chrome=1">

<style type="text/css">
.add_button{
background-image:url('images/Add-icon.png');background-repeat: no-repeat;background-color: transparent;background-position: 0px 0px;background-size:15px;
}
.del_button{
background-image:url('images/Math-minus-icon.png');background-repeat: no-repeat;background-color: transparent;background-position: 0px 0px;background-size:15px;
}
</style>
<SCRIPT type="text/javascript">
var obj = document.getElementById("form1");
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
	  //alert("hi1");
	  //changes
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
	//changes	 
		 
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
    <%}}%>
    
}
///////////
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
	 obj.drop2.disabled=false;
	 makeRequest3();
} 


function makeRequest3() {  
	var xmlHttpRequest = getXMLHttpRequestA();
    xmlHttpRequest.onreadystatechange = getReadyStateHandler1(xmlHttpRequest,"drop2");
    var e=document.getElementById("drop1");
    var f=document.getElementById("drop0");
    var system=e.value; 
    var appId=f.value; 
    var url="GetSubSystemTokensAction.action?appId="+appId+"&system="+system; 
    xmlHttpRequest.open("GET", url , true);  
    xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest.send(null);
}

function getReadyStateHandler1(xmlHttpRequest,drop)
{ 
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4) 
			  {      if (xmlHttpRequest.status == 200)
				   {       
				  document.getElementById(drop).options.length=1;
				      var temp=[];
				     temp=(xmlHttpRequest.responseText).split(',');
				
				  
				     if(temp.length==1)
				      {
				    	 document.getElementById(drop).disabled=true;
				    	 
				      }
				     else
				    	 {
				    	 
				    	 
				     for(var i=0; i<temp.length-1; i++) {
				    	 if(temp[i]!=null)
				    		 {
				    		 
				    		 
				    	 var opt=document.createElement('option');
				    	 opt.text=temp[i];
				    	
				    	 opt.value=temp[i];
				    	
				    	 document.getElementById(drop).options.add(opt);
				    		 }
				    		 }
				     var lastOpt=document.createElement('option');
                     lastOpt.text="Create new Operation";
                     lastOpt.value="Create new Operation";
                     document.getElementById(drop).options.add(lastOpt);
				    
				    	 }		    	
				    
				      
		   } else {  
	      alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText); 
     } 
	   }
		     };
		     


			 }



///////////////////
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


//////////
function showServiceDetails()
{
	  var f=document.getElementById("drop1");
	   
	 var serviceName=f.options[f.selectedIndex].text; 
	 var g=document.getElementById("drop2"); 
	 var operName = g.options[g.selectedIndex].text; 
	 if(operName=="Create new Operation")
		 {
		var h=document.getElementById("toolTip");  
		h.style.display = "block";
		 document.getElementById('newOperFlagToAction').value = true;
		 }
	 else{
		 document.getElementById('newOperFlagToAction').value = false;
		 makeRequest2();
	 } 
}


function makeRequest2()
{
	
	var e=document.getElementById("drop0");
	  var appId=e.value;
	 
	var f=document.getElementById("drop1");
	  var serviceName=f.value;
	  
	 
	  
	     var xmlHttpRequest = getXMLHttpRequestA();
	    obj.action='ShowExistingServiceDetailsAction.action';
	    	obj.submit();	   
	  
	}





//////////////
function getReadyStateHandler(xmlHttpRequest,drop)
{ 
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4) 
			  {      if (xmlHttpRequest.status == 200)
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

////////////

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
 
 function getOperation(field){
	 document.getElementById("oprType2").checked="checked";
	 document.getElementById("tdID").style.display="none";
	 ajaxEditFunctionCall(field);
 }
 

 var xmlHttp;
 function ajaxEditFunctionCall(field){

     var URL = "ajaxAction.action?filePath="+field+"&fileCont="+$form.find( "input[id='form1_serviceInfo_file']" );
     try{
         xmlHttp=new XMLHttpRequest();
     }catch (e){
         try{
             xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
         }catch (e){
             try{
                 xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
             }catch (e){
                 alert("Your browser does not support AJAX!");
                 return false;
             }
         }
     }
     xmlHttp.onreadystatechange = showMessage;
     xmlHttp.open("GET", URL, true);
     xmlHttp.send(null);
 }

 var elements=[];
 var values=[];
 
 
 var allElements = "test";
 var valEle = [];
 
 function showMessage() {
     if(xmlHttp.readyState==4)
     {
         document.getElementById('dropOpr').options.length=1;

	      var elementsNvalue=[];
	      elementsNvalue = (xmlHttp.responseText).split('#1#');
	      values=(elementsNvalue[0]).split('#');
	      elements=(elementsNvalue[1]).split('#');
	    
	     for(var i=0; i<values.length; i++) {
	    	 var opt=document.createElement('option');
	    	 if(values[i]!=''){
		    	 opt.text=values[i];	    	
		    	 opt.value=values[i];	    	
		    	 document.getElementById('dropOpr').options.add(opt);
		    	 document.getElementById('dropOpr').options[i+1].style.color='blue';
	    	 }
	    	 //document.getElementById('dropOpr').options[document.getElementById('dropOpr').options.length].style.color='blue';
	    }
	     for(var i=0; i<elements.length; i++) {
	    	 var opt=document.createElement('option');
	    	 if(elements[i]!=''){
		    	 opt.text=elements[i];	    	
		    	 opt.value=elements[i];	    	
		    	 document.getElementById('dropOpr').options.add(opt);
	    	 }
	    }
	     document.getElementById('dropOpr').disabled=false;
     }
 }  
 
 function populateGeneratedKeys(field){
	 if(field=='1'){
		 document.getElementById("tdID").style.display="block";
	 }else{
		 document.getElementById("tdID").style.display="none";
	 }
	 var ele = splitUnique(allElements);
	 values = ele;
	 
	 
     if(document.getElementById("oprType2").checked){
         document.getElementById("dropOpr").options.length = 1;
         
         for(var i =1;i<=values.length;i++){
        	 if(values[i-1]!=''){
	             document.getElementById("dropOpr").options[i] = new Option(values[i-1],values[i-1]);
	             if(valEle.indexOf(values[i-1])<0)
	        	 document.getElementById("dropOpr").options[i].style.color='blue';
        	 }
         }
        /*  for(var j =i;j<i+elements.length;j++){
        	 if(elements[j-i]!='')
             document.getElementById("dropOpr").options[j] = new Option(elements[j-i],elements[j-i]);
         } */
         
     }
     if(document.getElementById("oprType1").checked){
         document.getElementById("dropOpr").options.length = 1;
         for(var i =1;i<=valEle.length;i++){
        	 if(valEle[i-1]!='')
             document.getElementById("dropOpr").options[i] = new Option(valEle[i-1],valEle[i-1]);
         }
     }
 }
 
 function isDuplicateValue(field1,field2){
	 if(optionExists(field1.value,field2)){
		 alert("Value already exists!!");
		 field1.focus();
	 }
 }
 
 function optionExists(val,field2) {
	  return $("#"+field2+" option[value='" + val + "']").length !== 0;
	}
</SCRIPT>
</head>
<body onload="createSelectElements()" >
<div class="ui-widget ui-widget-content ui-corner-all">
<s:form action="AddServiceFileInput.action" method="post" id="form1" name="form1" enctype="multipart/form-data">

<%-- <s:property value="#session.UserName" /> --%>

<table align="center">
	<tr>
		<td colspan=2><h3 align="center"><b>ADD SERVICE</b></h3></td>
		<td></td>
	</tr>
	<tr>
		<td>
			<s:select key="serviceInfo.applicationId" list="{'Select from below'}" id="drop0" disabled="true" label="APP-ID" onchange="getSystemSelectOptions()"></s:select>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>
			<label id="appIdLabel">New App Id : </label>
		</td>
		<td>
			<input type="text" name="appId" id="appId" onchange="isDuplicateValue(this,'drop0');"></input>
		</td>
		<td></td>
	</tr>
		<%-- <tr><td><s:textfield key="serviceInfo.applicationId" label="Application Id"></s:textfield></td></tr> --%>
		<%-- <tr><td><s:textfield  key="serviceInfo.applicationId" id="applicationId" label="NEW APP-ID" disabled="true"></s:textfield></td></tr> --%>
	<tr>
		<td>
			<s:select key="serviceInfo.serviceName" list="{'Select from below'}" id="drop1" disabled="true" label="Service Name" onchange="getSubSystemSelectOptions()"></s:select>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>
			<label id="serviceNameLabel">New Service Name : </label>
		</td>
		<td>
			<input type="text" name="serviceName" id="serviceName" onchange="isDuplicateValue(this,'drop1');"></input>
		</td>
		<td></td>
	</tr>
	<tr>
		<td>
			<s:select key="serviceInfo.operName" list="{'Select from below'}" id="drop2" disabled="true" label="Operation Name" onchange="showServiceDetails()"></s:select>
		</td>
		<td></td>
	</tr>
	<tr>
		<td></td>
		<td>
			<label id="toolTip" style="display:none;font-style: italic;" >Please select the following fields and Submit to select the New Operation name</label>
		</td>
		<td></td>
	</tr>
		<!-- <tr><td ><label id="operNameLabel">New Operation Name : </label></td><td><input type="text" name="operName" id="operName"></input></td></tr> -->
		<%-- <tr><td><s:textfield key="serviceInfo.serviceName" id="serviceName" label="New Service Name" disabled="true"></s:textfield></td></tr> --%>
		<%-- <tr><td><s:textfield key="serviceInfo.serviceName" label="Service Name"></s:textfield></td></tr> --%>
	<tr>
		<td><div id="abc"></div></td>
		<td><td>
		<td></td>
	</tr>
	<tr>
		<td><div  id="serviceDetails01"></div></td>
		<td width="70%"><div  id="serviceDetails02"></div></td>
		<td></td>
	</tr>
	<tr>
		<td><div  id="serviceDetails3"></div></td>
		<td width="70%"><div  id="serviceDetails4"></div></td>
		<td></td>
	</tr>
	<tr>
		<td><div id="serviceDetails1"></div></td>
		<td width="70%"><div  id="serviceDetails2"></div></td>
		<td></td>
	</tr>	
	<tr>
		<td class="tdLabel"><label for="serviceComplexity" class="label">Service Type:</label></td>
		<td>
			<div id="type" >
				<div style="float: left;"><input type="radio" onchange="populateFields('bus');" name="serviceInfo.serviceType" id="serviceTypeBusService" value="BusService" class="radio" class="radio" checked="checked"/></div><span style="float: left;"><label for="serviceTypeBusService">Bus Service</label></span>
				<div style="float: left;"><input type="radio" onchange="populateFields('web');" name="serviceInfo.serviceType" id="serviceTypeWebService" value="WebService" class="radio" class="radio"/></div><span style="float: left;"><label for="serviceTypeWebService">Web Service</label></span>
				<div style="float: left;"><input type="radio" onchange="populateFields('http');" name="serviceInfo.serviceType" id="serviceTypeHttpService" value="HttpService" class="radio" class="radio"/></div><span style="float: left;"><label for="serviceTypeHttpService">Http Service</label></span>
			</div>
		</td>
		<td></td>
	</tr>
	<tr></tr>
	<tr id="trID11">
		<td class="tdLabel"><label for="serviceComplexity" class="label">Service Complexity:</label></td>
		<td>
			<div id="type">
				<div style="float: left;"><input type="radio" name="serviceComplexity" id="serviceComplexitySimple" value="Simple" checked="checked"/></div><span style="float: left;"><label for="serviceComplexitySimple">Simple</label></span>
				<div style="float: left;"><input type="radio" name="serviceComplexity" id="serviceComplexityComplex" value="Complex"/></div><span style="float: left;"><label for="serviceComplexityComplex">Complex</label></span>
			</div>
		</td>
		<td></td>
	</tr>
	<tr id="trID12">
		<td class="tdLabel"><label for="form1_serviceInfo_file" class="label">Upload XML or XSD file:</label></td>
   	 	<td><input type="file" name="serviceInfo.file" value="" id="form1_serviceInfo_file" onchange="readFile(this.value);"/></td>
		<td></td>
	</tr>
	<tr id="trID14">
		<td class="tdLabel"><label for="serviceComplexity" class="label">Operation Type:</label></td>
		<td>
			<div id="type" >
				<div style="float: left;"><input type="radio" name="oprType" id="oprType1" value="byValue" onchange="populateGeneratedKeys('1');"/></div><span style="float: left;">By Value</span>
		        <div style="float: left;"><input type="radio" name="oprType" id="oprType2" checked="checked" value="byElement" onchange="populateGeneratedKeys('2');"/></div><span style="float: left;">By Element</span>			
			</div>
		</td>
		<td></td>
	</tr>
	<tr id="trID13">
		<td class="tdLabel"><label for="dropOpr" class="label">Select Operation:</label></td>
    	<td>
    		<select name="operationName" disabled="disabled" id="dropOpr"  onchange="isDuplicateValue(this,'drop2');">
    			<option value="Select from below">Select from below</option>
			</select>
		</td>

		<td>
		</td>
		<td> 
		</td>
	</tr>
	<tr style="display: none;" id="tdID">
		<td class="tdLabel"><label for="serviceComplexity" class="label">Operation Value:</label></td>
		<td>
			<div id="type" >
				<input type="text" name="oprVal" value=""/>			
			</div>
		</td>
		<td></td>
	</tr>
	<tr style="display: none;" id="tdServiceTypeID">
		<td class="tdLabel"><label for="serviceComplexity" class="label">Request Type:</label></td>
		<td>
			<div id="type" >
				<div style="float: left;"><input type="radio" name="serType" id="serType1" checked="checked" onchange="populateParamList('get');"/></div><span style="float: left;">GET</span>
		        <div style="float: left;"><input type="radio" name="serType" id="serType2" onchange="populateParamList('post');"/></div><span style="float: left;">POST</span>			
			</div>
		</td>
		<td></td>
	</tr>
	<tr style="display: none;" id="tdFormatTypeID">
		<td class="tdLabel"><label for="serviceComplexity" class="label">Content Type:</label></td>
		<td><input type="checkbox" name="contentType" id="contentType" ></td><td>JSON</td>
		
	</tr>
	<tr style="display: none;" id="tdServiceURLID">
		<td class="tdLabel"><label for="serviceComplexity" class="label">Service URL:</label></td>
		<td>
			<div id="type" >
				<input type="text" name="serviceURL" id="serviceURL" value="" size="50"/>			
			</div>
		</td>
		<td></td>
	</tr>
	<tr style="display: none;" id="trParamListID">
	<td class="tdLabel"><label for="serviceComplexity" class="label">Parameter List:</label></td>
		<td colspan="4">
			<table border="0" style="background-color: white;border-color: green;" id="mainTable">
				<tr>
					<th></th>
					<th>Parameter Name</th>
					<th>Parameter Value</th>
					<th>
						<input type="button" name="addRows" value="" alt="Add Row" class="add_button" onclick="addRow('mainTable');"/>
					</th>
				</tr>
				<tr>
					<td><input type="checkbox" name="selRow"></td>
					<td><input type="text" name="paramName" id="paramName" value=""></td>
					<td><input type="text" name="paramValue" id="paramValue" value=""></td>
					<td><input type="button" disabled="disabled" name="delRow" class="del_button" value=""></td>
				</tr>
			</table>
		</td>
	</tr>
		<tr><td colspan="1" align="right"><input type="checkbox" value="checkForCapture" onchange="showDataSourceField()" ></td><td>Integerate with capture util</td></tr>
	<tr id="dataSourceRow" style="display: none"><td><label>Data Source </label></td><td><input type="text" id="dataSource" name="dataSource"></input></td> </tr>
	<tr>
		
		<td align="center"> 
			<input type="button" name="submitForm" value="Submit" onclick="validateForm();"/>
		</td>
	</tr>
</table>
	<s:hidden id="newOperFlagToAction" value="" key="newOperFlagToAction"/>
</s:form>
</div>
</body>
<script type="text/javascript">
var formObj = document.getElementById("form1");
function validateForm(){

	var dataSource = document.getElementById("dataSource").value;
	//alert(dataSource);
	
	
	if(document.getElementById("dropOpr").value=="Select from below" && (document.getElementById("serviceTypeBusService").checked || document.getElementById("serviceTypeWebService").checked)){
		alert("Please select operation.");
		document.getElementById("dropOpr").focus();
		return false;
	}
	var params = "?";
	if(document.getElementById("serviceTypeHttpService").checked){
		//alert(document.getElementById("mainTable").innerHTML);
		//alert(totalRowCount);
		if(document.getElementById("serType2").checked){
				
			for(var i = 0; i<=totalRowCount; i++){
				if(i==0){
					params = params+document.getElementById("paramName").value;
					params = params+"="+document.getElementById("paramValue").value;
				}else{
					if(document.getElementById("paramName"+i)){
						params = params+"&"+ document.getElementById("paramName"+i).value;
						params = params+"="+document.getElementById("paramValue"+i).value;
					}
				}
			}
			
		}
	document.getElementById("serviceURL").value = document.getElementById("serviceURL").value+params;
	}
	//alert(params);
	formObj.submit();
}
function populateFields(field){
	 if(field=='web' || field=='bus'){
		 document.getElementById('trID11').style.display='block';
		 document.getElementById('trID12').style.display='block';
		 document.getElementById('trID13').style.display='block';
		 document.getElementById('trID14').style.display='block';
		 //document.getElementById('tdID').style.display='block';
		 document.getElementById('tdServiceURLID').style.display='none';
		 document.getElementById('tdServiceTypeID').style.display='none';
		 //document.getElementById('tdFormatTypeID').style.display='none';
		 document.getElementById('trParamListID').style.display='none';
		 
	 }else if(field=='http'){
		 document.getElementById('tdServiceURLID').style.display='block';
		 document.getElementById('tdServiceTypeID').style.display='block';
		 document.getElementById('trID11').style.display='none';
		 document.getElementById('trID12').style.display='none';
		 document.getElementById('trID13').style.display='none';
		 document.getElementById('trID14').style.display='none';
		 document.getElementById('tdID').style.display='none';
		 document.getElementById("oprType2").checked="checked";
		 document.getElementById('tdFormatTypeID').style.display='block';
	 }
}
function populateParamList(field){
	if(field=='get'){
		document.getElementById('trParamListID').style.display='none';
		
	}else if(field=='post'){
		document.getElementById('trParamListID').style.display='block';
	}
	
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
        	if(i==1){
        		newcell.childNodes[0].id="paramName"+totalRowCount;
        	}if(i==2){
        		newcell.childNodes[0].id="paramValue"+totalRowCount;
        	}
        }
        //alert(newcell.childNodes[0].type);
    }
	//alert("Rows :"+rowCount+" Columns :"+colCount);
}
function removeRow(src,tableID) {

    var oRow = src.parentElement.parentElement;
    document.getElementById(tableID).deleteRow(oRow.rowIndex);
    
}



function readFile(field){
	allElements = "test";
	valEle.length=0;
	field = field.replace(/\\/g,'\\');
	//alert(field);
	var fso, s,allXML="";
    fso = new ActiveXObject("Scripting.FileSystemObject");
    s = fso.OpenTextFile(field , 1, 1, -2);
    while (!s.AtEndOfStream) {
        var r = s.ReadLine();
        allXML = allXML+r;
        //alert(r);
    }
	s.close();
    allXML = allXML.replace( /<!\[CDATA\[/g, '' );
    allXML = allXML.replace( /\]\]>/g, '' );
    //alert(allXML.substring(1, 500));
   // alert(allXML.substring(allXML.length-200, allXML.length));
	parser=new DOMParser();
	xmlDoc=parser.parseFromString(allXML,"text/xml");
	
	var docEle = xmlDoc.documentElement;
	allElements = allElements +"#" +docEle.nodeName;
	getelements(docEle);
	allElements.replace(/\#text/g,'');
	do{
		allElements = allElements.replace(/\#\#/g,'#');
	}while(allElements.indexOf("##")!=-1);
	//alert(allElements);
	var eleList = splitUnique(allElements);
	//getLeafNodes(docEle);
	document.getElementById("dropOpr").options.length = 1;
    for(var i =1;i<=eleList.length;i++){
            document.getElementById("dropOpr").options[i] = new Option(eleList[i-1],eleList[i-1]);
            if(valEle.indexOf(eleList[i-1])<0){
            	document.getElementById("dropOpr").options[i].style.color='blue';
            }
    }
    document.getElementById('dropOpr').disabled=false;
    //alert(valEle);
    //alert(valEle.length);
	//alert(allElements);
	/* var chNodes = docEle.childNodes;
	var i=0;
	while(chNodes[i]){
		alert(chNodes[i].nodeName);
		i++;
	} */
}
function splitUnique(ele){
	var strele = ele.split('#');
	var eleList = [];
	for(var j=0;j<strele.length;j++){
		if(eleList.indexOf(strele[j])<0 && strele[j]!="test"){
			eleList.push(strele[j]);
			//document.write(strele[j]+"<br>")
		}
	}
	//alert(eleList);
	return eleList;//alert(eleList.length);
}
function getelements(docEle){
	
	var chNodes = docEle.childNodes;
	//alert(chNodes);
	for(var i=0; i<chNodes.length;i++){
		if(chNodes[i].childNodes.length>0){
			getelements(chNodes[i]);
			//alert("here");
			//alert("child element lenght>0 "+chNodes[i].nodeName);
		}
		if(chNodes[i].childNodes.length==0 && chNodes[i].parentNode.childNodes.length==1){
			
			//alert("child element lenght=0 "+chNodes[i].parentNode.nodeName);
			if(valEle.indexOf(chNodes[i].nodeName)<0){
				valEle.push(chNodes[i].parentNode.nodeName);
				//alert("child lenght zero --"+ chNodes[i].textContent +"--"+chNodes[i].nodeName);
				//alert(chNodes[i].textContent);
			}
		}
		allElements = allElements+"#"+chNodes[i].nodeName;
	}
}

function getLeafNodes(docEle){
	//alert("here");
   // var leaf = docEle.selectNodes
/* var leafList = docEle.SelectNodes("//*[not(child::*)]"); */
	//alert(leafList[0].nodeName);
}

function showDataSourceField() {
	var field = document.getElementById("dataSourceRow");
	if(field.style.display === "none")
	field.style.display = 'block';
	else
		field.style.display='none';
}

</script>
</html>