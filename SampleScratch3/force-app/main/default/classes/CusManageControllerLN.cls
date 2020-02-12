public with sharing class CusManageControllerLN {
    /** 最大表示件数 */
    private static final Integer MAX_ROW_SIZE = 10;
    /** NO_IMAGE、接尾字 */
    private static final String NO_IMAGE_FIX = 'noimage';
    
    /** ページ数 */
    public static Integer pageNumber = 1;
    /** ページ総数 */
    public static Integer pageSize {get {return Integer.valueOf(Math.ceil(double.valueOf(totalpages) / double.valueOf(MAX_ROW_SIZE)));} set;}
    /** レコード総数 */
    public static Integer totalpages {get {return [SELECT count() FROM CusManage__c];} set;}
    
    /** ページ番号のリンクを取得 */
    public static List<Integer> getPageNumberLinks(){
        Integer tmpPageNumber = 0;
        Integer startPageNumber = 1;
        if (num_of_links > 0) {
            tmpPageNumber = pageNumber - num_of_links;
            if (tmpPageNumber > 0) {
                startPageNumber = tmpPageNumber;
            }
        }
        
        tmpPageNumber = 0;
        Integer endPageNumber = pageSize;
        if (num_of_links > 0) {
            tmpPageNumber = pageNumber + num_of_links;
            if (tmpPageNumber <= pageSize) {
                endPageNumber = tmpPageNumber;
            }
        }
        
        List<Integer> links = new List<Integer>();
        for(Integer i = startPageNumber; i <= endPageNumber; i++){
            links.add(i);
        }
        
        return links;
    }
    
    //表示するサイン画像の列数
    public static Integer num_of_images { get; set; }
    
    /** NO_IMAGE(URL) */
    public static String noImageUrl { get; set; }
    /** 表示するリンクの数(現在ページを中心に前後に表示する数) */
    private static Integer num_of_links { get; set; }
    
    //コンストラクタ
    public CusManageControllerLN() {
        // NO_IMAGEの画像を取得
        noImageUrl = '';
        if (String.isNotBlank(System.Label.NO_IMG_RE_NAME) && String.isNotBlank(System.Label.NO_IMG_RE_PATH)) {
            noImageUrl = PageReference.forResource(System.Label.NO_IMG_RE_NAME, System.Label.NO_IMG_RE_PATH).getUrl() + NO_IMAGE_FIX;
            noImageUrl = '<img src=\"' + noImageUrl + '\">';
        }
        
        //表示するリンクの数(現在ページを中心に前後に表示する数)を設定
        num_of_links = 0;
        String sign_d_num_og_links = System.Label.SIGN_D_NUM_OF_LINKS;
        if(String.isNotBlank(sign_d_num_og_links)) {
            Decimal tmpVal = CommonUtil.convertToDecimal(sign_d_num_og_links);
            if(tmpVal != null) {
                num_of_links = tmpVal.intValue();
            }
        }
        
        //表示するサイン画像の列数を設定
        num_of_images = 1;
        String sign_d_num_of_images = System.Label.SIGN_D_NUM_OF_IMAGES;
        if(String.isNotBlank(sign_d_num_of_images)) {
            Decimal tmpVal = CommonUtil.ConvertToDecimal(sign_d_num_of_images);
            if(tmpVal != null) {
                num_of_Images = tmpVal.intValue();
            }
        }
    }
    
    //初期動作
    @AuraEnabled
    public static CusManageWrapperLN initCusManages(Integer page, String customer_code, String name) {
        new CusManageControllerLN();
        
        pageNumber = page;
        
        return execSearch(page, customer_code, name);
    }
    
    //検索ボタン動作
    @AuraEnabled
    public static CusManageWrapperLN getCusManages(Integer page, String customer_code, String name) {
        new CusManageControllerLN();
        
        pageNumber = page;
        
        return execSearch(page, customer_code, name);
    }
    
    //検索処理
    private static CusManageWrapperLN execSearch(Integer page, String customer_code, String name) {
        List<CusManage__c> CusManageList = Database.query(queryCusManage(page,customer_code, name));
        
        return setResultData(CusManageList);
    }
    
    @TestVisible private static String queryCusManage(Integer page, String customer_code, String name) {
        String sql_select = 'SELECT customer_code__c, Name, company_name__c, store_name__c, empNo__c, sign__c ';
        String sql_from = 'FROM CusManage__c ';
        
        //Map<カラム名, 値>
        Map<String, String> whereList = new Map<String, String>();
        whereList.put('customer_code__c',customer_code);
        whereList.put('Name',name);
        String sql_where = getQueryWhere(whereList);
        
        String sql_order_by = 'ORDER BY customer_code__c ASC ';
        String sql_limit = 'LIMIT ' + MAX_ROW_SIZE;
        
        Integer offset = ((Integer)page - 1) * MAX_ROW_SIZE;
        String sql_offset = 'OFFSET ' + offset + ' ';
        
        String sql_query = sql_select + sql_from + sql_where + sql_order_by + sql_limit + sql_offset;
        System.debug('SOQL : ' + sql_query);
        
        return sql_query;
    }
    
    @TestVisible private static String getQueryWhere(Map<String, String> whereList) {
        String result = '';
        //System.debug('customer_code__c：' + whereList.get('customer_code__c'));
        //System.debug('Name：' + whereList.get('Name'));
        
        for(String key : whereList.keySet()) {
            String val = whereList.get(key);
            
            //値が空白の場合はWHERE句に条件を追加しない
            if(String.isNotEmpty(val)) {
                if(String.isEmpty(result)) {
                    result = 'WHERE ';
                }else {
                    result = result + 'AND ';
                }
                
                result = result + key + ' LIKE \'%' + val + '%\' ';
            }
        }
        
        return result;
    }
    
    @TestVisible private static CusManageWrapperLN setResultData(List<CusManage__c> CusManageList) {
        CusManageWrapperLN cusManageWrapper = new CusManageWrapperLN();
        List<CusManageWrapperListLN> cusManageWrapperList = new List<CusManageWrapperListLN>();
        CusManageWrapperListLN cm = null;
        
        for(CusManage__c item : CusManageList) {
            cm = new CusManageWrapperListLN(item);
            Integer num = Math.mod(cm.signUrlList.size(), num_of_Images);
            
            //サイン画像の設定
            if(cm.signUrlList.size() == 0 || num != 0) {
                for(Integer i = num; i < num_of_Images; i++) {
                    cm.signUrlList.add(noImageUrl);
                }
                
            }
            
            cusManageWrapperList.add(cm);
        }
        
        cusManageWrapper.page = pageNumber;
        cusManageWrapper.pageSize = pageSize;
        cusManageWrapper.total = totalpages;
        cusManageWrapper.pageNumberLinks = getPageNumberLinks();
        cusManageWrapper.cmwList = cusManageWrapperList;
        
        //System.debug('cusManageWrapper.cmwList : ' + cusManageWrapper.cmwList);
        return cusManageWrapper;
    }
    
    /*@AuraEnabled
    public static CusManageWrapperLN fetchAccount(Decimal pageNumber ,Integer recordToDisply) {
        Integer pageSize = recordToDisply;
        Integer offset = ((Integer)pageNumber - 1) * pageSize;
    
        // create a instance of wrapper class.
        CusManageWrapperLN obj =  new CusManageWrapperLN();
        // set the pageSize,Page(Number), total records and accounts List(using OFFSET)   
        obj.pageSize = pageSize;
        obj.page = (Integer) pageNumber;
        obj.total = [SELECT count() FROM account];
        obj.accounts = [SELECT Id, Name,Phone FROM Account ORDER BY Name LIMIT :recordToDisply OFFSET :offset];
        // return the wrapper class instance .
        return obj;
    }*/
}