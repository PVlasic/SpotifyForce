/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistSelector {
    public static Id getPlaylistIdByDisplayName(String playlistDisplayName) {
        for (Playlist__c queriedPlaylist : [SELECT Id FROM Playlist__c WHERE DisplayName__c = :playlistDisplayName LIMIT 1]) {
            return queriedPlaylist.Id;
        }
        return null;
    }

    public static Playlist__c getPlaylistByDisplayName(String playlistDisplayName) {
        for (Playlist__c queriedPlaylist : [SELECT Id, Source__c, Name FROM Playlist__c WHERE DisplayName__c = :playlistDisplayName LIMIT 1]) {
            return queriedPlaylist;
        }
        return null;
    }
}