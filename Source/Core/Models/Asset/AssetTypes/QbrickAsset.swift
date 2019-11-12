import Foundation

/// Qbrick asset model
public struct QbrickAsset: Codable, AssetJSONDecoder {
    
    public let mediaId: String
    public let accountId: String
    
    enum CodingKeys: String, CodingKey {
        case mediaId = "media_id"
        case accountId = "account_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mediaId = try values.decode(String.self, forKey: .mediaId)
        accountId = try values.decode(String.self, forKey: .accountId)
    }
}
