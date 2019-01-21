import Foundation

/**
 Project environment types
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
    final class Configuration {

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

