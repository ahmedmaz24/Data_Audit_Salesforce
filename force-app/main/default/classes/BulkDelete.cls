public class BulkDelete {
public  void bulkdeletefuntion(){
Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
message.toAddresses = new String[] { 'mediouniahmed11@yahoo.com' };
message.optOutPolicy = 'FILTER';
message.subject = 'Bulk Delete Warning';
message.plainTextBody = 'Warning !! the system have detected an operation of BULK DELETE on '+system.now()+' Please check if this is a human error ';
Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

if (results[0].success) {
System.debug('The email was sent successfully.');
} else {
System.debug('The email failed to send: ' + results[0].errors[0].message);
}
}}
