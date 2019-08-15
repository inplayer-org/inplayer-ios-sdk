import Foundation

/// Item access model
public struct InPlayerItemAccess : Codable {

    /// Merchant's Account ID
    public let accountId : Int?

    /// Customer's country
    public let countryCode : String?

    /// The date when access to the asset was created, measured in seconds since 1 January 1970 (UTC)
    public let createdAt : Double?

    /// Customer's Account ID
    public let customerId : Int?

    /// Customer's Account UUID
    public let customerUuid : String?

    /// The date when the access expires, measured in seconds since 1 January 1970 (UTC)
    public let expiresAt : Double?

    /// The access ID
    public let id : Int?

    /// Customer's IP Address
    public let ipAddress : String?

    /// Item model
    public let item : InPlayerItem?
    
    public let startsAt: Double?

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case countryCode = "country_code"
        case createdAt = "created_at"
        case customerId = "customer_id"
        case customerUuid = "customer_uuid"
        case expiresAt = "expires_at"
        case id = "id"
        case ipAddress = "ip_address"
        case item = "item"
        case startsAt = "starts_at"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accountId = try values.decodeIfPresent(Int.self, forKey: .accountId)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        customerUuid = try values.decodeIfPresent(String.self, forKey: .customerUuid)
        expiresAt = try values.decodeIfPresent(Double.self, forKey: .expiresAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        ipAddress = try values.decodeIfPresent(String.self, forKey: .ipAddress)
        item = try values.decodeIfPresent(InPlayerItem.self, forKey: .item)
        startsAt = try values.decodeIfPresent(Double.self, forKey: .startsAt)
    }

}
