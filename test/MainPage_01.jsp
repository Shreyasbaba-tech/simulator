<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
     <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><tiles:insertAttribute name="title" ignore="true" /></title>
     </head>
        <body >
             <table width="100%" height="100%">
                <tr>
                    <td height="50%" width="100%" >
                        <tiles:insertAttribute name="header" />
                    </td>
                </tr>
                <tr>
                    <td height="100%" width="100%">
                        <tiles:insertAttribute name="body" />
                    </td>
                </tr>
                <tr>
                    <td height="50%" width="100%">
                        <tiles:insertAttribute name="footer" />
                    </td>
                </tr>
           </table>
        </body>
</html>