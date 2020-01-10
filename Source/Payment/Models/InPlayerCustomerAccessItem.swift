import Foundation

/// Customer Access Item Model
public struct InPlayerCustomerAccessItem: Codable {
    public let consumerEmail : String?
    public let createdAt : Double?
    public let customerId : Int?
    public let expiresAt : Int?
    public let isTrial : Bool?
    public let itemAccessId : Int?
    public let itemId : Int?
    public let itemTitle : String?
    public let merchantId : Int?
    public let parentResourceId : String?
    public let paymentMethod : String?
    public let paymentTool : String?
    public let purchasedAccessFeeDescription : String?
    public let purchasedAccessFeeId : Int?
    public let purchasedAccessFeeType : String?
    public let purchasedAmount : Double?
    public let purchasedCurrency : String?
    public let revoked : Int?
    public let startsAt : Double?
    public let type : String?

    enum CodingKeys: String, CodingKey {
        case consumerEmail = "consumer_email"
        case createdAt = "created_at"
        case customerId = "customer_id"
        case expiresAt = "expires_at"
        case isTrial = "is_trial"
        case itemAccessId = "item_access_id"
        case itemId = "item_id"
        case itemTitle = "item_title"
        case merchantId = "merchant_id"
        case parentResourceId = "parent_resource_id"
        case paymentMethod = "payment_method"
        case paymentTool = "payment_tool"
        case purchasedAccessFeeDescription = "purchased_access_fee_description"
        case purchasedAccessFeeId = "purchased_access_fee_id"
        case purchasedAccessFeeType = "purchased_access_fee_type"
        case purchasedAmount = "purchased_amount"
        case purchasedCurrency = "purchased_currency"
        case revoked = "revoked"
        case startsAt = "starts_at"
        case type = "type"
    }

    /// Decoder Method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        consumerEmail = try values.decodeIfPresent(String.self, forKey: .consumerEmail)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        expiresAt = try values.decodeIfPresent(Int.self, forKey: .expiresAt)
        isTrial = try values.decodeIfPresent(Bool.self, forKey: .isTrial)
        itemAccessId = try values.decodeIfPresent(Int.self, forKey: .itemAccessId)
        itemId = try values.decodeIfPresent(Int.self, forKey: .itemId)
        itemTitle = try values.decodeIfPresent(String.self, forKey: .itemTitle)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        parentResourceId = try values.decodeIfPresent(String.self, forKey: .parentResourceId)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        paymentTool = try values.decodeIfPresent(String.self, forKey: .paymentTool)
        purchasedAccessFeeDescription = try values.decodeIfPresent(String.self, forKey: .purchasedAccessFeeDescription)
        purchasedAccessFeeId = try values.decodeIfPresent(Int.self, forKey: .purchasedAccessFeeId)
        purchasedAccessFeeType = try values.decodeIfPresent(String.self, forKey: .purchasedAccessFeeType)
        purchasedAmount = try values.decodeIfPresent(Double.self, forKey: .purchasedAmount)
        purchasedCurrency = try values.decodeIfPresent(String.self, forKey: .purchasedCurrency)
        revoked = try values.decodeIfPresent(Int.self, forKey: .revoked)
        startsAt = try values.decodeIfPresent(Double.self, forKey: .startsAt)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
