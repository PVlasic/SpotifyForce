/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistSelector {
    public static Playlist__c getPlaylistByName(String playlistName) {
        for (Playlist__c queriedPlaylist : [SELECT Id, Source__c FROM Playlist__c WHERE Name = :playlistName]) {
            return queriedPlaylist;
        }
        return null;
    }
}