import Foundation

/**
 Main class throught which developer access InPlayer API.
 */
public final class InPlayer {
    private init () {}

    /**
     Initializes SDK with Configuration. It can be called only once.
     - Parameters:
         - configuration: Configuration object
     */
    public static func initialize(configuration: Configuration) {
        guard isConfigured == false else { return }
        clientId = configuration.clientId
        referrer = configuration.referrer
        environment = configuration.environment
        switch environment {
        case .debug:
            redirectURI = InPlayerConstants.SocialRedirectUri.staging
        case .staging:
            redirectURI = InPlayerConstants.SocialRedirectUri.staging
        case .production:
            redirectURI = InPlayerConstants.SocialRedirectUri.production
        }
        isConfigured = true
    }
}
