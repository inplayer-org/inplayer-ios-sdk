import Alamofire

/**
 Class that provides asset services which handles request creation and passes completion result
 */
class INPAssetService {
    static func getAsset(id: Int,
                         merchantUUID: String,
                         completion: @escaping RequestCompletion<InPlayerItem>) {
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AssetAPIRouter.getItemDetails(id: id,
                                                                              merchantUUID: merchantUUID),
                                         completion: completion)
    }

    static func getAssetAccessFees(id: Int,
                                   completion: @escaping RequestCompletion<[InPlayerAccessFee]>) {
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AssetAPIRouter.getItemAccessFees(id: id),
                                         completion: completion)
    }

    static func checkAccessForAsset(id: Int,
                                    entryId: String?,
                                    completion: @escaping RequestCompletion<InPlayerItemAccess>) {
        var parameters: [String: Any] = [:]
        if let entryId = entryId {
            parameters[AssetParameters.entryId] = entryId
        }
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AssetAPIRouter.getItemAccess(id: id, parameters: parameters),
                                         completion: completion)
    }

    static func getExternalAsset(assetType: String,
                                 externalId: String,
                                 merchantUUID: String?,
                                 completion: @escaping RequestCompletion<InPlayerItem>) {
        var parameters: [String: Any] = [:]
        if let merchantUUID = merchantUUID {
            parameters[AssetParameters.merchantUUID] = merchantUUID
        }
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AssetAPIRouter.getExternalAsset(assetType: assetType,
                                                                                externalID: externalId,
                                                                                parameters: parameters),
                                         completion: completion)
    }
}

private struct AssetParameters {
    static let merchantUUID = "merchant_uuid"
    static let entryId = "entry_id"
}


/// Enum of available asset api routes
private enum AssetAPIRouter: INPAPIConfiguration {
    case getItemDetails(id: Int, merchantUUID: String)
    case getItemAccessFees(id: Int)
    case getItemAccess(id: Int, parameters: [String: Any])
    case getExternalAsset(assetType: String, externalID: String, parameters: [String: Any])

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getItemDetails(let id, let merchantUUID):
            return String(format: NetworkConstants.Endpoints.Asset.itemDetails, merchantUUID, "\(id)")
        case .getItemAccessFees(let id):
            return String(format: NetworkConstants.Endpoints.Asset.itemAccessFees, "\(id)")
        case .getItemAccess(let id, _):
            return String(format: NetworkConstants.Endpoints.Asset.itemAccess, "\(id)")
        case .getExternalAsset(let assetType, let externalID, _):
            return String(format: NetworkConstants.Endpoints.Asset.externalItemDetails, assetType, externalID)
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getItemAccess(_, let parameters):
            return parameters
        case .getExternalAsset(_,_, let parameters):
            return parameters
        default:
            return nil
        }
    }

    var urlEncoding: Bool {
        switch self {
        default:
            return true
        }
    }

    var requiresAuthorization: Bool {
        switch self {
        case .getItemAccessFees,
             .getItemDetails,
             .getExternalAsset:
            return false
        default:
            return true
        }
    }
}
