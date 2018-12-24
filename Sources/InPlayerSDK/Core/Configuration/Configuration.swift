import Foundation

/// Interface declaring what is possible with Configuration class
private protocol ConfigurationDataSource {
    /**
     Bool property to check if configuration was set.

     Used to prevent calling
     ````
     func configure(withClientId clientId: String, environment: EnvironmentType?)
     ````
     multiple times.
     */
    ///
    static var isConfigured: Bool { get set }

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
     - Warning: It can be nil if
     ````
     func configure(withClientId clientId: String, environment: EnvironmentType?)
     ````
     was not called.
     - Returns: ClientId that was previously saved as optional string value.
     */
    static func getClientId() -> String?

    /**
     Method that retrieves project environment.
     - Returns: Project environment that was saved as EnvironmentTypes value.
     */
    static func getEnvironment() -> EnvironmentType
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
    final public class Configuration: ConfigurationDataSource {

        static var isConfigured: Bool = false

        private init() {}

        public static func configure(withClientId clientId: String, environment: EnvironmentType? = .production) {
            guard isConfigured == false else { return }
            UserDefaults.clientId = clientId
            UserDefaults.environment = environment!
            print("This should be executed once")
            isConfigured = true
        }

        public static func getClientId() -> String? {
            return UserDefaults.clientId
        }

        public static func getEnvironment() -> EnvironmentType {
            return UserDefaults.environment
        }
    }
}
