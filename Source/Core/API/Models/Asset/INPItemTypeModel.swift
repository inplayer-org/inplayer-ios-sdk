import Foundation

/// Item type model
public struct INPItemTypeModel : Codable {

    public let contentType : String?
    public let descriptionField : String?
    public let host : String?
    public let id : Int?
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
