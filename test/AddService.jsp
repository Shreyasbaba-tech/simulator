<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Service</title>
<script language=javascript type='text/javascript'>   

function validation(){
	
	var sname=document.getElementById('serviceName').value;
	var reqXml=document.getElementById('requestXml').value;
	var xpath=document.getElementById('xpath').value;
    var reqPara=document.getElementById('requestParameter').value;
    var subSys=document.getElementById('actionFilePath').value;
    var sys=document.getElementById('simulatorFilePath').value;

    var reqParaSplit= reqPara.split("#");

      

	if(sname==""){
alert("pls enter SERVICE NAME");
return false;
		}

	if(reqXml==""){
		alert("pls enter Request Xml file contents");
		return false;
				}


	if(reqPara==""){
		alert("pls enter REQUEST PARAMETER");
		return false;
				}

	 for( var i = 0; i < reqParaSplit.length; i++){
		 if(!chkXpath(reqParaSplit[i]))
		 {
		 	alert("pls enter valid Xpath for request parameter or enter the xpath's separated -->"+reqParaSplit[i]);
		 	return false;
		 }
	    }
	    
	if(xpath==""){
		alert("pls enter Xpath");
		return false;
				}
	
if(!chkXpath(xpath))
{
	alert("pls enter valid Action Xpath");
	return false;
}
	
	if(subSys=="")
	{
     alert("pls Enter Subsystem");
     return false;
	}

	if(sys==""){
		alert("pls Enter system");
	     return false;
	}
	return true;
}


/* function chkXpath(xpath)
{
	var xmlContent=document.getElementById("requestXml").value;

	if (window.DOMParser)
	  {
	  parser=new DOMParser();
	  xmlDoc=parser.parseFromString(xmlContent,"text/xml");
	  }
	else // Internet Explorer
	  {
	  xmlDoc=new ActiveXObject("Microsoft.XMLDOM");
	  xmlDoc.async=false;
	  xmlDoc.loadXML(xmlContent); 
	  } 
	

	 if(xmlDoc == null){
         alert("XML HTTP object is null");
         return;
     }
    
    
     var xmlNoadList1;
     if(window.ActiveXObject){
       //  alert("inside IE");
         xmlNoadList1 = xmlDoc.selectNodes(xpath);
        
        if(xmlNoadList1.length>0){
         //alert("valid xpath"); 
            return true;
         }
        else{
       //  alert("invalid xpath");
         return false;
        }

     }
	
	
	
} */


function EnableTextbox(ObjChkId,ObjTxtId)
{

    if(document.getElementById(ObjChkId).checked)
        document.getElementById(ObjTxtId).disabled = false;
    
    else
        document.getElementById(ObjTxtId).disabled = true;
}



function displayTextBox()
{
	
	var ele=document.getElementById("dynamicTextBox");
    var list=ele.childNodes;
	if(!ele.hasChildNodes())
		{
	var ele2=document.createElement("input");

	ele2.setAttribute("label", "Action Xpath : ");
	ele2.setAttribute("id","xPath");
	ele2.tagName="xPath";
	
	//document.getElementById("xpath")
	
	//alert(document.getElementById("xpath").getAttribute("id"));
	
	//document.body.appendChild(ele2);
	ele.appendChild(ele2);
		}
	else
		{
		
		var ele2=ele.firstChild;
		ele.removeChild(ele2);
		}
}

function checkAvailability()
{
 var e=document.getElementById("serviceName");
 //alert(e.value);
 makeRequest();

}
function makeRequest() {  
	var xmlHttpRequest = getXMLHttpRequest();
    xmlHttpRequest.onreadystatechange = getReadyStateHandler(xmlHttpRequest);
    var e=document.getElementById("serviceName");
    var serviceName=e.value;
    //alert(e.value);
    var url="CheckAvailabilityAction.action?serviceName="+serviceName; 
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

function getReadyStateHandler(xmlHttpRequest)
{ 
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4) 
			  {      if (xmlHttpRequest.status == 200)
				   {       

				  var present=xmlHttpRequest.responseText;
				 //alert(present);
				
				      if(present =="true")

				    	  {
				    	  //var e=document.getElementById("warningLabel");
				    	    alert("The SERVICE NAME is already present !! ");
				    	    
				    	    //e.disabled=false;
				    	   // e.value="The SERVICE NAME is already present !!";
				    	   
				    	  }
				     
		
							    	
				    
				      
		   } else {  
	      alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText); 
     } 
	   }
		     };
		     


			 }
</script>
</head>
<body>

<form action="AddServiceAction.action" onsubmit="return validation();">
<center>ADD SERVICE</center>


<table align="center">

<tR><td><s:select label="Service Type" list="{'WEB SERVICE','BUS SERVICE','HTTP SERVICE'}" key="serviceInfo.serviceType" width="12"></s:select></td></tR>

  <tR><td> <s:textfield label="Service Name"  key="serviceInfo.serviceName" id="serviceName" size="65" onchange="checkAvailability()" /> </td></tR>         
          <tR><td><s:label id="warningLabel" ></s:label> </td></tR>      
<tr><td><s:textarea label="Sample Request XML" key="serviceInfo.requestXML" id="requestXml" rows="5" cols="50"/>  </td></tr>            
   <tr><td><s:textfield label="Request paramater separated by #" id="requestParameter" key="serviceInfo.requestParams"  size="65"/></td></tr>    
                  
 <tr><tD><s:textfield label="Action Xpath" key="serviceInfo.actionXPath"  id="xpath" size="65"/> </tD></tr>               
<tr><td></td><td><div class="errors"><s:fielderror/></div></td></tr>	
 
		<tr><td><font color="blue">Please select check box if action XPath value check required</font></td></tr>
		<tr><td><s:checkbox label="Is XPath Check" id="checked" key="serviceInfo.isXPathCheck" onchange="displayTextBox()"/></td></tr>		
	 
	 	<tr><td><label id="xpathlabel"></label><td><div id="dynamicTextBox"></div></td></tr>						 
 		
			
	<tr><td><s:textfield label="Action File Path (SubSystem)" key="serviceInfo.subSystemName"/></td></tr>
	<tr><td><s:textfield label="Simulator File Path (System)" key="serviceInfo.systemName"/></td></tr>
      
		
					
		<tr><td><s:submit/></td></tr>	
      
    </table>
    <br></br>	

  </form>

</body>
</html>