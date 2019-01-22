import Foundation

/// Credentials Model
public struct InPlayerCredentials: Codable {

    /// Bearer access token used to authenticate user.
    public let accessToken: String

    /// Bearer refresh token used to generate new access token when expires.
    public let refreshToken: String

    /// Time at which the access token expires, measured in seconds since 1 January 1970 (UTC)
    public let expires: Double
}
