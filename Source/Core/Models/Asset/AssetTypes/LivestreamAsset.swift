import Foundation

/// Livestream asset model
public struct LivestreamAsset: Codable, AssetJSONDecoder {
    
    public let accountId: String
    public let eventId: String
    public let videoId: String
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case eventId = "event_id"
        case videoId = "video_id"
        
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try values.decode(String.self, forKey: .accountId)
        eventId = try values.decode(String.self, forKey: .eventId)
        videoId = try values.decode(String.self, forKey: .videoId)
    }
}
