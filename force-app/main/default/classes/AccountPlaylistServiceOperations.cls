/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceOperations {
    public static List<AccountPlaylist__c> getAccountPlaylistByAccountName(String accountName) {
        return AccountPlaylistServiceOperations.getAccountPlaylistByAccountName(String.escapeSingleQuotes(accountName));
    }
}