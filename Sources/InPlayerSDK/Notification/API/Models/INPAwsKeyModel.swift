import Foundation

public struct INPAwsKeyModel : Codable {

    let accessKey : String?
    let iotEndpoint : String?
    let region : String?
    let secretKey : String?
    let sessionToken : String?

    enum CodingKeys: String, CodingKey {
        case accessKey = "accessKey"
        case iotEndpoint = "iotEndpoint"
        case region = "region"
        case secretKey = "secretKey"
        case sessionToken = "sessionToken"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessKey = try values.decodeIfPresent(String.self, forKey: .accessKey)
        iotEndpoint = try values.decodeIfPresent(String.self, forKey: .iotEndpoint)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        secretKey = try values.decodeIfPresent(String.self, forKey: .secretKey)
        sessionToken = try values.decodeIfPresent(String.self, forKey: .sessionToken)
    }
}
