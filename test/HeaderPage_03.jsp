<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<% 
String contextpath = request.getContextPath(); 
Boolean flag=false;
String UserName=(String)session.getAttribute("UserName");
//out.println(UserName);
RxContextPathDeploymentUtil util = new RxContextPathDeploymentUtil();
String pathUser=util.getConfigItPath().replace("it", "VirtualAppUser.properties");
Properties pro = new Properties();

try {
    FileInputStream f1= new FileInputStream(pathUser);
    pro.load(f1);
    
} catch (Exception e) {
   e.printStackTrace(); 
}
String admin[]=pro.getProperty("virApp.admin").split(",");
  for(int i=0;i<admin.length;i++){
	if(admin[i].equalsIgnoreCase(UserName))
	{
		flag=true;
		
		//out.println("flag:"+flag);
		break;
	}  
  }	
%>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<%=contextpath %>/css/header.css" rel="stylesheet" type="text/css" />
<script src="<%=contextpath %>/js/jquery.min.js" type="text/javascript"></script>
	
	<script src="<%=contextpath %>/js/jQuery.bubbletip-1.0.6.js" type="text/javascript"></script>
	<link href="<%=contextpath %>/js/bubbletip/bubbletip.css" rel="stylesheet" type="text/css" />
	<!--[if IE]>
	<link href="<%=contextpath %>/js/bubbletip/bubbletip-IE.css" rel="stylesheet" type="text/css" />
	<![endif]-->
<style type="text/css" media="screen"> 

#suggestionContent{
	position: relative;
	background-color:white;
	overflow:scroll;
	height: 220px;
	width: 280px;
	
	scrollbar-base-color: #C0C0C0;
	scrollbar-base-color: #168e46;
	scrollbar-3dlight-color: #168e46;
	scrollbar-highlight-color: #c4e2ac;
	scrollbar-track-color: #c4e2ac;
	scrollbar-arrow-color: #C0C0C0;
	scrollbar-shadow-color: #c4e2ac;
	scrollbar-dark-shadow-color: #c4e2ac;
	
}
	::-webkit-scrollbar { width: 3px; height: 3px;}
	::-webkit-scrollbar-button {  background-color: #666; }
	::-webkit-scrollbar-track {  background-color: #999;}
	::-webkit-scrollbar-track-piece { background-color: #ffffff;}
	::-webkit-scrollbar-thumb { height: 50px; background-color: #666; border-radius: 3px;}
	::-webkit-scrollbar-corner { background-color: #999;}}
	::-webkit-resizer { background-color: #666;}
	
@-moz-document url-prefix(http://),url-prefix(https://) {
scrollbar {
   -moz-appearance: none !important;
   background: rgb(0,255,0) !important;
}
thumb,scrollbarbutton {
   -moz-appearance: none !important;
   background-color: rgb(0,0,255) !important;
}

thumb:hover,scrollbarbutton:hover {
   -moz-appearance: none !important;
   background-color: rgb(255,0,0) !important;
}

scrollbarbutton {
   display: none !important;
}

scrollbar[orient="vertical"] {
  min-width: 15px !important;
}
}

#logo{
	max-width:100%;
	height:70px;
	width:auto\9;
   	background-image: url("images/header_centre.png");
   	background-repeat: no-repeat;
}  
</style>
<script type="text/javascript">
function hideAdminUtil(){
	
	 	if(<%=flag%>)
		{
			document.getElementById("adminUtil").style.display = "block";
		}
		else{
			document.getElementById("adminUtil").style.display = "none";
			 }
		
}

</script>
<title></title>
</head>
<body >
<form name="headerForm">
<marquee>This application is currently IE supported.IE users please turn off the IE compatibility mode by pressing F12 and selecting Browser Mode:IE9</marquee>
<div id="logo"></div>
<%-- <s:property value="#session['UserName']"/> --%>
<div id='menuWrapper'>
	<ul class='menu'>
		<li class='top'><a class='top_link' href='#' onclick="goToAction('homPage');"><span>Home</span></a></li>


		<li class='top'><a class='top_link' href='#'><span class='down'>Add Service</span></a>
			<ul class='sub'>
				<li><a href='#' onclick="goToAction('addService')">Bus/Web/HTTP Service</a></li>
				<!-- <li><a href='#' onclick="goToAction('addService')">Web Service</a></li>
				<li><a href='#' onclick="goToAction('addService')">HTTP Service</a></li> -->
				<li><a href='#' onclick="goToAction('addJMSService')">JMS Service</a></li>
			</ul>
		</li>
		
		<li class='top'><a class='top_link' href='#'><span class='down'>Responses</span></a>
			<ul class='sub'>
				<li><a href='#' onclick="goToAction('literalXml')">Add/Edit Response</a></li>
				<!-- <li><a href='#' onclick="goToAction('loadResponse')">Load JMS Response</a></li> -->
				<!-- <li><a href='#' onclick="goToAction('addJMSResponse')">Add/Edit JMS Response</a></li> -->
				<li><a href='#' onclick="goToAction('searchPage')">Search Response</a></li>
			</ul>
		</li>
		
		<li class='top'><a class='top_link' href='#' onclick="goToAction('applyResiliency')"><span>Apply Resiliency Parameter</span></a></li>
		<li class='top'><a class='top_link' href='#' onclick="goToAction('getRepositorySummary')"><span>Repository Summary</span></a></li>

		<li class='top' id='util'><a class='top_link' href='#'><span class='down' onmouseover="hideAdminUtil()">Util</span></a>
			<ul class='sub'>
				<li><a href='#' onclick="goToAction('captureUtil')">Capture Util</a></li>
				<li id='adminUtil'><a class='fly'  href='#'>Admin Util</a>
					<ul>
					<li id='TakeResponseBackup'><a href='#'  onclick="goToAction('takeResponseBackup')">Take Response Backup</a></li>
					<!-- <li><a href='#' onclick="goToAction('loginAdminResponse')">Response Recording</a></li> -->
					<!-- <li><a href='#' onclick="goToAction('createUserAccessPermission')">Create User Access</a></li> -->
					<li id='CreateUserAccess'><a href='#'  onclick="goToAction('createUserAccessPermission')">Create User Access</a></li>
					</ul>
				</li>
				<li><a href='#' onclick="goToAction('viewContextDetail')">View Service Context File</a></li>
			</ul>
		</li>
		
		<li class='top'><a class='top_link' id='a1_down' href='#'>Suggestion Box</a></li>
		<li class='top'><a class='top_link' id='logout' href='#'  onclick="goToAction('logout')">Logout</a></li>

</ul>
</div>
<div id="tip1_down" style="display:none;width: 290px">	
	<!-- <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">Close</a> -->
	<h3>Recent Comments</h3>
	<div id="suggestionContent">
	</div>
	<h3>Type In your comments/suggestions<br></h3>
	<div id="textareadiv">
		<textarea rows="3" cols="33" id="newComment"></textarea><br>
	</div>
	<br>Email address<input type="text" id="userEmail"></input>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button onclick="saveUpdateSuggestionBox('second');">Post</button>&nbsp;&nbsp;&nbsp;
	<a href="mailto:VirtualizationApp@centurylink.com?Subject=VirtualApp issue-" target="_top">
	Report an issue(email)</a>
</div>
</form>
</body>
<script type="text/javascript">
//window.onload=function(){saveUpdateSuggestionBox('first');};
listen("load", window, function() {
					saveUpdateSuggestionBox('first');	
					$(document).ready(function() {
						/*$('#a1_up').bubbletip($('#tip1_up'));*/
						$('#a1_down').bubbletip($('#tip1_down'), {
							deltaDirection: 'down',
							deltaPosition: 50,
							offsetTop: 20
						});
					});
					});

function listen(evnt, elem, func) {
    if (elem.addEventListener)  // W3C DOM
        elem.addEventListener(evnt,func,false);
    else if (elem.attachEvent) { // IE DOM
         var r = elem.attachEvent("on"+evnt, func);
         return r;
    }
    else window.alert('Oops!! Something Went wrong!!');
}



var enter = "";
function goToAction(field) {
	document.headerForm.action=field+'.action';
	document.headerForm.submit();
}  

	function saveUpdateSuggestionBox(field) {
		enter = field;
		//alert(enter);
		ajaxCallRequest();
		//if(enter!="first"){
			//document.getElementById('light').style.display='block';
			//document.getElementById('fade').style.display='block';
			//alert(enter);
		//}
	}

	function ajaxCallRequest() {
		//  alert("yo");
		var xmlHttpRequest = getAjaxXMLHttpRequest();

		xmlHttpRequest.onreadystatechange = getAjaxReadyStateHandler(xmlHttpRequest);

		var f = document.getElementById("newComment");
		var newComment = f.value;
		var g = document.getElementById("userEmail");
		var userEmail = g.value;
		// alert("newComment "+newComment);
		var url = "SaveUpdateComments.action?newComment=" + newComment + "&userEmail=" + userEmail;
		xmlHttpRequest.open("GET", url, true);
		xmlHttpRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		xmlHttpRequest.send(null);

	}

	function getAjaxXMLHttpRequest() {
		var xmlHttpReq = false;
		if (window.XMLHttpRequest) {
			xmlHttpReq = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			try {
				xmlHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (exp1) {
				try {
					xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (exp2) {
					xmlHttpReq = false;
				}
			}
		}
		return xmlHttpReq;
	}

	function getAjaxReadyStateHandler(xmlHttpRequest) {				
		// an anonymous function returned it listens to the XMLHttpRequest instance 
		return function() {
			if (xmlHttpRequest.readyState == 4) {
				if (xmlHttpRequest.status == 200) {

					var temp = new Array(); 
					var commentString = "";
					email = "";
					temp = (xmlHttpRequest.responseText).split('##');
					// alert(temp);
					for ( var i = temp.length; i > 0; i--) {

						if (temp[i] != "" && temp[i] != undefined)

						{
							// alert(temp[i]);
							var comment = temp[i].split("|#|")[0];
							var email = temp[i].split("|#|")[1];
							if (email == "") {
								email = "Anonymous";
							}
							commentString = commentString + "<b>" + comment + "</b><br>--" + email + "<br><br>";

						}

					}

					document.getElementById("suggestionContent").innerHTML = commentString;
					// alert(xmlHttpRequest.responseText);

				} else {
					alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText);
				}
			}
		};
					

	}
</script>
</html>