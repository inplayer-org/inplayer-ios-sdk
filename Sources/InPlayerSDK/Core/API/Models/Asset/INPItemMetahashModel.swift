import Foundation

public struct INPItemMetahashModel : Codable {

    let clientApp : String?
    let paywallCoverPhoto : String?
    let previewDescription : String?
    let previewTitle : String?

    enum CodingKeys: String, CodingKey {
        case clientApp = "client_app"
        case paywallCoverPhoto = "paywall_cover_photo"
        case previewDescription = "preview_description"
        case previewTitle = "preview_title"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        clientApp = try values.decodeIfPresent(String.self, forKey: .clientApp)
        paywallCoverPhoto = try values.decodeIfPresent(String.self, forKey: .paywallCoverPhoto)
        previewDescription = try values.decodeIfPresent(String.self, forKey: .previewDescription)
        previewTitle = try values.decodeIfPresent(String.self, forKey: .previewTitle)
    }

}
