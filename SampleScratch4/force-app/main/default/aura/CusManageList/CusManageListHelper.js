({
    getCusManages: function(component, page, actionName) {
        console.log('CusManageListHelperハンドラ');
        var srchCusManage = JSON.parse(JSON.stringify(component.get("v.schCusManage")));
        //顧客コード
        var customer_code = srchCusManage['customer_code__c'];
        console.log("customer_code__c：" + customer_code);
        //顧客名
        var name = srchCusManage['Name'];
        console.log("Name：" + name);
        
        var action = component.get(actionName);
        action.setParams({
            "page": page,
            "customer_code": customer_code, 
            "name": name
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.page", result.page);
                component.set("v.pages", result.pageSize);
                component.set("v.total", result.total);
                component.set("v.pageNumberLinks", result.pageNumberLinks);
                component.set("v.cusManageList", result.cmwList);
            }
        
        });
        
        $A.enqueueAction(action);
    }
})