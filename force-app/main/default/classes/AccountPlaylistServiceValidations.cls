/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class AccountPlaylistServiceValidations {

    public static Boolean isStringInputValid(String input) {
        return String.isNotBlank(input) && input.isAlphanumericSpace();
    }
}