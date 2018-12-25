import Alamofire

/// Enum of available account api routes
enum AccountAPIRouter: INPAPIConfiguration {
    //    static func authenticateUser()
    //    static func logout()
    //    static func getUser()
    //    static func updateUser()
    //    static func eraseUser()
    //    static func changePassword()
    //    static func requestForgotPasswordToken()
    //    static func setNewPassword()

    case createAccount(parameters: [String: Any])

    var method: HTTPMethod {
        switch self {
        case .createAccount:
            return .post
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .createAccount:
            return NetworkConstants.Endpoints.Account.createAccount
        }
    }

    var parameters: Parameters? {
        switch self {
        case .createAccount(let parameters):
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
}

/// Service through which api calls are made
public class INPAccountService {
    @discardableResult
    public static func createAccount(fullName: String,
                                     email: String,
                                     password: String,
                                     passwordConfirmation: String,
                                     type: AccountType,
                                     merchantUUID: String,
                                     referrer: String? = nil,
                                     completion: @escaping (Result<INPAuthorizationModel>) -> Void) -> Request {
        var params: [String: Any] = [
            AccountParameters.fullName: fullName,
            AccountParameters.email: email,
            AccountParameters.password: password,
            AccountParameters.passwordConfirmation: passwordConfirmation,
            AccountParameters.type: type.rawValue,
            AccountParameters.merchantUUID: merchantUUID,
        ]
        if let referrer = referrer {
            params[AccountParameters.referrer] = referrer
        }
        return NetworkDataSource.performRequest(route: AccountAPIRouter.createAccount(parameters: params),
                                                completion: completion)
    }
}
