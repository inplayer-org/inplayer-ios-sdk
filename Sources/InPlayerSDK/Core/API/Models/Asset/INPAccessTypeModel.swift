import Foundation

public struct INPAccessTypeModel : Codable {

    let id : Int?
    let name : String?
    let period : String?
    let quantity : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case period = "period"
        case quantity = "quantity"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        period = try values.decodeIfPresent(String.self, forKey: .period)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
    }

}
