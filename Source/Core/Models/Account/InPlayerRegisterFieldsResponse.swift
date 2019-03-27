import Foundation

/// Register Fields Server response model
struct InPlayerRegisterFieldsResponse : Codable {

    let collection: [InPlayerRegisterField]

    enum CodingKeys: String, CodingKey {
        case collection = "collection"
    }

    /// Decoder method
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        collection = try values.decodeIfPresent([InPlayerRegisterField].self, forKey: .collection) ?? []
    }
}

