import Foundation

public class InPlayer {
    private init () {}

    /**
     Initialize SDK with clientID and enviorment.
     - Parameters:
     - clientId: Also called merchantId, to identify client using the SDK.
     - environment: Sets SDK environment.
     */
    public static func initialize(withClienId clientId: String, environment: EnvironmentType? = .production) {
        InPlayer.Configuration.configure(withClientId: clientId, environment: environment)
    }
}
