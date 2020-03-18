<%@taglib uri="/struts-tags" prefix="s" %>
<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.util.*,com.ctl.app.virtual.ExternalDataPullDTO" %>
	<%@page import="com.ctl.simulation.http.RxContextPathDeploymentUtil"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileInputStream"%>
<!DOCTYPE html>
<html>
<head>
<jsp:useBean id="myBean2" class="com.ctl.app.virtual.util.AddKeyValueUtil" scope="session"/>
<%
RxContextPathDeploymentUtil util = new RxContextPathDeploymentUtil();
String path=util.getConfigItPath().replace("it", "VirtualConfig.properties");
Properties pro = new Properties();
try {
    FileInputStream f = new FileInputStream(path);
    pro.load(f);
} catch (Exception e) {
    
}

String[] list2 = myBean2.getAppIds(pro.getProperty("ResponeFilePath"));
%>
<%
List<ExternalDataPullDTO> xmlsims = (ArrayList<ExternalDataPullDTO> )session.getAttribute("xmls");
String rxNumber = (String)session.getAttribute("rxNumber");
String env = (String)session.getAttribute("env");
%>
<title>Capture Simulation XML</title>
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
	.odd{background-color: white;} 
    .even{background-color: gray;} 
    -->
   </style>
<SCRIPT type="text/javascript">
var obj = document.getElementById("dumpForm");
function createSelectElements( )
{
   // obj = document.getElementById("dumpForm");
       document.getElementById("appId").disabled=false;
     // document.form1.drop1.options.length=0;
     <% 
      for(int i=0;i<list2.length;i++)
      {
    	  System.out.println("-->"+list2.length);
        %>
       var opt=document.createElement('option');            
      opt.text='<%=list2[i]%>';
       opt.value='<%=list2[i]%>'; 
       document.getElementById("appId").options.add(opt);
    <%} %>  
   // alert(document.form1.drop1.options[document.form1.drop1.selectedIndex].value);    
}

function dumpSubmit(){
	//alert("abc");
	av=document.getElementsByName("edpAiChk");
	//alert("chk box length : "+av.length);
	av1=document.getElementById("rxNumber").value;
	//alert(av1);
	av2=document.getElementsByName("env");
	//alert(av2[0].value);
	var j=0;
	var combined = "";
	for (j=0;j<av.length;j++) {
		if (av[j].checked == true) {	
			//alert();
			if(combined == "")
				combined = combined + av[j].value;
				else
				combined = combined + ":" + av[j].value;
		} else {
			//alert("INSide ELSE "+j);
		}
	}
	if(combined=="" || combined==":"){
		alert("Please select any checkbox");
		return false;
	}
	<%-- //alert("rxnumber : "+<%=rxNumber %>);
	var rxN = <%=rxNumber %> ;
	var enV = <%=env %>;
	//alert("combined : "+combined+" RxNumber :"+rxN+" Env : "+enV); --%>
	//alert("combined : "+combined+" RxNumber :"+av1+" Env : "+av2[0].value);
	document.dumpForm.combinedString.value = combined;
	document.dumpForm.rxNumberVal.value = av1;
	document.dumpForm.envVal.value = av2[0].value;
	document.dumpForm.action='dumpXMLDataAction.action';
	document.dumpForm.submit();
}

function toggle(source) {
	  checkboxes = document.getElementsByName('edpAiChk');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
	
function alternate(id){ 
	  if(document.getElementsByTagName){  
	    var table = document.getElementById(id);   
	    var rows = table.getElementsByTagName("tr");   
	    for(i = 0; i < rows.length; i++){           
	  //manipulate rows 
	      if(i % 2 == 0){ 
	        rows[i].className = "even"; 
	      }else{ 
	        rows[i].className = "odd"; 
	      }       
	    } 
	  } 
	}
</SCRIPT>

</head>



<body onload="createSelectElements()">
<div  class="container,ui-widget ui-widget-content ui-corner-all" >
<table bgcolor="#ECF6CE" width="100%"><tr ><td>
<table align="center"><tr ><td>
<form name="dumpForm" action="">
<h3>Capture Data</h3>
<div class="field">
	<label for="rxNumber">Rx Number:</label>
  	<input type="text" class="input" name="rxNumber" id="rxNumber" value="<%=rxNumber %>" disabled="disabled" />
</div>

<div class="radio">  
	<label for="env">Environment:</label>
	<table><tr><td>
	<input id="env" type="radio" name="env" value="<%=env %>" checked="checked" disabled="disabled"/></td><td><%=env %></td>
    </tr></table>
</div><br/> 
<h3>Xml Data</h3>
<div style="max-height:150px; overflow-y:auto">
<table rules="rows">
<%
Iterator<ExternalDataPullDTO> itr = xmlsims.iterator();
 int i=0;
 boolean flag=true;
while (itr.hasNext()) {
		ExternalDataPullDTO element = itr.next();
		//out.println(element.getDataSource());  
  %>
<tr>
	<td style="width:1px;">  
  		<input type="checkbox" name="edpAiChk" value='<%=element.getExternalDataPullAi()%>'/>
  	</td>
  	<td style="width:600px;"> &nbsp; 
  		<%=element.getRequestTimeStamp()%> - <%=element.getQueryName()%> 
  	</td>
</tr>
<%
i++;
}
%> </table>
</div>

<div class="field">  
   <table><tr><td>
   		<input type="hidden" name="combinedString" id="combinedString" value="" />
   		<input type="hidden" name="rxNumberVal" id="rxNumberVal" value="" />
   		<input type="hidden" name="envVal" id="envVal" value="" />
   		</td></tr>
   </table>
</div>
<div class="check">  
   <table>
    <tr>
        <td colspan="2">
        <div style="float: left"><input type="checkbox" onClick="toggle(this)"></div><div style="float: left;">&nbsp;Select All</div>
   		</td>    		
   	</tr>
   	<tr><td>&nbsp;</td></tr>
   <tr>
        <td colspan="2"><label style="font-style: italic; width: 100%">Please Select the application where you want to dump the Responses</label></td>
   </tr>
   <tr><td>&nbsp;</td></tr>
   <tr><td><s:select label="Application Id "  id="appId" key="appId" list="{'Select from below'}" disabled="true" ></s:select></td><td>&nbsp;</td></tr>
   </table>
</div>
<input type="submit" value="submit" name="submit" class="button" onClick="javaScript:dumpSubmit();" />
</form>
</td></tr></table>
</td></tr></table>
</div>
</body>

</html>