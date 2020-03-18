<!DOCTYPE html>
<html lang="en" manifest="manifest.appcache">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>Service Virtualization</title>
    <style>
     label,input { display:block;}
    </style>
</head>
<body>
	<div  id="homePage" class="ui-widget ui-widget-content ui-corner-all " >
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
</body>
</html>
