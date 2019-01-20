import Foundation

/// Item metahash model
public struct INPItemMetahashModel : Codable {

    public let clientApp : String?
    public let paywallCoverPhoto : String?
    public let previewDescription : String?
    public let previewTitle : String?
    public let previewButtonLabel: String?

    enum CodingKeys: String, CodingKey {
        case clientApp = "client_app"
        case paywallCoverPhoto = "paywall_cover_photo"
        case previewDescription = "preview_description"
        case previewTitle = "preview_title"
        case previewButtonLabel = "preview_button_label"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        clientApp = try values.decodeIfPresent(String.self, forKey: .clientApp)
        paywallCoverPhoto = try values.decodeIfPresent(String.self, forKey: .paywallCoverPhoto)
        previewDescription = try values.decodeIfPresent(String.self, forKey: .previewDescription)
        previewTitle = try values.decodeIfPresent(String.self, forKey: .previewTitle)
        previewButtonLabel = try values.decodeIfPresent(String.self, forKey: .previewButtonLabel)
    }

}
