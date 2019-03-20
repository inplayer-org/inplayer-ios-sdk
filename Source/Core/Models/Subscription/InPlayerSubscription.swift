import Foundation

/// Subscription Model
public struct InPlayerSubscription: Codable {

    public let cancelToken: String?
    public let status: String?
    public let description: String?
    public let assetTitle: String?
    public let assetId: Int?
    public let formattedAmount: String?
    public let amount: Float?
    public let currency: String?
    public let merchantId: Int?
    public let createdAt: Double?
    public let updatedAt: Double?
    public let nextBillingDate: Double?
    public let unsubscribeUrl: String?

    enum CodingKeys: String, CodingKey {
        case cancelToken = "cancel_token"
        case status = "status"
        case description = "description"
        case assetTitle = "asset_title"
        case assetId = "asset_id"
        case formattedAmount = "formatted_amount"
        case amount = "amount"
        case currency = "currency"
        case merchantId = "merchant_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case nextBillingDate = "next_billing_date"
        case unsubscribeUrl = "unsubscribe_url"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cancelToken = try values.decodeIfPresent(String.self, forKey: .cancelToken)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        assetTitle = try values.decodeIfPresent(String.self, forKey: .assetTitle)
        assetId = try values.decodeIfPresent(Int.self, forKey: .assetId)
        formattedAmount = try values.decodeIfPresent(String.self, forKey: .formattedAmount)
        amount = try values.decodeIfPresent(Float.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
        nextBillingDate = try values.decodeIfPresent(Double.self, forKey: .nextBillingDate)
        unsubscribeUrl = try values.decodeIfPresent(String.self, forKey: .unsubscribeUrl)
    }
}
