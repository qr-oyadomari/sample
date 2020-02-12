public with sharing class CommonUtil {
    public CommonUtil() {}
    
    public static Decimal convertToDecimal(String str) {
        return Decimal.valueOf(str);
    }
}