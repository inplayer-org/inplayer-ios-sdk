import Foundation

/// Access type model
public struct InPlayerAccessType : Codable {

    /// Access type ID
    public let id : Int?

    /// The name of the access type (ppv, subscription, or custom)
    public let name : String?
    
    /// Account ID
    public let accountId: Int?

    /// Refers to one of the period types: ‘minute’, ‘hour’, ‘day’, ‘week’, ‘month’ or ‘year’
    public let period : String?

    /// Number denoting the duration of the access
    public let quantity : Int?
    
    public let createdAt: Double?
    public let updatedAt: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case accountId = "account_id"
        case period = "period"
        case quantity = "quantity"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        accountId = try values.decodeIfPresent(Int.self, forKey: .accountId)
        period = try values.decodeIfPresent(String.self, forKey: .period)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }

}
