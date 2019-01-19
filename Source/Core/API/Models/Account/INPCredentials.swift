import Foundation

public struct INPCredentials: Codable {
    let accessToken: String
    let refreshToken: String
    let expires: Double
}
