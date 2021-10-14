/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class SObjectOperations {
    public static Boolean insertSObjects(List<SObject> lObjectsToInsert, Boolean insertAllOrNone) {
        for (Database.SaveResult sResult : Database.insert(lObjectsToInsert, insertAllOrNone)) {
            if (!sResult.isSuccess()) {
                //todo process and log errors; alternatively, return a fault
            }
        }
        return true;
    }

    public static Boolean deleteSObjects(List<Id> lIdsToDelete, Boolean deleteALlorNone) {
        Boolean singleRecordDeleted = false;
        for (Database.DeleteResult dResult : Database.delete(lIdsToDelete, deleteALlorNone)) {
            if (dResult.isSuccess()) {
                singleRecordDeleted = true;
            } else {
                //todo process and log errors; alternatively, return a fault selectively
                if (deleteALlorNone)
                    return false;
            }
        }
        return singleRecordDeleted;
    }

    public static Boolean upsertSObjects(List<SObject> lObjectsToUpsert, Boolean upsertAllOrNone) {
        Boolean singleRecordUpserted = false;
        System.debug('### Upsert records: ' + lObjectsToUpsert);
        for (Database.UpsertResult uResult : Database.upsert(lObjectsToUpsert, upsertAllOrNone)) {
            if (uResult.isSuccess()) {
                singleRecordUpserted = true;
            } else {
                //todo process and log errors; alternatively, return a fault selectively
                if (upsertAllOrNone)
                    return false;
            }
        }
        return singleRecordUpserted;
    }
}