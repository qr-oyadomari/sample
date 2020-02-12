public class CusManage {
    //表示するサイン画像の列数
    @AuraEnabled public Integer num_of_images { get; set; }
    
    /** NO_IMAGE(URL) */
    @AuraEnabled public String noImageUrl { get; set; }
    
    public CusManage() {}
}