import Foundation

/// DaCast asset model
public struct DaCastAsset: Codable, AssetJSONDecoder {
    
    public let contentId: String
    public let token: String?
    
    enum CodingKeys: String, CodingKey {
        case contentId = "content_id"
        case token = "token"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contentId = try values.decode(String.self, forKey: .contentId)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
