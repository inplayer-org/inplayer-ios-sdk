import Foundation

protocol UserDefaultsDataSource {
    /// Sets and retrieves clientId from UserDefaults
    static var clientId: String { get set }

    /// Sets and retrieves environment
    static var environment: EnvironmentType { get set }

    static var credentials: INPCredentials { get set }
}

extension UserDefaults: UserDefaultsDataSource {

    static var clientId: String {
        get {
            return standard.string(forKey: InPlayerConstants.UserDefaultsKeys.clientId) ?? ""
        }
        set {
            standard.set(clientId, forKey: InPlayerConstants.UserDefaultsKeys.clientId)
        }
    }

    static var environment: EnvironmentType {
        get {
            guard
                let environmentString = standard.string(forKey: InPlayerConstants.UserDefaultsKeys.environment),
                let environment = EnvironmentType(rawValue: environmentString)
            else {
                return .production
            }
            return environment
        }
        set {
            standard.set(environment.rawValue, forKey: InPlayerConstants.UserDefaultsKeys.environment)
        }
    }

    static var credentials: INPCredentials {
        get {
            guard
                let savedCredentialData = standard.object(forKey: InPlayerConstants.UserDefaultsKeys.token) as? Data,
                let credentials = try? JSONDecoder().decode(INPCredentials.self, from: savedCredentialData)
            else {
                return INPCredentials(accessToken: "", refreshToken: "", expires: 0)
            }
            return credentials
        }
        set {
            let encoded = try? JSONEncoder().encode(credentials)
            standard.set(encoded, forKey: InPlayerConstants.UserDefaultsKeys.token)
        }
    }
}
