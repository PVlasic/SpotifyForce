/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistSelector {
    public static List<AccountPlaylist__c> getAccountPlaylistsByAccountName(String accountName) {
        return [SELECT Name, Playlist__r.DisplayName__c, Account__r.Name FROM AccountPlaylist__c WHERE Account__r.Name = :accountName];
    }

    public static List<AccountPlaylist__c> getAccountPlaylistsByPlaylistName(String playlistDisplayName) {
        //todo remove redundant fields for REST; keep for SOAP
        return [SELECT Name, Account__r.Name, Playlist__r.DisplayName__c FROM AccountPlaylist__c WHERE Playlist__r.DisplayName__c = :playlistDisplayName];
    }

    public static List<AccountPlaylist__c> getAccountPlaylistByAccountAndPlaylistNames(String accountName, String playlistDisplayName) {
        for (AccountPlaylist__c currentPlaylist : [SELECT Account__r.Name, Playlist__r.Name, Name FROM AccountPlaylist__c WHERE Account__r.Name = :accountName AND Playlist__r.DisplayName__c = :playlistDisplayName LIMIT 1]) {
            return new AccountPlaylist__c[] {currentPlaylist};
        }
        return null;
    }

    public static Id getAccountPlaylistIdForAccountAndPlaylistName(String accountName, String playlistDisplayName) {
        for (AccountPlaylist__c currentPlaylist : [SELECT Id FROM AccountPlaylist__c WHERE Account__r.Name = :accountName AND Playlist__r.DisplayName__c = :playlistDisplayName LIMIT 1]) {
            return currentPlaylist.Id;
        }
        return null;
    }
}