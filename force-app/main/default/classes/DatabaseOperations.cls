/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class DatabaseOperations {
    public static Boolean insertSObjects(List<SObject> lObjectsToInsert, Boolean insertAllOrNone) {
        for (Database.SaveResult sResult :  Database.insert(lObjectsToInsert, insertAllOrNone)) {
            if (!sResult.isSuccess()) {
                //todo process and log errors; alternatively, return a fault
            }
        }
        return true;
    }
}