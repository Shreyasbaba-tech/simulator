<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
        <link rel='stylesheet' type='text/css' href='css/xmltree.css' />
        <script src='js/libs/jquery-1.10.2.js'></script>
        <script src='js/libs/xmltree.js'></script>

        <script>
            $(function() {
                new XMLTree({
                    fpath : 'xmltree/'+'<%=(String)request.getAttribute("respName") %>',
                    container : '#tree',
                    startCollapsed : true,
                    clickCallback : getNodeDetails
                });

                function getNodeDetails(ref, xpath, myevent) {
                     alert(ref.text());
                    alert(xpath);
                }

            });
        </script>
  

</head>
<body>
 
        <h1>XMLTree</h1>
        <div id='tree'> </div>
</body>
</html>