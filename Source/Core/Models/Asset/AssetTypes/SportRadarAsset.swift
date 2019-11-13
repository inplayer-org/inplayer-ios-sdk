import Foundation

/// SportRadar asset model
public struct SportRadarAsset: Codable, AssetJSONDecoder {
    
    public let streamId: String
    public let partnerId: String
    public let token: String?
    
    enum CodingKeys: String, CodingKey {
        case streamId = "stream_id"
        case partnerId = "partner_id"
        case token = "token"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        streamId = try values.decode(String.self, forKey: .streamId)
        partnerId = try values.decode(String.self, forKey: .partnerId)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
