import Foundation

/// Interface declaring what is possible with Configuration class
private protocol ConfigurationDataSource {
    /**
     Sets clientId and environment to UserDefaults.
     - Parameter clientId: Id of the client using the SDK
     - Parameter referrer: The request’s source URL
     - Parameter environment: Project *environment*. Defaults to production

     It can be called with or without *environment* parameter (defaults to production).
     ````
     InPlayer.Configuration.configure(withClientId: "XXXXX")
     InPlayer.Configuration.configure(withClientId: "XXXXX", environment: .debug)
     InPlayer.Configuration.configure(withClientId: "XXXXX", referrer: "http://inplayer.com" environment: .debug)
     ````
     */
    static func configure(withClientId clientId: String, referrer: String?, environment: EnvironmentType)

    /**
     Method that retrieves clientId
     - Warning: It can be empty string if
     ````
     func configure(withClientId clientId: String, referrer: String?, environment: EnvironmentType?)
     ````
     was not called.
     - Returns: ClientId that was previously saved as string value.
     */
    static func getClientId() -> String

    /**
     Method that retrieves project environment.
     - Returns: Project environment that was saved as EnvironmentTypes value.
     */
    static func getEnvironment() -> EnvironmentType

    /**
     Method that retreives referrer string.
     - Returns: Optional string containing referrer.
     */
    static func getReferrer() -> String?

    /**
     Method that retrieves server base url string.
     - Returns: String representation of server base url depending on environment.
     */
    static func getBaseUrlString() -> String
}

/**
 Project environment types
 ````
 case production
 case debug
 case staging
 */
public enum EnvironmentType: String {
    /// Sets project environment to production (default)
    case production

    /// Sets project environment to debug
    case debug

    /// Sets project environment to staging
    case staging
}


extension InPlayer {
    /// Class that setup project configuration
    final class Configuration: ConfigurationDataSource {

        /**
         Bool property to check if configuration was set.

         Used to prevent calling
         ````
         func configure(withClientId clientId: String, environment: EnvironmentType?)
         ````
         multiple times.
         */
        private static var isConfigured: Bool = false

        /**
         ClientId from the configuration. Defaults to empty string.
         */
        private static var clientId: String = ""

        /**
         Referrer
         */
        private static var referrer: String?
        /**
         Environment from the configuration. Defaults to production.
         */
        private static var environment: EnvironmentType = .production

        private init() {}

        static func configure(withClientId clientId: String,
                              referrer: String? = nil,
                              environment: EnvironmentType = .production) {

            guard isConfigured == false else { return }
            self.clientId = clientId
            self.referrer = referrer
            self.environment = environment
            isConfigured = true
        }

        static func getClientId() -> String {
            return clientId
        }

        static func getEnvironment() -> EnvironmentType {
            return environment
        }

        static func getReferrer() -> String? {
            return referrer
        }

        static func getBaseUrlString() -> String {
            switch InPlayer.Configuration.getEnvironment() {
            case .debug:
                return NetworkConstants.BaseUrls.debug
            case .staging:
                return NetworkConstants.BaseUrls.staging
            case .production:
                return NetworkConstants.BaseUrls.production
            }
        }
    }
}

