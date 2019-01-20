import Foundation
import Alamofire

class INPNotificationService {
    private init() {}

    static func takeAwsCredentials(completion: @escaping RequestCompletion<INPAwsKeyModel>) {
        NetworkDataSource.performRequest(session: INPNotificationAPIManager.default.session,
                                         route: NotificationAPIRouter.takeAwsCredentials(),
                                         completion: completion)
    }
}

private enum NotificationAPIRouter: INPAPIConfiguration {

    case takeAwsCredentials()

    var baseURL: String {
        switch self {
        case .takeAwsCredentials:
            switch InPlayer.Configuration.getEnvironment() {
            case .debug:
                return NetworkConstants.BaseUrls.Notification.debug
            case .staging:
                return NetworkConstants.BaseUrls.Notification.staging
            case .production:
                return NetworkConstants.BaseUrls.Notification.production
            }
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
