import Foundation

/// Access control type model
public struct InPlayerAccessControlType : Codable {

    /// Access control type ID
    public let id: Int?

    /// Shows whether the access is acquired by authentication
    public let auth : Bool?

    /// Denotes one of the control types (free, paid or code) that enable the customer to access the asset.
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
