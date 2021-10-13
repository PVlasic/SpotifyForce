/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistFactory {
    public static Id createAccountPlaylist(String accountName, String playlistName) {
        AccountPlaylist__c newAccountPlaylist = new AccountPlaylist__c(
                Account__c = AccountSelector.getIdByAccountName(accountName);
        );
    }
}