import Foundation

/// Access control type model
public struct INPAccessControlTypeModel : Codable {

    public let auth : Bool?
    public let name : String?

    enum CodingKeys: String, CodingKey {
        case auth = "auth"
        case name = "name"
    }

    /**
     Decoder method
     */
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        auth = try values.decodeIfPresent(Bool.self, forKey: .auth)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
