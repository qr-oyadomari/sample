@isTest
private class CusManageWrapperTest {
    //テスト設定
    @testSetup static void methodName() {}
    
    //コンストラクタ
    @isTest static void Test_CusManageWrapper() {
        CusManageWrapper result = new CusManageWrapper();
        
        System.assertNotEquals(null, result);
    }
    
    //サイン画像処理の設定
    @isTest static void Test_signUrlList() {
        CusManage__c cusManage = new CusManage__c();
        
        //サイン画像が添付されている場合
        cusManage.customer_code__c = '10000';
        cusManage.Name = 'テスト顧客名1';
        cusManage.sign__c = '<p><img src="url1" alt="salesforce_logo.png"></img><img src="url2" alt="salesforce_logo.png"></img><img src="url3" alt="salesforce_logo.png"></img></p>';
        
        CusManageWrapper result1 = new CusManageWrapper(cusManage);
        System.debug('サイン画像が添付されている場合 : ' + result1.signUrlList.size());
        System.assertEquals(3, result1.signUrlList.size());
        
        //サイン画像が添付されていない場合
        cusManage.customer_code__c = '20000';
        cusManage.Name = 'テスト顧客名2';
        cusManage.sign__c = '';
        
        CusManageWrapper result2 = new CusManageWrapper(cusManage);
        System.debug('サイン画像が添付されていない場合 : ' + result2.signUrlList.size());
        System.assertEquals(0, result2.signUrlList.size());
        
        //サイン画像が添付されているがURLが存在しない場合
        cusManage.customer_code__c = '30000';
        cusManage.Name = 'テスト顧客名3';
        cusManage.sign__c = '<p><img alt="salesforce_logo.png"></img><img alt="salesforce_logo.png"></img><img alt="salesforce_logo.png"></img></p>';
        
        CusManageWrapper result3 = new CusManageWrapper(cusManage);
        System.debug('サイン画像が添付されているがURLが存在しない場合 : ' + result3.signUrlList.size());
        System.assertEquals(0, result3.signUrlList.size());
    }
}