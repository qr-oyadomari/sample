public class CusManageWrapperListLN {
    @AuraEnabled public CusManage__c cmRecord {get; set;}
    @AuraEnabled public List<String> signUrlList {get; set;}
    
    public CusManageWrapperListLN() {}
    
    public CusManageWrapperListLN(CusManage__c cusManage) {
        this.cmRecord = cusManage;
        
        //サイン画像のURLをリストに格納
        String strFirst = '<img src=';
        String strLast = '</img>';
        Integer startNum = 0;
        Integer lastNum = 0;
        String tmpWd = cusManage.sign__c;
        signUrlList = new List<String>();
        
        while(String.isNotEmpty(tmpWd) && tmpWd.indexOf(strFirst) > 0) {
            startNum = tmpWd.indexOf(strFirst);
            lastNum = tmpWd.indexOf(strLast, startNum);
            signUrlList.add(tmpWd.substring(startNum, lastNum));
            tmpWd = tmpWd.substring(lastNum);
        }

    }
}