/**
 * Created by catalinalexandrutanasie on 13.10.2021.
 */

public with sharing class AccountPlaylistServiceValidations {

    public static Boolean isStringInputValid(String input) {
        return String.isNotBlank(input) && input.isAlphanumericSpace();
    }

    public static Boolean isDatetimeStringValid(String datetimeStr) {
        try {
            Datetime testDatetime = Datetime.parse(datetimeStr);
            return true;
        } catch (System.TypeException tEx) {
            return false;
        }
    }
}