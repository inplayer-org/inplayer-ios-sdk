import Foundation

/// StreamAMGAsset model
public struct StreamAMGAsset: Codable, AssetJSONDecoder {
    public let partnerId: String
    public let uiconfigId: String
    public let entryId: String
    public let token: String?

    enum CodingKeys: String, CodingKey {
        case partnerId = "partner_id"
        case uiconfigId = "uiconfig_id"
        case entryId = "entry_id"
        case token = "token"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        partnerId = try values.decode(String.self, forKey: .partnerId)
        uiconfigId = try values.decode(String.self, forKey: .uiconfigId)
        entryId = try values.decode(String.self, forKey: .entryId)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
