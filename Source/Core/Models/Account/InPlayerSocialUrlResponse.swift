import Foundation

/// Social URLs Server response model
struct InPlayerSocialUrlResponse : Codable {
    
    let socialUrls: [[String: String]]
    
    enum CodingKeys: String, CodingKey {
        case socialUrls = "social_urls"
    }
    
    /// Decoder method
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        socialUrls = try values.decodeIfPresent([[String: String]].self, forKey: .socialUrls) ?? []
    }
}

