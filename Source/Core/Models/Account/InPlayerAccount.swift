import Foundation

/**
 Account types
 */
public enum AccountType: String, Codable {
    case consumer = "consumer"
    case merchant = "merchant"
}

/// Account Model
public struct InPlayerAccount : Codable {

    /// Refers to whether the customer account registration has been completed
    public let completed : Bool?

    /// Account’s email address
    public let email : String?

    /// Account’s first and last name
    public let fullName : String?

    /// Account's username
    public let username: String?

    /// Unique account ID
    public let id : Int?

    /// The request’s source URL
    public let referrer : String?

    /// Account’s roles
    public let roles : [AccountType]?

    /// Time at which the account was created, measured in seconds since 1 January 1970 (UTC)
    public let createdAt : Double?

    /// Time at which the account was updated, measured in seconds since 1 January 1970 (UTC)
    public let updatedAt : Double?

    public let uuid: String?
    public let merchantId: Int?
    public let merchantUUID: String?

    /// Additional information about the account that can be attached to the account object
    public let metadata : [String: String]?

    enum CodingKeys: String, CodingKey {
        case completed = "completed"
        case createdAt = "created_at"
        case email = "email"
        case fullName = "full_name"
        case username = "username"
        case id = "id"
        case referrer = "referrer"
        case roles = "roles"
        case updatedAt = "updated_at"
        case uuid = "uuid"
        case merchantId = "merchant_id"
        case merchantUUID = "merchant_uuid"
        case metadata = "metadata"
    }

    /**
     Decoder method
     */
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        completed = try values.decodeIfPresent(Bool.self, forKey: .completed)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        username = try values.decodeIfPresent(String.self, forKey: .username)
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
    }
}

