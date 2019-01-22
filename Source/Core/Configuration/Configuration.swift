import Foundation

public extension InPlayer {
    /// Class that setup project configuration
    public struct Configuration {

        public let clientId: String
        public let referrer: String?
        public let environment: InPlayerEnvironmentType

        public init(clientId: String, refferrer: String? = nil, environment: InPlayerEnvironmentType = .production) {
            self.clientId = clientId
            self.referrer = refferrer
            self.environment = environment
        }
    }
}
