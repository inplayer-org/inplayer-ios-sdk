import Foundation

/**
 Main class throught which developer access InPlayer API.
 */
public class InPlayer {
    private init () {}

    /**
     Initialize SDK with clientID, referrer string and enviorment type.
     - Parameters:
         - clientId: Also called merchantId, to identify client using the SDK.
         - referrer: The request’s source URL
         - environment: Sets SDK environment.
     */
    public static func initialize(withClienId clientId: String,
                                  referrer: String? = nil,
                                  environment: EnvironmentType = .production) {
        InPlayer.Configuration.configure(withClientId: clientId, referrer: referrer, environment: environment)
    }
}
