import Foundation

/// Birghtcove asset model
public struct BrightcoveAsset: Codable, AssetJSONDecoder {
    
    public let accountId: String
    public let videoId: String
    public let token: String?
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case videoId = "video_id"
        case token = "token"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try values.decode(String.self, forKey: .accountId)
        videoId = try values.decode(String.self, forKey: .videoId)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
}
