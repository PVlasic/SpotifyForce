/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistSelector {
    public static List<AccountPlaylist__c> getAccountPlaylistsByAccountName(String accountName) {
        return [SELECT Name FROM AccountPlaylist__c WHERE Account__r.Name = :accountName];
    }

    public static AccountPlaylist__c getAccountPlaylistByName(String accountName, String playlistName) {
        for (AccountPlaylist__c currentPlaylist : [SELECT Name FROM AccountPlaylist__c WHERE Account__r.Name = :accountName AND Playlist__r.Name = :playlistName LIMIT 1]) {
            return currentPlaylist;
        }
        return null;
    }
}