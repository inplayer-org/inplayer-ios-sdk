import Foundation

public struct INPItemModel : Codable {

    let accessControlType : INPAccessControlTypeModel?
    let accessFees : [INPAccessFeeModel]?
    let createdAt : Double?
    let id : Int?
    let isActive : Bool?
    let itemType : INPItemTypeModel?
    let merchantId : Int?
    let merchantUuid : String?
    let metadata : [INPItemMetadataModel]?
    let metahash : INPItemMetahashModel?
    let title : String?
    let updatedAt : Double?

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
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessControlType = try values.decodeIfPresent(INPAccessControlTypeModel.self, forKey: .accessControlType)
        accessFees = try values.decodeIfPresent([INPAccessFeeModel].self, forKey: .accessFees)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        itemType = try values.decodeIfPresent(INPItemTypeModel.self, forKey: .itemType)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        merchantUuid = try values.decodeIfPresent(String.self, forKey: .merchantUuid)
        metadata = try values.decodeIfPresent([INPItemMetadataModel].self, forKey: .metadata)
        metahash = try values.decodeIfPresent(INPItemMetahashModel.self, forKey: .metahash)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
    }

}
