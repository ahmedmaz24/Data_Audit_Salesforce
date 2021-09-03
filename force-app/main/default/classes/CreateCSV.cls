public with sharing class CreateCSV {
@AuraEnabled(cacheable=true)

public static string getCSV(List<Integer> contents){
string message;
string start = 'Date'+','+'idi'+','+'Field'+','+'ID'+','+'newValue'+','+'oldValue'+','+'typeOfChange'+','+'typeOfObject'+'\n';
List<public_dataaudit__x> a = [SELECT date__c,idi__c,name_of_field__c,name_of_object__c,new_value__c,old_value__c,type_of_change__c,type_of_object__c from public_dataaudit__x WHERE idi__c IN : contents];
for(public_dataaudit__x i : a){

message = i.date__c+','+i.idi__c+','+i.name_of_field__c+','+i.name_of_object__c+','+i.new_value__c+','+i.old_value__c+','+i.type_of_change__c+','+i.type_of_object__c+'\n'+message;
message=message.replace('null','');


}
message=start+message;
return message ;

}
}
