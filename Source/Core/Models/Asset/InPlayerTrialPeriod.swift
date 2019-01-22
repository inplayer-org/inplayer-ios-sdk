import Foundation

/// Trial period model
public struct InPlayerTrialPeriod : Codable {

    public let descriptionField : String?
    public let period : String?
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
