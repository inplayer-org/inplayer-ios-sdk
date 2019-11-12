import Foundation

/// JwPlayer asset model
public struct JwPlayerAsset: Codable, AssetJSONDecoder {
    
    public let videoId: String
    public let playerId: String
    
    enum CodingKeys: String, CodingKey {
        case videoId = "video_id"
        case playerId = "player_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        videoId = try values.decode(String.self, forKey: .videoId)
        playerId = try values.decode(String.self, forKey: .playerId)
    }
}
