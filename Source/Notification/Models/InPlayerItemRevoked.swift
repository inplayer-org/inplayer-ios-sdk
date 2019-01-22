import Foundation

/// Item Revoked model
public struct InPlayerItemRevoked: Codable {
    public var itemId: Int?

    private enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try values.decodeIfPresent(Int.self, forKey: .itemId)
    }
}
