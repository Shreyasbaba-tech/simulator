<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/dhtmlxchart.js" type="text/javascript"></script>
<link rel="STYLESHEET" type="text/css" href="css/dhtmlxchart.css">
</head>
<body onload="init()">
<div class="ui-widget ui-widget-content ui-corner-all">
<table align="center">
	<tr>
		<td colspan=2><h3 align="center"><b>Application Usage</b></h3></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="3">
			<div id="chart6" style="width:650px;height:400px;border:0px solid #A4BED4;"></div>
		</td>
	</tr>
</table>
</div>
	
	<script>
	var data = [
	    		{ usage:"125", month:"Jan" },
	    		{ usage:"97", month:"Feb" },
	    		{ usage:"112", month:"March" },
	    		{ usage:"108", month:"April" },
	    		{ usage:"92", month:"May" },
	    		{ usage:"89", month:"June" },
	    		{ usage:"75", month:"July" },
	    		{ usage:"125", month:"Aug" },
	    		{ usage:"122", month:"Sept" },
	    		{ usage:"107", month:"Oct" }
	    	];

	var barChart6 =  new dhtmlXChart({
		view:"bar",
		alpha:function(data){
			return data.usage/150;
		},
		container:"chart6",
	    value:"#usage#",
		label:"#usage#",
		color:"#66cc33",
		border:false,
		width:30,
		radius:0,
		tooltip:{
			template:"#usage#"
		},
		xAxis:{
			title:"Usage per Month",
			template:"#month#"
		},
		yAxis:{
			start:0,
			end:250,
			step:50,
			title:"Application Usage"
		}
	});
	barChart6.parse(data,"json");
</script>
</body>
</html>