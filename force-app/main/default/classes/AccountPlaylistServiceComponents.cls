/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceComponents {

    public class SongPlaylistAddRequest {
        public String songName {get;set;}
        public String playlistDisplayName {get;set;}

        public SongPlaylistAddRequest(String sName, String pDName) {
            this.songName = sName;
            this.playlistDisplayName = pDName;
        }
    }

    public class SongPlaylistAddResponse {
        public Id playlistSongId {get;set;}
        public List<PlaylistSong__c> currentPlaylistSongs {get;set;}

        public SongPlaylistAddResponse(Id playlistSongId, List<PlaylistSong__c> lCurrentSongs) {
            this.playlistSongId = playlistSongId;
            this.currentPlaylistSongs = lCurrentSongs;
        }
    }

    public class AccountPlaylistServiceResponse {
        public String outcome {get; set;}

        public AccountPlaylistServiceResponse(AccountPlaylistServiceConstants.OUTCOME outcome) {
            this.outcome = String.valueOf(outcome);
        }
    }
}