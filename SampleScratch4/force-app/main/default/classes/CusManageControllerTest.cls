@isTest
private class CusManageControllerTest {
    //テスト設定
    @testSetup static void methodName() {}
        
    //次ページの判断
    @isTest static void Test_hasNext() {
        boolean result = new CusManageController().hasNext;
        
        System.debug('次ページの判断 : ' + result);
        //System.assertEquals(true, result);
    }
    
    //前ページの判断
    @isTest static void Test_hasPrevious() {
        boolean result = new CusManageController().hasPrevious;
        
        System.debug('前ページの判断 : ' + result);
        //System.assertEquals(true, result);
    }
    
    //ページ数
    @isTest static void Test_pageNumber() {
        Integer result = new CusManageController().pageNumber;
        
        System.debug('ページ数 : ' + result);
        //System.assertEquals(123, result);
    }
    
    //ページ総数
    @isTest static void Test_totalPages() {
        Integer result = new CusManageController().totalPages;
        
        System.debug('ページ総数 : ' + result);
        //System.assertEquals(123, result);
    }
    
    //ページ総数の計算
    @isTest static void Test_getTotalPages() {
        Integer result = new CusManageController().getTotalPages();
        
        System.debug('ページ総数の計算 : ' + result);
        //System.assertEquals(123, result);
    }
    
    //レコード数
    @isTest static void Test_recordNumber() {
        Integer result = new CusManageController().recordNumber;
        
        System.debug('レコード数 : ' + result);
        //System.assertEquals(123, result);
    }
    
    //最初のページ
    @isTest static void Test_first() {
        new CusManageController().first();
        
        //System.debug('最初のページ : ' + result);
        //System.assertEquals(123, result);
    }
    
    //最後のページ
    @isTest static void Test_last() {
        new CusManageController().last();
        
        //System.debug('最後のページ : ' + result);
        //System.assertEquals(123, result);
    }
    
    //前のページ
    @isTest static void Test_previous() {
        new CusManageController().previous();
        
        //System.debug('前のページ : ' + result);
        //System.assertEquals(123, result);
    }
    
    //次のページ
    @isTest static void Test_next() {
        new CusManageController().next();
        
        //System.debug('次のページ : ' + result);
        //System.assertEquals(123, result);
    }
    
    //指定ページ
    @isTest static void Test_doPageNumber() {
        //new CusManageController().doPageNumber();
        
        CusManageController cmc = new CusManageController();
        cmc.clickPageNumber = 5;
        cmc.doPageNumber();
        
        //System.debug('指定ページ : ' + result);
        //System.assertEquals(123, result);
    }
    
    //ページ番号のリンクを取得
    @isTest static void Test_getPageNumberLinks() {
        CusManageController cmc = new CusManageController();
        
        //
        List<Integer> result1 = cmc.getPageNumberLinks();
        
        //System.debug('');
        //System.assertEquals(123, result1);
        
        //
        cmc.setCon.setPageNumber(10);
        System.debug('setCon.getPageNumber() : ' + cmc.setCon.getPageNumber());
        List<Integer> result2 = cmc.getPageNumberLinks();
        
        System.debug('');
        //System.assertEquals(123, result2);
        
        //System.debug('ページ番号のリンクを取得 : ' + result);
        //System.assertEquals(123, result);
    }
    
    //WHERE句の取得
    @isTest static void Test_getQueryWhere() {
        Map<String, String> whereList = new Map<String, String>();
        whereList.put('test1','ABCDE');
        whereList.put('test2','あいうえお');
        
        String result = new CusManageController().getQueryWhere(whereList);
        System.debug('WHERE句の取得 : ' + result);
        System.assertEquals('WHERE test1 LIKE \'%ABCDE%\' AND test2 LIKE \'%あいうえお%\' ', result);
    }
    
    //検索処理
    @isTest static void Test_schCusManages() {
        CusManageController cmc = new CusManageController();
        //検索項目を設定
        cmc.cusCode = '';
        cmc.cusName = 'データ11';
        
        //検索処理
        cmc.schCusManages();
        
        //System.debug('検索処理 : ' + cmc.cusManageList.size());
        //System.assert(0 < cmc.cusManageList.size());
    }
}