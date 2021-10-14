/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistFactory {
    public static AccountPlaylist__c createAccountPlaylist(String accountName, String playlistDisplayName, Boolean insertRecord) {
        AccountPlaylist__c newAccountPlaylist = new AccountPlaylist__c(
                Account__c = AccountSelector.getIdByAccountName(accountName),
                Playlist__c = PlaylistSelector.getPlaylistIdByDisplayName(playlistDisplayName)
        );
        if (insertRecord) {
            SObjectOperations.insertSObjects(new AccountPlaylist__c[] {newAccountPlaylist}, false);
        }
        return newAccountPlaylist;
    }

    public static AccountPlaylistServiceConstants.OUTCOME deleteAccountPlaylists(List<Id> lAccPlaylistIdsToDelete) {
        return SObjectOperations.deleteSObjects(lAccPlaylistIdsToDelete, false) ? AccountPlaylistServiceConstants.OUTCOME.SUCCESS : AccountPlaylistServiceConstants.OUTCOME.FAILURE;
    }
}