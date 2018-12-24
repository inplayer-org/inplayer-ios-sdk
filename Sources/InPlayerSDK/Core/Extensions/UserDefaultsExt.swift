import Foundation

protocol UserDefaultsDataSource {
    /// Sets and retrieves clientId from UserDefaults
    static var clientId: String? { get set }

    /// Sets and retrieves environment
    static var environment: EnvironmentType { get set }
}

extension UserDefaults: UserDefaultsDataSource {

    static var clientId: String? {
        get {
            return standard.string(forKey: InPlayerConstants.UserDefaultsKeys.clientId)
        }
        set {
            standard.set(clientId, forKey: InPlayerConstants.UserDefaultsKeys.clientId)
        }
    }

    static var environment: EnvironmentType {
        get {
            return EnvironmentType(rawValue: InPlayerConstants.UserDefaultsKeys.environment) ?? .production
        }
        set {
            standard.set(environment.rawValue, forKey: InPlayerConstants.UserDefaultsKeys.environment)
        }
    }
}
