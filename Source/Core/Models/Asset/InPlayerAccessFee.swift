import Foundation

// Access fee model
public struct InPlayerAccessFee : Codable {

    public let accessType : InPlayerAccessType?
    public let amount : Int?
    public let currency : String?
    public let descriptionField : String?
    public let id : Int?
    public let itemType : String?
    public let merchantId : Int?
    public let startsAt : Double?
    public let trialPeriod: InPlayerTrialPeriod?
    public let setupFee: InPlayerSetupFee?

    enum CodingKeys: String, CodingKey {
        case accessType = "access_type"
        case amount = "amount"
        case currency = "currency"
        case descriptionField = "description"
        case id = "id"
        case itemType = "item_type"
        case merchantId = "merchant_id"
        case startsAt = "starts_at"
        case trialPeriod = "trial_period"
        case setupFee = "setup_fee"
    }

    /// Decoder Method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessType = try values.decodeIfPresent(InPlayerAccessType.self, forKey: .accessType)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        itemType = try values.decodeIfPresent(String.self, forKey: .itemType)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        startsAt = try values.decodeIfPresent(Double.self, forKey: .startsAt)
        trialPeriod = try values.decode(InPlayerTrialPeriod.self, forKey: .trialPeriod)
        setupFee = try values.decode(InPlayerSetupFee.self, forKey: .setupFee)
    }

}
