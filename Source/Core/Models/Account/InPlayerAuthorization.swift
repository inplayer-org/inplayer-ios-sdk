import Foundation

/// Authorization Model
public struct InPlayerAuthorization : Codable {

    /// Bearer access token used to authenticate user.
    public let accessToken : String?

    /// Bearer refresh token used to generate new access token when expires.
    public let refreshToken: String?

    /// Logged in account
    public let account : InPlayerAccount?

    /// Time at which the access token expires, measured in seconds since 1 January 1970 (UTC)
    public let expires: Double?

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case account = "account"
        case expires = "expires"
    }

    /**
     Decoder method
     */
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
        account = try values.decodeIfPresent(InPlayerAccount.self, forKey: .account)
        expires = try values.decodeIfPresent(Double.self, forKey: .expires)
    }

}
