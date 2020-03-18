<%@taglib uri="/struts-tags" prefix="s"%>
<html >
<%@ page import="java.util.*,com.ctl.simulation.helper.XpathUtil,com.ctl.app.virtual.AddServiceInfo" %>
<%
List<String> restXpathMapKey = (List<String>)request.getAttribute("restXpathMapKey");
List<String> generatedXpathMapKey = (List<String>)request.getAttribute("generatedXpathMapKey");
String fileText = (String)request.getAttribute("fileText");
AddServiceInfo serviceInfo = (AddServiceInfo)session.getAttribute("serviceInfo");
Map<String,String> generatedXpathMap = serviceInfo.getGeneratedXpathMap();
Iterator itr=generatedXpathMap.keySet().iterator();
Map<String,String> hm = new HashMap<String,String>(); 
XpathUtil util = new XpathUtil();
while (itr.hasNext()) {
    String thisEntry = (String) itr.next();
    //hm.put(thisEntry, util.retrieveElementValue(generatedXpathMap.get(thisEntry),serviceInfo.getFile().toString()));
    hm.put(thisEntry, util.getValueByXpath(serviceInfo.getFile(),generatedXpathMap.get(thisEntry)));
    System.out.print(thisEntry+"--->>>"+hm.get(thisEntry));
}
%>
<body>
    
          
<script language="javascript">

function moveOptionsProfiles(option){                  
       var clauseOptionsAvailable = document.getElementById('GeneratedXpaths');
       var clauseOptionsSelected = document.getElementById('SelectedXpaths');
       if(option=='selectedToRightProfiles'){    
              moveSelectedOptionsProfiles(clauseOptionsAvailable, clauseOptionsSelected, option);
       }
       else if(option=='selectedToLeftProfiles'){
              moveSelectedOptionsProfiles(clauseOptionsSelected, clauseOptionsAvailable, option);
       }
       else if(option=='selectedAllRightProfiles'){
              moveAllOptionsProfiles(clauseOptionsAvailable, clauseOptionsSelected, option);
       }
       else if(option=='selectedAllLeftProfiles'){
              moveAllOptionsProfiles(clauseOptionsSelected, clauseOptionsAvailable, option);
       }
}

function moveOptionsProfiles3(option){                  
    var clauseOptionsAvailable = document.getElementById('GeneratedXpaths');
    var clauseOptionsSelected = document.getElementById('SelectedOperationXpaths');
    if(option=='selectedToRightProfiles'){    
           moveSelectedOptionsProfiles(clauseOptionsAvailable, clauseOptionsSelected, option);
           disableDrag();
    }
    else if(option=='selectedToLeftProfiles'){
           moveSelectedOptionsProfiles(clauseOptionsSelected, clauseOptionsAvailable, option);
           disableDrag();
    }
    else if(option=='selectedAllRightProfiles'){
    	alert("Only single element can be selected");
           //moveAllOptionsProfiles(clauseOptionsAvailable, clauseOptionsSelected, option);
    }
    else if(option=='selectedAllLeftProfiles'){
    	alert("Only single element can be selected");
           //moveAllOptionsProfiles(clauseOptionsSelected, clauseOptionsAvailable, option);
    }
}


function moveSelectedOptionsProfiles(from, to, option){       
       var i=0, selectedObject;
       while(i<from.length){   
              var optionOne = from.options[i];
              if(optionOne.selected){
                     to.options[to.length] = new Option(optionOne.text, optionOne.value);
                     from.removeChild(optionOne);
                     i=0;
              }
              else i++;
       }
    
       if(option=='selectedToLeftProfiles') {
              selectedObject = from;
       }
       else if(option=='selectedToRightProfiles'){
       selectedObject = to;
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



function disableDrag(){
	if(document.GeneratedXpathsForm.SelectedOperationXpaths.options.length>0){
		document.getElementById("disableMe").disabled=true;
	}else{
		document.getElementById("disableMe").disabled=false;
	}
}



</script>

<div class="ui-widget ui-widget-content ui-corner-all">
<s:form action="CreateSimulatorContext.action"  name="GeneratedXpathsForm" method="post" enctype="multipart/form-data" >
<table align="center" width="600" class=menu1 border="1">
<tr><td colspan="3"><b>Operation : </b><s:property value="operationName" /></td></tr>
<tr><td colspan="3"><b>Operation Value : </b><s:property value="operationValue" /></td></tr>
<body>
<h3 align="center"><b>
ADD SERVICE
</b></h3>
<tr>
<th align = "center" ><b>Generated Keys</b></th>
<td>&nbsp;</td>
<th align = "left" ><b>Selected Keys</b></th>
</tr>

<tr>
<td>
<select name="GeneratedXpaths" id="GeneratedXpaths" SIZE="+20" style="width:70mm">
<s:iterator value="serviceInfo.generatedXpathMapKey" var="xpath">
 <option><s:property value="#xpath" /></option>
</s:iterator>
</select>
</td>
 
<td>
<input type="button" class="trans" name="button5" size="5" value="&nbsp;&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;" onclick="javascript:moveOptionsProfiles('selectedToRightProfiles')"/>
<input type="button" class="trans" value="&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;" name="button6" size="5" onclick="javascript:moveOptionsProfiles('selectedAllRightProfiles')">
<input type="button" class="trans" value="&nbsp;&nbsp;&nbsp;&lt;&nbsp;&nbsp;&nbsp;" name="button7" size="5" onclick="javascript:moveOptionsProfiles('selectedToLeftProfiles')">
<input type="button" class="trans" value="&nbsp;&nbsp;&lt;&lt;&nbsp;&nbsp;" name="button8" size="5" onclick="javascript:moveOptionsProfiles('selectedAllLeftProfiles')">
</td>

<td>
<select name="SelectedXpaths" id="SelectedXpaths"  SIZE="+20" style="width:70mm" multiple="multiple" >
</select>
</td><div id="operationTBLocation"></div>

</tr> 
<tr><td colspan="3"></td></tr>
<tr><td colspan="3"></td></tr>
<tr><td colspan="3"></td></tr>
<tr><td colspan="3"></td></tr>
<tr><td colspan="3"></td></tr>




</tbody>
</table>

 <table align="center">
<tr><td><s:file label="Upload Sample Response xml" key="serviceInfo.sampleResponseFile"/></td></tr>

<tr></tr>
<tr align="right"><td>

<s:submit  value="Add Service" onclick="javascript:getSelectedXpaths()" 	/>
</td></tr>
</table>

<s:hidden id="selectedXpathsToAction" value="" key="serviceInfo.selectedXpaths"/>
<s:set name="oopr" value="operationName"/>
<s:set name="ooprv" value="operationValue"/>
<s:hidden id="selectedOperXpathsToAction" value="%{#oopr}" key="selectedOperXpathsToAction"/>
<s:hidden id="SelectedOperationXpaths" value="%{#oopr}" key="SelectedOperationXpaths"/>
<s:hidden id="valueOfOperToAction" value="%{#ooprv}" key="valueOfOperToAction"/>
 </s:form>
    </div>
    
    </body>
    
   <script type="text/javascript">
    function populateGeneratedKeys(){
        if(document.getElementById("oprType1").checked){
            document.getElementById("GeneratedXpaths").options.length = 0;
            //alert('I am here1');  
            <%for(int i =0;i<generatedXpathMapKey.size();i++){%>
                document.getElementById("GeneratedXpaths").options[<%=i%>] = new Option('<%=generatedXpathMapKey.get(i)%>','<%=generatedXpathMapKey.get(0)%>')
            <%}%>
            //alert('I am here1');          
        }
        if(document.getElementById("oprType2").checked){
            document.getElementById("GeneratedXpaths").options.length = 0;
            <% int count = 0;
            for(int i =0;i<generatedXpathMapKey.size();i++){%>
                document.getElementById("GeneratedXpaths").options[<%=i%>] = new Option('<%=generatedXpathMapKey.get(i)%>','<%=generatedXpathMapKey.get(i)%>')
            <%count++;}%>
            <%for(int i =0;i<restXpathMapKey.size();i++){%>
            document.getElementById("GeneratedXpaths").options[<%=i+count%>] = new Option('<%=restXpathMapKey.get(i)%>','<%=restXpathMapKey.get(i)%>')
            document.getElementById("GeneratedXpaths").options[<%=i+count%>].style.color='blue';
        <%}%>
           // alert('I am here2');          
        }
    }
    
    function createOperElementTextBox() {
        
        
        if(document.getElementById("oprType1").checked)
            {
            var operName = document.getElementById("SelectedOperationXpaths").value;
            createOperTextBox(operName);
            }
        
    }
    function createOperTextBox(keyName) {
        
          var parent = document.getElementById("operationTBLocation");
          
             var label = document.createElement("label");
             label.setAttribute("for","id2");
             parent.appendChild(label);
             parent.value= keyName ;
             parent.innerHTML = "Value for "+keyName ;
             
            
             var element2 = document.createElement("input");
             element2.type = "text";
             element2.id = "Opertext";
             element2.name = "Opertext";
             parent.appendChild(element2);

            

        }
        
    function getSelectedXpaths()
    {
    	/* if(document.getElementById("oprType1").checked)
    		{
        var valueOfOperation = document.getElementById("Opertext").value;

        document.getElementById('valueOfOperToAction').value = valueOfOperation;
    		} */
        
        var selectXpathValuesArr=new Array();
        var selectXpathSelectLength=document.GeneratedXpathsForm.SelectedXpaths.options.length;
        var selectXpathSelect=document.GeneratedXpathsForm.SelectedXpaths.options;  
        
        for(var x=0;x<selectXpathSelectLength;x++)
        {
            selectXpathValuesArr[x]=selectXpathSelect[x].text;
        }
        document.getElementById('selectedXpathsToAction').value=selectXpathValuesArr.join("#"); 
        //alert(document.getElementById('selectedOperXpathsToAction').value);
        /* var selectXpathValuesArr3=new Array();
        var selectXpathSelectLength3=document.GeneratedXpathsForm.SelectedOperationXpaths.options.length;
        var selectXpathSelect3=document.GeneratedXpathsForm.SelectedOperationXpaths.options;    
        
        for(var x=0;x<selectXpathSelectLength3;x++)
        {
            selectXpathValuesArr3[x]=selectXpathSelect3[x].text;
        }
        document.getElementById('selectedOperXpathsToAction').value=selectXpathValuesArr3.join("#");  */
        
        //alert(document.getElementById('selectedXpathsToAction').value);
        
    }
    </script>    
</html>


