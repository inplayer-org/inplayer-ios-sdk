import Foundation

/// Subscription List Server Response Model
public struct InPlayerSubscriptionList: Codable {
    public let collection : [InPlayerSubscription]
    public let limit : Int?
    public let offset : Int?
    public let page : Int?
    public let total : Int?

    enum CodingKeys: String, CodingKey {
        case collection = "collection"
        case limit = "limit"
        case offset = "offset"
        case page = "page"
        case total = "total"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collection = try values.decodeIfPresent([InPlayerSubscription].self, forKey: .collection) ?? []
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}
