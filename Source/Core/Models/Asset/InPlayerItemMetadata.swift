import Foundation

/// Item metadata model
public struct InPlayerItemMetadata : Codable {

    public let id : Int?
    public let name : String?
    public let value : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case value = "value"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}
