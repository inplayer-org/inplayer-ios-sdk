import Foundation

/// Purchase History enum
public enum PurchaseHistory: String {
    /// Show all purchased items.
    case all

    /// Show only active purchased items.
    case active

    /// Show only inactive purchased items.
    case inactive
}

/// Customer Purchase History Server Response Model
public struct InPlayerCustomerPurchaseHistory : Codable {

    public let collection : [InPlayerCustomerAccessItem]
    public let total : Int

    enum CodingKeys: String, CodingKey {
        case collection = "collection"
        case total = "total"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collection = try values.decodeIfPresent([InPlayerCustomerAccessItem].self, forKey: .collection) ?? []
        total = try values.decodeIfPresent(Int.self, forKey: .total) ?? 0
    }
}
