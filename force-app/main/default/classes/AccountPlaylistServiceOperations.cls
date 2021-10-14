/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceOperations {

    public static List<AccountPlaylist__c> getAccountPlaylistsByAccountAndPlaylistNames() {
        //todo change to path parameters
        Boolean isAccountNameValid = AccountPlaylistServiceValidations.isStringInputValid(RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNTNAMEREQUESTPARAMETER));
        Boolean isPlaylistNameValid = AccountPlaylistServiceValidations.isStringInputValid(RestContext.request.params.get(AccountPlaylistServiceConstants.PLAYLISTNAMEREQUESTPARAMETER));
        if (isAccountNameValid && isPlaylistNameValid) {
            return AccountPlaylistSelector.getAccountPlaylistByAccountAndPlaylistNames(
                    SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNTNAMEREQUESTPARAMETER), false),
                    SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.PLAYLISTNAMEREQUESTPARAMETER), false));
        } else if (isAccountNameValid) {
            return AccountPlaylistSelector.getAccountPlaylistsByAccountName(SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNTNAMEREQUESTPARAMETER), false));
        } else if (isPlaylistNameValid) {
            return AccountPlaylistSelector.getAccountPlaylistsByPlaylistName(SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.PLAYLISTNAMEREQUESTPARAMETER), false));
        }
        return null;
    }

    public static AccountPlaylist__c createAccountPlaylist(String accountName, String playlistDisplayName) {
        String accName = SecurityUtils.parseAndSecureSOQLParameter(accountName, false);
        String plName = SecurityUtils.parseAndSecureSOQLParameter(playlistDisplayName, false);
        if (AccountPlaylistServiceValidations.isStringInputValid(accName) && AccountPlaylistServiceValidations.isStringInputValid(plName)) {
            return PlaylistFactory.createAccountPlaylist(accName, plName, true);
        }
        return null;
    }

    public static void deleteAccountPlaylist() {
        String accName = SecurityUtils.parseAndSecureSOQLParameter(ServiceUtils.obtainValueFromURI(RestContext.request.requestURI, AccountPlaylistServiceConstants.URISEPARATOR, 1), false);
        String plName = SecurityUtils.parseAndSecureSOQLParameter(ServiceUtils.obtainValueFromURI(RestContext.request.requestURI, AccountPlaylistServiceConstants.URISEPARATOR, 0), false);
        if (AccountPlaylistServiceValidations.isStringInputValid(accName) && AccountPlaylistServiceValidations.isStringInputValid(plName)) {
            RestContext.response.responseBody = AccountPlaylistServiceOperations.buildWSResponseBlob(PlaylistFactory.deleteAccountPlaylists(new Id[] {AccountPlaylistSelector.getAccountPlaylistIdForAccountAndPlaylistName(accName, plName)}));
        }
    }

    public static void addSongToPlaylist() {

    }

    private static Blob buildWSResponseBlob(AccountPlaylistServiceConstants.OUTCOME currentOutcome) {
        return Blob.valueOf(JSON.serializePretty(new AccountPlaylistServiceComponents.AccountPlaylistServiceResponse(currentOutcome)));
    }
}