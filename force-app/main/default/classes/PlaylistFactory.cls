/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistFactory {
    public static Id createAccountPlaylist(String accountName, String playlistName, Boolean insertRecord) {
        AccountPlaylist__c newAccountPlaylist = new AccountPlaylist__c(
                Account__c = AccountSelector.getIdByAccountName(accountName),
                Playlist__c = PlaylistSelector.getPlaylistIdByName(playlistName)
        );
        if (insertRecord) {
            DatabaseOperations.insertSObjects(new AccountPlaylist__c[] {newAccountPlaylist}, false);
        }
        return newAccountPlaylist.Id;
    }
}