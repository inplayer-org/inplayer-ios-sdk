import Alamofire

/**
 Class that provides account services which handles request creation and passes completion result
 */
class INPAccountService {
    static func signUp(fullName: String,
                       email: String,
                       password: String,
                       passwordConfirmation: String,
                       metadata: [String: Any]?,
                       completion: @escaping RequestCompletion<InPlayerAuthorization>) {
        var params: [String: Any] = [
            AccountParameters.fullName: fullName,
            AccountParameters.username: email,
            AccountParameters.password: password,
            AccountParameters.passwordConfirmation: passwordConfirmation,
            AccountParameters.type: AccountType.consumer.rawValue,
            AccountParameters.clientId: InPlayer.clientId,
            AccountParameters.grantType: AccountParameters.password
        ]
        if let referrer = InPlayer.referrer {
            params[AccountParameters.referrer] = referrer
        }
        if let metadata = metadata {
            params[AccountParameters.metadata] = metadata
        }

        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.createAccount(parameters: params),
                                         completion: { (authorization: InPlayerAuthorization?, error: InPlayerError?) in
                                            updateAuthorization(authorization: authorization,
                                                                error: error,
                                                                completion: completion)
        })
    }

    static func getAccount(completion: @escaping RequestCompletion<InPlayerAccount>) {
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.getAccountInfo,
                                         completion: { (account: InPlayerAccount?, error: InPlayerError?) in
                                            saveAccount(account: account, error: error, completion: completion)
        })
    }

    static func authenticate(username: String,
                             password: String,
                             completion: @escaping RequestCompletion<InPlayerAuthorization>) {
        let params = [
            AccountParameters.username: username,
            AccountParameters.password: password,
            AccountParameters.grantType: AuthenticationTypes.password.rawValue,
            AccountParameters.clientId: InPlayer.clientId
        ]

        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.authenticate(parameters: params),
                                         completion: { (authorization: InPlayerAuthorization?, error: InPlayerError?) in
                                            updateAuthorization(authorization: authorization,
                                                                error: error,
                                                                completion: completion)

        })
    }

    static func signOut(completion: @escaping RequestCompletion<Empty>) {
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.logout,
                                         completion: { (empty: Empty?, error: InPlayerError?) in
                                            cleanUpCredentials(empty: empty,
                                                               error: error,
                                                               completion: completion)
        })
    }

    static func updateAccount(fullName: String,
                              metadata: [String: Any]?,
                              completion: @escaping RequestCompletion<InPlayerAccount>) {
        var params: [String: Any] = [AccountParameters.fullName: fullName]
        if let metadata = metadata {
            params[AccountParameters.metadata] = metadata
        }
        if let referrer = InPlayer.referrer {
            params[AccountParameters.referrer] = referrer
        }
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.updateAccount(parameters: params),
                                         completion: { (account: InPlayerAccount?, error: InPlayerError?) in
                                            saveAccount(account: account,
                                                        error: error,
                                                        completion: completion)

        })
    }

    static func changePassword(oldPassword: String,
                               newPassword: String,
                               newPasswordConfirmation: String,
                               completion: @escaping RequestCompletion<Empty>) {
        let params: [String: Any] = [
            AccountParameters.oldPassword: oldPassword,
            AccountParameters.password: newPassword,
            AccountParameters.passwordConfirmation: newPasswordConfirmation
        ]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.changePassword(parameters: params),
                                         completion: completion)
    }

    static func deleteAccount(password: String,
                              completion: @escaping RequestCompletion<Empty>) {
        let params = [AccountParameters.password: password]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.eraseAccount(parameters: params),
                                         completion: { (empty: Empty?, error: InPlayerError?) in
                                            cleanUpCredentials(empty: empty,
                                                               error: error,
                                                               completion: completion)
        })
    }

    static func setNewPassword(token: String,
                               password: String,
                               passwordConfirmation: String,
                               completion: @escaping RequestCompletion<Empty>) {
        let params = [
            AccountParameters.password: password,
            AccountParameters.passwordConfirmation: passwordConfirmation
        ]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.setNewPassword(token: token,
                                                                                parameters: params),
                                         completion: completion)
    }

    static func requestNewPassword(email: String,
                                   completion: @escaping RequestCompletion<Empty>) {
        let params = [
            AccountParameters.merchantUUID: InPlayer.clientId,
            AccountParameters.email: email
        ]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.forgotPassword(parameters: params),
                                         completion: completion)
    }

    static func refreshToken(using refreshToken: String,
                             completion: @escaping RequestCompletion<InPlayerAuthorization>) {
        let params = [
            AccountParameters.clientId: InPlayer.clientId,
            AccountParameters.grantType: AuthenticationTypes.refreshToken.rawValue,
            AccountParameters.refreshToken: refreshToken
        ]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.refreshToken(parameters: params),
                                         completion: { (authorization: InPlayerAuthorization?, error: InPlayerError?) in
                                            updateAuthorization(authorization: authorization,
                                                                error: error,
                                                                completion: completion)
        })
    }

    static func authenticateUsingClientCredentials(clientSecret: String,
                                                   completion: @escaping RequestCompletion<InPlayerAuthorization>) {
        let params = [
            AccountParameters.clientId: InPlayer.clientId,
            AccountParameters.grantType: AuthenticationTypes.clientCredentials.rawValue,
            AccountParameters.clientSecret: clientSecret
        ]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.authenticateClientCredentials(parameters: params),
                                         completion: { (authorization: InPlayerAuthorization?, error: InPlayerError?) in
                                            updateAuthorization(authorization: authorization,
                                                                error: error,
                                                                completion: completion)
        })
    }

    static func exportData(password: String, completion: @escaping RequestCompletion<Empty>) {
        let params = [AccountParameters.password: password]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.exportData(parameters: params),
                                         completion: completion)
    }

    static func getRegisterFields(completion: @escaping RequestCompletion<InPlayerRegisterFieldsResponse>) {
        let merchantUUID = InPlayer.clientId
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.getRegisterFields(merchantUUID: merchantUUID),
                                         completion: completion)
    }
    
    static func getSocialURLs(completion: @escaping RequestCompletion<InPlayerSocialUrlResponse>) {
        let base64 = [ AccountParameters.clientId: InPlayer.clientId,
                       AccountParameters.redirect: InPlayer.redirectUri
                     ].toString()?.toBase64()

        var params: [String: Any] = [:]
        if let base64 = base64 {
            params[AccountParameters.state] = base64
        }
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.getSocialURLs(parameters: params),
                                         completion: completion)
    }

    static func validateSocialLogin(url: URL, completion: @escaping RequestCompletion<InPlayerAccount>) {
        if url.absoluteString.starts(with: InPlayer.redirectUri),
            let startRange = url.absoluteString.range(of: InPlayer.redirectUri)?.upperBound {
            let authorizationValueString = String(url.absoluteString[startRange...])
            let values = authorizationValueString.components(separatedBy: "&")
            if values.count < 3 {
                completion(nil,InPlayerMalformedUrlError())
            } else {
                let token = values.filter { return $0.starts(with: "#token") }.first
                let expires = values.filter { return $0.starts(with: "expires") }.first
                let refreshToken = values.filter { return $0.starts(with: "refresh_token") }.first

                if let token = token,
                    let expiresValue = expires,
                    let refreshToken = refreshToken,
                    let tokenRange = token.range(of: "=")?.upperBound,
                    let expiresRange = expiresValue.range(of: "=")?.upperBound,
                    let refreshTokenRange = refreshToken.range(of: "=")?.upperBound,
                    let expires = Double(expiresValue[expiresRange...]) {
                    UserDefaults.credentials = InPlayerCredentials(accessToken: String(token[tokenRange...]),
                                                                   refreshToken: String(refreshToken[refreshTokenRange...]),
                                                                   expires: expires)
                    getAccount(completion: completion)
                } else {
                    completion(nil,InPlayerMalformedUrlError())
                }
            }
        }
    }
    
    static func sendPinCode(brandingId: Int?, completion: @escaping RequestCompletion<Empty>) {
        var params: [String: Any] = [:]
        if let brandingID = brandingId {
            params[AccountParameters.brandingID] = brandingID
        }
        
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.getSocialURLs(parameters: params),
                                         completion: completion)
    }
    
    static func validatePinCode(_ pinCode: String, completion: @escaping RequestCompletion<Empty>) {
        let params = [AccountParameters.pinCode: pinCode]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: AccountAPIRouter.validatePinCode(parameters: params),
                                         completion: completion)
    }
}

private extension INPAccountService {
    private static func updateAuthorization(authorization: InPlayerAuthorization?,
                                            error: InPlayerError?,
                                            completion: @escaping RequestCompletion<InPlayerAuthorization>) {
        if error != nil {
            completion(authorization, error)
        } else {
            guard let auth = authorization,
                let accessToken = auth.accessToken,
                let refreshToken = auth.refreshToken,
                let expires = auth.expires
                else {
                    return completion(authorization, InPlayerUnauthorizedError())
            }

            UserDefaults.credentials = InPlayerCredentials(accessToken: accessToken,
                                                           refreshToken: refreshToken,
                                                           expires: expires)
            UserDefaults.account = auth.account
            completion(authorization, error)
        }
    }

    private static func saveAccount(account: InPlayerAccount?,
                                    error: InPlayerError?,
                                    completion: @escaping RequestCompletion<InPlayerAccount>) {
        if error != nil {
            completion(account, error)
        } else {
            UserDefaults.account = account
            completion(account, error)
        }
    }

    private static func cleanUpCredentials(empty: Empty?,
                                           error: InPlayerError?,
                                           completion: @escaping RequestCompletion<Empty>) {
        if error != nil {
            completion(empty, error)
        } else {
            UserDefaults.credentials = nil
            UserDefaults.account = nil
            completion(empty, error)
        }
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
    static let state                = "state"
    static let redirect             = "redirect"
    static let pinCode              = "pin_code"
    static let brandingID           = "branding_id"
}

private enum AuthenticationTypes: String {
    case password           = "password"
    case clientCredentials  = "client_credentials"
    case refreshToken       = "refresh_token"
}

/// Enum of available account api routes
private enum AccountAPIRouter: INPAPIConfiguration {
    case createAccount(parameters: [String: Any])
    case getAccountInfo
    case logout
    case updateAccount(parameters: [String: Any])
    case changePassword(parameters: [String: Any])
    case eraseAccount(parameters: [String: Any])
    case setNewPassword(token: String, parameters: [String: Any])
    case forgotPassword(parameters: [String: Any])
    case authenticate(parameters: [String: Any])
    case refreshToken(parameters: [String: Any])
    case authenticateClientCredentials(parameters: [String: Any])
    case exportData(parameters: [String: Any])
    case getRegisterFields(merchantUUID: String)
    case getSocialURLs(parameters: [String: Any])
    case sendPinCode(parameters: [String: Any])
    case validatePinCode(parameters: [String: Any])

    var method: HTTPMethod {
        switch self {
        case .createAccount,
             .changePassword,
             .forgotPassword,
             .authenticate,
             .refreshToken,
             .authenticateClientCredentials,
             .exportData,
             .sendPinCode,
             .validatePinCode:
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
        case .exportData:
            return NetworkConstants.Endpoints.Account.exportData
        case .getRegisterFields(let merchantUUID):
            return String(format: NetworkConstants.Endpoints.Account.registerFields, merchantUUID)
        case .getSocialURLs:
            return NetworkConstants.Endpoints.Account.getSocialUrls
        case .sendPinCode:
            return NetworkConstants.Endpoints.Account.sendPinCode
        case .validatePinCode:
            return NetworkConstants.Endpoints.Account.validatePinCode
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
        case .exportData(let parameters):
            return parameters
        case .getSocialURLs(let parameters):
            return parameters
        case .sendPinCode(let parameters):
            return parameters
        case .validatePinCode(let parameters):
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

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(NetworkConstants.HeaderParameters.applicationUrlEncoded,
                            forHTTPHeaderField: NetworkConstants.HeaderParameters.contentType)
        urlRequest.setValue(NetworkConstants.HeaderParameters.applicationJSON,
                            forHTTPHeaderField: NetworkConstants.HeaderParameters.accept)

        switch self {
        case .refreshToken:
            urlRequest.setValue(NetworkConstants.HeaderParameters.refreshToken,
                                forHTTPHeaderField: NetworkConstants.HeaderParameters.authenticationType)
        default: break
        }

        // Parameters
        guard let parameters = parameters else { return urlRequest }
        if urlEncoding {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }

    var requiresAuthorization: Bool {
        switch self {
        case .createAccount,
             .setNewPassword,
             .forgotPassword,
             .authenticate,
             .authenticateClientCredentials,
             .getRegisterFields,
             .getSocialURLs:
            return false
        default:
            return true
        }
    }
}
