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
     .trans{height: 1.4em;width: 3em;font-size: 0.7em;}
    </style>
    <script language=javascript type='text/javascript'>   
var prevLink;

function showhide(link){ 
	if (document.getElementById(link)){ 
		if(prevLink==null)
			prevLink = document.getElementById("homeLink");
	linkObj=document.getElementById(link);
		prevLink.setAttribute("class","inactive");
	prevLink=linkObj;
	linkObj.setAttribute("class","active");
	} 
	
	if(document.getElementById("homeLink").onmousedown){
		homePage();
	}
	
	
}

function homePage() {
	document.headerForm.action='homPage.action';
	document.headerForm.submit();
}
function addService() {
	document.headerForm.action='addService.action';
	document.headerForm.submit();
}
function literalXml() {
	document.headerForm.action='literalXml.action';
	document.headerForm.submit();
}
function searchService() {
	document.headerForm.action='searchPage.action';
	document.headerForm.submit();
}
function applyResiliency() {
	document.headerForm.action='applyResiliency.action';
	document.headerForm.submit();
}
function captureUtil() {
	document.headerForm.action='captureUtil.action';
	document.headerForm.submit();
}
function getRepositorySummary() {
    document.headerForm.action='getRepositorySummary.action';
    document.headerForm.submit();
}

</script>
</head>

<body>


<form name="headerForm">
	<div  id="logo" class="ui-widget ui-widget-content ui-header ui-stubH1"  >
	<h1> .</h1>
	
	<h2 align="center" ><b></b></h2>
	</div>


	<div id="tabs">
		<div class="tabs" >
			<ul class = "tabs primary">
			     <li class = "active" id="homeLink"><a  href=# onmouseover=showhide('homeLink')  onclick="homePage()" ><span>Home</span></a></li> 
	   		 	<li class = "active"  id="link1" ><a href=# onmouseover=showhide('link1') onclick="addService()"><span>Add Service</span></a></li> 
	    		<li class = "active" id="link2" ><a href =# onmouseover=showhide('link2') onclick="literalXml()"><span>Add/Edit Response</span></a></li> 
	    	<li class = "active" id="link6"><a  href =# onmouseover=showhide('link6') onclick="searchService()" ><span>Search Response</span></a></li>
	    	<li class = "active" id="link7"><a  href=# onmouseover=showhide('link7') onclick="applyResiliency()"><span>Apply Resiliency Parameter</span></a></li>
	    	<li class = "active" id="link8"><a  href=# onmouseover=showhide('link8') onclick="captureUtil()"><span>Capture Util</span></a></li>
	    	<li class = "active" id="link10"><a  href=# onmouseover=showhide('link10') onclick="getRepositorySummary()"><span>Respository Summary</span></a></li>
	    	<%-- <li class = "active" id="link8"><a  href="CaptureSimulationXml.jsp"><span>Capture Util</span></a></li> --%>
		</ul> 
	</div>
	</div>

</form>	
</body>
</html>
