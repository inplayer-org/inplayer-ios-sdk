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
    case getAccountInfo()

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
        case .getAccountInfo:
            return NetworkConstants.Endpoints.Account.accountInfo
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
                                     referrer: String? = nil,
                                     completion: @escaping (Result<INPAuthorizationModel>) -> Void) -> Request {
        var params: [String: Any] = [
            AccountParameters.fullName: fullName,
            AccountParameters.email: email,
            AccountParameters.password: password,
            AccountParameters.passwordConfirmation: passwordConfirmation,
            AccountParameters.type: type.rawValue,
            AccountParameters.merchantUUID: InPlayer.Configuration.getClientId()
        ]
        if let referrer = referrer {
            params[AccountParameters.referrer] = referrer
        }
        return NetworkDataSource.performRequest(route: AccountAPIRouter.createAccount(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func getUserInfo(completion: @escaping (Result<INPAccount>) -> Void) -> Request {
        return NetworkDataSource.performRequest(route: AccountAPIRouter.getAccountInfo(), completion: completion)
    }
}




private struct AccountParameters {
    static let fullName = "full_name"
    static let email = "email"
    static let password = "password"
    static let passwordConfirmation = "password_confirmation"
    static let type = "type"
    static let merchantUUID = "merchant_uuid"
    static let referrer = "referrer"
    static let metadata = "metadata"
}
