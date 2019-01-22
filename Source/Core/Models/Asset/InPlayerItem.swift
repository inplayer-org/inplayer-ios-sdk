import Foundation

/// Item model
public struct InPlayerItem : Codable {

    public let accessControlType : InPlayerAccessControlType?
    public let accessFees : [InPlayerAccessFee]?
    public let createdAt : Double?
    public let id : Int?
    public let isActive : Bool?
    public let itemType : InPlayerItemType?
    public let merchantId : Int?
    public let merchantUuid : String?
    public let metadata : [InPlayerItemMetadata]?
    public let metahash : [String: String]?
    public let title : String?
    public let updatedAt : Double?
    public let content: String?

    enum CodingKeys: String, CodingKey {
        case accessControlType = "access_control_type"
        case accessFees = "access_fees"
        case createdAt = "created_at"
        case id = "id"
        case isActive = "is_active"
        case itemType = "item_type"
        case merchantId = "merchant_id"
        case merchantUuid = "merchant_uuid"
        case metadata = "metadata"
        case metahash = "metahash"
        case title = "title"
        case updatedAt = "updated_at"
        case content = "content"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessControlType = try values.decodeIfPresent(InPlayerAccessControlType.self, forKey: .accessControlType)
        accessFees = try values.decodeIfPresent([InPlayerAccessFee].self, forKey: .accessFees)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        itemType = try values.decodeIfPresent(InPlayerItemType.self, forKey: .itemType)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        merchantUuid = try values.decodeIfPresent(String.self, forKey: .merchantUuid)
        metadata = try values.decodeIfPresent([InPlayerItemMetadata].self, forKey: .metadata)
        metahash = try values.decodeIfPresent([String: String].self, forKey: .metahash)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
        content = try values.decode(String.self, forKey: .content)
    }

}
