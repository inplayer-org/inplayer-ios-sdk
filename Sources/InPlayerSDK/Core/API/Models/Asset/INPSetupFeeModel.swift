import Foundation

struct INPSetupFeeModel : Codable {

    let descriptionField : String?
    let feeAmount : Int?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case feeAmount = "fee_amount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        feeAmount = try values.decodeIfPresent(Int.self, forKey: .feeAmount)
    }

}
