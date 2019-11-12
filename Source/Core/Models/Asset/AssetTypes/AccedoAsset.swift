import Foundation

/// Accedo asset model
public struct AccedoAsset: Codable, AssetJSONDecoder {

    public let videoKey: String
    
    enum CodingKeys: String, CodingKey {
        case videoKey = "video_key"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        videoKey = try values.decode(String.self, forKey: .videoKey)
    }
}
