import Alamofire

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
        baseURLString = NetworkConstants.BaseUrls.Notification.debug
        let handler = INPAuthHandler(baseURLString: baseURLString)
        session = INPSession(adapter: handler, retrier: handler)
    }
}

