/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class AccountSelector {
    public static Id getIdByAccountName(String accountName) {
        for (Account selectedAccount : [SELECT Id FROM Account WHERE Name = :accountName]) {
            return selectedAccount.Id;
        }
        return null;
    }
}