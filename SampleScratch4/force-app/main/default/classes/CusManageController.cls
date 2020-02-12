public with sharing class CusManageController {
    /** 最大表示件数 */
    private static final Integer MAX_ROW_SIZE = 500;
    /** ページ表示数 */
    private static final Integer PAGE_SIZE = 10;
    /** NO_IMAGE、接尾字 */
    private static final String NO_IMAGE_FIX = 'noimage';
    
    /** StandardSetController ページング */
    public ApexPages.StandardSetController setCon {get; set;}
    /** 次ページの判断 */
    public Boolean hasNext { get { return setCon.getHasNext();} set;}
    /** 前ページの判断 */
    public Boolean hasPrevious {get { return setCon.getHasPrevious();} set;}
    /** ページ数 */
    public Integer pageNumber {get {return setCon.getPageNumber(); } set;}
    /** ページ総数 */
    public Integer totalPages {get { return getTotalPages();} set;}
    
    /** ページ総数の計算 */
    public Integer getTotalPages(){
        Decimal totalSize = setCon.getResultSize();
        Decimal pageSize = setCon.getPageSize();
        Decimal pages = totalSize/pageSize;
        return (Integer)pages.round(System.RoundingMode.CEILING);
    }
    
    /** レコード数 */
    public Integer recordNumber {get {return setCon.getResultSize();} set;}
    /** クリックしたページ番号 */
    public Integer clickPageNumber {get; set;}
    
    /** 最初のページ */
    public void first() {
        setCon.first();
        setResultData();
    }
    /** 最後のページ */
    public void last() {
        setCon.last();
        setResultData();
    }
    /** 前のページ */
    public void previous() {
        setCon.previous();
        setResultData();
    }
    /** 次のページ */
    public void next() {
        setCon.next();
        setResultData();
    }
    /** 指定ページ */
    public void doPageNumber(){
        setCon.setpageNumber(clickPageNumber);
        setResultData();
    }
    
    /** ページ番号のリンクを取得 */
    public List<Integer> getPageNumberLinks(){
        Integer tmpPageNumber = 0;
        Integer startPageNumber = 1;
        if (num_of_links > 0) {
            tmpPageNumber = setCon.getPageNumber() - num_of_links;
            if (tmpPageNumber > 0) {
                startPageNumber = tmpPageNumber;
            }
        }
        
        tmpPageNumber = 0;
        Integer endPageNumber = getTotalPages();
        if (num_of_links > 0) {
            tmpPageNumber = setCon.getPageNumber() + num_of_links;
            if (tmpPageNumber <= getTotalPages()) {
                endPageNumber = tmpPageNumber;
            }
        }
        
        List<Integer> links = new List<Integer>();
        for(Integer i = startPageNumber; i <= endPageNumber; i++){
            links.add(i);
        }
        
        return links;
    }
    
    //顧客コード
    public String cusCode { get; set; }
    //顧客名
    public String cusName { get; set; }
    //表示リスト
    public List<CusManageWrapper> cusManageList { get; set;}
    //表示するサイン画像の列数
    public Integer num_of_images { get; set; }
    //固定行
    public Integer num_of_rows { get; set; }
    //固定列
    public Integer num_of_cols { get; set; }
    
    /** NO_IMAGE(URL) */
    private String noImageUrl { get; set; }
    /** 表示するリンクの数(現在ページを中心に前後に表示する数) */
    private Integer num_of_links { get; set; }
    
    public CusManageController() {
        // NO_IMAGEの画像を取得
        noImageUrl = '';
        if (String.isNotBlank(System.Label.NO_IMG_RE_NAME) && String.isNotBlank(System.Label.NO_IMG_RE_PATH)) {
            noImageUrl = PageReference.forResource(System.Label.NO_IMG_RE_NAME, System.Label.NO_IMG_RE_PATH).getUrl() + NO_IMAGE_FIX;
        }
        //System.debug('サイン画像URL : ' + noImageUrl);
        
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
        
        //固定行を設定
        num_of_rows = 1;
        String fixed_midashi_rows = System.Label.FIXED_MIDASHI_ROWS;
        if(String.isNotBlank(fixed_midashi_rows)) {
            Decimal tmpVal = CommonUtil.ConvertToDecimal(fixed_midashi_rows);
            if(tmpVal != null) {
                num_of_rows = tmpVal.intValue();
            }
        }
        
        //固定列を設定
        num_of_cols = 1;
        String fixed_midashi_cols = System.Label.FIXED_MIDASHI_COLS;
        if(String.isNotBlank(fixed_midashi_cols)) {
            Decimal tmpVal = CommonUtil.ConvertToDecimal(fixed_midashi_cols);
            if(tmpVal != null) {
                num_of_cols = tmpVal.intValue();
            }
        }
        
        //初期検索
        execSearch();
    }
    
    public PageReference schCusManages() {
        //検索処理
        execSearch();

        return null;
    }
    
    @TestVisible private void execSearch() {
        //
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryCusManage()));
        
        //ページング設定
        setCon.setPageSize(PAGE_SIZE);
        
        //画面に返却する値をセット
        setResultData();
    }
    
    @TestVisible private String queryCusManage() {
        String sql_select = 'SELECT customer_code__c, Name, company_name__c, store_name__c, empNo__c, sign__c ';
        String sql_from = 'FROM CusManage__c ';
        
        //Map<カラム名, 値>
        Map<String, String> whereList = new Map<String, String>();
        whereList.put('customer_code__c',cusCode);
        whereList.put('Name',cusName);
        String sql_where = getQueryWhere(whereList);
        
        String sql_order_by = 'ORDER BY customer_code__c ASC ';
        String sql_limit = 'LIMIT ' + MAX_ROW_SIZE;
        
        String sql_query = sql_select + sql_from + sql_where + sql_order_by + sql_limit;
        System.debug('SOQL : ' + sql_query);
        
        return sql_query;
    }
    
    @TestVisible private String getQueryWhere(Map<String, String> whereList) {
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
    
    @TestVisible private void setResultData () {
        cusManageList = new List<CusManageWrapper>();
        CusManageWrapper cm = null;
        
        for(CusManage__c item : (List<CusManage__c>)setCon.getRecords()) {
            cm = new CusManageWrapper(item);
            Integer num = Math.mod(cm.signUrlList.size(), num_of_Images);
            
            //サイン画像の設定
            if(cm.signUrlList.size() == 0 || num != 0) {
                for(Integer i = num; i < num_of_Images; i++) {
                    cm.signUrlList.add(noImageUrl);
                }
            }
            
            cusManageList.add(cm);
        }
        
        //System.debug('cusManageList : ' + cusManageList);
    }
}