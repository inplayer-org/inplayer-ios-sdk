import Foundation

/// Access control type model
public struct InPlayerAccessControlType : Codable {

    public let id: Int?
    public let auth : Bool?
    public let name : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case auth = "auth"
        case name = "name"
    }

    /**
     Decoder method
     */
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        auth = try values.decodeIfPresent(Bool.self, forKey: .auth)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
