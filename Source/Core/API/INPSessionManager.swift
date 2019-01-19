import Alamofire

/**
 Class used to provide user ability to inject his own implementation of Session.
 */
public final class INPSessionManager {

    /// Singleton object.
    public static let `default` = INPSessionManager()

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

public class INPSession: Session {
    var isAuthorized: Bool {
        return InPlayer.Account.isAuthenticated()
    }
}
