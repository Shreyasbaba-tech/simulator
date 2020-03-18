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
		<td colspan=2><h3 align="center"><b>Service Usage</b></h3></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="3">
			<div id="chart1" style="width:650px;height:400px;border:0px solid #A4BED4;"></div>
		</td>
	</tr>
</table>
</div>
	
	<script>
	var data = [
		{ usage:"200",usage1:"115",usage2:"30",usage3:"30", month:"December" },
		{ usage:"215",usage1:"135",usage2:"80",usage3:"35", month:"January" },
		{ usage:"250",usage1:"175",usage2:"90",usage3:"47", month:"February" }
	];
	function init(){
		var barChart1 =  new dhtmlXChart({
			view:"stackedBar",
			container:"chart1",
		    value:"#usage#",
			label:"#usage#",
			width:60,
			tooltip:{
				template:"#usage#"
			},
			xAxis:{
				title:"Usage per month",
				template:"#month#"
			},
			yAxis:{
				title:"No of time services used"
			},
			gradient:"3d",
			//border:false,
			color: "#66cc33",
			legend:{
				values:[{text:"WEB Service",color:"#66cc33"},{text:"HTTP Service",color:"#ff9933"},{text:"BUS Service",color:"#ffff99"},{text:"JMS Service",color:"#66ffcc"}],
				valign:"top",
				align:"right",
				width:120,
				layout:"y",
				marker:{
					width:15,
					type:"round"
				}
			}
		})
		barChart1.addSeries({
		    value:"#usage1#",
			color:"#ff9933",
			label:"#usage1#",
			tooltip:{
				template:"#usage1#"
			}
		});
		barChart1.addSeries({
		    value:"#usage2#",
			color:"#ffff99",
			label:"#usage2#",
			tooltip:{
				template:"#usage2#"
			}
		});
		barChart1.addSeries({
		    value:"#usage3#",
			color:"#66ffcc",
			label:"#usage3#",
			tooltip:{
				template:"#usage3#"
			}
		});
		barChart1.parse(data,"json");	
	}
</script>
</body>
</html>