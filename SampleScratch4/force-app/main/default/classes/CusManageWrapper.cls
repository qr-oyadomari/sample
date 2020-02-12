public class CusManageWrapper {
    public CusManage__c cmRecord {get; set;}
    public List<String> signUrlList {get; set;}
    
    public CusManageWrapper() {}
    
    public CusManageWrapper(CusManage__c cusManage) {
        this.cmRecord = cusManage;
        
        //サイン画像のURLをリストに格納
        String strFirst = 'img src=\"';
        String strLast = '\"';
        Integer startNum = 0;
        Integer lastNum = 0;
        String tmpWd = cusManage.sign__c;
        signUrlList = new List<String>();
        
        while(String.isNotEmpty(tmpWd) && tmpWd.indexOf(strFirst) > 0) {
            startNum = tmpWd.indexOf(strFirst) + strFirst.length();
            lastNum = tmpWd.indexOf(strLast, startNum);
            signUrlList.add(tmpWd.substring(startNum, lastNum));
            tmpWd = tmpWd.substring(lastNum);
        }
        
        //System.debug('顧客名 : ' + cusManage.Name + ' サイン画像URL : ' + signUrlList);
    }
}