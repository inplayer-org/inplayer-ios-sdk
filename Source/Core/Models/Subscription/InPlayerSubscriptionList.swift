import Foundation

public struct InPlayerSubscriptionList: Codable {
    let collection : [InPlayerSubscription]
    let limit : Int?
    let offset : Int?
    let page : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {
        case collection = "collection"
        case limit = "limit"
        case offset = "offset"
        case page = "page"
        case total = "total"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collection = try values.decodeIfPresent([InPlayerSubscription].self, forKey: .collection) ?? []
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}
