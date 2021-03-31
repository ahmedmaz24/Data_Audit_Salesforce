public with sharing class TableController {
    @AuraEnabled(cacheable=true)
    public static List<public_dataaudit__x> getAudits(){
        return [SELECT date__c,idi__c,name_of_field__c,name_of_object__c,new_value__c,old_value__c,type_of_change__c,type_of_object__c,user_audit__c	 from public_dataaudit__x  ORDER BY date__c DESC NULLS LAST LIMIT 20
        ];
    }
    @AuraEnabled(cacheable=true)

    public static List<public_dataaudit__x> getAuditsdelete(){
        return [SELECT date__c,idi__c,name_of_field__c,name_of_object__c,new_value__c,old_value__c,type_of_change__c,type_of_object__c	 FROM public_dataaudit__x  WHERE type_of_change__c ='Delete' LIMIT 20];
    }

    @AuraEnabled(cacheable=true)

    public static List<public_dataaudit__x> getAuditsUpdate(){
        return [SELECT date__c,idi__c,name_of_field__c,name_of_object__c,new_value__c,old_value__c,type_of_change__c,type_of_object__c	 FROM public_dataaudit__x  WHERE type_of_change__c ='Update' LIMIT 20];
    }

    @AuraEnabled(cacheable=true)

    public static List<public_dataaudit__x> getAuditsCreate(){
        return [SELECT date__c,idi__c,name_of_field__c,name_of_object__c,new_value__c,old_value__c,type_of_change__c,type_of_object__c	 FROM public_dataaudit__x  WHERE type_of_change__c ='Create' LIMIT 20];
    }
    
    
}
