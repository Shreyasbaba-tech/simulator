<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<html >
<%@ page import="com.ctl.app.virtual.AddServiceInfo,java.util.List" %>
<%
    try {
        List<String> strList = (List<String>) request.getSession()
                .getAttribute("strList");
        System.out.println("List Size : " + strList.size());
%>
<body>
    
          
<script language="javascript">

function moveOptionsProfiles(option){                  
       var clauseOptionsAvailable = document.getElementById('GeneratedXpaths');
       var clauseOptionsSelected = document.getElementById('SelectedXpaths');
       if(option=='selectedToRightProfiles'){    
              moveSelectedOptionsProfiles(clauseOptionsAvailable, clauseOptionsSelected, option);
              document.GeneratedXpathsForm.button5.disabled=true;
       }
       else if(option=='selectedToLeftProfiles'){
              moveSelectedOptionsProfiles(clauseOptionsSelected, clauseOptionsAvailable, option);
              document.GeneratedXpathsForm.button5.disabled=false;
              document.getElementById("keyRangeRow").style.display='none';
       }
       else if(option=='selectedAllRightProfiles'){
              moveAllOptionsProfiles(clauseOptionsAvailable, clauseOptionsSelected, option);
       }
       else if(option=='selectedAllLeftProfiles'){
              moveAllOptionsProfiles(clauseOptionsSelected, clauseOptionsAvailable, option);
       }
}

function moveSelectedOptionsProfiles(from, to, option){       
       var i=0, selectedObject;
       var flag;
       while(i<from.length){   
              var optionOne = from.options[i];
              if(optionOne.selected){
                     to.options[to.length] = new Option(optionOne.text, optionOne.value);
                     from.removeChild(optionOne);
                     i=0;
                     flag=optionOne.text;
              }
              else i++;
       }
    
       if(option=='selectedToLeftProfiles') {
              selectedObject = from;
       }
       else if(option=='selectedToRightProfiles'){
       selectedObject = to;
       showRow(flag);
       }
       
}

function moveAllOptionsProfiles(from, to, option){     
       var i=0, selectedObject;
       while(i<from.length){             
              var optionOne = from.options[i];
              to.options[to.length] = new Option(optionOne.text, optionOne.value);
              from.removeChild(optionOne);                    
       }

       sortSelect(to, compareText);
       sortSelect(from, compareText);
       if(option=='selectedAllLeftProfiles') {
              selectedObject = from;
       }
       else selectedObject = to;
       makeAllOptionsSelectedProfiles(from);           
       makeAllOptionsSelectedProfiles(to);
}

function makeAllOptionsSelectedProfiles(selectedObject){
       for(i=0; i<selectedObject.length; i++) selectedObject.options[i].selected=true;
}

function moveSelectedToRightProfiles(){
       var openerSelectField = "secondclauseoptions";
       var queryvalue=gup("clause");
       if(queryvalue=="secondary"){
              
       }else{
              openerSelectField ="tertclauseoptions";
       }

       var selectb = opener.document.forms['editCallCenterAlertForm'].elements[openerSelectField];
       //iterate and find out if its there in the left hand window
       var leftfield =document.getElementById('GeneratedXpaths');
       for (var i = selectb.length - 1; i>=0; i--) {
              var n_moved = 0;
              var selectedOption= selectb.options[i].value;
              for(var j=0;j<leftfield.options.length;j++){
                     if(leftfield.options[j].value==selectedOption){
                           n_moved++;    
                     }else if(n_moved){
                           leftfield.options[j - n_moved] = new Option(leftfield.options[j].text, leftfield.options[j].value);
                     }
              
              }
       }
       //removed every duplicate entry in the left field..now populate the right one with the selected
       //items
       var rightField =document.getElementById('SelectedXpaths');
       for (var k = selectb.length - 1; k>=0; k--) {          
              rightField.options[rightField.options.length]=new Option(selectb.options[k].text,selectb.options[k].value);    
       }
}

function sortSelect (select, compareFunction) {
       if (!compareFunction)
       compareFunction = compareText;
       var options = new Array (select.options.length);
       for (var i = 0; i < options.length; i++)
              options[i] = new Option (select.options[i].text,select.options[i].value,select.options[i].defaultSelected,select.options[i].selected);
       options.sort(compareFunction);
       select.options.length = 0;
       for (var i = 0; i < options.length; i++) select.options[i] = options[i];
}


function compareText (opt1, opt2) {
       // not case sensitive
       return opt1.text.toLowerCase() < opt2.text.toLowerCase() ? -1 :
       opt1.text.toLowerCase() > opt2.text.toLowerCase() ? 1 : 0;
}


function compareValueAsFloat (option1, option2) {
       var value1 = parseFloat(option1.value);
       var value2 = parseFloat(option2.value);
       return value1 < value2 ? -1 :
       value1 > value2 ? 1 : 0;
}

function getSelectedXpaths()
{
    var selectXpathValuesArr=new Array();
    var selectXpathSelectLength=document.GeneratedXpathsForm.SelectedXpaths.options.length;
    var selectXpathSelect=document.GeneratedXpathsForm.SelectedXpaths.options;  
    
    for(var x=0;x<selectXpathSelectLength;x++)
    {
        selectXpathValuesArr[x]=selectXpathSelect[x].text;
    }
    document.getElementById('selectedXpathsToAction').value=selectXpathValuesArr.join("#"); 
    
}

function showRow(field){
    //alert(field);
    var oobj = document.getElementById("keyRangeRow");
    var oobj1 = document.getElementById("spanKey");
    oobj1.innerHTML = field;
    oobj.style.display='block';
}

function valueChange(field1){
    document.getElementById("elementToBeReplaced").value = field1;
}

</script>

<div class="ui-widget ui-widget-content ui-corner-all">
        <s:form action="AddBulkResponseAction.action" name="GeneratedXpathsForm" method="post" enctype="multipart/form-data">
            <table align="center" width="600" class=menu1 border="1">
                <body>
                    <h3 align="center">
                        <b> Generate Bulk Responses </b>
                    </h3>
                <tr>
                    <th align="center"><b>Generated Request Ids</b></th>
                    <td>&nbsp;</td>
                    <th align="left"><b>Selected Request Ids</b></th>
                </tr>
                <tr>
                    <td>&nbsp; 
                        <select name="GeneratedXpaths" id="GeneratedXpaths"
                        SIZE="+10" style="width: 70mm">
                            <s:iterator value="serviceInfo.generatedXpathMapKey" var="xpath">
                                <option>
                                    <s:property value="#xpath" />
                                </option>
                            </s:iterator>
                        </select>
                    </td>
                    <td><input type="button" name="button5" size="5" value="&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;" onclick="javascript:moveOptionsProfiles('selectedToRightProfiles')" />
                        <br><input type="button" value="&nbsp;&nbsp;&nbsp;&lt;&nbsp;&nbsp;&nbsp;" name="button7" size="5" onclick="javascript:moveOptionsProfiles('selectedToLeftProfiles')">
                        &nbsp; &nbsp; &nbsp;
                    </td>
                    <td>
                        <select name="SelectedXpaths" id="SelectedXpaths" SIZE="+10" style="width: 70mm" multiple="multiple" onchange="valueChange(this.value);"></select>
                    </td>

                </tr>
                <tr><td colspan="3"></td></tr>
                <tr><td colspan="3"></td></tr>
                <tr><td colspan="3"></td></tr>
                <tr><td colspan="3"></td></tr>
                <tr><td colspan="3"></td></tr>
                <tr>
                </tbody>
            </table>

            <table align="center">
                <tr id="keyRangeRow" style="display: none;">
                    <td><span id="spanKey"></span> Range :</td>
                    <td><s:textfield label="Range" value="000" key="minRange" id="minRange" name="minRange" theme="simple" /></td>
                    <td><s:textfield label="" value="000" key="maxRange" id="maxRange" name="maxRange" theme="simple" /></td>
                </tr>
                <%for (int i = 0; i < strList.size(); i++) {
                    String st = strList.get(i);
                %>
                <tr>
                    <td><%=st%> :</td>
                    <td><s:textfield label="NPA" value="000" key="min<%=st%>Range" id="min<%=st%>Range" name="min<%=st%>Range" theme="simple" /></td>
                    <td><s:textfield label="" value="000" key="max<%=st%>Range" id="max<%=st%>Range" name="max<%=st%>Range" theme="simple" /></td>
                </tr>
                <%}%>
                <tr align="right">
                    <td><s:submit value="Generate XMLs" /></td>
                </tr>
            </table>

            <s:hidden id="selectedXpathsToAction" value="" key="serviceInfo.selectedXpaths" />
            <s:textfield id="elementToBeReplaced" name="elementToBeReplaced" value=""></s:textfield>

        </s:form>
    </div>
    
    </body>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</html>