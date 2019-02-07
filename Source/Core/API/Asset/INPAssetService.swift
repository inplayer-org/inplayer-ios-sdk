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
                                    completion: @escaping RequestCompletion<InPlayerItemAccess>) {
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AssetAPIRouter.getItemAccess(id: id),
                                         completion: completion)
    }
}


/// Enum of available asset api routes
private enum AssetAPIRouter: INPAPIConfiguration {
    case getItemDetails(id: Int, merchantUUID: String)
    case getItemAccessFees(id: Int)
    case getItemAccess(id: Int)

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
        case .getItemAccess(let id):
            return String(format: NetworkConstants.Endpoints.Asset.itemAccess, "\(id)")
        }
    }

    var parameters: Parameters? {
        switch self {
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
             .getItemDetails:
            return false
        default:
            return true
        }
    }
}
