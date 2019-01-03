import Foundation

public protocol CredentialsProvider {
    static func getCredentials() -> INPCredentials
    func isTokenValid() -> Bool
}

public struct INPCredentials: Codable {
    let accessToken: String
    let refreshToken: String
    let expires: Double
}

extension INPCredentials: CredentialsProvider {
    public static func getCredentials() -> INPCredentials {
        return UserDefaults.credentials
    }

    public func isTokenValid() -> Bool {
        let timeNow: Double = Date().milisecondsSince1970
        return expires * 1000 > timeNow && accessToken != "" && !accessToken.isEmpty
    }
    
}
