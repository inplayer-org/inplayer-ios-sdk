import Alamofire

/**
 Class that provides subscription services which handles request creation and passes completion result
 */
class INPSubscriptionService {
    static func getSubscriptions(page: Int,
                                 limit: Int,
                                 completion: @escaping RequestCompletion<InPlayerSubscriptionList>) {
        let params = [SubscriptionParameters.page: page,
                      SubscriptionParameters.limit: limit]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: SubscriptionAPIRouter.getSubscriptions(parameters: params),
                                         completion: completion)
    }
}

private struct SubscriptionParameters {
    static let page = "page"
    static let limit = "limit"
}

/// Enum of available account api routes
private enum SubscriptionAPIRouter: INPAPIConfiguration {
    case getSubscriptions(parameters: [String: Any])

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getSubscriptions:
            return NetworkConstants.Endpoints.Subscription.subscriptionList
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getSubscriptions(let parameters):
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
        default:
            return true
        }
    }
}
