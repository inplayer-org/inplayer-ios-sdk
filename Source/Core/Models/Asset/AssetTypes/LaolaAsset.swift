import Foundation

/// Laola asset model
public struct LaolaAsset: Codable, AssetJSONDecoder {
    
    public let videoId: String
    public let partnerId: String
    
    enum CodingKeys: String, CodingKey {
        case videoId = "video_id"
        case partnerId = "partner_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        videoId = try values.decode(String.self, forKey: .videoId)
        partnerId = try values.decode(String.self, forKey: .partnerId)
    }
}
