<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html lang="en" manifest="manifest.appcache">
<head>
<style type="text/css" media="screen">  
#logo{
    max-width:100%;
    height:70px;
    width:auto\9;
    background-image: url("images/header_centre.png");
    background-repeat: no-repeat;
}          
#centeredmenu {
   float:left;
   width:100%;
   background:#fff;   
   overflow:hidden;
   position:relative;
   background-image: url("images/Menu_back.png");
   
}
#centeredmenu ul {
   clear:left;
   float:left;
   list-style:none;
   margin:0;
   padding:0;
   position:relative;
   left:50%;
   text-align:center;
}
#centeredmenu ul li {
   display:block;
   float:left;
   list-style:none;
   margin:0 2px 0 0;    
   padding:0;
   position:relative;
   right:50%;
   text-align: justify;
}
#centeredmenu ul li a {
   display:block;
   margin:0 0 0 1px;
   padding:10px 10px;
   /*background:#00853f;*/
   background-image: url("images/Green.png");
   color:silver;
   text-decoration:none;
   line-height:1.3em;
   font-size: large;
   font-family: sans-serif;
}
#centeredmenu ul li a:hover {
   /*background:#1b8f2d;*/
   background-image: url("images/Menu_hover1.png");
   color:#fff;
}
#centeredmenu ul li a.active,
#centeredmenu ul li a.active:hover {
   color:#fff;
   background:#000;
   font-weight:bold;
}
#nav{    text-align:justify;}#nav li{ /*border:1px solid #000; margin-right:1px; margin-left:1px;*/    display:inline-block; white-space:nowrap;}
#nav li#span{ /*hack to make 100% horizontal*/    display:inline-block; width:100%; height:1px;}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
<title>Service Virtualization</title>
<script language=javascript type='text/javascript'>  
window.onresize = function(){
    var img = document.getElementById('logo');
    img.style.width = "100%";
};
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

function takeResponseBackup() {
    document.adminForm.action='takeResponseBackup.action';
    //alert(document.adminForm.action);
    document.adminForm.submit();
}
function responseRecording() {
    document.adminForm.action='responseRecording.action';
    document.adminForm.submit();
}

</script>
</head>

<body>
<form name="adminForm">
       <div id="centeredmenu"> 
        <div id="nav">     
            <ul>                    
                <li><a href="#" onclick="takeResponseBackup()">Take Response Backup</a></li>                
                <li><a href="#" onclick="responseRecording()">Response Recording</a></li>                    
               
                <li id="span"></li>                 
            </ul>   
        </div>       
    </div>
</form> 
</body>
</html>
