import Foundation

/// Kaltura asset model
public struct KalturaAsset: Codable, AssetJSONDecoder {
    
    public let entryId: String
    public let uiconfigId: String
    public let partnerId: String
 
    enum CodingKeys: String, CodingKey {
        case entryId = "entry_id"
        case uiconfigId = "uiconfig_id"
        case partnerId = "partner_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        entryId = try values.decode(String.self, forKey: .entryId)
        uiconfigId = try values.decode(String.self, forKey: .uiconfigId)
        partnerId = try values.decode(String.self, forKey: .partnerId)
    }
}
