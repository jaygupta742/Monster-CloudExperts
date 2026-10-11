({
	getQuote : function(component, event, helper) {
        var action = component.get("c.get_Quote");
        
        action.setParams({
            'recordId' : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS') {
                var rval = JSON.parse(response.getReturnValue());
                if(rval.qt.Contact__c!=null){
                var subject = "Quote from Monster for "+rval.qt.Contact__r.Name+" | "+rval.qt.Name;
                var body = '<div style="white-space: nowrap;">Dear '+ rval.qt.Contact__r.Name +',<br/><br/>'
              					+'Greetings from <b>Monster</b> !!!<br/>'
              					+'In Continuation to your requirement, we are forwarding you the Quotation with this mail.<br/>'
                				+'We attached our best Quotation as pdf bellow, please check it.'
              					+'Kindly reach us back for any required clarification/change.<br/>' 
              					+'Thanking you and looking forward for your order.<br/><br/></div>' 
					            +'Because we care.®,<br/>';
                
                component.set("v.quote", rval.qt);
                component.set("v.to", rval.to);
                component.set("v.cc", rval.cc);
                component.set("v.subject", subject);
                component.set("v.body", body);
                }
                
                if(rval.qt.Contact__c==null){
                     var subject = "Quote from Monster for "
                var body = '<div style="white-space: nowrap;">Dear '
              					+'Greetings from <b>Monster</b> !!!<br/>'
              					+'In Continuation to your requirement, we are forwarding you the Quotation with this mail.<br/>'
                				+'We attached our best Quotation as pdf bellow, please check it.'
              					+'Kindly reach us back for any required clarification/change.<br/>' 
              					+'Thanking you and looking forward for your order.<br/><br/></div>' 
					            +'Because we care.®,<br/>';
                
                component.set("v.quote", rval.qt);
                component.set("v.to", rval.to);
                component.set("v.cc", rval.cc);
                component.set("v.subject", subject);
                component.set("v.body", body);
                }
                
            }
            else {
                console.log("error in getQuote");
            }
        });
        
        $A.enqueueAction(action);
	},
    
     getTemplateheper : function(component, event , helper) { 
        var action = component.get("c.getTemplate");
        //console.log('All product' + action);
       
         action.setParams({
            'recId' : component.get("v.recordId")
        });
      
        action.setCallback(this,function(response){
            var state= response.getState();
            console.log('All template state'+ state);
            if(state==='SUCCESS'){
                var res=(response.getReturnValue());
                //console.log('All template result pdf name++++++' + res.PDF__c);
                
                component.set("v.temp" , res);
                 // component.set("v.pdfname" , res.PDF__c);
            }
            
        });
        $A.enqueueAction(action); 
    }
})