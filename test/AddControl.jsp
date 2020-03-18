<%@taglib uri="/struts-tags" prefix="s" %>
<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="myBean" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>
<%
RxContextPathDeploymentUtil util = new RxContextPathDeploymentUtil();
String path=util.getConfigItPath().replace("it", "VirtualConfig.properties");
Properties pro = new Properties();
try {
    FileInputStream f = new FileInputStream(path);
    pro.load(f);
} catch (Exception e) {
    
}

String[] list1 = myBean.getAppIds(pro.getProperty("ResponeFilePath"));
%>

<link href="style/style.css" rel="stylesheet" type="text/css"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<SCRIPT type="text/javascript">
  

function createSelectElementsA( )
{
	
	  document.form1.drop0.disabled=false;
	 // document.form1.drop1.options.length=0;
	 <% 
	  for(int i=0;i<list1.length;i++)
	  {
		%>
       var opt=document.createElement('option');            
      opt.text='<%=list1[i]%>';
       opt.value='<%=list1[i]%>'; 
       document.getElementById("drop0").options.add(opt);
    <%} %>  
   // alert(document.form1.drop1.options[document.form1.drop1.selectedIndex].value);    
}
////////////////////////////////////
function getSystemSelectOptions() {
	document.form1.drop1.disabled=false;

	makeRequest7A();
	
}

function makeRequest7A() {  
	var xmlHttpRequest8 = getXMLHttpRequestA();
	
    xmlHttpRequest8.onreadystatechange = getReadyStateHandlerA(xmlHttpRequest8,"drop1");
   
    var f=document.getElementById("drop0");
   
    var appId=f.options[f.selectedIndex].text; 
    var url="GetSystemTokensAction.action?appId="+appId; 
    //alert(url);
    xmlHttpRequest8.open("GET", url , true);  
    xmlHttpRequest8.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest8.send(null);
}


//////////
function getSubSystemSelectOptionsA() {
	 document.form1.drop2.disabled=false;
	//  document.form1.drop2.options.length=0;
	  makeRequestA();
} 

function makeRequestA() {  
	var xmlHttpRequest = getXMLHttpRequestA();
    xmlHttpRequest.onreadystatechange = getReadyStateHandlerA(xmlHttpRequest,"drop2");
    var e=document.getElementById("drop1");
    var f=document.getElementById("drop0");
    var system=e.options[e.selectedIndex].text; 
    var appId=f.options[f.selectedIndex].text; 
    var url="GetSubSystemTokensAction.action?appId="+appId+"&system="+system; 
    //alert(url);
    xmlHttpRequest.open("GET", url , true);  
    xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest.send(null);
}


/////////////////////


function getControlFileOptionsA(){
	 document.form1.drop3.disabled=false;
	 var e=document.getElementById('drop1');
	 var system=e.options[e.selectedIndex].text;
	// alert(system);
	 makeRequest2A(system);
	 //makeRequest2(system);
}





function makeRequest2A(system) {  
	var xmlHttpRequest2 = getXMLHttpRequestA();
    xmlHttpRequest2.onreadystatechange = getReadyStateHandlerA(xmlHttpRequest2,"drop3");
    var e=document.getElementById("drop2");
    var subSystem=e.options[e.selectedIndex].text; 
    var f=document.getElementById("drop0");
    var appId=f.options[f.selectedIndex].text; 
    var url="GetControlFileTokensAction.action?appId="+appId+"&system="+system+"&subSystem="+subSystem; 
   // alert(url);
    xmlHttpRequest2.open("GET", url , true);  
    xmlHttpRequest2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest2.send(null);
}

function makeRequest4A(system){
	//alert(system);
	var xmlHttpRequest4 = getXMLHttpRequestA();
    xmlHttpRequest4.onreadystatechange = getReadyStateHandlerA(xmlHttpRequest4,"drop3");
    var f=document.getElementById("drop0");
    var appId=f.options[f.selectedIndex].text; 
    var url="GetSystemResponsesAction.action?appId="+appId+"&system="+system;
    xmlHttpRequest4.open("GET", url , true);  
    xmlHttpRequest4.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest4.send(null);
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

function getReadyStateHandlerA(xmlHttpRequest,drop)
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
				     if(temp.length==1)
				      {
				    	
				    	  document.getElementById(drop).disabled=true;
				    	  //alert("no elements inside");
				    	  document.getElementById('drop3').disabled=false;
				    	  makeRequest4A(document.getElementById('drop1').options[document.getElementById('drop1').selectedIndex].text);
				      	
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
	      alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText); 
     } 
	   }
		     };
		     


			 }


function fillControlPathA() {
	var appId=document.getElementById('drop0').options[document.getElementById('drop0').selectedIndex].text;
	var system=document.getElementById('drop1').options[document.getElementById('drop1').selectedIndex].text;
	var controlFilePath="C:\\Responses\\"+appId+"\\"+system;
	var subSystem=document.getElementById('drop2').options[document.getElementById('drop2').selectedIndex].text;
	
	if(subSystem=="Select from below")
	{
		controlFilePath.slice(0, controlFilePath.lastIndexOf("\\"));
	}
	else{controlFilePath+="\\"+subSystem;}
	//alert(controlFilePath);
    var responseFile=document.getElementById('drop3').options[document.getElementById('drop3').selectedIndex].text;
    var responseName=getResponseName(responseFile);
    controlFilePath+="\\"+responseName+".ctrl";
  
    var e=document.getElementById('controlFilePath');
    
    e.value=controlFilePath;
   //alert(controlFilePath);
    makeRequest3A(controlFilePath);
    document.getElementById('content').disabled="true";
 }  


function getResponseName(responseFile) {
	var responseFileName=responseFile.replace(/\.vm/g,'');
	responseFileName=responseFileName.replace(/\.ctrl/g,'');
	return responseFileName;
}
function makeRequest3A(controlFilePath) {  
	var xmlHttpRequest = getXMLHttpRequestA();
    xmlHttpRequest.onreadystatechange = getReadyStateHandler3A(xmlHttpRequest);
  
    var url="DisplayControlFileContentAction.action?controlFilePath="+controlFilePath; 
   // alert("3="+url);
    xmlHttpRequest.open("GET", url , true);  
    xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest.send(null);
}



function getReadyStateHandler3A(xmlHttpRequest)
{ 
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4) 
			  {      if (xmlHttpRequest.status == 200)
				   {       
                      var contents=xmlHttpRequest.responseText;
                      contents=contents.replace(/##/,'<br />');
                    //  contents=contents.replace(/(\r\n|\n|\r)/gm, '<BR/>');
                  //  contents=contents.re
				//alert("in return function  + "+xmlHttpRequest.responseText);
				   var e=document.getElementById('content');
				   e.value=xmlHttpRequest.responseText;
				    
				      
		   } else {  
	      alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText); 
     } 
	   }
		     };  
 }

/////////////////////////////////////////
function addKeyValue() {
	makeRequest5();
}

function makeRequest5() {  
	
	var xmlHttpRequest5 = getXMLHttpRequestA();
	//alert("yo");
	 var value1=document.getElementById("value").value;
	  // alert(value1);  
	   var appId=document.getElementById('drop0').options[document.getElementById('drop0').selectedIndex].text;
	  
	   var system=document.getElementById('drop1').options[document.getElementById('drop1').selectedIndex].text;
	  //alert(system);
	    var subSystem=document.getElementById('drop2').options[document.getElementById('drop2').selectedIndex].text;
	  //alert(subSystem);
	    var controlFile=document.getElementById('drop3').options[document.getElementById('drop3').selectedIndex].text;
	 //alert(controlFile);
	    var key=document.getElementById('key1').options[document.getElementById('key1').selectedIndex].text;
	 //alert(key);
	    var flag="add";
	 // alert(flag);
	  var controlFilePath=document.getElementById("controlFilePath").value;
    //alert(controlFilePath);
    var content=document.getElementById("content").value;
    content=content.replace("/n","//");
    
    xmlHttpRequest5.onreadystatechange = getReadyStateHandler5(xmlHttpRequest5);
    var url="AddKeyValueAction.action?appId="+appId+"&system="+system+"&subSystem="+subSystem+"&controlFile="+controlFile+"&controlFilePath="+controlFilePath+"&content="+content+"&key="+key+"&value="+value1+"&flag="+flag; 
    //alert(url);
    xmlHttpRequest5.open("GET", url , true);  
    xmlHttpRequest5.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest5.send(null);
}


function getReadyStateHandler5(xmlHttpRequest)
{ 
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4) 
			  {      if (xmlHttpRequest.status == 200)
				   {       
           
				 //alert("in return function  + "+xmlHttpRequest.responseText);
				 var result= xmlHttpRequest.responseText;
				// result=result.replace(/##/g,'<br/>');
				 //alert(result);
				   var e=document.getElementById('content');
				   e.value=result;
				    
				      
		   } else {  
	      alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText); 
     } 
	   }
		     };  
 }
 
//////////////////////////
function editKeyValue()
{
	
	makeRequest6();
	}
	
function makeRequest6() {  
	var xmlHttpRequest6 = getXMLHttpRequestA();
   
	 var value1=document.getElementById("value").value;
	 //   alert(value1);
  var appId=document.getElementById('drop0').options[document.getElementById('drop0').selectedIndex].text; 
	   
  var system=document.getElementById('drop1').options[document.getElementById('drop1').selectedIndex].text;
	  //  alert(system);
	    var subSystem=document.getElementById('drop2').options[document.getElementById('drop2').selectedIndex].text;
	  //  alert(subSystem);
	    var controlFile=document.getElementById('drop3').options[document.getElementById('drop3').selectedIndex].text;
	   // alert(controlFile);
	    var key=document.getElementById('key1').options[document.getElementById('key1').selectedIndex].text;
	   // alert(key);
	    var flag="edit";
	  //  alert(flag);
	  var controlFilePath=document.getElementById("controlFilePath").value;
   // alert(controlFilePath);
    var content=document.getElementById("content").value;
  
    xmlHttpRequest6.onreadystatechange = getReadyStateHandler5(xmlHttpRequest6);
    var url="AddKeyValueAction.action?appId="+appId+"&system="+system+"&subSystem="+subSystem+"&controlFile="+controlFile+"&controlFilePath="+controlFilePath+"&content="+content+"&key="+key+"&value="+value1+"&flag="+flag; 
    //alert(url);
    xmlHttpRequest6.open("GET", url , true);  
    xmlHttpRequest6.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest6.send(null);
}
function trim(someText){
	return someText.replace(/(\r\n|\n|\r)/gm,"");
}

</SCRIPT>

</head>
<body onload="createSelectElementsA()">
<div class="ui-widget ui-widget-content ui-corner-all">
<s:form action="SubmitControlFileAction.action" name="form1" >

<table align="center">
<h3 align="center"><b>
Apply Resiliency Parameter
</b></h3>
<tr>
<TD><s:select   id="drop0" list="{'Select from below'}" disabled="true" label="ADD-ID" onchange="getSystemSelectOptions()" ></s:select></TD>
<TD><s:select   id="drop1" list="{'Select from below'}" disabled="true" label="SYSTEM" onchange="getSubSystemSelectOptionsA()" ></s:select></TD>
<TD><s:select  id="drop2" list="{'Select from below'}" disabled="true" label="SUB-SYSTEM" onchange="getControlFileOptionsA()"></s:select></TD>
<TD><s:select  id="drop3" list="{'Select from below'}" disabled="true" label="RESPONSE-FILE" onchange="fillControlPathA()"></s:select></TD>

</tr>

<s:hidden  name="controlFilePath" key="controlFilePath" id="controlFilePath" label="Control File Path"  ></s:hidden>



<tr><TD colspan="2"><s:textarea name="content" id="content" key="content" rows="10" label="CONTENTS" ></s:textarea></TD></tr>
<tr><td colspan="2"><s:label value="Add a new property"></s:label></td></tr>
<tr><td><s:select name="key1" id="key1" label="Select Key" list="{'TimeOut','latency','httpError'}"></s:select></td>
 <td><s:textfield name="value" id="value" label="Add Value"></s:textfield></td>
<td colspan="1"></td></tr>
<tr><td><button type="button" value="Add Key Value" name="Add Key Value"  class="button" onclick="addKeyValue()" >Add Key Value</button></td>  
<td><button type="button" value="Edit Key Value" name="Edit Key Value"  class="button" onclick="editKeyValue()">Edit Key Value</button></td>   </tr>
<tr><td><s:submit ></s:submit></td><td>  </td></tr>
</table>




</s:form >

</div>
</body>
</html>