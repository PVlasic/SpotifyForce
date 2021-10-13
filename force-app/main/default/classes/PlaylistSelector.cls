/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistSelector {
    public static Id getPlaylistIdByName(String playlistName) {
        for (Playlist__c queriedPlaylist : [SELECT Id FROM Playlist__c WHERE Name = :playlistName LIMIT 1]) {
            return queriedPlaylist.Id;
        }
        return null;
    }

    public static Playlist__c getPlaylistByName(String playlistName) {
        for (Playlist__c queriedPlaylist : [SELECT Id, Source__c FROM Playlist__c WHERE Name = :playlistName LIMIT 1]) {
            return queriedPlaylist;
        }
        return null;
    }
}