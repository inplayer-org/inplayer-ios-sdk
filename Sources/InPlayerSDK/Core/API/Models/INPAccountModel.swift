import Foundation

public enum AccountType: String, Codable {
    case consumer = "consumer"
    case merchant = "merchant"
}

public struct INPAccount : Codable {

    let completed : Bool?
    let email : String?
    let fullName : String?
    let id : Int?
    let referrer : String?
    let roles : [AccountType]?
    let createdAt : Double?
    let updatedAt : Double?
    //    let socialAppsMetadata : [AnyObject]?
    //    let metadata : InPlayerMetadata?


    enum CodingKeys: String, CodingKey {
        case completed = "completed"
        case createdAt = "created_at"
        case email = "email"
        case fullName = "full_name"
        case id = "id"
        case referrer = "referrer"
        case roles = "roles"
        case updatedAt = "updated_at"
//        case metadata = "metadata"
//        case socialAppsMetadata = "social_apps_metadata"
    }

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
        //        metadata = try InPlayerMetadata(from: decoder)
        //        socialAppsMetadata = try values.decodeIfPresent([AnyObject].self, forKey: .socialAppsMetadata)
    }

}

