import Foundation

public struct LaolaAsset: Codable, AssetJSONDecoder {
    
    public let videoId: String
    public let partnerId: String
    
    enum CodingKeys: String, CodingKey {
        case videoId = "videoId"
        case partnerId = "partner_id"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        videoId = try values.decode(String.self, forKey: .videoId)
        partnerId = try values.decode(String.self, forKey: .partnerId)
    }
}
