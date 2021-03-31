public with sharing class EmailClass {
@AuraEnabled(cacheable=true)
//Email sent when requesting an email version of records
public static void getEmailSend(List<Integer> content){

String text = FormulateMessage.getFormulate(content);


Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] { 'ahmedmediouni24@hotmail.com' };
message.optOutPolicy = 'FILTER';
message.subject = 'Data Change Logs';
message.plainTextBody = 'Greeitngs Admin,\n\n Data Change Operation Requested on '+ System.now()+' are :\n'+text;
Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

if (results[0].success) {
System.debug('The email was sent successfully.');
} else {
System.debug('The email failed to send: ' + results[0].errors[0].message);
}
}
@AuraEnabled(cacheable=true)
//email sent when requesting History of object
public static void getEmailSendhistory(List<String> content){

String text = FormulateMessage.getFormulatehistory(content);


Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] { 'ahmedmediouni24@hotmail.com' };
message.optOutPolicy = 'FILTER';
message.subject = 'History';
message.plainTextBody = 'Greeitngs Admin,\n\n History of an object were requested on  '+ System.now()+' are :\n'+text;
Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

if (results[0].success) {
System.debug('The email was sent successfully.');
} else {
System.debug('The email failed to send: ' + results[0].errors[0].message);
}
}
}
