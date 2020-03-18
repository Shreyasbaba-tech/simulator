<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="myBean2" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>

<!-- soumya start  -->
<%
String cuid=(String)session.getAttribute("UserName");
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

String[] list1 = myBean2.getAppIds(pro.getProperty("ResponeFilePath"));

String users=pro.getProperty("virApp.users");
String admins=pro.getProperty("virApp.admin");

%>
<!-- soumya end  -->

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<SCRIPT type="text/javascript">
var obj = document.getElementById("addResponseForm");

function createSelectElements( )
{
	 obj = document.getElementById("addResponseForm");
	  obj.appId.disabled=false;
	 
	 <%
	 
	 if(admins.contains(cuid))
	 {
		 for(int i=0;i<list1.length;i++)
		  {
	 %>
		 var opt=document.createElement('option');
		 opt.text='<%=list1[i]%>';
	     opt.value='<%=list1[i]%>'; 
	     document.getElementById("appId").options.add(opt);
		<%  } %>
		var lastOpt=document.createElement('option');
	    lastOpt.text="Create new application";
	    lastOpt.value="Create new application";
	    document.getElementById("appId").options.add(lastOpt);
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
       document.getElementById("appId").options.add(opt);
    <%} } } } }%> 
    

}

function getSystemSelectOptions() {
	//alert("yo");
	//obj = document.getElementById("addResponseForm");
	 obj.system.disabled=false;
	
	 makeRequest2();
}

function showExistingResponses() {
	 obj.key.disabled=false;
		
	 makeRequest3();
	
}

function addOrEditSelection(){
	
	 var responseKey=document.getElementById("key").value;
	 //alert(responseKey);
	 if(responseKey=="Add New Response")
		 {
		 obj.action='ShowAddNewResponsePageAction.action';
	     obj.submit();	
		 }
	 else
		 {
		 obj.action='ShowEditResponsePageAction.action';
		 obj.submit();
		 }
}


function makeRequest3() {  
	
	var xmlHttpRequest3 = getXMLHttpRequest();
    xmlHttpRequest3.onreadystatechange = getReadyStateHandler1(xmlHttpRequest3,"key");
    var appId=document.getElementById("appId").value; 
    var system=document.getElementById("system").value;
    var subSystem=document.getElementById("subSystem").value;
    var url="GetResponseFileTokensAction.action?appId="+appId+"&system="+system+"&subSystem="+subSystem;  
   // alert(url);
    xmlHttpRequest3.open("GET", url , true);  
    xmlHttpRequest3.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest3.send(null);
}

function makeRequest2() {  
	
	var xmlHttpRequest2 = getXMLHttpRequest();
    xmlHttpRequest2.onreadystatechange = getReadyStateHandler(xmlHttpRequest2,"system");
    var appId=document.getElementById("appId").value; 
    var url="GetSystemTokensAction.action?appId="+appId; 
   // alert(url);
    xmlHttpRequest2.open("GET", url , true);  
    xmlHttpRequest2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest2.send(null);
}

function getSubSystemSelectOptions() {
	obj = document.getElementById("addResponseForm");
	 obj.subSystem.disabled=false;
	//  document.form1.drop2.options.length=0;
	  makeRequest();
} 


function makeRequest() {  
	var xmlHttpRequest = getXMLHttpRequest();
    xmlHttpRequest.onreadystatechange = getReadyStateHandler(xmlHttpRequest,"subSystem");
    var system=document.getElementById("system").value; 
    var appId=document.getElementById("appId").value; 
    var url="GetSubSystemTokensAction.action?appId="+appId+"&system="+system; 
    //alert(url);
    xmlHttpRequest.open("GET", url , true);  
    xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest.send(null);
}


function getXMLHttpRequest()
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
			  {      if (xmlHttpRequest.status == 200)
				   {       

				  // alert("in return function + "+xmlHttpRequest.responseText);
				 
				      document.getElementById(drop).options.length=1;
				      var temp=[];
				      
				     temp=(xmlHttpRequest.responseText).split(',');
				     //alert(temp);
				     if(temp.length==1)
				      {
				    	  document.getElementById(drop).disabled=true;
				    	  //alert("no elements");
				    	 // document.getElementById('drop3').disabled=false;
				    	//  makeRequest(document.getElementById('system').options[document.getElementById('system').selectedIndex].text);
				      }
				     for(var i=0; i<temp.length; i++) {
				    	 if(!(temp[i]==null || trim(temp[i])=='')){
				    	 var opt=document.createElement('option');
				    	 opt.text=temp[i];
				    	
				    	 opt.value=temp[i];
				    	
				    	 document.getElementById(drop).options.add(opt);
				    	}
				     }
							    	
				    
				      
		   } else {  
	       
     } 
	   }
		     };
		     


			 }
			 
function getReadyStateHandler1(xmlHttpRequest,drop)
{ 
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4) 
			  {      if (xmlHttpRequest.status == 200)
				   {       

				  // alert("in return function + "+xmlHttpRequest.responseText);
				 
				      document.getElementById(drop).options.length=1;
				      var temp=[];
				      
				     temp=(xmlHttpRequest.responseText).split(',');
				    // alert(temp);
				    /*  if(temp.length==0)
				      {
				    	  document.getElementById(drop).disabled=true;
				    	  //alert("no elements");
				    	 // document.getElementById('drop3').disabled=false;
				    	//  makeRequest(document.getElementById('system').options[document.getElementById('system').selectedIndex].text);
				      } */
				     var j=0;
				     for(var i=0; i<temp.length; i++) {
				    	 if(!(temp[i]==null || trim(temp[i])=='')){
				    	 var opt=document.createElement('option');
				    	 opt.text=temp[i];
				    	
				    	 opt.value=temp[i];
				    	
				    	 document.getElementById(drop).options.add(opt);
				    	 j=i;
				    	 }
				    	}
				     var opt=document.createElement('option');
			    	 opt.text="Add New Response";
			    	
			    	 opt.value="Add New Response";
			    	
			    	 document.getElementById(drop).options.add(opt);
							    	
				    
				      
		   } else {  
	       
     } 
	   }
		     };
		     


			 }			 


function trim(someText){
	return someText.replace(/(\r\n|\n|\r)/gm,"");
}





</SCRIPT>
</head>
<body onload="createSelectElements()">
<div class="ui-widget ui-widget-content ui-corner-all">
<s:form action="AddResponseAction.action" id="addResponseForm" name="addResponseForm" method="post" enctype="multipart/form-data">
<table align="center">
<%-- <tr><td><s:textfield label="Response identifier" key="responseInfo.key" id="key"></s:textfield></td></tr> --%>
<h3 align="center"><b>
ADD/EDIT RESPONSE
</b></h3>
<tr><td colspan="2">&nbsp;</td></tr>
	<tr>
		<td align="right">
			<label id="serviceNameLabel">Application Id : </label>
		</td>
		<td>
			<select id="appId" name="responseInfo.appId" disabled="disabled" onchange="getSystemSelectOptions()">
				<option value="">Select from below</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">
			<label id="serviceNameLabel">Service Name : </label>
		</td>
		<td>
			<select id="system" name="responseInfo.system" disabled="disabled" onchange="getSubSystemSelectOptions()">
				<option value="">Select from below</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">
			<label id="serviceNameLabel">Operation Name : </label>
		</td>
		<td>
			<select id="subSystem" name="responseInfo.subSystem" disabled="disabled" onchange="showExistingResponses()">
				<option value="">Select from below</option>
			</select>
		</td>
	</tr>
	<tr>
		<td align="right">
			<label id="serviceNameLabel">Response Identifier : </label>
		</td>
		<td>
			<select id="key" name="responseInfo.key" disabled="disabled" onchange="addOrEditSelection()">
				<option value="">Select from below</option>
			</select>
		</td>
	</tr>
<%--<tr><td><s:select label="Application Id "  id="appId" key="responseInfo.appId" list="{'Select from below'}" disabled="true" onchange="getSystemSelectOptions()"></s:select>
<tr><td><s:select label="Service Name " id="system" key="responseInfo.system"  list="{'Select from below'}" disabled="true"  onchange="getSubSystemSelectOptions()" /></td></tr>
<tr><td><s:select label="Operation Name " id="subSystem" key="responseInfo.subSystem" list="{'Select from below'}" disabled="true" onchange="showExistingResponses()"/></td></tr>
<tr><td><s:select label="Response Identifier " id="key" key="responseInfo.key" list="{'Select from below'}" disabled="true" onchange="addOrEditSelection()" /></td></tr>
 <tr><td><s:textfield label="Search tags separated by #" id="searchTags" key="responseInfo.searchTags" size="65"/></td></tR>
<tr><td><s:textarea label="Description" key="responseInfo.desc" rows="6" cols="35"/></td></tr>
<tr><td><s:file label="Response file" id="sampleXml" key="responseInfo.sampleXml"/></td></tr> --%>
<tr><td colspan="2"></td></tr>
</table>

</s:form>
</div>
</body>
</html>