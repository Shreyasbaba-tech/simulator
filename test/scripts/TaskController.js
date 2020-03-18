/// TaskController: Manages Interaction of users for tasks.
/// Author: Gokuldas C.
/// Date: 27/01/2012

/// <reference path="knockout-latest.js" />
/// <reference path="jquery-1.7.1.min.js" />
/// <reference path="jquery-ui-1.8.17.custom.min.js" />
/// <reference path="jquery-ui-timepicker-addon.js" />
/// <reference path="../images/Actions-document-edit-icon.png" />
/// <reference path="additional-methods.js" />

/// <reference path="json2.js" />
/// <reference path="jquery.tmpl.js" />
/// <reference path="ko-protected-observable.js" />
/// <reference path="date.js" />

/// <reference path="StorageManager.js" />


if (typeof String.prototype.startsWith != 'function') {
    String.prototype.startsWith = function (str) {
        return this.indexOf(str) == 0;
    };
}
ko.bindingHandlers.customerFromID = {
    init: function (element, valueAccessor, allBindingsAccessor) {
        var options = allBindingsAccessor().viewmodelOptions || {};
        var custid = valueAccessor();
        var vm = options.ViewModel;
        var sfield = options.showField;
        var curCust = vm.getCurrentCustomer(custid);
        if (curCust != null) {
           if(sfield===1)
             $(element).text(curCust.firstname + '_' + curCust.lastname);
           else if(sfield===2)
               $(element).text(curCust.phone);
           else if(sfield==3)
               $(element).text(curCust.mobile);
           
        }
        else
            $(element).text('');
    }
}



ko.bindingHandlers.datepicker = {
    init: function (element, valueAccessor, allBindingsAccessor) {
        //initialize datepicker with some optional options
        var options = allBindingsAccessor().datepickerOptions || {};
        $(element).datepicker(options);

        //handle the field changing
        ko.utils.registerEventHandler(element, "change", function () {
            try {
                var obs = valueAccessor();
                var d=$(element).datepicker("getDate");
                d=$.datepicker.formatDate('yy-mm-dd',d);
                obs(d);
            } catch (e) {
                // ignore
                // console.log(e.toString());
            }
        });

        //handle disposal (if KO removes by the template binding)
        ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
            $(element).datepicker("destroy");
        });

    },
    update: function (element, valueAccessor) {
        var value = ko.utils.unwrapObservable(valueAccessor()),
        value = $.datepicker.parseDate('yy-mm-dd', value);
        current = $(element).datepicker("getDate");

        if (value - current !== 0) {
            $(element).datepicker("setDate", value);
        }
    }
};



   

// Declare namespace.
//var taskNS = taskNS | {};
//var task = { id: 1000, name: "", description: "", startDate: new Date(), visitDate: new Date(), visitTime: "9:00 am", price: 0, status: "pending" };

// Document ready
$(function () {
    //  localStorage.clear();
    var isOnline= navigator.onLine;
    $('#onlineStatus').html(isOnline?'Yes':'No');
    $('#customerForm').validate({
        rules: {
            firstname: "required",
            lastname: "required",
            //compound rule
            email: {
                email: true

            }
        }
    });

    // Define validation options for taskform
    $('#taskForm').validate({
        rules: {
            taskname: "required",
            startdate: {
                dateITA: true

            },
            visitdate: {

                dateITA: true
            },
            visittime: {
                time12h: true
            },

            price: {
                number: true,
                min: 0
            }

        },
        messages: {
            startdate: {
                dateITA: "Invalid Date! Enter date in (dd/mm/yyyyy) format."
            },
            visitdate:{
                dateITA: "Invalid Date! Enter date in (dd/mm/yyyyy) format."
            }
        }



    });
    
    $("#tabs").tabs();
    $("#taskNew,#taskSave,#taskUpdate").button();
    $("#taskNew").button("option", "disabled", false);
    $("#taskUpdate").button("option", "disabled", true);

    //        $("#taskStartDate,#taskVisitDate").datepicker(
    //                        {
    //                            dateFormat: 'dd/mm/yy'

    //                        });
    //    $("#taskVisitTime").timepicker({
    //        ampm: true
    //    });

    var viewModel = new TaskViewModel();
    viewModel.init();
    viewModel.initCustomers();
    ko.applyBindings(viewModel);

    //$( "#dialog:ui-dialog" ).dialog( "destroy" );

    $("#dlgNotes").dialog({
        autoOpen: false,
        modal: true,
        buttons: {
            Ok: function () {

                $(this).dialog("close");
                viewModel.addTask();
            }
        }
    });


});
// Declare Customer Class
function Customer() {
    var self = this;
    self.custid = ko.observable(101);
    self.firstname = ko.observable("");
    self.lastname = ko.observable("");
    self.address1 = ko.observable("");
    self.address2 = ko.observable("");
    self.city = ko.observable("");
    self.country = ko.observable("");
    self.zip = ko.observable("");
    self.phone = ko.observable("");
    self.mobile = ko.observable("");
    self.email = ko.observable("");


}

// Declare Task class
 function Task() {
    var self = this;
    self.name= ko.observable("");
    self.id = 1,
        self.description = ko.observable(""),
        self.startDate = ko.observable($.datepicker.formatDate('yy-mm-dd',new Date())),
        self.visitDate = ko.observable($.datepicker.formatDate('yy-mm-dd',new Date())),
        self.visitTime = ko.observable("9:00 am"),
        self.price = ko.observable(0),
        self.status = ko.observable("Pending"),
        self.custid = ko.observable();
    self.notes = ko.observable("");

}

function TaskViewModel() {
    var self =this;
    self.lastID = 1000;
    self.custID = 100;
    self.taskCustomer = ko.observable();
    self.currentCustomer = ko.observable(new Customer());
    self.customerSelected = -1;
    self.customers = ko.observable([]);
    self.normalCustomers = [];
    self.selected = ko.observable();
    self.taskMenu = ko.observable("Add Task");
    self.customerMenu = ko.observable("Add Customer");
    self.editFlag = false;
    self.editCustFlag = false;
    self.tasks = ko.observableArray([]);
    self.normalTasks = [];
    self.currentTask = ko.observable(new Task());
    self.taskOptions = ['Pending', 'In Progress', 'Complete'],
    self.filterCustomer = ko.observable("");
    self.fcustomers = ko.dependentObservable(function () {
        var filter = self.filterCustomer().toLowerCase();
        console.log(filter);
        if (!filter)
            return self.customers();
        // return filtered customers
        return ko.utils.arrayFilter(self.customers(), function (item) {
            console.log(item);
            if ($.isFunction(item.firstname)) {
                console.log(item.firstname());
                return item.firstname().toLowerCase().startsWith(filter);
            } else {

                return item.firstname.toLowerCase().startsWith(filter);
            }
        });

    });
    self.filterDate = ko.observable("");
    self.ftasks = ko.dependentObservable(function () {
        var filter = self.filterDate();
        if (!filter) {
            return self.tasks();

        }
        return ko.utils.arrayFilter(self.tasks(), function (item) {
            if ($.isFunction(item.visitDate)) {
                var val1 = item.visitDate();
                var val2 = self.filterDate();
                if (item.status() === 'Complete')
                    return false;
                return (val1 === val2);
            } else {
                return self.tasks();
            }
        });

    }, self);

    // Initialise Customers
    self.initCustomers = function () {
        var sCustID = tsk_ns.storage.getItem("lastCustID");
        if (sCustID !== null) {
            self.custID = parseInt(sCustID);
        }



        var sCustomers = tsk_ns.storage.getItem("customers");
        //  alert(sTasks);
        if (sCustomers !== null) {

            self.normalCustomers = JSON.parse(sCustomers);
            self.customers(self.normalCustomers);


        } else {

        }


    },
        self.validateCustomer = function () {
            $("#customerForm").validate().form();
        },
    // Add Customer
        self.addCustomer = function () {
              $("#customerForm").validate().form();
           var custValid=  $("#customerForm").valid();
            if(custValid){
            if (self.editCustFlag) {
                self.updateCustomer();
            } else {
                self.custID += 1;
                self.currentCustomer().custid = self.custID;

                // get JSON
                var normalCust = ko.toJSON(self.currentCustomer());

                var tskCust = JSON.parse(normalCust);
                self.normalCustomers.push(tskCust);
                tsk_ns.storage.saveItem("lastCustID", self.custID.toString());

            }

            self.customers(self.normalCustomers);

            // save customers
            var mCusts = JSON.stringify(self.normalCustomers);
            console.log(mCusts);
            tsk_ns.storage.saveItem("customers", mCusts);
            // current taks
            self.customerMenu("Add Customer");
            self.currentCustomer(new Customer());
            self.editCustFlag = false;
            }

        },

    // Remove tasks.
        self.removeCustomer = function (iCustomer) {

            //self.normalTasks.splice(index,1);
            //self.normalTasks.remove(itask);
            console.log(iCustomer);
            var index = ko.utils.arrayIndexOf(self.normalCustomers, iCustomer);
            self.normalCustomers.splice(index, 1);
            self.customers(self.normalCustomers);
            var mCusts = JSON.stringify(self.normalCustomers);
            tsk_ns.storage.saveItem("customers", mCusts);
        },

    // Edit task
        self.editCustomer = function (iCustomer) {
            self.customerSelected = ko.utils.arrayIndexOf(self.normalCustomers, iCustomer);
            self.currentCustomer(iCustomer);

            self.customerMenu("Edit Customer");
            $("#tabs").tabs("option", "selected", 3);
            self.editCustFlag = true;

        };

        // Update Customer
        self.updateCustomer = function () {
            var normalCust = ko.toJSON(self.currentCustomer());
            // self.currentTask().visitDate(normalTsk.visitDate);
            var tskObject = JSON.parse(normalCust);
            if (this.customerSelected > -1)
                this.normalCustomers[self.customerSelected] = tskObject;
        }


    // Update Customer

    // Init tasks
        self.init = function () {

            var sLastID = tsk_ns.storage.getItem("lastTaskID");
            if (sLastID !== null) {
                self.lastID = parseInt(sLastID);
            }
            // Read tasks.
            var sTasks = tsk_ns.storage.getItem("tasks");
            //  alert(sTasks);
            if (sTasks !== null) {

                self.normalTasks = JSON.parse(sTasks);
                self.updateTaskArray();
                self.currentTask(new Task());
                // this.tasks(ko.observableArray(ntasks));
                //this.tasks(ntasks);

            } else {

            }

        },
        self.addTask = function () {
            $('#taskForm').validate().form();
            var isvalid = $('#taskForm').valid();
            if (isvalid) {
                if (!self.editFlag) {
                    self.lastID += 1;
                    self.currentTask().id = self.lastID;

                    //  console.log(self.taskCustomer().custid);
                    self.currentTask().custid(self.taskCustomer().custid);
                    //                var d1 = ko.utils.unwrapObservable(self.currentTask().startDate());
                    //                d1 = $.datepicker.formatDate('yy-mm-dd', d1);
                    //                var d2 = ko.utils.unwrapObservable(self.currentTask().visitDate());
                    //                d2 = $.datepicker.formatDate('yy-mm-dd', d2);

                    //                console.log(d1);
                    //                console.log(d2);
                    //                self.currentTask().startDate(d1);
                    //                self.currentTask().visitDate(d2);
                    self.tasks.push(self.currentTask);
                    tsk_ns.storage.saveItem("lastTaskID", self.lastID.toString());

                } else {
                    self.currentTask().custid = self.taskCustomer().custid;

                    //self.selected(self.currentTask);
                }
                // Save last task ID
                //self.tasks(self.normalTasks);

                // save tasks
                var mTasks = ko.toJSON(self.tasks);
                console.log(mTasks);
                tsk_ns.storage.saveItem("tasks", mTasks);
                self.normalTasks = JSON.parse(mTasks);
                self.updateTaskArray();

                // current taks
                self.taskMenu("Add Task");
                self.currentTask(new Task());
                self.editFlag = false;
            }

        };

        // Remove tasks.
        self.removeTask = function (itask) {

            //            //self.normalTasks.splice(index,1);
            //            //self.normalTasks.remove(itask);
            //            console.log(itask);
            //            var index = ko.utils.arrayIndexOf(self.normalTasks, itask);
            //            self.normalTasks.splice(index, 1);
            //            self.tasks(self.normalTasks);
            //            console.log("No of tasks are : " + self.tasks().length);
            self.tasks.remove(itask);
            var mTasks = ko.toJSON(self.tasks);
            self.normalTasks = JSON.parse(mTasks);
            tsk_ns.storage.saveItem("tasks", mTasks);
            self.updateTaskArray();
        };

        // Edit task
        self.editTask = function (itask) {
            self.selected(itask);
            //    var index=ko.utils.arrayIndexOf(self.tasks, self.selected);
            // Get Current customer

            var curCust = self.getCurrentCustomer(itask.custid);
            if (curCust !== null) {
                self.taskCustomer(curCust);
            }

            self.currentTask(itask);
            self.taskMenu("Edit Task");
            $("#tabs").tabs("option", "selected", 2);
            self.editFlag = true;
            //$("#taskNew").button("option", "disabled", true);
            //$("#taskUpdate").button("option", "disabled", false);

        };

        self.addNotes = function (itask) {

            var curCust = self.getCurrentCustomer(itask.custid);
            if (curCust !== null) {
                self.taskCustomer(curCust);
            }

            self.currentTask(itask);
            $("#dlgNotes").dialog("open");
            self.editFlag = true;

        };

        // Update task
        self.updateTask = function () {
            // self.currentTask().custid = self.taskCustomer.custid;
            var normalTsk = ko.toJSON(self.currentTask());
            // self.currentTask().visitDate(normalTsk.visitDate);
            var tskObject = JSON.parse(normalTsk);
           // var stdate = $("#taskStartDate").datepicker(
            tskObject.custid = self.taskCustomer().custid;
            console.log(tskObject.custid);
            if (this.selected > -1)
                this.normalTasks[this.selected] = tskObject;
        };

        self.getCurrentCustomer = function (cid) {
            for (var i = 0; i < self.normalCustomers.length; i++) {
                var c1 = self.normalCustomers[i];
                if (c1.custid === cid)
                    return c1;
            }
            return null;

        }

        // copy tasks.
        self.updateTaskArray = function () {

            self.tasks.removeAll();
            // self.tasks(self.normalTasks);
            for (var i = 0; i < self.normalTasks.length; i++) {
                var ctask = self.normalTasks[i];
                // var ctask = JSON.parse(self.normalTasks[i]);

                var t = new Task();
                t.id = ctask.id;
                t.name(ctask.name);
                t.description(ctask.description);
                t.startDate(ctask.startDate);
                t.visitDate(ctask.visitDate);
                t.visitTime(ctask.visitTime);
                t.price(ctask.price);
                t.status(ctask.status);
                t.custid = ctask.custid;
                t.notes(ctask.notes);
                self.tasks.push(t);
            };
        };
        self.toggleScroll= function() {
        
            $("#taskcontent").toggleClass("scrollingon");
        };

}