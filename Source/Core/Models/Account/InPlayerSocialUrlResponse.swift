import Foundation

/// Social URLs Server response model
public struct InPlayerSocialUrlResponse : Codable {
    
    public let socialUrls: [[String: String]]
    
    enum CodingKeys: String, CodingKey {
        case socialUrls = "social_urls"
    }
    
    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        socialUrls = try values.decodeIfPresent([[String: String]].self, forKey: .socialUrls) ?? []
    }
}

