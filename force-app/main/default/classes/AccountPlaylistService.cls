/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

@RestResource(UrlMapping = '/APS/*')
global with sharing class AccountPlaylistService {

    @HttpGet
    global static List<AccountPLaylist__c> getSpecificAccountPlaylist() {
        return AccountPlaylistServiceOperations.getAccountPlaylistsByAccountAndPlaylistNames();
    }

    @HttpPost
    global static AccountPlaylist__c createAccountPlaylist(String accountName, String playlistDisplayName) {
        return AccountPlaylistServiceOperations.createAccountPlaylist(accountName, playlistDisplayName);
    }

    @HttpDelete
    global static void removeAccountPlaylist() {
        AccountPlaylistServiceOperations.deleteAccountPlaylist();
    }

    @HttpPut
    global static void addSongToPlaylist() {

    }

    @HttpPatch
    global static void updatePlaylistSong() {

    }
}