/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceComponents {

    public class SongPlaylistAddRequest {
        public String songName {get;}
        public String playlistDisplayName {get;}

        public SongPlaylistAddRequest(String sName, String pDName) {
            this.songName = sName;
            this.playlistDisplayName = pDName;
        }
    }

    public class AccountPlaylistServiceResponse {
        public String outcome {get; set;}

        public AccountPlaylistServiceResponse(AccountPlaylistServiceConstants.OUTCOME outcome) {
            this.outcome = String.valueOf(outcome);
        }
    }
}