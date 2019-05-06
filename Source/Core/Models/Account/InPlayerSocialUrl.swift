import Foundation

public struct InPlayerSocialUrl {

    public let name: String?
    public let url: URL?

    public enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }

    public init(name: String?, url: URL?) {
        self.name = name
        self.url = url
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(URL.self, forKey: .url)
    }

    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(name, forKey: .name)
        try values.encodeIfPresent(url, forKey: .url)
    }

    public static func initFromDictionary(dictionary: [String: String]) -> InPlayerSocialUrl {
        let key = dictionary.keys.first
        let value = URL(string: dictionary.values.first ?? "")
        return InPlayerSocialUrl(name: key, url: value)
    }
}
