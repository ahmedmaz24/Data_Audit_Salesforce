public with sharing class FormulateMessage {
public static string getFormulate(List<Integer> content){
string message;
List<public_dataaudit__x> a = [SELECT date__c,idi__c,name_of_field__c,name_of_object__c,new_value__c,old_value__c,type_of_change__c,type_of_object__c from public_dataaudit__x WHERE idi__c IN : content];
for(public_dataaudit__x i : a){

message = 'Type of change : '+i.type_of_change__c+'    Object ID : '+i.name_of_object__c+'   Object Type : '+i.type_of_object__c+' New Value : '+i.new_value__c+' Old Value :  '+ i.old_value__c+'  Date : '+i.date__c+'\n'+message;
message=message.replace('null','');


}
return message;

}

}