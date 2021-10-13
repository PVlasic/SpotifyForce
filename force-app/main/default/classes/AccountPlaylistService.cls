/**
 * Created by catalinalexandrutanasie on 11.10.2021.
 */

@RestResource(UrlMapping = '/APS/*')
global with sharing class AccountPlaylistService {
    @HttpGet
    global static List<AccountPLaylist__c> getPlaylistsByAccountName() {
        return AccountPlaylistServiceOperations.getAccountPlaylistByAccountName();
    }
    @HttpGet
    global static List<AccountPLaylist__c> getSpecificAccountPlaylist() {
        return AccountPlaylistServiceOperations.getAccountPlaylistByAccountName();
    }

    @HttpPost
    global static Id createAccountPlaylist(String accountName, String playlistName) {
        return AccountPlaylistServiceOperations.createAccountPlaylist(accountName, playlistName);
    }
}