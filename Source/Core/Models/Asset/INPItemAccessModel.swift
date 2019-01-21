import Foundation

/// Item access model
public struct INPItemAccessModel : Codable {

    public let accountId : Int?
    public let countryCode : String?
    public let createdAt : Double?
    public let customerId : Int?
    public let customerUuid : String?
    public let expiresAt : Double?
    public let id : Int?
    public let ipAddress : String?
    public let item : INPItemModel?
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
        item = try values.decodeIfPresent(INPItemModel.self, forKey: .item)
        startsAt = try values.decode(Double.self, forKey: .startsAt)
    }

}
