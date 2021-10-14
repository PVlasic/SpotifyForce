/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistSongSelector {
    public static Id getIdByRelatedNames(String playlistDisplayName, String songName) {
        for (PlaylistSong__c selectedPlaylistSong : [SELECT Id FROM PlaylistSong__c WHERE Playlist__r.DisplayName__c = :playlistDisplayName AND Song__r.Name = :songName]) {
            return selectedPlaylistSong.Id;
        }
        return null;
    }

    public static PlaylistSong__c getPlaylistSongByName(String playlistDisplayName, String songName) {
        for (PlaylistSong__c selectedPlaylistSong : [SELECT Id FROM PlaylistSong__c WHERE Playlist__r.DisplayName__c = :playlistDisplayName AND Song__r.Name = :songName]) {
            return selectedPlaylistSong;
        }
        return null;
    }

    public static List<PlaylistSong__c> getAllSongsByPlaylistName(String playlistName) {
        return [SELECT Id, Name, Song__r.Id, Song__r.Name, Song__r.Author__c, Song__r.ReleaseYear__c FROM PlaylistSong__c WHERE Playlist__r.DisplayName__c = :playlistName];
    }
}