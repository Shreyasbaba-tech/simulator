<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html lang="en" manifest="manifest.appcache">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>Service Virtualization</title>
    <link href="themes/le-frog/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="themes/le-frog/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css" />
    <link href="css/tasktracker.css" rel="stylesheet" type="text/css" />
    <script src="scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="scripts/json2.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
    <script src="scripts/knockout-latest.js" type="text/javascript"></script>
    <script src="scripts/ko-protected-observable.js" type="text/javascript"></script>
    <script src="scripts/StorageManager.js" type="text/javascript"></script>
    <script src="scripts/TaskController.js" type="text/javascript"></script>
    <script src="scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="scripts/additional-methods.js" type="text/javascript"></script>
  
    <style>
     label,input { display:block;}
    </style>
</head>
<body>
<script language=javascript type='text/javascript'>   
var curDiv;
var prevLink;

function showhide(id,link){ 
	if (document.getElementById(id) && document.getElementById(link)){ 
		if(curDiv == null)
			curDiv=document.getElementById("tabHome");
		if(prevLink==null)
			prevLink = document.getElementById("homeLink");
	obj = document.getElementById(id); 
	linkObj=document.getElementById(link);
		curDiv.style.display="none";	
		prevLink.setAttribute("class","inactive");
     curDiv=obj;
	 obj.style.display="";
	prevLink=linkObj;
	linkObj.setAttribute("class","active");
	} 
}
</script>
<div  id="logo" class="ui-widget ui-widget-content ui-corner-all" >
<br></br>
<img align="right" src="century-link-logo.jpg" height="50" width="300"/>
&nbsp;&nbsp;&nbsp;&nbsp;
<h2 align="center">Application Virtualization</h2>
</div>


 <div id="tabs">
	<div class="tabs" >
		<ul class = "tabs primary">
		     <li class = "inactive" id="homeLink"><a  href=# onclick=showhide('tabHome','homeLink');><span>Home</span></a></li> 
   		 	<li class = "inactive"  id="link1" ><a href="#" onclick=showhide('div1','link1');><span>Add Service</span></a></li> 
    		<li class = "inactive" id="link2" ><a href = "#" onclick=showhide('div2','link2');><span>Add Response</span></a></li> 
    	<li class = "inactive" id="link6"><a  href =# onclick=showhide('div7','link6');><span>Search Response</span></a></li>
	</ul> 
</div>

 <div id="tabHome">
    <p>
	<h3>Introduction:</h3>
	Application Virtualization is means of providing simulated interfaces an application connects with. For instance Rx talks to around 50 external systems. These systems expose their APIs through Web Services, Bus Services, Http Services, Sockets, WFA Contracts (with case of WFA system) etc. Application Virtualization provides a means of simulating these external systems.
    </p>
    <p>
	<h3>Motivation:</h3>
	<p>a.	Dependent Application down time which makes testing respective functions during such times impossible.</p>
	<p>b.	Test Data Non Availability during Dev, Testing cycles.</p>
	<p>c.	Testing Rx against multiple external system behaviors (Resiliency). Can help in Training Users for such exceptional scenarios. Awareness of Rx behavior under such circumstances increases.</p>
	<p>d.	External systems developing / enhancing their APIs along with Rx. Both the releases happen at the same time, so testing against the real system might be impossible.</p>

    </p>
    <p>
	<h3>Architecture:</h3>
     A light weight application which can be hosted in FOSS environment was decided. This application had to be self contained, able to initialize and service multiple types of services namely Web Service, Bus Service, Http Service etc.
    </p>
    </div>

	
	
	<div name="div1" id="div1" style="display:none">
	<%@include file="AddServicePage_01.jsp" %>   
	</div>
	
	<div name="div2" id="div2" style="display:none">
	<%@include file="LiteralXmlForm.jsp" %>   
	</div>
	
	
	<div name="div6" id="div6" style="display: none">
	<%@include file="AddControl.jsp" %>     
	</div>
	
	<div name="div7" id="div7" style="display: none">
	  <%@include file="Search.jsp" %>    
	</div>
 
	 <div id="footer" class="ui-widget ui-widget-content ui-corner-all">
	<p class="footerHeader">&#169;All rights reserved.</p>
	<p class="footerRA">Developed by Rx Team</p>
	</div>

</div>
</body>
</html>
