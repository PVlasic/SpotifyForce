/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

public with sharing class AccountPlaylistServiceConstants {
    public static final String ACCOUNTNAMEREQUESTPARAMETER = 'accountName';
    public static final String PLAYLISTNAMEREQUESTPARAMETER = 'playlistDisplayName';
    public static final String URISEPARATOR = '/';

    public enum OUTCOME {SUCCESS, PARTIALSUCCESS, FAILURE}
}