import Foundation

/// Trial period model
public struct InPlayerTrialPeriod : Codable {
    
    /// Id
    public let id: Int?

    /// Description regarding the trial period
    public let descriptionField : String?

    /// One of the period types: 'minute', ‘hour', ‘day', ‘week', ‘month' or ‘year'
    public let period : String?

    /// The number denoting the duration of the access
    public let quantity : Int?
    
    public let createdAt: Double?
    public let updatedAt: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case descriptionField = "description"
        case period = "period"
        case quantity = "quantity"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        period = try values.decodeIfPresent(String.self, forKey: .period)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }

}
