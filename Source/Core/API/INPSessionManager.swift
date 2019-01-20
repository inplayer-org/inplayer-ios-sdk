import Alamofire

/**
 Class used to provide user ability to inject his own implementation of Session.
 */
public final class INPSessionAPIManager {

    /// Singleton object.
    public static let `default` = INPSessionAPIManager()

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
        baseURLString = InPlayer.Configuration.getBaseUrlString()
        let handler = INPAuthHandler(baseURLString: baseURLString)
        session = INPSession(adapter: handler, retrier: handler)
    }
}

/**
 Subclass of Alamofire Session object.
 */
public class INPSession: Session {

    /// Bool check if there is logged in account.
    var isAuthorized: Bool {
        return InPlayer.Account.isAuthenticated()
    }
}
