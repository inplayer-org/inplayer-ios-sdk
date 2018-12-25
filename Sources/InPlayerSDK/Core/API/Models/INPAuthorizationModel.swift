import Foundation

public struct INPAuthorizationModel : Codable {

    let accessToken : String?
    let account : INPAccount?

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case account = "account"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        account = try INPAccount(from: decoder)
    }

}
