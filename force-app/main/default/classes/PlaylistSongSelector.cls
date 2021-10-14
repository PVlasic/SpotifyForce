/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class PlaylistSongSelector {
    public static PlaylistSong__c getPlaylistSongByName(String playlistName, String songName) {
        for (PlaylistSong__c selectedPlaylistSong : [SELECT Id FROM PlaylistSong__c WHERE Playlist__r.Name = :playlistName AND Song__r.Name = :songName]) {
            return selectedPlaylistSong;
        }
        return null;
    }

    public static List<PlaylistSong__c> getAllSongsByPlaylistName(String playlistName) {
        return null;
    }
}