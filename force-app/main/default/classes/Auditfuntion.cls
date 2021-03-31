public class Auditfuntion{

//Create functions for sobjects
public public_dataaudit__x CreateFunction(sObject a){
//fetching time and date 
TimeZone tz = UserInfo.getTimeZone();
DateTime dt = Datetime.now();
//fetching object type
String sobjectType = a.Id.getSObjectType().getDescribe().getName();
public_dataaudit__x audit = new public_dataaudit__x (
name_of_field__c ='',
name_of_object__c =string.valueof(a.ID),
new_value__c = '',
old_value__c = '',
type_of_change__c = 'Create',

type_of_object__c = sobjectType,
date__c = system.now(),
user_audit__c=UserInfo.getFirstName()+' '+UserInfo.getLastName()
);
return audit;





}


//Delete funtions for sobjects
public public_dataaudit__x DeleteFunction(sObject a){
String str = JSON.serialize(a);
Blob data = Blob.valueOf(str);
Blob key = Crypto.generateAesKey(128);
Blob encrypted = Crypto.encryptWithManagedIV('AES128', key, data);



//fetching date and time
TimeZone tz = UserInfo.getTimeZone();
DateTime dt = Datetime.now();
//fetching type of object 
String sobjectType = a.Id.getSObjectType().getDescribe().getName();

public_dataaudit__x audit = new public_dataaudit__x (
name_of_field__c ='',
name_of_object__c =string.valueof(a.ID),
new_value__c ='' ,
old_value__c = string.valueof(encrypted),
type_of_change__c = 'Delete',

type_of_object__c = sobjectType,
date__c = system.now(),
user_audit__c=UserInfo.getFirstName()+' '+UserInfo.getLastName()

);

return audit;




}    

//Update funtion for sobjects
public List<public_dataaudit__x> UpdateFunction(sObject a){
//fetching date and time 
TimeZone tz = UserInfo.getTimeZone();
DateTime dt = Datetime.now();
//the update method return a list
List<public_dataaudit__x>listobj = new List<public_dataaudit__x>();

//the object type
String sobjectType = a.Id.getSObjectType().getDescribe().getName();

//map out all fields of the sobject 'a' 

String selectedObject = string.valueof(a.Id.getSObjectType());
Map<String, Schema.SObjectType> gdMap = Schema.getGlobalDescribe();
Schema.Describesobjectresult dsr = gdMap.get(selectedObject).getDescribe();
Map<String, Schema.SObjectField> fieldMap = dsr.fields.getMap();

//start comparing every filed of the new sobject 'a' with the old filed value of sobject 'a' and if there is any change of the same field then we fill in those information 
for (String fieldName : fieldMap.keySet()){
if( trigger.newMap.get(a.Id).get(fieldName) != trigger.oldMap.get(a.Id).get(fieldName) && fieldName != 'lastmodifieddate' && fieldName != 'systemmodstamp' && fieldName != 'lastclosedatechangedhistoryid'){

public_dataaudit__x audit = new public_dataaudit__x (
name_of_object__c = string.valueof(a.ID),
new_value__c = string.valueof(trigger.newMap.get(a.Id).get(fieldName)),
old_value__c= string.valueof(trigger.oldMap.get(a.Id).get(fieldName)),
type_of_change__c = 'Update',
type_of_object__c = selectedObject,  
name_of_field__c = string.valueof(fieldName),
date__c = dt.addSeconds((tz.getOffset(dt)/1000)),
user_audit__c=UserInfo.getFirstName()+' '+UserInfo.getLastName()

);                 listobj.add(audit);}}

return listobj ;
}

} 