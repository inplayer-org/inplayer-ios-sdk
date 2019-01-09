import Foundation

struct INPTrialPeriodModel : Codable {

    let descriptionField : String?
    let period : String?
    let quantity : Int?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case period = "period"
        case quantity = "quantity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        period = try values.decodeIfPresent(String.self, forKey: .period)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
    }

}
