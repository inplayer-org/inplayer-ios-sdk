import Foundation

/// Setup fee model
public struct InPlayerSetupFee : Codable {

    /// Description regarding the setup fee
    public let descriptionField : String?

    /// The price to be paid for accessing the asset
    public let feeAmount : Int?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case feeAmount = "fee_amount"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        feeAmount = try values.decodeIfPresent(Int.self, forKey: .feeAmount)
    }

}
