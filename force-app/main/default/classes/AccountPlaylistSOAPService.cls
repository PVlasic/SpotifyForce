/**
 * Created by catalinalexandrutanasie on 14.10.2021.
 */
//todo: with sharing enforcement, as by default rules are not enforced
global class AccountPlaylistSOAPService {
    global class AccountPlaylistSOAPRequest {
        webService String accountName;
        webService String playlistDisplayName;
    }

    global class AccountPlaylistSOAPResponseItem {
        webService String accountPlaylistId;
        webService String accountName;
        webService String playlistDisplayName;

        public AccountPlaylistSOAPResponseItem(String accountPlaylistId, String accountName, String playlistDisplayName) {
            this.accountPlaylistId = accountPlaylistId;
            this.accountName = accountName;
            this.playlistDisplayName = playlistDisplayName;
        }
    }

    global class AccountPlaylistSOAPResponse {
        webService List<AccountPlaylistSOAPResponseItem> items {
            get {
                if (items == null) {
                    items = new List<AccountPlaylistSOAPResponseItem>();
                }
                return items;
            } set;
        }
    }

    webService static AccountPlaylistSOAPResponse getSpecificAccountPlaylist(AccountPlaylistSOAPRequest wsRequest) {
        return AccountPlaylistSOAPServiceOperations.getAccountPlaylistsByAccountAndPlaylistNames(wsRequest);
    }
}