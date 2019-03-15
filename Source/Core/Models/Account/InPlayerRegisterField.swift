import Foundation

struct InPlayerRegisterField : Codable {

    let defaultValue : String?
    let id : Int?
    let label : String?
    let name : String?
//    let options : [AnyObject]?
    let placeholder : String?
    let required : Bool?
    let type : String?

    enum CodingKeys: String, CodingKey {
        case defaultValue = "default_value"
        case id = "id"
        case label = "label"
        case name = "name"
//        case options = "options"
        case placeholder = "placeholder"
        case required = "required"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        defaultValue = try values.decodeIfPresent(String.self, forKey: .defaultValue)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        name = try values.decodeIfPresent(String.self, forKey: .name)
//        options = try values.decodeIfPresent([AnyObject].self, forKey: .options)
        placeholder = try values.decodeIfPresent(String.self, forKey: .placeholder)
        required = try values.decodeIfPresent(Bool.self, forKey: .required)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}

