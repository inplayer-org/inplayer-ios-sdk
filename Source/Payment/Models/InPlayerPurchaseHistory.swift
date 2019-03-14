import Foundation

public enum PurchaseHistory: String {
    case all
    case active
    case inactive
}

public struct InPlayerCustomerPurchaseHistory : Codable {

    public let accessItems : [InPlayerCustomerAccessItem]
    public let total : Int

    enum CodingKeys: String, CodingKey {
        case accessItems = "collection"
        case total = "total"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessItems = try values.decodeIfPresent([InPlayerCustomerAccessItem].self, forKey: .accessItems) ?? []
        total = try values.decodeIfPresent(Int.self, forKey: .total) ?? 0
    }
}
