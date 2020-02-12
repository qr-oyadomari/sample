({
    doInit: function(component, event, helper) {
       var page = component.get("v.page") || 1;
       //var recordToDisply = component.find("recordSize").get("v.value");

       helper.getCusManages(component, page, "c.initCusManages");
    },
    
    schCusManages: function(component, event, helper) {
        var page = 1;
        
        helper.getCusManages(component, page, "c.getCusManages");
    },
    
    doPageNumber: function(component, event, helper) {
        console.log('リンク値：' + event.getSource().get("v.value"));
        var page = event.getSource().get("v.value");
        
        helper.getCusManages(component, page, "c.getCusManages");
    }
 
    /*navigate: function(component, event, helper) {
       // this function call on click on the previous page button  
       var page = component.get("v.page") || 1;
       // get the previous button label  
       var direction = event.getSource().get("v.label");
       // get the select option (drop-down) values.  
       var recordToDisply = component.find("recordSize").get("v.value");
       // set the current page,(using ternary operator.)  
       page = direction === "Previous Page" ? (page - 1) : (page + 1);
       // call the helper function
       helper.getAccounts(component, page, recordToDisply); 
    },*/
 
    /*onSelectChange: function(component, event, helper) {
       // this function call on the select opetion change,	 
       var page = 1
       var recordToDisply = component.find("recordSize").get("v.value");
       helper.getAccounts(component, page, recordToDisply);
    },*/
})