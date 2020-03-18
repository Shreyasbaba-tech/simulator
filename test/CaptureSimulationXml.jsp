<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" manifest="manifest.appcache">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link href="style/style.css" rel="stylesheet" type="text/css"/>
<title>Test</title>

<style type="text/css" > 
    <!--
	* { margin: 0; padding: 0; }
	body {font-family: Verdana, Arial; font-size: 12px; line-height: 18px; }
	a { text-decoration: none; }
	.container{margin: 20px auto; width: 900px; background: #fff;}
	h3 { margin-bottom: 15px; font-size: 22px; text-shadow: 2px 2px 2px #ccc; }
	
	#contactform {
	
	width: 500px;
	padding: 20px;
	background: #ECF6CE;
	overflow:auto;
	
	border: 1px solid #cccccc;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border-radius: 7px;	
	
	-moz-box-shadow: 2px 2px 2px #cccccc;
	-webkit-box-shadow: 2px 2px 2px #cccccc;
	box-shadow: 2px 2px 2px #cccccc;
	
	}
	
	.field{margin-bottom:7px;}
	
	label {
	font-family: Arial, Verdana; 
	text-shadow: 2px 2px 2px #ccc;
	display: block; 
	float: left; 
	font-weight: bold; 
	margin-right:10px; 
	text-align: right; 
	width: 120px; 
	line-height: 25px; 
	font-size: 15px; 
	}
	
	.input{
	font-family: Arial, Verdana; 
	font-size: 15px; 
	padding: 5px; 
	border: 1px solid #b9bdc1; 
	width: 300px; 
	color: #797979;	
	}
	
	.input:focus{
	background-color:#E7E8E7;	
	}
	
	.textarea {
	height:150px;	
	}
	
	.hint{
	display:none;
	}
	
	.field:hover .hint {  
	position: absolute;
	display: block;  
	margin: -30px 0 0 455px;
	color: #FFFFFF;
	padding: 7px 10px;
	background: rgba(0, 0, 0, 0.6);
	
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border-radius: 7px;	
	}
	
	.button{
	float: right;
	margin:10px 55px 10px 0;
	font-weight: bold;
	line-height: 1;
	padding: 6px 10px;
	cursor:pointer;   
	color: #0A2A0A;
	
	text-align: center;
	text-shadow: 0 -1px 1px #64799e;
	
	/* Background gradient */
	background: #BEF781;
	background: -moz-linear-gradient(top, #a5b8da 0%, #7089b3 100%);
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#a5b8da), to(#7089b3));
	
	/* Border style */
  	border: 1px solid #5c6f91;  
	-moz-border-radius: 10px;
	-webkit-border-radius: 10px;
	border-radius: 10px;
  
	/* Box shadow */
	-moz-box-shadow: inset 0 1px 0 0 #aec3e5;
	-webkit-box-shadow: inset 0 1px 0 0 #aec3e5;
	box-shadow: inset 0 1px 0 0 #aec3e5;
	
	}
	
	.button:hover {
	background: #A5DF00;
    cursor: pointer;
	}
    -->
   </style>
  <SCRIPT type="text/javascript">

function captureSubmit(){
	
	//alert("abc");

	var value1=document.getElementById("rxNumber").value;
	//alert("rxNumber : "+value1);
	av=document.getElementsByName("env");
	//alert("radio length : "+av.length);
	//av1=document.getElementsByName("env").value;
	//alert("radio length : "+av1);
	var j=0;
	var selectedRadio="";
	for (j=0;j<av.length;j++) {
		if (av[j].checked == true) {	
			selectedRadio = av[j].value;
		} 
	}
	//alert(value1 +" : "+selectedRadio);
	//32578848 -- rxNumnber for WST
	value1 = "32578848";
	if(value1=="" || selectedRadio==""){
		if(value1==""){
			alert("Rx Number empty");
		}
		if(selectedRadio==""){
			alert("Please select the environment");
		}
		return false;
	}
	//alert("action");
	document.contactform.action='captureXMLAction.action';
	document.contactform.submit();
	//alert("action1");

}
function trim(someText){
	return someText.replace(/(\r\n|\n|\r)/gm,"");
}

</SCRIPT> 
   
</head>

<body >
<div class="container, ui-widget ui-widget-content ui-corner-all">
<table bgcolor="#ECF6CE" width="100%"><tr ><td>
<table align="center"><tr ><td>
<form name="contactform" id="contactform" class="rounded" action="">
<h3>Capture Data</h3>
<div class="field">
	<label for="rxNumber">Rx Number:</label>
  	<input type="text" class="input" name="rxNumber" id="rxNumber" />
	<p class="hint">Enter Rx Number.</p>
</div>

<div class="radio">  
	<label for="env">Environment:</label>
	<table><tr><td>
    <input id="dev" type="radio" name="env" value="dev" /><p class="hint">Select dev.</p></td><td>Dev</td><td>
    <input id="wst" type="radio" name="env" value="wst" checked="checked" /></td><td>WST</td><td>
    <input id="prod" type="radio" name="env" value="prod" /></td><td>Prod
    </td></tr></table>
</div> 


<input type="submit" value="submit" name="submit"  class="button" onClick="javaScript:captureSubmit();" />
</form>
</td></tr></table>
</td></tr></table>
</div>
</body>

</html>


