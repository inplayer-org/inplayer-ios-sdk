import Foundation
import Alamofire

class INPNotificationService {
    private init() {}

    static func takeAwsCredentials(completion: @escaping RequestCompletion<InPlayerAwsKey>) {
        NetworkDataSource.performRequest(session: InPlayerNotificationAPIManager.default.session,
                                         route: NotificationAPIRouter.takeAwsCredentials,
                                         completion: completion)
    }
}

private enum NotificationAPIRouter: INPAPIConfiguration {

    case takeAwsCredentials

    var baseURL: String {
        switch self {
        case .takeAwsCredentials:
            return InPlayerNotificationAPIManager.getBaseUrlString
        }
    }

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        default:
            return ""
        }
    }

    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }

    var requiresAuthorization: Bool {
        switch self {
        case .takeAwsCredentials:
            return true
        }
    }

    var urlEncoding: Bool {
        switch self {
        default:
            return true
        }
    }
}
