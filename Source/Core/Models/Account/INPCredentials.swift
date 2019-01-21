import Foundation

/// Credentials Model
public struct INPCredentials: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let expires: Double
}
