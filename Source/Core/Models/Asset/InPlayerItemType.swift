import Foundation

/// Item type model
public struct InPlayerItemType : Codable {

    /// One of the content types (html, ovp, dlc, rss)
    public let contentType : String?

    /// The description of the asset type
    public let descriptionField : String?

    /// The platform hosting the content (OVP, CDN etc.)
    public let host : String?

    /// Asset type ID
    public let id : Int?

    /// The name of the asset type
    public let name : String?

    enum CodingKeys: String, CodingKey {
        case contentType = "content_type"
        case descriptionField = "description"
        case host = "host"
        case id = "id"
        case name = "name"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contentType = try values.decodeIfPresent(String.self, forKey: .contentType)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        host = try values.decodeIfPresent(String.self, forKey: .host)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
