/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceOperations {

    public static List<AccountPlaylist__c> getAccountPlaylistsByAccountAndPlaylistNames() {
        Boolean isAccountNameValid = AccountPlaylistServiceValidations.isStringInputValid(RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNT_NAME_REQUEST_PARAMETER));
        Boolean isPlaylistNameValid = AccountPlaylistServiceValidations.isStringInputValid(RestContext.request.params.get(AccountPlaylistServiceConstants.PLAYLIST_NAME_REQUEST_PARAMETER));
        if (isAccountNameValid && isPlaylistNameValid) {
            return AccountPlaylistSelector.getAccountPlaylistByAccountAndPlaylistNames(
                    SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNT_NAME_REQUEST_PARAMETER), false),
                    SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.PLAYLIST_NAME_REQUEST_PARAMETER), false));
        } else if (isAccountNameValid) {
            return AccountPlaylistSelector.getAccountPlaylistsByAccountName(SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.ACCOUNT_NAME_REQUEST_PARAMETER), false));
        } else if (isPlaylistNameValid) {
            return AccountPlaylistSelector.getAccountPlaylistsByPlaylistName(SecurityUtils.parseAndSecureSOQLParameter(RestContext.request.params.get(AccountPlaylistServiceConstants.PLAYLIST_NAME_REQUEST_PARAMETER), false));
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
        String accName = SecurityUtils.parseAndSecureSOQLParameter(ServiceUtils.obtainValueFromURI(RestContext.request.requestURI, AccountPlaylistServiceConstants.URI_SEPARATOR, 1), false);
        String plName = SecurityUtils.parseAndSecureSOQLParameter(ServiceUtils.obtainValueFromURI(RestContext.request.requestURI, AccountPlaylistServiceConstants.URI_SEPARATOR, 0), false);
        if (AccountPlaylistServiceValidations.isStringInputValid(accName) && AccountPlaylistServiceValidations.isStringInputValid(plName)) {
            RestContext.response.responseBody = AccountPlaylistServiceOperations.buildWSResponseBlob(PlaylistFactory.deleteAccountPlaylists(new Id[] {AccountPlaylistSelector.getAccountPlaylistIdForAccountAndPlaylistName(accName, plName)}) ? AccountPlaylistServiceConstants.OUTCOME.SUCCESS : AccountPlaylistServiceConstants.OUTCOME.FAILURE);
        }
    }

    public static void addSongToPlaylist() {
        AccountPlaylistServiceComponents.SongPlaylistAddRequest spRequest = (AccountPlaylistServiceComponents.SongPlaylistAddRequest)JSON.deserializeStrict(RestContext.request.requestBody.toString(), AccountPlaylistServiceComponents.SongPlaylistAddRequest.class);
        String pdName = SecurityUtils.parseAndSecureSOQLParameter(spRequest.playlistDisplayName, false);
        String sName = SecurityUtils.parseAndSecureSOQLParameter(spRequest.songName, false);
        if (AccountPlaylistServiceValidations.isStringInputValid(pdName) && AccountPlaylistServiceValidations.isStringInputValid(sName)) {
            PlaylistSong__c upsertedPSong = PlaylistFactory.upsertPlaylistSong(pdName, sName, spRequest.addedOn);
            if (String.isNotBlank(upsertedPSong.Id)) {
                RestContext.response.responseBody = AccountPlaylistServiceOperations.buildWSResponseBlob(new AccountPlaylistServiceComponents.SongPlaylistAddResponse(upsertedPSong.Id, PlaylistSongSelector.getAllSongsByPlaylistName(pdName)));
            } else {
                RestContext.response.responseBody = AccountPlaylistServiceOperations.buildWSResponseBlob(AccountPlaylistServiceConstants.OUTCOME.FAILURE);
            }
        }

    }

    private static Blob buildWSResponseBlob(AccountPlaylistServiceConstants.OUTCOME currentOutcome) {
        return Blob.valueOf(JSON.serializePretty(new AccountPlaylistServiceComponents.AccountPlaylistServiceResponse(currentOutcome)));
    }

    private static Blob buildWSResponseBlob(AccountPlaylistServiceComponents.SongPlaylistAddResponse deserializedSPResponse) {
        return Blob.valueOf(JSON.serializePretty(deserializedSPResponse));
    }
}