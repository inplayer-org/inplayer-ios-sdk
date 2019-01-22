import Foundation

/// Credentials Model
public struct InPlayerCredentials: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let expires: Double
}
