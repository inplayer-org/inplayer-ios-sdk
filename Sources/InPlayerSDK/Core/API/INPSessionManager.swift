import Alamofire

/**
 Class used to provide user ability to inject his own implementation of Session.
 */
public final class INPSessionManager {

    /// Singleton object.
    public static let `default` = INPSessionManager()

    /// The session.
    public var session: Session

    /// Session base url string.
    public var baseURLString: String

    private init() {
        baseURLString = InPlayer.Configuration.getBaseUrlString()
        let handler = INPAuthHandler(baseURLString: baseURLString)
        session = Session(adapter: handler, retrier: handler)
    }
}

extension Session {
    var isAuthorized: Bool {
        return InPlayer.Account.isAuthenticated()
    }
}
