import Foundation

/// Access type model
public struct INPAccessTypeModel : Codable {

    public let id : Int?
    public let name : String?
    public let period : String?
    public let quantity : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case period = "period"
        case quantity = "quantity"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        period = try values.decodeIfPresent(String.self, forKey: .period)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
    }

}
