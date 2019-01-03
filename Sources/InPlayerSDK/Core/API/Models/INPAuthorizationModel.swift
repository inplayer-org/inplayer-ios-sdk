import Foundation

public struct INPAuthorizationModel : Codable {

    let accessToken : String?
    let refreshToken: String?
    let account : INPAccount?
    let expires: Double?

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case account = "account"
        case expires = "expires"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
        account = try values.decodeIfPresent(INPAccount.self, forKey: .account)
        expires = try values.decodeIfPresent(Double.self, forKey: .expires)
    }

}
