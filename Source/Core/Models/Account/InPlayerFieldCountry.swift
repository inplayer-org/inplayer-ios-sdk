import Foundation

public struct InPlayerFieldCountry: Codable {
    public let name: String?
    public let code: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case code = "code"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }
}
