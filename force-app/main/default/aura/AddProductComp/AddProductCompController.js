({
    scriptsLoaded: function (component, event, helper) {
        //console.log('Script loaded..'); 
    },
    doInit: function (component, event, helper) {
        helper.getAccountStatusApexHelper(component, event, helper);
        var bb = [];
        var cc = [];
        helper.x = bb;
        helper.y = cc;
        component.set('v.showFirstpage', true);
        component.set('v.lstSize', 0);

        helper.fetchtodaysdate(component, event, helper);
        helper.fetchtpreviousdate(component, event, helper);
        helper.fetchOpportunity(component, event, helper);
        helper.fetchProducts(component, event, helper);
        helper.fetchacc(component, event, helper);
        helper.fetchcountry(component, event, helper);
        helper.fetchskutype(component, event, helper);
        helper.fetchpronames(component, event, helper);
        helper.pageLoadClassMethod1(component, event, helper);
        helper.fetchprochannels(component, event, helper);
        helper.fetchtenure(component, event, helper);
        helper.fetchptypes(component, event, helper);
    },

    HandleCancelPage: function (component) {
        var action = $A.get("e.force:closeQuickAction");
        action.fire();
    },

    searchTable: function (cmp, event, helper) {
        var allRecords = cmp.get("v.allData");
        var searchFilter = event.getSource().get("v.value").toUpperCase();
        var tempArray = [];
        var i;
        for (i = 0; i < allRecords.length; i++) {
            if ((allRecords[i].prodName && allRecords[i].prodName.toUpperCase().indexOf(searchFilter) != -1) ||
                (allRecords[i].category && allRecords[i].category.toUpperCase().indexOf(searchFilter) != -1) ||
                (allRecords[i].subCategory && allRecords[i].subCategory.toUpperCase().indexOf(searchFilter) != -1) ||
                (allRecords[i].typeProd && allRecords[i].typeProd.toUpperCase().indexOf(searchFilter) != -1)) {
                tempArray.push(allRecords[i]);
            }
        }
        //cmp.set("v.oppliWrapList",tempArray);
    },
    ctcvalidate: function (component, event, helper) {
        var ind = event.getSource().get("v.label");
        var lltp = component.get("v.proceedItem");
        var pname = component.get("v.category");
        var tpoper = lltp[ind].tpo;
        console.log('tpoper:' + tpoper);
        var ctcc = lltp[ind].opli.CTC__c;
        console.log('ctcc:' + ctcc);

        console.log(pname);

        if (pname == 'TPS' || pname == 'Sprynt') {
            lltp[ind].opli.Unit_Price__c = ((Number(ctcc) * Number(tpoper)) / 100);
            // console.log('price:'+lltp[ind].opli.Unit_Price__c);
        }
        if (pname == 'VCF') {
            lltp[ind].opli.Unit_Price__c = tpoper;
        }

        var llp = component.get("v.proceedItem");

        for (var item of llp) {
            var unit = item.opli.Unit_Price__c;
            var qty = item.opli.Quantity_Unit__c;
            item.opli.Base_Total__c = helper.getBaseTotal(item);
            if (item.opli.Discount_Type__c === "%") {
                var discountval = item.opli.Discount_Value__c;
                var base = item.opli.Base_Total__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Discount_Amount_1__c = ((base / qty) * discountval) / 100;
                item.opli.Gross_Total__c = base - (((base / qty) * discountval) / 100);
            }
            if (item.opli.Discount_Type__c === "Amount") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = base - (dis);
                item.opli.Discount_Amount_1__c = dis;
            }
            if (item.opli.Discount_Type__c === "Base Price Override") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = dis;
                item.opli.Discount_Amount_1__c = base - (dis);
            }
            if (item.opli.Discount_Type__c === "Price Override") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = dis * qty;
                item.opli.Discount_Amount_1__c = base - (dis * qty);
            }
            if (item.opli.Quantity_Unit__c > item.to) {
                alert('Quantity Should be in the Range of BIN');
                item.opli.Quantity_Unit__c = item.fromqty;

            }
        }

        component.set("v.proceedItem", lltp);

        component.set("v.proceedItem", llp);


        // $A.get('e.force:refreshView').fire();

    },

    tpovalidate: function (component, event, helper) {
        var ind = event.getSource().get("v.label");
        var lltp = component.get("v.proceedItem");
        var pname = component.get("v.category");
        var tpoper = lltp[ind].tpo;
        console.log('tpoper:' + tpoper);
        var ctcc = lltp[ind].opli.CTC__c;
        console.log('ctcc:' + ctcc);

        console.log(pname);

        if (pname == 'TPS' || pname == 'Sprynt') {
            lltp[ind].opli.Unit_Price__c = ((Number(ctcc) * Number(tpoper)) / 100);
            // console.log('price:'+lltp[ind].opli.Unit_Price__c);
        }
        if (pname == 'VCF') {
            lltp[ind].opli.Unit_Price__c = tpoper;
        }

        component.set("v.proceedItem", lltp);
        // $A.get('e.force:refreshView').fire();

    },

    selectAllCheckbox: function (component, event, helper) {
        var lltp = component.get("v.oppliWrapList");
        var testervalue = component.get("v.sel");
        var filt = [];
        for (var item of lltp) {
            item.ckb = testervalue;
            filt.push(item);

        }
        component.set('v.oppliWrapList', filt);
        $A.get('e.force:refreshView').fire();

    },
    callopli: function (component, event, helper) {
        var ind1 = event.getSource().get("v.label");
        var it1 = component.get("v.oppliWrapList");
        var opid = it1[ind1].opli.OpliId__c;
        var tdate = component.get("v.todays");
        var opp = component.get("v.oppInstance");
        var ptypes = component.get("v.ptype");

        var mlogin = it1[ind1].Masterlogin;
        console.log('mlogin:' + mlogin);

        var pname = component.get("v.category");
        //console.log('pname:'+pname);

        //var sku=it1[ind1].opli.SKU_Type__c;
        var sku = it1[ind1].skutype;
        console.log('sku orig:' + sku);

        //var ed=it1[ind1].End_Date__c;
        //console.log('end date:'+ed);

        var action = component.get('c.getoplitenure');
        //console.log('v.recordId:'+component.get("v.recordId"));
        action.setParams({
            "opId": opid
        });

        action.setCallback(this, function (response) {
            //console.log('I am in callback: '+action);
            var status = response.getState();
            //console.log('status:'+status);
            if (status === "SUCCESS") {

                component.set('v.oppTenure', response.getReturnValue());
                component.set("v.quoteupsell", response.getReturnValue());
                var sd = it1[ind1].opli.Start_Date__c;
                var items1 = component.get("v.oppliWrapList");
                var items3 = component.get("v.oppInstance");
                /*  if(items3.Opportunity_Type__c=='Upsell')
                {
                    var ten=component.get("v.oppTenure"); 
                }
                if(items3.Opportunity_Type__c !='Upsell')
                {
                    var ten=items1[0].prodtenure;
                }  */
                var qq = response.getReturnValue();



                // var ten=component.get("v.oppTenure"); 
                var ten = qq.Tenure_Months__c;
                console.log('tenure month:' + ten);
                var edttt = qq.End_Date__c;
                console.log('end date:' + edttt);

                var pcountry = qq.Product_Country__c;
                var pcode = qq.Product_Code__c;
                console.log('pcode:' + pcode);

                var pindu = qq.Product_Industry__c;
                var geo = qq.Product_Geo_Scope__c;
                console.log('geo:' + geo);

                var skutype = qq.SKU_Type__c;
                console.log('sku fetched:' + skutype);

                var skuu = qq.Sku_Type1__c;
                console.log('new sku skuu:' + skuu);

                var linkedtypes = qq.Product_Type1__c;
                console.log('linkedtypes:' + linkedtypes);

                var today = new Date();

                // get today's date in `MM/DD/YYYY` format
                var now = today.toLocaleDateString('en-US');
                console.log('todys date:' + now);

                var dt1 = new Date(now);
                var mon = dt1.getMonth();
                var dt = dt1.getDate();
                var yyyy = dt1.getFullYear();

                var newst = yyyy + '-' + mon + '-' + dt;
                console.log('newstart date:' + newst);



                if (ten == '12 Months') { var prodten = 13; }
                if (ten == '6 Months') { var prodten = 7; }
                if (ten == '3 Months') { var prodten = 4; }
                if (ten == '1 Month') { var prodten = 2; }
                if (ten == '1 Week') { var prodten = 1; }
                if (ten == '0.1 Months') { var prodten = 1; }

                if (ten == '1 Day') { var prodten = 1; }
                if (ten == '2 Days') { var prodten = 1; }
                if (ten == '3 Days') { var prodten = 1; }
                if (ten == '15 days') { var prodten = 1; }


                if (ten == '4 Days') { var prodten = 1; }
                if (ten == '5 Days') { var prodten = 1; }
                if (ten == '6 Days') { var prodten = 1; }
                if (ten == '7 Days') { var prodten = 1; }
                if (ten == '14 Days') { var prodten = 1; }

                if (ten == '60 Days') { var prodten = 1; }

                if (ten == '2 Months') { var prodten = 3; }
                if (ten == '9 Months') { var prodten = 10; }


                const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

                // alert('start date is: '+sd+' tenure is'+prodten);

                var loop = new Date(sd);
                var mon = loop.getMonth();
                var dl = loop.getDate();
                // var dll=dl-1;
                if (ten == '1 Week') {
                    var dll = dl + 6;
                }
                if (ten == '0.1 Months') {
                    var dll = dl + 2;
                }

                if (ten == '1 Day') {
                    var dll = dl + 0;
                }
                if (ten == '2 Days') {
                    var dll = dl + 1;
                }
                if (ten == '4 Days') {
                    var dll = dl + 3;
                }
                if (ten == '5 Days') {
                    var dll = dl + 4;
                }
                if (ten == '6 Days') {
                    var dll = dl + 5;
                }
                if (ten == '7 Days') {
                    var dll = dl + 6;
                }
                if (ten == '14 Days') {
                    var dll = dl + 13;
                }
                if (ten == '60 Days') {
                    var dll = dl + 59;
                }
                else {
                    var dll = dl - 1;
                }
                console.log('days added:' + dll);
                var monn = mon + prodten;

                if (dll.length < 2) {
                    dll = '0' + dll;
                }
                if (monn.length < 2) {
                    monn = '0' + monn;
                }
                var newDate = new Date(loop.setMonth(monn));
                var newDate1 = new Date(newDate.setDate(dll));
                console.log('newdate1:' + newDate1);

                console.log('monn anup:' + monn);

                var dd = newDate1.getDate();
                var mm = newDate1.getMonth();
                var yyyy = newDate1.getFullYear();

                /*if(mm=='0'){
                    mm=1;
                }*/

                var loop = yyyy + '-' + mm + '-' + dd;
                console.log('loop extra:' + loop);


                /////////////////////////////////////////////////////////////////////////////
                var startdate;
                var enddate;
                // if(ptypes=='Upsell'){
                if (opp.Opportunity_Type__c == 'Upsell') {
                    //startdate=sd;
                    enddate = edttt;
                }
                // if(ptypes!='Upsell'){
                if (opp.Opportunity_Type__c != 'Upsell') {

                    // startdate=now;
                    enddate = loop;
                }



                /////////////////////////////////////////////////////////////////////////////
                // it1[ind1].opli.Start_Date__c=startdate;  

                //it1[ind1].opli.End_Date__c=loop;
                it1[ind1].opli.End_Date__c = enddate;
                // it1[ind1].opli.Discount_Type__c=qq.Adjustment_Type__c;
                //  it1[ind1].opli.Discount_Value__c=qq.Adjusted_Value__c;
                component.set("v.oppliWrapList", it1);

                console.log(`@@ ptypes : ${ptypes}`);
                console.log(`@@ pname : ${pname}`);
                console.log(`@@ linkedtypes : ${linkedtypes}`);
                console.log(`@@ skutype : ${skutype}`);

                if (ptypes == 'Upsell') {

                    if (pname == 'User Login' || pname == 'Power Login' || pname == 'Inventory Login') {
                        var tot = Number(Number(qq.Unit_Price__c) * Number(it1[ind1].Masterlogin) / 100);
                        console.log('total amount:' + tot);

                        it1[ind1].opli.Unit_Price__c = tot;
                        if (pcountry != null || pcountry != undefined) {
                            it1[ind1].opli.Product_Country__c = pcountry;
                        }
                        //it1[ind1].opli.Product_Country__c=pcode;
                        if (pindu != null || pindu != undefined) {
                            it1[ind1].opli.DB_Type_Industry__c = pindu;
                        }
                        if (geo != null || geo != undefined) {
                            it1[ind1].opli.DB_Scope_Geography__c = geo;
                        }
                        if (ten != null || ten != undefined) {
                            it1[ind1].opli.Tenure_Months__c = ten;
                        }
                        if (skuu != null || skuu != undefined) {
                            it1[ind1].opli.Sku_Type1__c = skuu;
                        }


                        console.log('enterd into upsell to upsell if');

                    }

                    if (pname == 'Views' || pname == 'Mailers' || pname == 'Excel Views' || pname == 'CV Views' || pname == 'Excel Downloads' || pname == 'PC Pack' || pname == 'OC Pack' || pname == 'Login Pack') {
                        console.log('ented into mailers,viwes and excel viws 1');
                        if ((linkedtypes != 'Core-Std') || (skutype == 'To be derived')) {
                            alert('Linked Product should be of Core Std Or Sku Type is not similar Or Sku Type should not be To be Derived');
                            return null;
                        }

                        if (linkedtypes == 'Core-Std') {

                            console.log('ented into mailers,viwes and excel viws 2');
                            if (pcountry != null || pcountry != undefined) {
                                it1[ind1].opli.Product_Country__c = pcountry;
                            }
                            //it1[ind1].opli.Product_Country__c=pcode;
                            if (pindu != null || pindu != undefined) {
                                it1[ind1].opli.DB_Type_Industry__c = pindu;
                            }
                            if (geo != null || geo != undefined) {
                                it1[ind1].opli.DB_Scope_Geography__c = geo;
                            }
                            if (ten != null || ten != undefined) {
                                it1[ind1].opli.Tenure_Months__c = ten;
                                component.set("v.oppliWrapList", it1);

                            }
                            if (skuu != null || skuu != undefined) {
                                it1[ind1].opli.Sku_Type1__c = skuu;
                            }
                        }

                        console.log('@@ updated tenure : ' + it1[ind1].opli.Tenure_Months__c);
                    }
                }

                /*if(ten=="Tenure" || ten=="Per Month" || ten=="As per Balance Original Contract") {
                   it1[ind1].opli.End_Date__c=null;  
                }*/
                // component.set("v.enddate11",loop); 
                component.set("v.oppliWrapList", it1);
                //alert('start date is '+sd+'end date is '+loop);*/


            }
        });
        $A.enqueueAction(action);



    },
    calloplii1: function (component, event, helper) {
        console.log('On change Quote Line Items');
        var ind1 = event.getSource().get("v.label");
        var it1 = component.get("v.oppliWrapList");
        var opid = it1[ind1].opli.OPLI__c;
        console.log('opid:' + opid);
        var tdate = component.get("v.todays");
        var opp = component.get("v.oppInstance");

        var mlogin = it1[ind1].Masterlogin;
        console.log('mlogin:' + mlogin);

        // var sku=it1[ind1].opli.SKU_Type__c;
        var sku = it1[ind1].skutype;
        console.log('sku orig:' + sku);

        var pname = component.get("v.category");
        console.log('pname:' + pname);
        var ed = it1[ind1].End_Date__c;
        var upOppStartDate = it1[ind1].Start_Date__c;
        console.log('end date:' + ed);

        var ptypes = component.get("v.ptype");

        var action = component.get('c.getoplitenure1');
        //console.log('v.recordId:'+component.get("v.recordId"));
        action.setParams({
            "opId": opid
        });

        action.setCallback(this, function (response) {
            //console.log('I am in callback: '+action);
            var status = response.getState();
            console.log('@@ status : ' + status);
            if (status === "SUCCESS") {

                component.set("v.oppupsell", response.getReturnValue());

                //component.set('v.oppTenure',response.getReturnValue());
                var sd = it1[ind1].opli.Start_Date__c;

                var items1 = component.get("v.oppliWrapList");
                var items3 = component.get("v.oppInstance");
                /*  if(items3.Opportunity_Type__c=='Upsell')
                {
                    var ten=component.get("v.oppTenure"); 
                }
                if(items3.Opportunity_Type__c !='Upsell')
                {
                    var ten=items1[0].prodtenure;
                }  */
                var qq = response.getReturnValue();



                // var ten=component.get("v.oppTenure"); 
                var ten = qq.Tenure_Months__c;
                console.log('tenure month:' + ten);
                var eddd = qq.End_Date__c;
                console.log('end date:' + eddd);
                /****/
                var startddd = qq.Start_Date__c;
                console.log('end date:' + startddd);

                var skutype = qq.SKU_Type__c;
                console.log('sku fetched:' + skutype);

                var skuu = qq.Sku_Type1__c;
                console.log('sku new:' + skuu);


                var linkedtypes = qq.Product_Type1__c;
                console.log('linkedtypes:' + linkedtypes);



                var pcountry = qq.Product_Country__c;
                // var pcode=qq.Product_Code__c;
                console.log('pcontry:' + pcountry);

                var pindu = qq.DB_Type_Industry__c;
                var geo = qq.DB_Scope_Geography__c;
                console.log('geo:' + geo);

                var today = new Date();

                // get today's date in `MM/DD/YYYY` format
                var now = today.toLocaleDateString('en-US');
                console.log('todys date:' + now);

                var dt1 = new Date(now);
                var mon = dt1.getMonth();
                var dt = dt1.getDate();
                var yyyy = dt1.getFullYear();

                var newst = yyyy + '-' + mon + '-' + dt;
                console.log('newstart date:' + newst);



                if (ten == '12 Months') { var prodten = 13; }
                if (ten == '6 Months') { var prodten = 7; }
                if (ten == '3 Months') { var prodten = 4; }
                if (ten == '1 Month') { var prodten = 2; }
                if (ten == '1 Week') { var prodten = 1; }
                if (ten == '0.1 Months') { var prodten = 1; }

                if (ten == '1 Day') { var prodten = 1; }
                if (ten == '2 Days') { var prodten = 1; }
                if (ten == '4 Days') { var prodten = 1; }
                if (ten == '5 Days') { var prodten = 1; }
                if (ten == '6 Days') { var prodten = 1; }
                if (ten == '7 Days') { var prodten = 1; }
                if (ten == '14 Days') { var prodten = 1; }
                if (ten == '60 Days') { var prodten = 1; }

                if (ten == '3 Days') { var prodten = 1; }
                if (ten == '15 days') { var prodten = 1; }

                if (ten == '2 Months') { var prodten = 3; }
                if (ten == '9 Months') { var prodten = 10; }


                // alert('start date is: '+sd+' tenure is'+prodten);

                var loop = new Date(sd);
                var mon = loop.getMonth();
                var dl = loop.getDate();
                // var dll=dl-1;
                if (ten == '1 Week') {
                    var dll = dl + 6;
                }
                if (ten == '0.1 Months') {
                    var dll = dl + 2;
                }

                if (ten == '1 Day') {
                    var dll = dl + 0;
                }
                if (ten == '2 Days') {
                    var dll = dl + 1;
                }

                if (ten == '3 Days') {
                    var dll = dl + 2;
                }

                if (ten == '4 Days') {
                    var dll = dl + 3;
                }
                if (ten == '5 Days') {
                    var dll = dl + 4;
                }
                if (ten == '6 Days') {
                    var dll = dl + 5;
                }
                if (ten == '7 Days') {
                    var dll = dl + 6;
                }
                if (ten == '14 Days') {
                    var dll = dl + 13;
                }

                if (ten == '15 days') {
                    var dll = dl + 14;
                }

                if (ten == '60 Days') {
                    var dll = dl + 59;
                }
                else {
                    var dll = dl - 1;
                }
                console.log('days added:' + dll);
                var monn = mon + prodten;
                var newDate = new Date(loop.setMonth(monn));
                var newDate1 = new Date(newDate.setDate(dll));


                var dd = newDate1.getDate();
                var mm = newDate1.getMonth();
                var yyyy = newDate1.getFullYear();

                var loop = yyyy + '-' + mm + '-' + dd;
                //console.log('loop extra:'+loop);


                /////////////////////////////////////////////////////////////////////////////
                var startdate;
                var enddate;
                /**/
                var startenddate;
                if (ptypes == 'Upsell') {
                    //startdate=sd;
                    enddate = eddd;
                    startenddate = startddd;
                }
                if (ptypes != 'Upsell') {
                    // startdate=now;
                    enddate = loop;
                }



                /////////////////////////////////////////////////////////////////////////////
                // it1[ind1].opli.Start_Date__c=startdate;  

                //it1[ind1].opli.End_Date__c=loop;
                it1[ind1].opli.End_Date__c = enddate;
                it1[ind1].opli.Start_Date__c = startenddate;

                //   it1[ind1].opli.Discount_Type__c=qq.Discount_Type__c;
                // it1[ind1].opli.Discount_Value__c=qq.Discount_Value__c;

                component.set("v.oppliWrapList", it1);
                console.log(`ptypes : ${ptypes}`);
                console.log(`pname : ${pname}`);
                console.log(`linkedtypes : ${linkedtypes}`);
                console.log(`sku type : ${skutype}`);

                if (ptypes == 'Upsell') {
                    if (pname == 'User Login' || pname == 'Power Login' || pname == 'Inventory Login') {
                        var tot = Number(Number(qq.Unit_Price__c) * Number(it1[ind1].Masterlogin) / 100);
                        console.log('total amount:' + tot);

                        it1[ind1].opli.Unit_Price__c = tot;
                        if (pcountry != null || pcountry != undefined) {
                            it1[ind1].opli.Product_Country__c = pcountry;
                        }
                        //it1[ind1].opli.Product_Country__c=pcode;
                        if (pindu != null || pindu != undefined) {
                            it1[ind1].opli.DB_Type_Industry__c = pindu;
                        }
                        if (geo != null || geo != undefined) {
                            it1[ind1].opli.DB_Scope_Geography__c = geo;
                        }
                        if (ten != null || ten != undefined) {
                            it1[ind1].opli.Tenure_Months__c = ten;
                        }
                        if (skuu != null || skuu != undefined) {
                            it1[ind1].opli.Sku_Type1__c = skuu;
                        }
                        console.log('enterd into upsell to upsell if');

                    }
                    if (pname == 'Views' || pname == 'Mailers' || pname == 'Excel Views' || pname == 'CV Views' || pname == 'Excel Downloads' || pname == 'PC Pack' || pname == 'OC Pack' || pname == 'Login Pack') {
                        if ((linkedtypes != 'Core-Std') || (skutype == 'To be derived')) {
                            alert('Linked Product should be of Core Std Or Sku Type should not be To be Derived');
                            return null;
                        }
                        if (linkedtypes == 'Core-Std') {
                            console.log('ented into mailers,viwes and excel viws');
                            if (pcountry != null || pcountry != undefined) {
                                it1[ind1].opli.Product_Country__c = pcountry;
                            }
                            //it1[ind1].opli.Product_Country__c=pcode;
                            if (pindu != null || pindu != undefined) {
                                it1[ind1].opli.DB_Type_Industry__c = pindu;
                            }
                            if (geo != null || geo != undefined) {
                                it1[ind1].opli.DB_Scope_Geography__c = geo;
                            }
                            if (ten != null || ten != undefined) {
                                it1[ind1].opli.Tenure_Months__c = ten;
                            }
                            if (skuu != null || skuu != undefined) {
                                it1[ind1].opli.Sku_Type1__c = skuu;
                            }
                        }
                        console.log(`Product Tenure : ${it1[ind1].opli.Tenure_Months__c}`);
                    }
                }
                // }


                /* if(ten=="Tenure" || ten=="Per Month" || ten=="As per Balance Original Contract") {
                   it1[ind1].opli.End_Date__c=null;  
                }*/
                // component.set("v.enddate11",loop); 
                component.set("v.oppliWrapList", it1);
            }
            //alert('start date is '+sd+'end date is '+loop);*/

            /*let lltp=component.get("v.oppliWrapList");
                
                for(let items of lltp){
                    let skutypes=items.opli.SKU_Type__c;
                     let linkedtypess=items.opli.Product_Type1__c;
                    
                   if(pname=='Views' || pname=='Mailers' || pname=='Excel Views'){
                         if((linkedtypess!='Core-Std') || (skutypes!=sku) || (skutypes=='To be derived')){
                            alert('Linked Product should be of Core Std Or Sku Type is not similar Or Sku Type should not be To be Derived');
                            return null;
                        }

                }
                
            }*/
        });
        $A.enqueueAction(action);


    },


    showNext: function (component, event, helper) {
        var items1 = component.get("v.oppliWrapList");
        var items2 = component.get("v.oppliWrapper");
        var items3 = component.get("v.oppInstance");

        var pname = component.get("v.category");
        var skutype = component.get("v.skutype");
        console.log('pname:' + pname);
        console.log('skutype :' + skutype);

        // component.set('v.showFirstpage',false);

        var allItems = component.get("v.oppliWrapList");
        //console.log('allItems: '+allItems[0].ckb);
        var selectedItems = [];
        for (var item of allItems) {
            if (item.ckb == true) {
                var unit = item.opli.Unit_Price__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Discount_Amount_1__c = 0;
                if (helper.isUnberry(item)) {
                    // Product BT__c has no platform fee, so compute Base Total here
                    item.opli.Base_Total__c = helper.getBaseTotal(item);
                    item.opli.Gross_Total__c = item.opli.Base_Total__c;
                } else {
                    item.opli.Gross_Total__c = unit * qty;
                }
                /* if(item.opli.OPLI__c!=null){
                    var skutype=item.skutype;
                    console.log('sku type:'+skutype);
                    var linkedtypes=item.opli.Product_Type1__c;
                                        console.log('linkedtypes:'+linkedtypes);

                    
                    if(pname=='Views' || pname=='Mailers' || pname=='Excel Views'){
                         if((linkedtypes!='Core-Std') || (skutype!=sku) || (skutype=='To be derived')){
                            alert('Linked Product should be of Core Std Or Sku Type is not similar Or Sku Type should not be To be Derived');
                           // return null;
                        }
                }
                }*/

                /* if(item.opli.OPLI__c==null || item.opli.OPLI__c==''){
                    alert('Link Opportunty Items');
                       component.set('v.showFirstpage',true);
  
                    return null;
                }*/
                var ten = item.prodtenure;
                console.log('ten months:' + ten);
                //var tdt=item.todaydate;
                var tdt = item.opli.Start_Date__c;
                //let enddt=tdt.setMonth(tdt.getMonth()+ten);
                //console.log('enddate anup:'+enddt);

                // var ten=items1[0].prodtenure;
                //  alert('start date is: '+tdt+' tenure is'+ten);

                //if(items3.Opportunity_Type__c!='Upsell'){
                if (ten == '12 Months') { var prodten = 13; }
                if (ten == '6 Months') { var prodten = 7; }
                if (ten == '3 Months') { var prodten = 4; }
                if (ten == '1 Month') { var prodten = 2; }
                // }
                /*if(items3.Opportunity_Type__c=='Upsell'){
                 if(ten=='12 Months') {var prodten=14;}
        if(ten=='6 Months') {var prodten=8;}
        if(ten=='3 Months') {var prodten=5;}
        if(ten=='1 Month') {var prodten=3;}
            }*/

                var loop = new Date(tdt);
                var mon = loop.getMonth();
                var dl = loop.getDate();
                var dll = dl - 1;

                var monn = mon + prodten;
                var newDate = new Date(loop.setMonth(monn));
                var newDate1 = new Date(newDate.setDate(dll));


                var dd = newDate1.getDate();
                var mm = newDate1.getMonth();
                var yyyy = newDate1.getFullYear();

                if (mm.length < 10) {
                    mm = '0' + mm;
                }
                if (dd.length < 10) {
                    dd = '0' + dd;
                }
                var loop = yyyy + '-' + mm + '-' + dd;

                helper.x.push(item);
            }
        }
        component.set('v.showFirstpage', false);

        //taking the value from helper array



        component.set('v.proceedItem', helper.x);


    },
    endate: function (component, event, helper) {
        console.log("end date is running");

        var ind = event.getSource().get("v.name");
        var ss = component.get('v.proceedItem');

        var sd = ss[ind].opli.Start_Date__c;
        var items1 = component.get("v.oppliWrapList");
        var ten = ss[ind].prodtenure;

        if (ten == '12 Months') { var prodten = 12; }
        if (ten == '6 Months') { var prodten = 6; }
        if (ten == '3 Months') { var prodten = 3; }
        if (ten == '1 Month') { var prodten = 1; }
        if (ten == '1 Week') { var prodten = 1; }

        //alert('start date is: '+sd+' tenure is'+prodten);

        var loop = new Date(sd);
        console.log('start date : ' + loop);

        var mon = loop.getMonth();
        var dl = loop.getDate();
        var yearl = loop.getFullYear();

        var monn = mon + prodten;
        if (monn > 11) { monn = monn % 12; yearl += 1; }

        var newDate1 = new Date(yearl, monn, dl);
        console.log("new date : " + newDate1);
        var newDate2 = ss[ind].opli.End_Date__c;

        var dt2 = new Date(newDate2);

        monn += 1;
        var monthl = monn > 9 ? monn : '0' + monn;
        dl -= 1;
        var datel = dl > 9 ? dl : '0' + dl;

        var loop1 = yearl + '-' + monthl + '-' + datel;

        console.log('d2 ms : ' + dt2.getTime());
        console.log('new date ms : ' + newDate1.getTime());

        if (dt2.getTime() > newDate1.getTime()) {
            console.log('end date : ' + ss[ind].opli.End_Date__c);
            console.log('update to : ' + loop1);
            alert('Enter Valid End Date');
            ss[ind].opli.End_Date__c = loop1;
            component.set("v.proceedItem", ss);
        }
    },
    /*stdate : function(component,event,helper){
        var ind= event.getSource().get("v.class");
        var ss=component.get('v.proceedItem');
        var sd=ss[ind].opli.Start_Date__c;
        
        var items1=component.get("v.oppliWrapList");
        var ten=ss[ind].prodtenure;
        
       
       // alert('ten is '+ten);
        if(ten=='12 Months') {var prodten=13;}
        if(ten=='6 Months') {var prodten=7;}
        if(ten=='3 Months') {var prodten=4;}
        if(ten=='1 Month') {var prodten=2;}
                if(ten=='1 Week') {var prodten=1;}

        
        // alert('start date is: '+sd+' tenure is'+prodten);
        
        var loop=new Date(sd);
        var mon=loop.getMonth();
        var dl=loop.getDate();
        //var dll=dl-1;
        if(ten=='1 Week'){
           var dll=dl+6;
        }
        else{
         var dll=dl-1;
        }
        
        var monn=mon+prodten;
        var newDate=new Date(loop.setMonth(monn));
        var newDate1=new Date(newDate.setDate(dll));
        
       
        var dd = newDate1.getDate();
        var mm = newDate1.getMonth();
        var yyyy = newDate1.getFullYear();
        
         if(dd.length<2){
            dd='0'+dd;
        }
        if(mm.length<2){
            mm='0'+newDate;
        }
        
        var loop = yyyy+'-'+mm+'-'+dd;
        console.log('enddate st:'+loop);
        
        var pp=component.get("v.ptype");
        if(pp!='Upsell'){
        ss[ind].opli.End_Date__c=loop;
            
        component.set("v.enddate11",loop); 
        }
        component.set("v.proceedItem",ss); 
        //alert('start date is '+sd+'end date is '+loop);
        
        
         ////////////////////////////validation /////////////////////////////////////////////////////////////////////////////////////
        var today = new Date();
 
// get today's date in `MM/DD/YYYY` format
var now = today.toLocaleDateString('en-US');
//console.log('todys date:'+now);
         var dt1=new Date(now);
        var mon=dt1.getMonth();
        var dt=dt1.getDate();
                var yyyy =dt1.getFullYear();
        
                 var monn=mon+1;
       // var newDate=new Date(dt1.setMonth(monn));
        //var newDate1=new Date(newDate.setDate(dll));
                var newst=yyyy+'-'+monn+'-'+dt;
               // console.log('newstart date:'+newst);
        
         var loop=new Date(sd);
        var mon=loop.getMonth();
        var dl=loop.getDate();
        //var dll=dl-1;
        
         var dll=dl+1;
        
        
        var monn=mon+1;
        var newDate=new Date(loop.setMonth(monn));
        var newDate1=new Date(newDate.setDate(dll));
        
        
        var dd = newDate1.getDate();
        var mm = newDate1.getMonth();
        var yyyy = newDate1.getFullYear();
        
        var loop = yyyy+'-'+mm+'-'+dd;
        //console.log('sttttt@@:'+loop);
        
        //console.log('start date:'+sd);
        var ttdays=component.get("v.todays");
        //console.log('ttdays:'+ttdays);
        
            //var ToDate = new Date();

           var d1 = new Date(now);
               // var d1 = new Date(ToDate);

        var d2 = new Date(sd);
        console.log('d1 now:'+now);
       
        if(d2.getTime() < d1.getTime()){
             
            ss[ind].opli.Start_Date__c=ttdays;
             component.set("v.proceedItem",ss); 

            alert('Please Enter Date Greater than todays date');
               return null;
        }
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
        
        
        for(var item of ss)
            
        {           var dt1=new Date(item.opli.Start_Date__c);
         var dt2=new Date(item.opli.End_Date__c);
         
         if (dt1.getTime() > dt2.getTime()){
             alert('start date can not be greater than end date');
             return;}
         
        }
        
    },*/
    stdate: function (component, event, helper) {
        var ind = event.getSource().get("v.class");
        var ss = component.get('v.proceedItem');
        var sd = ss[ind].opli.Start_Date__c;
        console.log('start date stt:' + sd);
        var prev = component.get("v.previous");

        var ttdays = component.get("v.todays");

        var items1 = component.get("v.oppliWrapList");
        //var ten1=ss[ind].prodtenure;
        var ten1 = ss[ind].opli.Tenure_Months__c;

        console.log('ten:' + ten1);
        var pp = component.get("v.ptype");

        var action = component.get('c.getenddate');

        action.setParams({
            'wroppp': JSON.stringify(component.get('v.proceedItem')),
            'stdate': sd.toString(),
            'ten': ten1.toString()
        });

        action.setCallback(this, function (response) {
            var status = response.getState();
            //console.log('status:'+status);
            if (status === "SUCCESS") {
                if (sd < prev) {
                    alert('Start Date cannot be less than todays date');
                    ss[ind].opli.Start_Date__c = ttdays;
                    component.set("v.proceedItem", ss);

                    return null;
                }
                if (pp != 'Upsell') {
                    // console.log('enddate:'+response.getReturnValue());
                    ss[ind].opli.End_Date__c = response.getReturnValue();
                }


                component.set("v.proceedItem", ss);

            }

        });
        $A.enqueueAction(action);
    },
    /* endatevalidate : function(component,event,helper){
        var ind= event.getSource().get("v.name");
        var lltp=component.get("v.proceedItem");
        
        var lltp1=component.get("v.oppupsell");
        var lltp2 = component.get("v.quoteupsell");
        
        var edate=lltp[ind].opli.End_Date__c;
        console.log('orginal enddate:'+edate);
        
        var edatenew = lltp1 === null ? lltp2.End_Date__c : lltp1.End_Date__c;
        console.log('eupsell new:' + edatenew);
        
        //var edtt=lltp1[ind].End_Date__c;
        // console.log('upsell enddate:'+edtt);
        
        if(edate>edatenew){
            alert('End Date cant be greater than Linked End Date');
            lltp[ind].opli.End_Date__c=edatenew;
            
        }
        component.set("v.proceedItem",lltp);
        
        
    },*/
    endatevalidate: function (component, event, helper) {
        var ind = event.getSource().get("v.name");
        var lltp = component.get("v.proceedItem");
        var lltp1 = component.get("v.oppupsell");
        var lltp2 = component.get("v.quoteupsell");

        var startdate = lltp[ind] && lltp[ind].opli ? lltp[ind].opli.Start_Date__c : null;
        console.log('original startdate:' + startdate);

        var edate = lltp[ind] && lltp[ind].opli ? lltp[ind].opli.End_Date__c : null;
        console.log('original enddate:' + edate);

        if (startdate && edate) {
            var startDateObj = new Date(startdate);
            var endDateObj = new Date(edate);
            if (endDateObj < startDateObj) {
                // Invalid: End date is less than start date
                alert('End date cannot be less than start date');
                lltp[ind].opli.End_Date__c = null;
            }
        }

        var edatenew = lltp1 === null ? lltp2 && lltp2.End_Date__c : lltp1 && lltp1.End_Date__c;
        console.log('eupsell new:' + edatenew);

        if (edate && edatenew && new Date(edate) > new Date(edatenew)) {
            alert('End Date cant be greater than Linked End Date');
            lltp[ind].opli.End_Date__c = edatenew;
        }

        component.set("v.proceedItem", lltp);
    },

    endatevalidate1: function (component, event, helper) {
        var index = event.getSource().get("v.name");
        var lltp = component.get("v.proceedItem");
        var llopp = component.get("v.oppupsell");

        var edtt = llopp.End_Date__c;

        var edate = lltp[index].opli.End_Date__c;

        for (var item of lltp) {
            if (item.opli.End_Date__c == edtt) {

            }
        }

    },


    saveOn: function (component, event, helper) {
        console.log('running save method');

        var ss = component.get('v.proceedItem');
        var ttdays = component.get("v.todays");
        var ptypes = component.get("v.ptype");
        var pname = component.get("v.category");

        for (let item of ss) {
            let DiscountCap = item.disamt * item.opli.Quantity_Unit__c;
            if (item.opli.Discount_Amount_1__c > DiscountCap) {
                alert(`Exceeded Discount Cap Amount. Max Allowed ${DiscountCap}. Given Discount Amount ${item.opli.Discount_Amount_1__c}.`);
                return;
            }
        }

        for (let item of ss) {
            if (pname == 'TPS') {
                if (item.opli.CTC__c == null) {
                    alert('Please Enter CTC Amount');
                    return null;
                }
            }
        }

        var action = component.get('c.saveOpli');
        action.setParams({
            "strWrap": JSON.stringify(component.get('v.proceedItem')),
            "RecordId": component.get('v.recordId'),
            "ptypes": component.get('v.ptype')
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            var type;
            var msg;
            var title;

            var status = response.getState();
            if (status === "SUCCESS") {
                type = "success";
                msg = 'Opportunity Line Items Added';
                title = "Opportunity Line Items Added Successfully!!!!";
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/" + component.get("v.recordId")
                });
                urlEvent.fire();
            }
            if (state === "ERROR") {
                let err = response.getError();
                title = 'Error';
                type = 'error';
                msg = err[0].message;
            }
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": title,
                "type": type,
                "message": msg
            });

            toastEvent.fire();
        });
        $A.enqueueAction(action);
    },
    doFilter: function (component, event, helper) {
        var skuty = component.get('v.skutype');
        //   var skuty = sku_type.toLowerCase();
        var queryTerm = component.get('v.text1');
        //var queryTerm = component.find('enter-search').get('v.value');
        var srctm = queryTerm.toLowerCase();
        var cat = component.get("v.category");
        var ptype = component.get("v.ptype");
        // alert('product name is '+cat);

        var channel = component.get("v.channel");
        var typ = component.get("v.type");
        var pri = component.get("v.principal");
        var fullList = component.get('v.allData');
        //console.log('fullList:'+fullList);
        var filteredList = [];
        console.log("The Skuty is  : " + skuty);

        if ((cat == 'None' || skuty == 'None' || typ == 'None' || ptype == 'None') && queryTerm == '') {
            alert('Please choose Mandatory Filters');
        }
        else {

            if (cat != 'None' && skuty == 'None' && pri == 'None' && typ == 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat == 'None' && skuty != 'None' && pri == 'None' && typ == 'None') {
                for (var item of fullList) {
                    if (item.skutype == skuty) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat == 'None' && skuty == 'None' && pri != 'None' && typ == 'None') {
                for (var item of fullList) {
                    if (item.prodtenure == pri) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat == 'None' && skuty == 'None' && pri == 'None' && typ != 'None') {
                for (var item of fullList) {
                    if (item.proocountry == typ) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat != 'None' && skuty != 'None' && pri == 'None' && typ == 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat && item.skutype == skuty) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat != 'None' && skuty != 'None' && pri != 'None' && typ == 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat && item.skutype == skuty && item.prodtenure == pri) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat != 'None' && skuty != 'None' && pri != 'None' && typ != 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat && item.skutype == skuty && item.prodtenure == pri && item.proocountry == typ) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat != 'None' && skuty == 'None' && pri != 'None' && typ != 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat && item.prodtenure == pri && item.proocountry == typ) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat != 'None' && skuty != 'None' && pri == 'None' && typ != 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat && item.skutype == skuty && item.proocountry == typ) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat != 'None' && skuty == 'None' && pri == 'None' && typ != 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat && item.proocountry == typ) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat != 'None' && skuty == 'None' && pri != 'None' && typ == 'None') {
                for (var item of fullList) {
                    if (item.prodName == cat && item.prodtenure == pri) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat == 'None' && skuty != 'None' && pri != 'None' && typ == 'None') {
                for (var item of fullList) {
                    if (item.skutype == skuty && item.prodtenure == pri) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat == 'None' && skuty != 'None' && pri == 'None' && typ != 'None') {
                for (var item of fullList) {
                    if (item.skutype == skuty && item.proocountry == typ) {

                        filteredList.push(item);
                    }
                }
            }
            if (cat == 'None' && skuty != 'None' && pri != 'None' && typ != 'None') {
                for (var item of fullList) {
                    if (item.skutype == skuty && item.proocountry == typ && item.prodtenure == pri) {

                        filteredList.push(item);
                    }
                }
            }

            if (srctm != '') {
                for (var item of fullList) {
                    if (item.sku.toLowerCase().includes(srctm)) {
                        filteredList.push(item);
                    }
                }
            }

        }

        component.set('v.oppliWrapList', filteredList);
        component.set('v.lstSize', filteredList.length);
        helper.fetchopli1(component, event, helper, skuty, cat);
        helper.fetchopli(component, event, helper, skuty, cat);
        $A.get('e.force:refreshView').fire();
    },
    addmore: function (component, event, helper) {
        setTimeout(function () {
            $('#example').DataTable().clear();
            $('#example').DataTable().destroy();
        }, 500);
        component.set("v.sel", false);
        component.set("v.text1", '');
        component.set("v.principal", '');
        component.set("v.type", '');
        component.set("v.category", '');
        var eet = component.get("v.oppliWrapList");

        for (var item of eet) {
            if (item.ckb == true) {
                helper.x.push(item);
            }

        }
        var ggt = [];
        component.set('v.oppliWrapList', ggt);



        $A.get('e.force:refreshView').fire();
    },
    access: function (component, event, helper) {
        component.set('v.nex', true);

    },
    onChangeColor: function (component, event, helper) {
        //component.set('v.nex1',true);
        //var queryterm=component.get('v.text2');
        var queryTerm = component.find('enter-search').get('v.value');
        var srctm = queryTerm.toLowerCase();
        //console.log(queryTerm);
        //console.log(srctm);
        var tty = component.get('v.allDatas');
        var cat = component.get("v.ACCcategory");
        var typ = component.get("v.ACCtype");
        var pri = component.get("v.ACCprincipal");
        var aacessoryType = component.get('v.accesstype');
        var nny = component.get('v.proceedItem');
        //console.log('accesorytype'+aacessoryType);
        //console.log(tty);
        //console.log(nny);
        //console.log('cat'+cat);
        //console.log('type'+typ);
        //console.log('principal'+pri);
        if (queryTerm == '') {
            console.log('working');
        }
        ////for selected product Author:Amit////////        
        var ulu = [];
        for (var item of tty) {
            for (var items of nny) {
                if (items.opli.Product__c == item.opli.Product__c) {
                    item.opli.Discount_Type__c = items.opli.Discount_Type__c;
                    item.opli.Discount_Value__c = items.opli.Discount_Value__c;
                    item.opli.Qty__c = items.opli.Qty__c;
                    item.opli.Unit_Price__c = items.opli.Unit_Price__c;
                    //console.log('working');
                    ulu.push(item);
                }


            }
        }
        /////with filter/////
        var jio = [];
        for (var item of tty) {
            if (item.category == cat && item.principal == pri && item.typeProd == typ) {
                jio.push(item);
            }
        }
        ///with search text box///
        var filteredList = [];

        for (var item of tty) {
            if (item.prodName.toLowerCase().includes(srctm)) {
                filteredList.push(item);
                //console.log(filteredList);
            }

        }


        if (aacessoryType == 'Selected Product Accessories' && queryTerm == '') {
            component.set('v.oppliWrapList1', ulu);
        }
        else if (aacessoryType == 'None' && queryTerm != '') {
            component.set('v.oppliWrapList1', filteredList);
        }
        else {
            component.set('v.oppliWrapList1', jio);
        }
        setTimeout(function () {
            $('#example').DataTable();
            // add lightning class to search filter field with some bottom margin..  
            $('div.dataTables_filter input').addClass('slds-input');
            $('div.dataTables_filter input').css("marginBottom", "10px");
        }, 500);
        $A.get('e.force:refreshView').fire();

    },
    NextOn: function (component, event, helper) {
        component.set('v.nex1', true);
        //console.log(component.get('v.nex1'));

        var allItemst = component.get("v.oppliWrapList1");
        var allItems = component.get("v.oppliWrapList");
        console.log('checking line: ' + allItems);
        console.log('checking acc: ' + allItemst);
        //console.log('allItems: '+allItemst.length);
        var selectedItems = [];
        const mySet1 = new Set();
        for (let item of allItemst) {
            if (item.ckb == true) {
                //item.opli.Qty__c=1;
                helper.y.push(item);
            }

        }
        console.log('mySet1:' + mySet1);
        //console.log('selectedItems: '+helper.y);
        component.set('v.proceedAcc', helper.y);
    },
    selectAllCheckbox1: function (component, event, helper) {
        var lltp = component.get("v.oppliWrapList1");
        var testervalue = component.get("v.sel1");
        var filt = [];
        for (var item of lltp) {
            item.ckb = testervalue;
            filt.push(item);

        }
        component.set('v.oppliWrapList1', filt);
        $A.get('e.force:refreshView').fire();
    },
    SAVEWITHACC: function (component, event, helper) {
        let Products = component.get('v.proceedItem');
        for (let item of Products) {
            let DiscountCap = item.disamt * item.opli.Quantity_Unit__c;
            if (item.opli.Discount_Amount_1__c > item.DiscountCap) {
                alert(`Exceeded Discount Cap Amount. Max Allowed ${DiscountCap}. Given Discount Amount ${item.opli.Discount_Amount_1__c}.`);
                return;
            }
        }

        var action = component.get('c.saveOplit');
        action.setParams({
            "strWrap": JSON.stringify(component.get('v.proceedItem')),
            "strWrapt": JSON.stringify(component.get('v.proceedAcc')),
            "RecordId": component.get('v.recordId')
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            var type;
            var msg;
            var title;
            var status = response.getState();
            if (status === "SUCCESS") {
                type = "success";
                msg = 'Opportunity Line Items Added';
                title = "Opportunity Line Items Added Successfully!!!!";

                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/" + component.get("v.recordId")
                });
                urlEvent.fire();
            }
            if (state === "ERROR") {
                let err = res.getError();
                title = 'Error';
                type = 'error';
                msg = err[0].message;
            }
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": title,
                "type": type,
                "message": msg
            });

            toastEvent.fire();
        });
        $A.enqueueAction(action);
    },
    addmore1: function (component, event, helper) {
        setTimeout(function () {
            $('#example').DataTable().clear();
            $('#example').DataTable().destroy();
        }, 500);
        var eet = component.get("v.oppliWrapList1");
        component.set('v.accesstype', 'None');
        component.set('v.text2', '');
        component.set('v.ACCtype', '');
        component.set('v.ACCprincipal', '');
        component.set('v.ACCcategory', '');
        for (var item of eet) {
            if (item.ckb == true) {
                helper.y.push(item);
            }

        }
        var ggt = [];
        component.set('v.oppliWrapList1', ggt);

        $A.get('e.force:refreshView').fire();
    },
    showSpinner: function (component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true);
    },

    // this function automatic call by aura:doneWaiting event 
    hideSpinner: function (component, event, helper) {
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    },
    handleHideErrorDisplayModal: function (component, event, helper) {
        helper.handleHideErrorDisplayModal(component);
    },


    validateqty: function (component, event, helper) {

        var llp = component.get("v.proceedItem");

        for (var item of llp) {
            var unit = item.opli.Unit_Price__c;
            var qty = item.opli.Quantity_Unit__c;
            item.opli.Base_Total__c = helper.getBaseTotal(item);
            if (item.opli.Discount_Type__c === "%") {
                var discountval = item.opli.Discount_Value__c;
                var base = item.opli.Base_Total__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Discount_Amount_1__c = ((base / qty) * discountval) / 100;
                item.opli.Gross_Total__c = base - (((base / qty) * discountval) / 100);
            }
            if (item.opli.Discount_Type__c === "Amount") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = base - (dis);
                item.opli.Discount_Amount_1__c = dis;
            }
            if (item.opli.Discount_Type__c === "Base Price Override") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = dis;
                item.opli.Discount_Amount_1__c = base - (dis);
            }
            if (item.opli.Discount_Type__c === "Price Override") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = dis * qty;
                item.opli.Discount_Amount_1__c = base - (dis * qty);
            }
            if (item.opli.Quantity_Unit__c > item.to) {
                alert('Quantity Should be in the Range of BIN');
                item.opli.Quantity_Unit__c = item.fromqty;

            }
        }

        component.set("v.proceedItem", llp);
    },

    checkdiscount: function (component, event, helper) {
        console.log("Inside checkdiscount");
        var llp = component.get("v.proceedItem");
        for (var item of llp) {

            var unit = item.opli.Unit_Price__c;
            var qty = item.opli.Quantity_Unit__c;

            item.disamt = (unit * qty) * item.discap / 100;

            //item.disamt = unit

            //item.opli.Discount_Value__c = item.discap;


            console.log(item.disamt);
            console.log(item.discap);
            console.log(unit);
            console.log(qty);
            console.log(item.opli.Base_Total__c);
            console.log(item.opli.Discount_Value__c);

            if (item.opli.Discount_Type__c === "%") {
                var discountval = item.opli.Discount_Value__c;
                var base = item.opli.Base_Total__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Discount_Amount_1__c = ((base / qty) * discountval) / 100;
                item.opli.Gross_Total__c = base - (((base / qty) * discountval) / 100);
            }
            if (item.opli.Discount_Type__c === "Amount") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = base - (dis);
                item.opli.Discount_Amount_1__c = dis;
            }
            if (item.opli.Discount_Type__c === "Base Price Override") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = dis;
                item.opli.Discount_Amount_1__c = base - (dis);
            }
            if (item.opli.Discount_Type__c === "Price Override") {
                var base = item.opli.Base_Total__c;
                var dis = item.opli.Discount_Value__c;
                var qty = item.opli.Quantity_Unit__c;
                item.opli.Gross_Total__c = dis * qty;
                item.opli.Discount_Amount_1__c = base - (dis * qty);
            }
        }

        let discountValusInput = component.find("DiscountValue");
        if (Array.isArray(discountValusInput)) {
            let index = 0;
            discountValusInput.forEach(function (input) {
                let currentItem = llp[index];
                console.log(currentItem);
                let DiscountCap = currentItem.disamt * currentItem.opli.Quantity_Unit__c;
                if (currentItem.opli.Discount_Amount_1__c > DiscountCap) {
                    input.setCustomValidity(`Exceeded Discount Cap Amount, Allowed : ${DiscountCap}`);
                    input.showHelpMessageIfInvalid();
                } else {
                    input.setCustomValidity('');
                    input.showHelpMessageIfInvalid();
                }
                index += 1;
            });
        } else {
            let currentItem = llp[0];
            let DiscountCap = currentItem.disamt * currentItem.opli.Quantity_Unit__c;
            if (currentItem.disamt != null && currentItem.opli.Discount_Amount_1__c && currentItem.opli.Discount_Amount_1__c > DiscountCap) {
                discountValusInput.setCustomValidity(`Exceeded Discount Cap Amount, Allowed : ${DiscountCap}`);
                discountValusInput.showHelpMessageIfInvalid();
            } else {
                discountValusInput.setCustomValidity('');
                discountValusInput.showHelpMessageIfInvalid();
            }
        }

        component.set("v.proceedItem", llp);
    },

    checkdiscountInvalid: function (component, event, helper) {
        let discountValusInput = component.find("DiscountValue");

        if (Array.isArray(discountValusInput)) {
            discountValusInput.forEach(function (input, index) {
                let currentItem = llp[index];
                let DiscountCap;

                if (currentItem.disamt != null && currentItem.disamt > 0) {
                    // Amount-based discount cap
                    DiscountCap = currentItem.disamt * currentItem.opli.Quantity_Unit__c;
                } else {
                    // Percentage-based discount cap
                    let discPercentage = currentItem.discap || 0;
                    DiscountCap = (currentItem.opli.Base_Total__c * discPercentage) / 100;
                }

                if (currentItem.opli.Discount_Amount_1__c > DiscountCap) {
                    input.setCustomValidity(
                        `Exceeded Discount Cap Amount, Allowed : ${DiscountCap}`
                    );
                    input.showHelpMessageIfInvalid();
                } else {
                    input.setCustomValidity('');
                    input.showHelpMessageIfInvalid();
                }
            });

        } else {
            let currentItem = llp[0];
            let DiscountCap;

            if (currentItem.disamt != null && currentItem.disamt > 0) {
                // Amount-based discount cap
                DiscountCap = currentItem.disamt * currentItem.opli.Quantity_Unit__c;
            } else {
                // Percentage-based discount cap
                let discPercentage = currentItem.discap || 0;
                DiscountCap = (currentItem.opli.Base_Total__c * discPercentage) / 100;
            }

            if (
                currentItem.opli.Discount_Amount_1__c &&
                currentItem.opli.Discount_Amount_1__c > DiscountCap
            ) {
                input.setCustomValidity(
                    `Exceeded Discount Cap Amount, Allowed : ${DiscountCap}`
                );
                input.showHelpMessageIfInvalid();
            } else {
                discountValusInput.setCustomValidity('');
                discountValusInput.showHelpMessageIfInvalid();
            }
        }
    },

    changevalue: function (component, event, helper) {
        var brand = component.get("v.category");
        var type = component.get("v.ptype");
        //console.log('ghfghf');
        var duplicates = component.get('v.allData');

        var list = [];
        for (var item of duplicates) {
            if (item.prodName == brand && item.typeProd == type) {
                list.push(item.skutype);
            }
        }

        var list1 = [];
        for (var item of duplicates) {
            if (item.prodName == brand && item.typeProd == type) {
                console.log('get countr ' + item.proocountry);
                if (item.proocountry != null)
                    list1.push(item.proocountry);
            }
        }

        var list2 = list.filter((x, i, a) => a.indexOf(x) === i);
        var list3 = list1.filter((x, i, a) => a.indexOf(x) === i);
        console.log('sku nature:' + list2);
        //console.log(list3);
        component.set("v.objskutype", list2);
        component.set("v.objType", list3);

    },

    changevalue2: function (component, event, helper) {
        var type = component.get("v.skutype");
        //console.log('ghfghf');
        var duplicates = component.get('v.allData');
        var list = [];
        for (var item of duplicates) {
            if (item.skutype == type) {
                console.log('get countr ' + item.proocountry);
                if (item.proocountry != null)
                    list.push(item.proocountry);
            }
        }



        var list2 = list.filter((x, i, a) => a.indexOf(x) === i);

        console.log(list2);

        component.set("v.objType", list2);


    },

    /*
    After change the product type running this method
    */
    changevalue5: function (component, event, helper) {
        var brand = component.get("v.ptype");
        var duplicates = component.get('v.allData');
        console.log(duplicates.length);
        var list = [];
        for (var item of duplicates) {
            if (item.typeProd == brand) {
                list.push(item.prodName);
            }
        }

        var list1 = [];
        for (var item of duplicates) {
            if (item.typeProd == brand) {
                console.log('get countr ' + item.proocountry);
                if (item.proocountry != null)
                    list1.push(item.proocountry);

            }
        }

        var list2 = list.filter((x, i, a) => a.indexOf(x) === i);
        var list3 = list1.filter((x, i, a) => a.indexOf(x) === i);
        console.log('cat:' + list2);
        console.log('for cuntry ' + list3);
        component.set("v.objCategory", list2);
        component.set("v.objType", list3);

    },

    enddatevalidate: function (component, event, helper) {

        var getendd = event.getSource().get("v.value");
        var datem = new Date(getendd);
        var dd = datem.getDate();
        var mm = datem.getMonth();
        var yy = datem.getFullYear();
        var enddate = dd + '-' + mm + '-' + yy;

        console.log('end date month ' + enddate);


        const d = new Date();
        var day = d.getDate();
        var month = d.getMonth();
        var year = d.getFullYear();
        var tdate = day + '-' + month + '-' + year;
        console.log('today months ' + tdate)
        var endd = Date.enddate().addDays(30);
        console.log('end date with 30 ' + tdate)
        var diff = Math.abs((enddate.getDate() - tdate.getDate()));
        console.log('get diff ' + diff);

        var gettenuremonths = component.get("v.proceedItem");
        for (var item of gettenuremonths) {
            var tenmonths = item.prodtenure;
            console.log('tenuremonth ' + tenmonths);
            //   console.log('tenuremonth '+ typeof(tenmonths));
            if (diff > tenmonths) {
                alert('End Date : End date Months Should not be grater Than Tenure Months');
                return null;
            }

        }
    },


})