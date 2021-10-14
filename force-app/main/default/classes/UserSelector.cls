/**
 * Created by catalinalexandrutanasie on 14.10.2021.
 */

public with sharing class UserSelector {
    public static Boolean isUserOAuthRestricted(Id userId) {
        for (User userToEvaluate : [SELECT DenyConnectedAppAccess__c FROM User WHERE Id = :userId]) {
            return userToEvaluate.DenyConnectedAppAccess__c;
        }
        return true;
    }
}