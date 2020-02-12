public class CusManageWrapperLN {
    @AuraEnabled public Integer page {get; set;}
    @AuraEnabled public Integer pageSize {get; set;}
    @AuraEnabled public Integer total {get; set;}
    @AuraEnabled public List<Integer> pageNumberLinks {get; set;}
    @AuraEnabled public List<CusManageWrapperListLN> cmwList {get; set;}
    
    public CusManageWrapperLN() {}
    
}