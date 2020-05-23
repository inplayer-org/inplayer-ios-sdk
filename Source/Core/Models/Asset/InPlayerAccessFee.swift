import Foundation

/// Access fee model
public struct InPlayerAccessFee : Codable {

    /// Voucher Rule
    public let voucherRule: InPlayerVoucherRule?
    
    /// Unique item ID
    public let id : Int?
    
    /// Unique merchant ID
    public let merchantId : Int?
    
    /// The amount of the asset’s fee
    public let amount : Double?

    /// The currency of the asset’s fee
    public let currency : String?

    /// The description of the asset
    public let descriptionField : String?
    
    /// Item model
    public let item: InPlayerItem?
    
    /// Access type model
    public let accessType : InPlayerAccessType?
    
    /// The number denoting the duration of the access
    public let trialPeriod: InPlayerTrialPeriod?

    /// The initial one-time fee that is charged when subscribing for accessing the asset
    /// Note: This only applies for the subscription model
    public let setupFee: InPlayerSetupFee?
    
    /// Geo restriction model
    public let geoRestriction: InPlayerGeoRestriction?
    
    /// Seasonal fee model
    public let seasonalFee: InPlayerSeasonalFee?
    
    public let externalFees: [InPlayerExternalFee]?
    
    /// The date the access expires, measured in seconds since 1 January 1970 (UTC) Note: This only applies for the custom access type
    public let expiresAt: Double?
    
    public let startsAt: Double?
    
    enum CodingKeys: String, CodingKey {
        
        case voucherRule = "voucher_rule"
        case id = "id"
        case merchantId = "merchant_id"
        case amount = "amount"
        case currency = "currency"
        case descriptionField = "description"
        case item = "item"
        case accessType = "access_type"
        case trialPeriod = "trial_period"
        case setupFee = "setup_fee"
        case geoRestriction = "geo_restriction"
        case seasonalFee = "seasonal_fee"
        case expiresAt = "expires_at"
        case externalFees = "external_fees"
        case startsAt = "starts_at"
    }

    /// Decoder Method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        voucherRule = try values.decodeIfPresent(InPlayerVoucherRule.self, forKey: .voucherRule)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        item = try values.decodeIfPresent(InPlayerItem.self, forKey: .item)
        accessType = try values.decodeIfPresent(InPlayerAccessType.self, forKey: .accessType)
        trialPeriod = try values.decodeIfPresent(InPlayerTrialPeriod.self, forKey: .trialPeriod)
        setupFee = try values.decodeIfPresent(InPlayerSetupFee.self, forKey: .setupFee)
        geoRestriction = try values.decodeIfPresent(InPlayerGeoRestriction.self, forKey: .geoRestriction)
        seasonalFee = try values.decodeIfPresent(InPlayerSeasonalFee.self, forKey: .seasonalFee)
        expiresAt = try values.decodeIfPresent(Double.self, forKey: .expiresAt)
        externalFees = try values.decodeIfPresent([InPlayerExternalFee].self, forKey: .externalFees)
        startsAt = try values.decodeIfPresent(Double.self, forKey: .startsAt)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(voucherRule, forKey: .voucherRule)
        try values.encodeIfPresent(id, forKey: .id)
        try values.encodeIfPresent(merchantId, forKey: .merchantId)
        try values.encodeIfPresent(amount, forKey: .amount)
        try values.encodeIfPresent(currency, forKey: .currency)
        try values.encodeIfPresent(descriptionField, forKey: .descriptionField)
        try values.encodeIfPresent(item, forKey: .item)
        try values.encodeIfPresent(accessType, forKey: .accessType)
        try values.encodeIfPresent(trialPeriod, forKey: .trialPeriod)
        try values.encodeIfPresent(setupFee, forKey: .setupFee)
        try values.encodeIfPresent(geoRestriction, forKey: .geoRestriction)
        try values.encodeIfPresent(seasonalFee, forKey: .seasonalFee)
        try values.encodeIfPresent(expiresAt, forKey: .expiresAt)
        try values.encodeIfPresent(externalFees, forKey: .externalFees)
        try values.encodeIfPresent(startsAt, forKey: .startsAt)
    }

}
