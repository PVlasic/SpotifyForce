/**
 * Created by catalinalexandrutanasie on 14.10.2021.
 */

public with sharing class AccountPlaylistSOAPServiceOperations {
    public static AccountPlaylistSOAPService.AccountPlaylistSOAPResponse getAccountPlaylistsByAccountAndPlaylistNames(AccountPlaylistSOAPService.AccountPlaylistSOAPRequest wsRequest) {
        //todo implement a request class
        Boolean isAccountNameValid = AccountPlaylistServiceValidations.isStringInputValid(wsRequest.accountName);
        Boolean isPlaylistNameValid = AccountPlaylistServiceValidations.isStringInputValid(wsRequest.playlistDisplayName);
        if (isAccountNameValid && isPlaylistNameValid) {
            return AccountPlaylistSOAPServiceOperations.prepareResponse(AccountPlaylistSelector.getAccountPlaylistByAccountAndPlaylistNames(
                    SecurityUtils.parseAndSecureSOQLParameter(wsRequest.accountName, false),
                    SecurityUtils.parseAndSecureSOQLParameter(wsRequest.playlistDisplayName, false)));
        } else if (isAccountNameValid) {
            return AccountPlaylistSOAPServiceOperations.prepareResponse(AccountPlaylistSelector.getAccountPlaylistsByAccountName(SecurityUtils.parseAndSecureSOQLParameter(wsRequest.accountName, false)));
        } else if (isPlaylistNameValid) {
            return AccountPlaylistSOAPServiceOperations.prepareResponse(AccountPlaylistSelector.getAccountPlaylistsByPlaylistName(SecurityUtils.parseAndSecureSOQLParameter(wsRequest.playlistDisplayName, false)));
        }
        return null;
    }

    private static AccountPlaylistSOAPService.AccountPlaylistSOAPResponse prepareResponse(List<AccountPlaylist__c> lPlaylistsToReturn) {
        AccountPlaylistSOAPService.AccountPlaylistSOAPResponse response = new AccountPlaylistSOAPService.AccountPlaylistSOAPResponse();
        AccountPlaylistSOAPService.AccountPlaylistSOAPResponseItem item;
        for (AccountPlaylist__c currentAccountPlaylist : lPlaylistsToReturn) {
            item = new AccountPlaylistSOAPService.AccountPlaylistSOAPResponseItem(currentAccountPlaylist.Id, currentAccountPlaylist.Account__r.Name, currentAccountPlaylist.Playlist__r.DisplayName__c);
            response.items.add(item);
        }
        return response;
    }
}