import Foundation

/// Setup fee model
public struct InPlayerSetupFee : Codable {

    /// Id
    public let id: Int?
    
    /// Description regarding the setup fee
    public let descriptionField : String?

    /// The price to be paid for accessing the asset
    public let feeAmount : Double?
    
    public let createdAt: Double?
    public let updatedAt: Double?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case descriptionField = "description"
        case feeAmount = "fee_amount"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        feeAmount = try values.decodeIfPresent(Double.self, forKey: .feeAmount)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }

}
