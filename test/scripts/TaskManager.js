// TaskManager
// Responsible for maanaging Tasks.
// Author: Gokuldas
// Last Update: 23/01/2011
//var tsk_ns = tsk_ns || {};
var tsk_ns = tsk_ns || {};

//tsk_ns.storage = function () {
//    // create instance of local storage
//    var local = window.localStorage,
//    // Save to local storage
//        saveItem = function (key, item) {
//            local.setItem(key, item);
//        },
//        getItem = function (key, item) {
//            local.getItem(key, item);
//        },
//        hasLocalStorage = function () {

//            return('localStorage' in window && window['localStorage'] !=null);
//        };

//// public members
//    return {
//        saveItem: saveItem,
//        getItem: getItem,
//        hasLocalStorage: hasLocalStorage

//    };


//}();
$(document).ready(function () {
    //  localStorage.clear();  // Doing only once will comment out later
    // alert("Welcome!");
    $("#tabs").tabs();
    $("#taskNew,#taskSave,#taskClear").button();
    $("#taskStartDate,#taskVisitDate").datepicker(
                    {
                        dateFormat: 'dd/mm/yy'

                    });
    $("#taskVisitTime").timepicker({
        ampm: true
    });
    //$( "#dialog:ui-dialog" ).dialog( "destroy" );

    $("#save-message").dialog({
       autoOpen:false,
        modal: true,
        buttons: {
            Ok: function () {
                $(this).dialog("close");
            }
        }
    });

    WireEvents();
    tsk_ns.taskManager.init();

});

function WireEvents() {
    // wire new button event
    var curDate = new Date();
    $('#taskNew').click(function () {
                tsk_ns.taskManager.newTask();
                tsk_ns.taskManager.copyTaskToUI();
      
        //    alert("New Task Created");
    });
    // Wire Save button
    $('#taskSave').click(function () {
        //alert("You clicked me");
        // var taskName = $('#taskName').val();
        // alert("You entered " + taskName);
        //save value 
        var message = tsk_ns.taskManager.saveTask();
        console.log(message);
        // $("#dlgmessage").val(message);
        $("#save-message").dialog("open");
    });

    // clear event
    $('#taskClear').click(function () {
        //alert('you clicked me!');
     //   $("#dlgmessage").val('This is some message');
         $("#save-message").dialog("open");
    });

}

Array.prototype.indexOf = function (obj) {
    for (var i = 0; i< this.length; i++) 
        {
            if(obj!==null)
            {
                if(this[i].id===obj.id)
                return i;
            }
        }
        return -1;
}

// Task Manager singleton implemented using revealing module design pattern.


tsk_ns.taskManager = function () {
    // declare lastID
    // Declare tasks array 
    var lastID = 1000,
        tasks = [],
        sTasks = "",
    // Declare Task object
        curTask = {
            id: 1,
            name: "newTask",
            description: "",
            startDate: new Date(),
            visitDate: new Date(),
            visitTime: "",
            price: 0,
            status: "Pending"
        },

    // Initialises the tasks from localStorage
    init = function () {
        //get lastID 
        var sLastID = tsk_ns.storage.getItem("lastTaskID");
        if (sLastID !== null) {
            lastID = parseInt(sLastID);
        }

        var sTasks = tsk_ns.storage.getItem("tasks");
        //  alert(sTasks);
        if (sTasks !== null) {
            // parse tasks
            tasks = JSON.parse(sTasks);
        } else {

            alert("No Tasks in storage");
        }

    },
    // Save Task
    saveTask = function () {
        var message = "";
        try {
            // alert(curTask.name);
            // curTask.name = $('#taskName').val();
            // alert(curTask.name);
            populateTask();
            var index = tasks.indexOf(curTask)
            if (index === -1) {
                // New Task
                tasks.push(curTask);
            } else {
                // Updating task.
                tasks[index] = curTask;
            }
            sTasks = JSON.stringify(tasks);
            tsk_ns.storage.saveItem("tasks", sTasks);
            tsk_ns.storage.saveItem("lastTaskID", lastID.toString());
            // alert(curTask.name + 'with ID: ' + curTask.id + "Saved Successfully!");
            message = curTask.name + " with ID: " + curTask.id + " Saved Successfully!";
            return message;
        } catch (e) {

            //alert("Error occured while saving task and error is " + e.Message);
            message = "Error occured while saving task and error is" + e.Message;
            return message;
        }
    },

    // Create new Task 
    newTask = function () {
        lastID = lastID + 1;
        curTask.id = lastID;
        curTask.name = "New Task";
        curTask.description = "";
        curTask.startDate = new Date();
        curTask.visitDate = new Date();
        curTask.visitTime = new Date();
        curTask.price = 10;
        curTask.status = "Pending";
    },

    // PopulateTask
    populateTask = function () {
        curTask.name = $("#taskName").val();
        curTask.description = $("#taskDescription").val();
        curTask.startDate = $("#taskStartDate").val();
        curTask.visitDate = $("#taskVisitDate").val();
        curTask.visitTime = $("#taskVisitTime").val();
        curTask.price = $("#taskPrice").val();
        curTask.status = $("#taskStatus").val();

    },

    // CopyTaskToUI 
    copyTaskToUI = function () {
        try {
            $('#taskName').val(curTask.name);
            $("#taskDescription").val(curTask.description);
            $("#taskPrice").val(10);
            $("#taskStartDate").datepicker("setDate", curTask.startDate);
            $("#taskVisitDate").datepicker("setDate", curTask.visitDate);
            $("#taskVisitTime").timepicker("setTime", curTask.visitTime);
            $("#taskStatus").val("In Progress");
        } catch (e) {
            alert(e.Message);
        }

    };



    // declare public members here

    return {

        init: init,
        saveTask: saveTask,
        newTask: newTask,
        populateTask: populateTask,
        copyTaskToUI: copyTaskToUI
    };


} ();
