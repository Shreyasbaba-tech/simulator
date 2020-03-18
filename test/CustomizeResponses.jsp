<%@page import="com.ctl.app.virtual.AddResponseInfo"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="myBean2" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>
<%
String[] list2 = myBean2.getAppIds("/C:/Responses/");
String contextPath = request.getContextPath();
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customize Responses</title>
<style type="text/css">

.shadowDiv{
 position:absolute;
 left: 0px;
 top: 0px;
 width: 100%;
 height: 100%;
 background-color: gray;
 filter:alpha(opacity=50);
 -moz-opacity:0.5;
 opacity: 0.5;
 display: none;
}

</style>
<SCRIPT type="text/javascript">
var currentResponseInfo = "";
var obj = document.getElementById("customizeResponsesForm");
function createSelectElements( )
{
    obj = document.getElementById("customizeResponsesForm");
      obj.appId.disabled=false;
     // document.form1.drop1.options.length=0;
     <% 
      for(int i=0;i<list2.length;i++)
      {//System.out.println("-->"+list2.length);
        %>
       var opt=document.createElement('option');            
      opt.text='<%=list2[i]%>';
       opt.value='<%=list2[i]%>'; 
       document.getElementById("appId").options.add(opt);
    <%} %>  
   // alert(document.form1.drop1.options[document.form1.drop1.selectedIndex].value);    
}

function getSystemSelectOptions() {
    //alert("yo");
    //obj = document.getElementById("addResponseForm");
     obj.system.disabled=false;
    
     makeRequest2();
}

function showExistingResponses() {
     obj.keyName.disabled=false;
        
     makeRequest3();
    
}



function makeRequest3() {  
    
    var xmlHttpRequest3 = getXMLHttpRequest();
    xmlHttpRequest3.onreadystatechange = getReadyStateHandler1(xmlHttpRequest3,"keyName");
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
    obj = document.getElementById("customizeResponsesForm");
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
                    // alert(temp);
                     if(temp.length==1)
                      {
                          document.getElementById(drop).disabled=true;
                          //alert("no elements");
                         // document.getElementById('keyName').disabled=false;
                        // makeRequest(document.getElementById('system').options[document.getElementById('system').selectedIndex].text);
                       // makeRequest3();
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


function getReadyStateHandler2(xmlHttpRequest,drop)
{ 
    // an anonymous function returned it listens to the XMLHttpRequest instance 
    return function() {  
          if (xmlHttpRequest.readyState == 4) 
              {      if (xmlHttpRequest.status == 200)
                   {       
                   
                alert(xmlHttpRequest.responseText);
        
                 
                //window.open().document.write(xmlHttpRequest.responseText);
                
                //  var OpenWindow = window.open('ResponseContentPopup.html','_blank','width=335,height=330,resizable=1');
                  // var text = document.createTextNode('Hi');
                   
                  // OpenWindow.document.body.appendChild(text);


                  //showDiv('yo yo honey singh','div3');
                  
                    
                      
           } else {  
           
     } 
       }
             };
             


             }           

function trim(someText){
    return someText.replace(/(\r\n|\n|\r)/gm,"");
}

function enableButton() {
    obj.showContentsButton.disabled = "";
    obj.addToProfileButton.disabled = "";
}
function addResponseToProfile() {
    obj.system.options[obj.system.selectedIndex].disabled = "true";
    obj.subSystem.disabled = true;
    obj.keyName.disabled = true;
    
    var selectedApp = obj.appId.options[obj.appId.selectedIndex].value;
    var selectedSystem = obj.system.options[obj.system.selectedIndex].value;
    var selectedSubSystem = obj.subSystem.options[obj.subSystem.selectedIndex].value;
    var selectedResponse = obj.keyName.options[obj.keyName.selectedIndex].value;
    //alert(selectedApp + selectedResponse + selectedSubSystem + selectedSystem);
    
    currentResponseInfo +=  selectedApp + "||" +selectedSystem + "||" + selectedSubSystem + "||" + selectedResponse + "#$#" ;
   // alert(currentResponseInfo);
    createNewRowInDiv(selectedApp,selectedSystem,selectedSubSystem,selectedResponse);
}

function createNewRowInDiv(selectedApp,selectedSystem,selectedSubSystem,selectedResponse) {
    
    if(currentResponseInfo.split("#$#").length - 1 == 1)
    	{
    	document.getElementById('selectedResponsesTable').style.display ='block';
    	}
    var table = document.getElementById('selectedResponsesTable');
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    
    var cell1 = row.insertCell(0);
    var element1 = document.createElement("label");
    element1.name="appName"+rowCount;
    element1.innerHTML = selectedApp;
    cell1.appendChild(element1);
    
    var cell2 = row.insertCell(1);
    var element2 = document.createElement("label");
    element2.name="serviceName"+rowCount;
    element2.innerHTML = selectedSystem;
    cell2.appendChild(element2);
    
    var cell3 = row.insertCell(2);
    var element3 = document.createElement("label");
    element3.name="operName"+rowCount;
    element3.innerHTML = selectedSubSystem;
    cell3.appendChild(element3);
    
    var cell4 = row.insertCell(3);
    var element4 = document.createElement("label");
    element4.name="serviceName"+rowCount;
    element4.innerHTML = selectedResponse;
    cell4.appendChild(element4);
    
    
}

function showSelectedResponses() {
    makeRequest4();
}

function makeRequest4() {  
    
    var xmlHttpRequest3 = getXMLHttpRequest();
    xmlHttpRequest3.onreadystatechange = getReadyStateHandler2(xmlHttpRequest3);
    var appId=document.getElementById("appId").value; 
    var system=document.getElementById("system").value;
    var subSystem=document.getElementById("subSystem").value;
    var keyName = document.getElementById("keyName").value;
    var url="DisplayResponseFileContentAction.action?appId="+appId+"&system="+system+"&subSystem="+subSystem+"&keyName="+keyName;  
   //alert(url);
    xmlHttpRequest3.open("GET", url , true);  
    xmlHttpRequest3.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    xmlHttpRequest3.send(null);
}

function showDiv(content,field){
     document.getElementById("div1").style.display="block";
     document.getElementById(field).style.display="block";


    }
    
    
    function hidDiv(field){
     document.getElementById("div1").style.display="none";
     document.getElementById(field).style.display="none";
    }

  
function saveProfile() {
	 document.getElementById('responseInfoField').value = currentResponseInfo;

	 document.getElementById('customizeResponsesForm').submit();

	 
}
    
</SCRIPT>
</head>
<body onload="createSelectElements()">
<div class="ui-widget ui-widget-content ui-corner-all">
<s:form action="ShowCustomizedResponsePageAction" id="customizeResponsesForm" name="customizeResponsesForm" method="post" enctype="multipart/form-data" theme="simple">
<h3 align="center"><b>
CUSTOMIZE RESPONSES
</b></h3>
<table id="outerTable">
<tr>
<td>

<table id="innerLeftTable">

<tr>
<td><label>Application Id  :</label></td><td><s:select label="Application Id "  id="appId" key="responseInfo.appId" list="{'Select from below'}" disabled="true" onchange="getSystemSelectOptions()"></s:select></td></tr>

<tr><td><label>Service Name  :</label></td><td><s:select multiple="true" size="8" label="Service Name " id="system" name="system"  list="{'Select from below'}" disabled="true"  onchange="getSubSystemSelectOptions()" /></td> </tr>
<tr><td><label>Operation Name  :</label></td><td><s:select label="Operation Name : " id="subSystem" key="responseInfo.subSystem" list="{'Select from below'}" disabled="true" onchange="showExistingResponses()"/></td>  <td></td>
</tr>
<tr><td><label >Response Identifier :</label></td>
<td><s:select label="Response Identifier : " id="keyName" key="responseInfo.key" list="{'Select from below'}" disabled="true" onchange="enableButton()" /><button id="showContentsButton" disabled="disabled" onclick="showSelectedResponses();return false;">Show Contents</button></td>

</tr>

<tr><td><button disabled="disabled" id="addToProfileButton" onclick="addResponseToProfile();return false;">Add to UseCase</button></td></tr>

<tr><td colspan="3" align="center"><button onclick="saveProfile();return false;" >Save UseCase</button></td></tr>
</table>
</td>
<td>
<input id="responseInfoField" name="responseInfoField" style="display:none"></input>
<div id="selectedResponsesDiv">
<table id="selectedResponsesTable" style="display:none" width = "500px" border = "1">
<tr><th  colspan="4">You have added the following responses to the current UseCase</th></tr>

</table>
</div>

</td>

</tr>

</table>






</s:form>
</div>
</body>
</html>