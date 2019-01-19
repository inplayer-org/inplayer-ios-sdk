import Foundation

public struct INPAccessControlTypeModel : Codable {

    let auth : Bool?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case auth = "auth"
        case name = "name"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        auth = try values.decodeIfPresent(Bool.self, forKey: .auth)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
