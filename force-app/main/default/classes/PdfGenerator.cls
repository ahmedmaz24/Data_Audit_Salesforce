/**
 * Created by gerry on 2/23/2021.
 */

public with sharing class PdfGenerator
{
@AuraEnabled
public static List<public_dataaudit__x> getContactsController(){
return [SELECT date__c,name_of_object__c,name_of_field__c FROM public_dataaudit__x];

}
}