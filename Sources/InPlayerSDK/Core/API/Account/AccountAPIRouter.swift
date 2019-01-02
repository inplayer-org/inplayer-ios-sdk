import Alamofire

/// Enum of available account api routes
enum AccountAPIRouter: INPAPIConfiguration {
    //    static func authenticateUser()
    //    static func requestForgotPasswordToken()
    //    static func setNewPassword()

    case createAccount(parameters: [String: Any])
    case getAccountInfo()
    case logout()
    case updateAccount(parameters: [String: Any])
    case changePassword(parameters: [String: Any])
    case eraseAccount(parameters: [String: Any])
    case setNewPassword(token: String, parameters: [String: Any])
    case forgotPassword(parameters: [String: Any])
    case authenticate(parameters: [String: Any])
    case refreshToken(parameters: [String: Any])
    case authenticateClientCredentials(parameters: [String: Any])

    var method: HTTPMethod {
        switch self {
        case .createAccount, .changePassword, .forgotPassword, .authenticate, .refreshToken, .authenticateClientCredentials:
            return .post
        case .updateAccount, .setNewPassword:
            return .put
        case .eraseAccount:
            return .delete
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
        case .logout:
            return NetworkConstants.Endpoints.Account.logout
        case .updateAccount:
            return NetworkConstants.Endpoints.Account.updateAccount
        case .changePassword:
            return NetworkConstants.Endpoints.Account.changePassword
        case .eraseAccount:
            return NetworkConstants.Endpoints.Account.eraseAccount
        case .setNewPassword(let token, _):
            return String(format: NetworkConstants.Endpoints.Account.setNewPassword, token)
        case .forgotPassword:
            return NetworkConstants.Endpoints.Account.forgotPassword
        case .authenticate, .refreshToken, .authenticateClientCredentials:
            return NetworkConstants.Endpoints.Account.authenticate
        }
    }

    var parameters: Parameters? {
        switch self {
        case .createAccount(let parameters):
            return parameters
        case .updateAccount(let parameters):
            return parameters
        case .changePassword(let parameters):
            return parameters
        case .eraseAccount(let parameters):
            return parameters
        case .setNewPassword(_, let parameters):
            return parameters
        case .forgotPassword(let parameters):
            return parameters
        case .authenticate(let parameters):
            return parameters
        case .refreshToken(let parameters):
            return parameters
        case .authenticateClientCredentials(let parameters):
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
                                     metadata: [String: Any]? = nil,
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
        if let metadata = metadata {
            params[AccountParameters.metadata] = metadata
        }
        return NetworkDataSource.performRequest(route: AccountAPIRouter.createAccount(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func getUserInfo(completion: @escaping (Result<INPAccount>) -> Void) -> Request {
        return NetworkDataSource.performRequest(route: AccountAPIRouter.getAccountInfo(), completion: completion)
    }

    @discardableResult
    public static func logout(completion: @escaping (Result<Empty>) -> Void) -> Request {
        return NetworkDataSource.performRequest(route: AccountAPIRouter.logout(), completion: completion)
    }

    @discardableResult
    public static func updateAccount(fullName: String,
                                     referrer: String? = nil,
                                     metadata: [String: Any]? = nil,
                                     completion: @escaping (Result<INPAccount>) -> Void) -> Request {
        var params: [String: Any] = [AccountParameters.fullName: fullName]
        if let metadata = metadata {
            params[AccountParameters.metadata] = metadata
        }
        if let referrer = referrer {
            params[AccountParameters.referrer] = referrer
        }
        return NetworkDataSource.performRequest(route: AccountAPIRouter.updateAccount(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func changePassword(oldPassword: String,
                                      newPassword: String,
                                      newPasswordConfirmation: String,
                                      completion: @escaping (Result<Empty>) -> Void) -> Request {
        let params: [String: Any] = [
            AccountParameters.oldPassword: oldPassword,
            AccountParameters.password: newPassword,
            AccountParameters.passwordConfirmation: newPasswordConfirmation
        ]
        return NetworkDataSource.performRequest(route: AccountAPIRouter.changePassword(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func eraseAccount(password: String,
                                    completion: @escaping (Result<Empty>) -> Void) -> Request {
        let params = [AccountParameters.password: password]
        return NetworkDataSource.performRequest(route: AccountAPIRouter.eraseAccount(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func setNewPassword(token: String,
                                      password: String,
                                      passwordConfirmation: String,
                                      completion: @escaping (Result<Empty>) -> Void) -> Request {
        let params = [
            AccountParameters.password: password,
            AccountParameters.passwordConfirmation: passwordConfirmation
        ]
        return NetworkDataSource.performRequest(route: AccountAPIRouter.setNewPassword(token: token,
                                                                                       parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func forgotPassword(email: String,
                                      completion: @escaping (Result<Empty>) -> Void) -> Request {
        let params = [
            AccountParameters.merchantUUID: InPlayer.Configuration.getClientId(),
            AccountParameters.email: email
        ]
        return NetworkDataSource.performRequest(route: AccountAPIRouter.forgotPassword(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func authenticate(username: String,
                                    password: String,
                                    completion: @escaping (Result<INPAuthorizationModel>) -> Void) -> Request {
        let params = [
            AccountParameters.username: username,
            AccountParameters.password: password,
            AccountParameters.grantType: AuthenticationTypes.password.rawValue,
            AccountParameters.clientId: InPlayer.Configuration.getClientId()
        ]

        return NetworkDataSource.performRequest(route: AccountAPIRouter.authenticate(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func refreshAccessToken(using refreshToken: String,
                                          completion: @escaping (Result<INPAuthorizationModel>) -> Void) -> Request {
        let params = [
            AccountParameters.clientId: InPlayer.Configuration.getClientId(),
            AccountParameters.grantType: AuthenticationTypes.refreshToken.rawValue,
            AccountParameters.refreshToken: refreshToken
        ]
        return NetworkDataSource.performRequest(route: AccountAPIRouter.refreshToken(parameters: params),
                                                completion: completion)
    }

    @discardableResult
    public static func authenticateUsingClientCredentials(clientSecret: String,
                                                          completion: @escaping (Result<INPAuthorizationModel>) -> Void) -> Request {
        let params = [
            AccountParameters.clientId: InPlayer.Configuration.getClientId(),
            AccountParameters.grantType: AuthenticationTypes.clientCredentials.rawValue,
            AccountParameters.clientSecret: clientSecret
        ]
        return NetworkDataSource.performRequest(route: AccountAPIRouter.authenticateClientCredentials(parameters: params),
                                                completion: completion)
    }
}




private struct AccountParameters {
    static let fullName             = "full_name"
    static let username             = "username"
    static let email                = "email"
    static let password             = "password"
    static let passwordConfirmation = "password_confirmation"
    static let type                 = "type"
    static let merchantUUID         = "merchant_uuid"
    static let referrer             = "referrer"
    static let metadata             = "metadata"
    static let oldPassword          = "old_password"
    static let grantType            = "grant_type"
    static let clientId             = "client_id"
    static let refreshToken         = "refresh_token"
    static let clientSecret         = "client_secret"
}

private enum AuthenticationTypes: String {
    case password           = "password"
    case clientCredentials  = "client_credentials"
    case refreshToken       = "refresh_token"
}
