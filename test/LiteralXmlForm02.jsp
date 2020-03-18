<%@page import="com.ctl.app.virtual.AddResponseInfo"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<SCRIPT type="text/javascript">
function init()
{
	//document.getElementById("key").value="";
	getRequestParameters();
	}
	
	
function getRequestParameters(){
	//alert("inside get request");
	 makeRequest3();
}	
	
function makeRequest3(){

	//alert("request 3");
	var xmlHttpRequest = getXMLHttpRequest();
	  xmlHttpRequest.onreadystatechange = getTextBoxHandler(xmlHttpRequest);
	  var system;
	  var subSys;
	  var appId;
	  <%AddResponseInfo info=(AddResponseInfo)request.getSession().getAttribute("responseAdd_Data");
	 %>
	 system='<%=info.getSystem()%>';
	 subSys='<%=info.getSubSystem()%>';
	 appId='<%=info.getAppId()%>';
	 //alert(system);
	 //alert(subSys);
	//alert(appId);
	 // var e=document.getElementById("system");
	//    var f=document.getElementById("appId");
  //  var g=document.getElementById("subSystem");
    
		  //  var system=e.options[e.selectedIndex].text;
	  //var system=e.value;
	  //  alert("sys "+system); 
	  //  var appId=f.options[e.selectedIndex].text; 
     //var   appId=f.value;
     //   alert("app id "+appId);
    // var subSys=g.value;
	    var url="GetRequestParameterAction.action?appId="+appId+"&system="+system+"&subSys="+subSys; 
	   // alert(url);
	    xmlHttpRequest.open("GET", url , true);  
	    
	    xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	    xmlHttpRequest.send(null);
	
}
function getTextBoxHandler(xmlHttpRequest)
{ 
	//alert("inside text box handler....");
	// an anonymous function returned it listens to the XMLHttpRequest instance 
	return function() {  
		  if (xmlHttpRequest.readyState == 4) 
			  {      if (xmlHttpRequest.status == 200)
				   {       

				 // alert("in return function  "+xmlHttpRequest.responseText);

	//var resp=xmlHttpRequest.responseText;

	//if(resp=='deleteRow'){

	//	if(prevNoRows>0){
	//		alert("inside if");
	 //     deleteRows(prevNoRows);
	//	}
	//	elem.value="0";
	//return;
	//}
	var elem=document.getElementById("rowCount");

	var prevNoRows=elem.value;
	if(prevNoRows>0){
		//alert("inside if");
      deleteRows(prevNoRows);
	}

 //   alert("prev no of rows "+prevNoRows);
	
if(xmlHttpRequest.responseText==null){

	//alert("outside if");
	if(prevNoRows>0){
		//("inside if");
      deleteRows(prevNoRows);
	}
	elem.value="0";
return;
}
				  
				  var temp=[];
		     		  temp=(xmlHttpRequest.responseText).split(',');
		//alert(temp);
elem.value=temp.length-1;

				var formElem=document.getElementById("addResponseForm");
			   //   div = document.getElementById('reqParamDiv');
	            //     div.style.display="";
	
			var rowObj= document.getElementById("sub");
		
			//	   var target = document.getElementById(rowId);
   // var newElement = document.createElement('tr');

    
  //   next=target.nextSibling;
  // parentNode.insertBefore(newElement, next);

   var target = rowObj;
   var parent= target.parentNode;
  // alert("parent "+parent);
  // var newElement = document.createElement('tr');

  // target.parentNode.insertBefore(newElement, target );

   for(var i=0; i<temp.length; i++) {
	   if(!(temp[i]==null || trim(temp[i])=='')){
	   temp[i]=temp[i].replace("//","");  
	   var newElement = document.createElement('tr');
	   var tempRowId="row"+i;
	  // alert(tempRowId);
	   newElement.id=tempRowId;
   
	 //   alert(" parent inside for loop"+parent);
	 //   alert("current target "+target);
	    
        parent.insertBefore(newElement, target.nextSibling );
	    var newDef=document.createElement('td');
        // alert(temp[i]);
	    var cell1 = newElement.insertCell(0);
	    var label = document.createElement("label");
	    label.setAttribute("for","id2");
	    cell1.appendChild(label);
	    cell1.value= temp[i] ;
	    cell1.innerHTML =temp[i] ;
	    
	    var cell2 = newElement.insertCell(1);
	    var element2 = document.createElement("input");
	    element2.type = "text";
	    element2.id = "text"+i;
	    element2.name = "text"+i;
	    cell2.appendChild(element2);

	    target=document.getElementById(tempRowId);
	    parent=target.parentNode;
	   }
   }
	       
     } 
	  }
		     };
			 }



function       deleteRows(prevNoRows){


//alert("inside delete");
	var table=document.getElementById("infoTable")
	for(var i=0;i<prevNoRows;i++){

		var rowId="row"+i;
		var row=document.getElementById(rowId);
		 table.deleteRow(row.rowIndex);
	}
		
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
 
function trim(someText){
	return someText.replace(/(\r\n|\n|\r)/gm,"");
}
</SCRIPT>
</head>
<body onload="init()">
<s:form action="AddResponseAction.action" id="addResponseForm" name="addResponseForm" method="post" enctype="multipart/form-data">
<table align="center">
<h3 align="center"><b>
ADD/EDIT RESPONSE
</b></h3>

<tr>
<td>App ID:</td>
<td><b><s:property value="responseInfo.appId" /></b></td>
</tr>
<tr>
<td>Service Name</td>
<td><b><s:property value="responseInfo.system"/></b></td>
</tr>
<tr>
<td>Operation Name:</td>
<td><b><s:property value="responseInfo.subSystem"/></b></td>
</tr>


<%--  <tr><td><s:textfield label="Response identifier" key="responseInfo.key" id="key"></s:textfield></td></tr>  --%>
<tr><s:label value="Enter the values for the following response identifiers "></s:label></tr>
<tr id="sub"><tr>
<tr><td><s:textfield label="Search tags separated by #" id="searchTags" key="responseInfo.searchTags" size="65"/></td></tR>
<tr><td><s:textarea label="Description" key="responseInfo.desc" rows="6" cols="35"/></td></tr>
<tr><td><s:file label="Response file" id="sampleXml" key="responseInfo.sampleXml"/></td></tr>
<tr><td><s:hidden id="rowCount" name="rowCount" value="0"></s:hidden></td></tr>
<tr><td><s:submit label="Add Response"></s:submit></td></tr>
</table>

</s:form>
</body>
</html>