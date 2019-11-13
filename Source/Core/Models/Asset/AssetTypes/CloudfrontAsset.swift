import Foundation

/// Cloudfront asset model
public struct CloudfrontAsset: Codable, AssetJSONDecoder {
    
    public let player: String
    public let sourceUrl: String
    
    enum CodingKeys: String, CodingKey {
        case player = "player"
        case sourceUrl = "source_url"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        player = try values.decode(String.self, forKey: .player)
        sourceUrl = try values.decode(String.self, forKey: .sourceUrl)
    }
}
