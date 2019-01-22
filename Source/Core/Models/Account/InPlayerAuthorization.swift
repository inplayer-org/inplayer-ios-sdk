import Foundation

/// Authorization Model
public struct InPlayerAuthorization : Codable {

    public let accessToken : String?
    public let refreshToken: String?
    public let account : InPlayerAccount?
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
