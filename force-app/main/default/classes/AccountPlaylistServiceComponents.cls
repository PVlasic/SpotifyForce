/**
 * Created by catalinalexandrutanasie on 12.10.2021.
 */

global with sharing class AccountPlaylistServiceComponents {
    global class AccountPlaylistServiceRequest {

    }
    public class AccountPlaylistServiceResponse {
        public String outcome {get; set;}

        public AccountPlaylistServiceResponse(AccountPlaylistServiceConstants.OUTCOME outcome) {
            this.outcome = String.valueOf(outcome);
        }
    }
}