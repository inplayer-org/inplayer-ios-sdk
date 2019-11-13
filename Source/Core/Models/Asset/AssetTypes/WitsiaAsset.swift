import Foundation

/// Witsia asset model
public struct WitsiaAsset: Codable, AssetJSONDecoder {
    
    public let videoId: String
    
    enum CodingKeys: String, CodingKey {
        case videoId = "video_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        videoId = try values.decode(String.self, forKey: .videoId)
    }
}
