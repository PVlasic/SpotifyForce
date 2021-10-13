/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class AccountPlaylistServiceValidations {
    private static final String ALPHANUMERICRANGE = '[\w\d ]';

    public static Boolean isStringInputValid(String input) {
        return String.isNotBlank(input) && input.containsOnly(AccountPlaylistServiceValidations.ALPHANUMERICRANGE);
    }
}