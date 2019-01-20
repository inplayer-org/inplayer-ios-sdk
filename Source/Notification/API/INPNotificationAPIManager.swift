import Alamofire

/**
 Class used to provide user ability to inject his own implementation of Session.
 */
public final class INPNotificationAPIManager {

    /// Singleton object.
    public static let `default` = INPNotificationAPIManager()

    /// The session.
    public var session: INPSession

    /// Session base url string.
    public var baseURLString: String {
        didSet {
            let handler = INPAuthHandler(baseURLString: baseURLString)
            session = INPSession(adapter: handler, retrier: handler)
        }
    }

    private init() {
        baseURLString = INPNotificationAPIManager.getBaseUrlString
        let handler = INPAuthHandler(baseURLString: baseURLString)
        session = INPSession(adapter: handler, retrier: handler)
    }

    private static var getBaseUrlString: String {
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

