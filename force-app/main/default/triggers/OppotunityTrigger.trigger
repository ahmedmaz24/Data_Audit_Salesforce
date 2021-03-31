trigger OppotunityTrigger on Opportunity (after insert, before delete, after update) {
    
    List<public_dataaudit__x>listobj = new List<public_dataaudit__x>();
    
    
    /**********************
    TRIGGER BEFORE
    **********************/ 
    if(Trigger.isBefore){
        
        if ( Trigger.isDelete ){
            for (opportunity a : trigger.old){
                Auditfuntion f = new Auditfuntion();
                listobj.add(f.DeleteFunction(a)) ;
            }
            Database.insertAsync(listobj);
            if(trigger.old.size()>2){
                BulkDelete b = new BulkDelete();
                b.bulkdeletefuntion();
            }
        } 
    }
    
    
    
    /**********************
    TRIGGER AFTER
    **********************/ 
    if(Trigger.isAfter){
        
        if(trigger.isUpdate){
            
            for (opportunity a : trigger.new){
                Auditfuntion f = new Auditfuntion();
                listobj = f.UpdateFunction(a);
            }            
            Database.insertAsync(listobj);

        }
        
        if(trigger.isInsert){
            for (opportunity a : trigger.new){
                Auditfuntion f = new Auditfuntion();
                listobj.add(f.CreateFunction(a)) ;
            }
            Database.insertAsync(listobj);
        }
        
    }  
    
}