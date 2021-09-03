public class count {
    @AuraEnabled(cacheable=true) 
    public static double getCount() {
        double x=[select count() from public_dataaudit__x WHERE type_of_object__c = 'Lead' AND type_of_change__c='Update'];
        double y=[select count() from Lead];
        double z=x/y;
        return z;
    }
    @AuraEnabled(cacheable=true) 

    public static double getCountAccountLeft() {
        double x=[select count() from public_dataaudit__x WHERE type_of_object__c = 'Account' AND type_of_change__c='Delete'];
        double a=[select count() from public_dataaudit__x WHERE type_of_object__c = 'Account' AND type_of_change__c='Create'];

        double y=[select count() from Account];
        double z=(a-x)/y;
        double number2 = (integer)(Math.round(z * 100))/100.0;

        return number2;
    }
    @AuraEnabled(cacheable=true) 

    public static double getCountAccountMovedOut() {
        double x=[select count() from public_dataaudit__x WHERE type_of_object__c = 'Account' AND type_of_change__c='Update' AND name_of_field__c='billingstate'];
        double y=[select count() from Account];
        double z=x/y;
        double number2 = (integer)(Math.round(z * 100))/100.0;

        return number2;    }

    @AuraEnabled(cacheable=true) 
    public static double getCountContactMovedOut() {
        double x=[select count() from public_dataaudit__x WHERE type_of_object__c = 'Contact' AND type_of_change__c='Delete'];
        double y=[select count() from Contact];
        double z=x/y;
        return z;
    }

    @AuraEnabled(cacheable=true) 
    public static double getCountContactJoined() {
        double x=[select count() from public_dataaudit__x WHERE type_of_object__c = 'Contact' AND type_of_change__c='Create'];
        double y=[select count() from Contact];
        double z=x/y;
        return z;
    }

}