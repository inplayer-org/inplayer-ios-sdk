import Alamofire

/// Enum of available asset api routes
enum AssetAPIRouter: INPAPIConfiguration {
    case getItem(id: Int, merchantUUID: String)
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
        case .getItem(let id, let merchantUUID):
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
}

public class INPAssetService {

    @discardableResult
    public static func getItem(id: Int,
                               merchantUUID: String,
                               completion: @escaping RequestCompletion<INPItemModel>) -> Request {
        return NetworkDataSource.performRequest(route: AssetAPIRouter.getItem(id: id,
                                                                              merchantUUID: merchantUUID),
                                                completion: completion)
    }

    @discardableResult
    public static func getItemAccessFees(id: Int,
                                         completion: @escaping RequestCompletion<[INPAccessFeeModel]>) -> Request {
        return NetworkDataSource.performRequest(route: AssetAPIRouter.getItemAccessFees(id: id),
                                                completion: completion)
    }

    @discardableResult
    public static func getItemAccess(id: Int,
                                     completion: @escaping RequestCompletion<INPItemAccessModel>) -> Request {
        return NetworkDataSource.performRequest(route: AssetAPIRouter.getItemAccess(id: id),
                                                completion: completion)
    }
}
