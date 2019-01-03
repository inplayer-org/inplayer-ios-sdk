import Foundation

/// Interface declaring what is possible with Configuration class
private protocol ConfigurationDataSource {
    /**
     Sets clientId and environment to UserDefaults.
     - Parameter clientId: Id of the client using the SDK
     - Parameter environment: Project *environment*. Defaults to production

     It can be called with or without *environment* parameter (defaults to production).
     ````
     InPlayer.Configuration.configure(withClientId: "XXXXX")
     InPlayer.Configuration.configure(withClientId: "XXXXX", environment: .debug)
     ````
     */
    static func configure(withClientId clientId: String, environment: EnvironmentType?)

    /**
     Method that retrieves clientId
     - Warning: It can be empty string if
     ````
     func configure(withClientId clientId: String, environment: EnvironmentType?)
     ````
     was not called.
     - Returns: ClientId that was previously saved as optional string value.
     */
    static func getClientId() -> String

    /**
     Method that retrieves project environment.
     - Returns: Project environment that was saved as EnvironmentTypes value.
     */
    static func getEnvironment() -> EnvironmentType

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


public extension InPlayer {
    /// Class that setup project configuration
    final public class Configuration: ConfigurationDataSource {

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
         Environment from the configuration. Defaults to production.
         */
        private static var environment: EnvironmentType = .production

        private init() {}

        public static func configure(withClientId clientId: String, environment: EnvironmentType? = .production) {
            guard isConfigured == false else { return }
            UserDefaults.clientId = clientId
            UserDefaults.environment = environment!
            self.clientId = clientId
            self.environment = environment!
            print("Configured: ClientId: \(self.clientId), environment: \(self.environment.rawValue)")
            isConfigured = true
        }

        public static func getClientId() -> String {
            return clientId
        }

        public static func getEnvironment() -> EnvironmentType {
            return environment
        }

        public static func getBaseUrlString() -> String {
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

