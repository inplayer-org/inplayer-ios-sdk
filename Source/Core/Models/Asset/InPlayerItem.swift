import Foundation

/// Item model
public struct InPlayerItem : Codable {
    
/**Custom content type enum with associated values
 ```
     case html(content: String)
     case accedo(asset: AccedoAsset)
     case brightcove(asset: BrightcoveAsset)
     case cloudfront(asset: CloudfrontAsset)
     case daCast(asset: DaCastAsset)
     case jwPlayer(asset: JwPlayerAsset)
     case laola(asset: LaolaAsset)
     case kaltura(asset: KalturaAsset)
     case livestream(asset: LivestreamAsset)
     case mediaspace(content: String)
     case panopto(content: String)
     case piksel(content: String)
     case qbrick(asset: QbrickAsset)
     case sportOne(asset: SportOneAsset)
     case sportRadar(asset: SportRadarAsset)
     case streamAMG(asset: StreamAMGAsset)
     case witsia(asset: WitsiaAsset)
     case wowza(asset: WowzaAsset)
     case unknown
 */
    public enum ContentType {
        case html(content: String)
        case accedo(asset: AccedoAsset)
        case brightcove(asset: BrightcoveAsset)
        case cloudfront(asset: CloudfrontAsset)
        case daCast(asset: DaCastAsset)
        case jwPlayer(asset: JwPlayerAsset)
        case laola(asset: LaolaAsset)
        case kaltura(asset: KalturaAsset)
        case livestream(asset: LivestreamAsset)
        case mediaspace(content: String)
        case panopto(content: String)
        case piksel(content: String)
        case qbrick(asset: QbrickAsset)
        case sportOne(asset: SportOneAsset)
        case sportRadar(asset: SportRadarAsset)
        case streamAMG(asset: StreamAMGAsset)
        case witsia(asset: WitsiaAsset)
        case wowza(asset: WowzaAsset)
        case unknown
    }
    
    /// Item's ID
    public let id : Int?

    /// Merchant's ID
    public let merchantId : Int?

    /// Merchant's UUID
    public let merchantUuid : String?

    /// Shows whether the asset is active and can be monetized
    public let isActive : Bool?
    
    public let active : Bool?

    /// The asset’s title
    public let title : String?

    /// Access control type object
    public let accessControlType : InPlayerAccessControlType?

    /// Item type object
    public let itemType : InPlayerItemType?

    /// Age Restriction object
    public let ageRestriction: InPlayerAgeRestriction?
    
    /// Object containing additional information about the item
    public let metadata : [InPlayerItemMetadata]?
    
    public let metahash : [String: String]?
    
    /// The date the asset was created on, measured in seconds since 1 January 1970 (UTC)
    public let createdAt : Double?
    
    /// The date when the asset was last updated, measured in seconds since 1 January 1970 (UTC)
    public let updatedAt : Double?

    /// The asset’s content which can be a json object, a string, an html or an xml document
    public let content: String?
    
    /// Template id for asset
    public let templateId: Int?

    enum CodingKeys: String, CodingKey {
        case accessControlType = "access_control_type"
        case createdAt = "created_at"
        case id = "id"
        case isActive = "is_active"
        case active = "active"
        case itemType = "item_type"
        case merchantId = "merchant_id"
        case merchantUuid = "merchant_uuid"
        case metadata = "metadata"
        case metahash = "metahash"
        case title = "title"
        case updatedAt = "updated_at"
        case content = "content"
        case templateId = "template_id"
        case ageRestriction = "age_restriction"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessControlType = try values.decodeIfPresent(InPlayerAccessControlType.self, forKey: .accessControlType)
        createdAt = try values.decodeIfPresent(Double.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        itemType = try values.decodeIfPresent(InPlayerItemType.self, forKey: .itemType)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        merchantUuid = try values.decodeIfPresent(String.self, forKey: .merchantUuid)
        metadata = try values.decodeIfPresent([InPlayerItemMetadata].self, forKey: .metadata)
        metahash = try values.decodeIfPresent([String: String].self, forKey: .metahash)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        updatedAt = try values.decodeIfPresent(Double.self, forKey: .updatedAt)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        templateId = try values.decodeIfPresent(Int.self, forKey: .templateId)
        ageRestriction = try values.decodeIfPresent(InPlayerAgeRestriction.self, forKey: .ageRestriction)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(id, forKey: .id)
        try values.encodeIfPresent(merchantId, forKey: .merchantId)
        try values.encodeIfPresent(merchantUuid, forKey: .merchantUuid)
        try values.encodeIfPresent(accessControlType, forKey: .accessControlType)
        try values.encodeIfPresent(createdAt, forKey: .createdAt)
        try values.encodeIfPresent(isActive, forKey: .isActive)
        try values.encodeIfPresent(itemType, forKey: .itemType)
        try values.encodeIfPresent(metadata, forKey: .metadata)
        try values.encodeIfPresent(metahash, forKey: .metahash)
        try values.encodeIfPresent(title, forKey: .title)
        try values.encodeIfPresent(updatedAt, forKey: .updatedAt)
        try values.encodeIfPresent(content, forKey: .content)
        try values.encodeIfPresent(templateId, forKey: .templateId)
        try values.encodeIfPresent(ageRestriction, forKey: .ageRestriction)
        try values.encodeIfPresent(active, forKey: .active)
    }
    
    /// Method that return parsed content as enum with associated values
    public func parseContent() -> ContentType {
        do {
            guard let type = itemType?.name,
                let content = content
            else { return .unknown}
            
            switch type {
            case "html_asset":
                return .html(content: content)
            case "accedo_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: AccedoAsset = try AccedoAsset.from(data: data)
                return .accedo(asset: asset)
            case "brigthcove_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: BrightcoveAsset = try BrightcoveAsset.from(data: data)
                return .brightcove(asset: asset)
            case "cloudfront_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: CloudfrontAsset = try CloudfrontAsset.from(data: data)
                return .cloudfront(asset: asset)
            case "dacast_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: DaCastAsset = try DaCastAsset.from(data: data)
                return .daCast(asset: asset)
            case "jw_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: JwPlayerAsset = try JwPlayerAsset.from(data: data)
                return .jwPlayer(asset: asset)
            case "laola_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: LaolaAsset = try LaolaAsset.from(data: data)
                return .laola(asset: asset)
            case "kaltura_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: KalturaAsset = try KalturaAsset.from(data: data)
                return .kaltura(asset: asset)
            case "livestream_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: LivestreamAsset = try LivestreamAsset.from(data: data)
                return .livestream(asset: asset)
            case "kaltura_mediaspace_asset":
                return .mediaspace(content: content)
            case "panopto_asset":
                return .panopto(content: content)
            case "piksel_asset":
                return .piksel(content: content)
            case "qbrick_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: QbrickAsset = try QbrickAsset.from(data: data)
                return .qbrick(asset: asset)
            case "sport1_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: SportOneAsset = try SportOneAsset.from(data: data)
                return .sportOne(asset: asset)
            case "sportradar_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: SportRadarAsset = try SportRadarAsset.from(data: data)
                return .sportRadar(asset: asset)
            case "streamamg_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: StreamAMGAsset = try StreamAMGAsset.from(data: data)
                return .streamAMG(asset: asset)
            case "wistia_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: WitsiaAsset = try WitsiaAsset.from(data: data)
                return .witsia(asset: asset)
            case "wowza_asset":
                guard let data = try content.toJsonData() else { return .unknown }
                let asset: WowzaAsset = try WowzaAsset.from(data: data)
                return .wowza(asset: asset)
            default:
                return .unknown
            }
        }
        catch {
            return .unknown
        }
    }
}
