import Foundation

public struct INPItemRevokedModel: Codable {
    public var itemId: Int?

    private enum CodingKeys: String, CodingKey {
        case itemId = "item_id"
    }
}
