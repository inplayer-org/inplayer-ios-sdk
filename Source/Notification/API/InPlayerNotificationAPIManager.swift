import Alamofire

/**
 Class used to provide user ability to inject his own implementation of Session.
 */
public final class InPlayerNotificationAPIManager {

    /// Singleton object.
    public static let `default` = InPlayerNotificationAPIManager()

    /// The session.
    public var session: InPlayerSession

    /// Session base url string.
    public var baseURLString: String {
        didSet {
            let handler = INPAuthHandler(baseURLString: baseURLString)
            session = InPlayerSession(interceptor: handler)
        }
    }

    private init() {
        baseURLString = InPlayerNotificationAPIManager.getBaseUrlString
        let handler = INPAuthHandler(baseURLString: baseURLString)
        session = InPlayerSession(interceptor: handler)
    }

    static var getBaseUrlString: String {
        switch InPlayer.environment {
        case .debug:
            return NetworkConstants.BaseUrls.Notification.debug
        case .staging:
            return NetworkConstants.BaseUrls.Notification.staging
        case .production:
            return NetworkConstants.BaseUrls.Notification.production
        }
    }
}

