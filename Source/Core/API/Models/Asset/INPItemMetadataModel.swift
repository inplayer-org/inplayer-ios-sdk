import Foundation

public struct INPItemMetadataModel : Codable {

    let id : Int?
    let name : String?
    let value : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case value = "value"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}
