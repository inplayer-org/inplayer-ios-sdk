import Foundation

// Access fee model
public struct InPlayerAccessFee : Codable {

    /// Access type model
    public let accessType : InPlayerAccessType?

    /// The amount of the asset’s fee
    public let amount : Int?

    /// The currency of the asset’s fee
    public let currency : String?

    /// The description for the asset’s fee
    public let descriptionField : String?

    /// Fee ID
    public let id : Int?
    public let itemType : String?

    /// Merchant ID
    public let merchantId : Int?
    public let startsAt : Double?

    /// The period when customers have access to the asset before deciding whether to subscribe
    /// Note: This only applies for the subscription model
    public let trialPeriod: InPlayerTrialPeriod?

    /// The initial one-time fee that is charged when subscribing for accessing the asset
    /// Note: This only applies for the subscription model
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
        trialPeriod = try values.decodeIfPresent(InPlayerTrialPeriod.self, forKey: .trialPeriod)
        setupFee = try values.decodeIfPresent(InPlayerSetupFee.self, forKey: .setupFee)
    }

}
