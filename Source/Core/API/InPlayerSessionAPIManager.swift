import Alamofire

/**
 Class used to provide user ability to inject his own implementation of Session.
 */
public final class InPlayerSessionAPIManager {

    /// Singleton object.
    public static let `default` = InPlayerSessionAPIManager()

    /// The session.
    public var session: InPlayerSession

    /// Session base url string.
    public var baseURLString: String {
        didSet {
            let handler = INPAuthHandler(baseURLString: baseURLString)
            session = InPlayerSession();
            session.adapter = handler;
            session.retrier = handler;
        }
    }

    private init() {
        baseURLString = InPlayer.getBaseUrlString()
        let handler = INPAuthHandler(baseURLString: baseURLString)
        session = InPlayerSession();
        session.adapter = handler;
        session.retrier = handler;
    }
}

/**
 Subclass of Alamofire Session object.
 */
public class InPlayerSession: SessionManager {

    /// Bool check if there is logged in account.
    var isAuthorized: Bool {
        return InPlayer.Account.isAuthenticated()
    }
}
