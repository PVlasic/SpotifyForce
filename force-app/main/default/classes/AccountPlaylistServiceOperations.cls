/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceOperations {
    public static List<AccountPlaylist__c> getAccountPlaylistByAccountName() {
        return AccountPlaylistSelector.getAccountPlaylistsByAccountName(
                SecurityUtils.parseAndSecureSOQLParameter(
                        RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNTNAMEREQUESTPARAMETER), false));
    }

    public static AccountPlaylist__c getAccountPlaylistByAccountName() {
        return AccountPlaylistSelector.getAccountPlaylistByName(
                SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNTNAMEREQUESTPARAMETER), false),
                SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.PLAYLISTNAMEREQUESTPARAMETER), false));
    }

    public static Id createAccountPlaylist(String accountName, String playlistName) {
        String accName = SecurityUtils.parseAndSecureSOQLParameter(accountName, false);
        String plName = SecurityUtils.parseAndSecureSOQLParameter(playlistName, false);
        if (AccountPlaylistServiceValidations.isStringInputValid(accName) && AccountPlaylistServiceValidations.isStringInputValid(plName)) {
            return PlaylistFactory.createAccountPlaylist(accName, plName, true);
        }
        return null;
    }
}