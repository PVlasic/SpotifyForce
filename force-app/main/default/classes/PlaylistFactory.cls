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
            SObjectOperations.insertSObjects(new AccountPlaylist__c[]{
                    newAccountPlaylist
            }, AccountPlaylistServiceConstants.ALL_OR_NOTHING_DML);
        }
        return newAccountPlaylist;
    }

    public static Boolean deleteAccountPlaylists(List<Id> lAccPlaylistIdsToDelete) {
        return SObjectOperations.deleteSObjects(lAccPlaylistIdsToDelete, AccountPlaylistServiceConstants.ALL_OR_NOTHING_DML);
    }

    public static PlaylistSong__c upsertPlaylistSong(String playlistDisplayName, String songName, String addedOn) {
        PlaylistSong__c psToUpsert = new PlaylistSong__c(
                Playlist__c = PlaylistSelector.getPlaylistIdByDisplayName(playlistDisplayName),
                Song__c = SongSelector.getIdByName(songName),
                Id = PlaylistSongSelector.getIdByRelatedNames(playlistDisplayName, songName),
                AddedOn__c = String.isNotBlank(addedOn) && AccountPlaylistServiceValidations.isDatetimeStringValid(addedOn) ? Datetime.valueOf(addedOn) : Datetime.now()
                );
        SObjectOperations.upsertSObjects(new PlaylistSong__c[] {psToUpsert}, AccountPlaylistServiceConstants.ALL_OR_NOTHING_DML);
        return psToUpsert;
    }
}