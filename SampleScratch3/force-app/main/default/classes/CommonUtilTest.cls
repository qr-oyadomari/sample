@isTest
private class CommonUtilTest {
    //テスト設定
    @testSetup static void methodName() {}
    
    //コンストラクタ
    @isTest static void Test_CommonUtil() {
        CommonUtil result = new CommonUtil();
        
        System.assertNotEquals(null, result);
    }
    
    //StringからDecimalへ変換
    @isTest static void Test_convertToDecimal() {
        Decimal result = CommonUtil.convertToDecimal('123');
        
        System.assertEquals((Decimal)123, result);
    }
}