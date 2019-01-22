import Foundation

/// Access type model
public struct InPlayerAccessType : Codable {

    /// Access type ID
    public let id : Int?

    /// The name of the access type (ppv, subscription, or custom)
    public let name : String?

    /// Refers to one of the period types: ‘minute’, ‘hour’, ‘day’, ‘week’, ‘month’ or ‘year’
    public let period : String?

    /// Number denoting the duration of the access
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
