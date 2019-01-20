import Foundation

/**
 Account types
 */
public enum AccountType: String, Codable {
    case consumer = "consumer"
    case merchant = "merchant"
}

/// Account Model
public struct INPAccountModel : Codable {

    public let completed : Bool?
    public let email : String?
    public let fullName : String?
    public let id : Int?
    public let referrer : String?
    public let roles : [AccountType]?
    public let createdAt : Double?
    public let updatedAt : Double?
    public let uuid: String?
    public let merchantId: Int?
    public let merchantUUID: String?
    public let metadata : [String: String]?
//    let socialAppsMetadata : [AnyObject]?

    enum CodingKeys: String, CodingKey {
        case completed = "completed"
        case createdAt = "created_at"
        case email = "email"
        case fullName = "full_name"
        case id = "id"
        case referrer = "referrer"
        case roles = "roles"
        case updatedAt = "updated_at"
        case uuid = "uuid"
        case merchantId = "merchant_id"
        case merchantUUID = "merchant_uuid"
        case metadata = "metadata"
//        case socialAppsMetadata = "social_apps_metadata"
    }

    /**
     Decoder method
     */
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        completed = try values.decodeIfPresent(Bool.self, forKey: .completed)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        referrer = try values.decodeIfPresent(String.self, forKey: .referrer)
        if let accountTypes = try values.decodeIfPresent([String].self, forKey: .roles) {
            roles = accountTypes.map( { (type: String) -> AccountType in
                return AccountType(rawValue: type) ?? .consumer
            })
        } else {
            roles = nil
        }
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        merchantUUID = try values.decodeIfPresent(String.self, forKey: .merchantUUID)
        metadata = try values.decodeIfPresent([String: String].self, forKey: .metadata)
//        socialAppsMetadata = try values.decodeIfPresent([AnyObject].self, forKey: .socialAppsMetadata)
    }

}

