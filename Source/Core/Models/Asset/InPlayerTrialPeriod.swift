import Foundation

/// Trial period model
public struct InPlayerTrialPeriod : Codable {

    /// Description regarding the trial period
    public let descriptionField : String?

    /// One of the period types: 'minute', ‘hour', ‘day', ‘week', ‘month' or ‘year'
    public let period : String?

    /// The number denoting the duration of the access
    public let quantity : Int?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case period = "period"
        case quantity = "quantity"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        period = try values.decodeIfPresent(String.self, forKey: .period)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
    }

}
