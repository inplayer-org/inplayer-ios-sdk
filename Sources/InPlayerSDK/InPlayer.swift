import Foundation

public class InPlayer {
    private init () {}
    public static func initialize(withClienId clientId: String, environment: EnvironmentType? = .production) {
        InPlayer.Configuration.configure(withClientId: clientId, environment: environment)
    }
}
