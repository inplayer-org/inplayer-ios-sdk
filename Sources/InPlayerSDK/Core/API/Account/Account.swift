import Alamofire

private protocol AccountsAPI {

    /**
     Check if current user has access token.
     - Returns: Bool result of the check.
     */
    static func isAuthenticated() -> Bool

    /**
     Creates new account.
     - Parameters:
        - fullName: Full name of account
        - email: Email of account
        - password: Password of account
        - passwordConfirmation: Password confirmation of account
        - type: Account type
        - referrer: ??? (Optional)
        - metadata: Additional information for account
        - success: A closure to be executed once the request has finished successfully.
        - authorization: Authorization model containing info regarding token and account
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func createAccount(fullName: String,
                              email: String,
                              password: String,
                              passwordConfirmation: String,
                              type: AccountType,
                              referrer: String?,
                              metadata: [String: Any]?,
                              success: @escaping (_ authorization: INPAuthorizationModel) -> Void,
                              failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Gets the account information for a given authorization token
     - Parameters:
        - success: A closure to be executed once the request has finished successfully.
        - account: Contains account info
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func getAccountInfo(success: @escaping (_ account: INPAccount) -> Void,
                              failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Logout currently authenticated account
     - Parameters:
        - success: A closure to be executed once the request has finished successfully.
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func logout(success: @escaping () -> Void, failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Updates account information.
     - Parameters:
         - fullName: Account full name. Can be new or updated. (Required).
         - metadata: Optional key-value object containing additional fields that needs to be updated or added.
         - success: A closure to be executed once the request has finished successfully.
         - account: Contains account info.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func updateAccount(fullName: String,
                              referrer: String?,
                              metadata: [String: Any]?,
                              success: @escaping (_ account: INPAccount) -> Void,
                              failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Updates account password.
     - Parameters:
         - oldPassword: Old account password.
         - newPassword: New account password.
         - newPasswordConfirmation: New password confirmation
         - success: A closure to be executed once the request has finished successfully.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func changePassword(oldPassword: String,
                               newPassword: String,
                               newPasswordConfirmation: String,
                               success: @escaping () -> Void,
                               failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Deletes account and all information stored with it.
     - Parameters:
         - password: Account password.
         - success: A closure to be executed once the request has finished successfully.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func eraseAccount(password: String,
                             success: @escaping () -> Void,
                             failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Authenticates account using username and password
     - Parameters:
         - username: Account username
         - password: Account password
         - success: A closure to be executed once the request has finished successfully.
         - authorizationModel: Model containing access tokens and logged in account.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func authenticate(username: String,
                             password: String,
                             success: @escaping (_ authorizationModel: INPAuthorizationModel) -> Void,
                             failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Refreshes account access_token
     - Parameters:
         - refreshToken: Valid refresh token.
         - success: A closure to be executed once the request has finished successfully.
         - authorizationModel: Model containing access tokens and logged in account.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func refreshAccessToken(using refreshToken: String,
                                   success: @escaping (_ authorizationModel: INPAuthorizationModel) -> Void,
                                   failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Authenticates account using client credentials
     - Parameters:
         - clientSecret: Client secret
         - success: A closure to be executed once the request has finished successfully.
         - authorizationModel: Model containing access tokens and logged in account.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func authenticateUsingClientCredentials(clientSecret: String,
                                                   success: @escaping (_ authorizationModel: INPAuthorizationModel) -> Void,
                                                   failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Sends forgot password instructions on specified email.
     - Parameters:
         - email: Email on which instructions should be sent.
         - success: A closure to be executed once the request has finished successfully.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func forgotPassword(email: String,
                               success: @escaping () -> Void,
                               failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Sets new password for account using the token from account's email.
     - Parameters:
         - token: String received on account's email.
         - password: New account password.
         - passwordConfirmation: New password confirmation.
         - success: A closure to be executed once the request has finished successfully.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    @discardableResult
    static func setNewPassword(token: String,
                               password: String,
                               passwordConfirmation: String,
                               success: @escaping () -> Void,
                               failure: @escaping (_ error: Error) -> Void) -> Request
}

public extension InPlayer {
    final public class Account: AccountsAPI {
        private init() {}

        public static func isAuthenticated() -> Bool {
            let credentials = INPCredentials.getCredentials()
            return !credentials.accessToken.isEmpty && credentials.accessToken != ""
        }

        @discardableResult
        public static func createAccount(fullName: String,
                                         email: String,
                                         password: String,
                                         passwordConfirmation: String,
                                         type: AccountType,
                                         referrer: String?,
                                         metadata: [String: Any]?,
                                         success: @escaping (INPAuthorizationModel) -> Void,
                                         failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.createAccount(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   passwordConfirmation: passwordConfirmation,
                                                   type: type,
                                                   referrer: referrer,
                                                   metadata: metadata) { (result) in
                switch result {
                case .success(let response):
                    //---------------------------------------------//
                    // TODO: do a guard check of properties exists,
                    // else return custom error!
                    //---------------------------------------------//
                    UserDefaults.credentials = INPCredentials(accessToken: response.accessToken ?? "",
                                                              refreshToken: "",
                                                              expires: response.expires ?? 0)
                    success(response)
                case .failure(let error):
                    failure(error)
                }
            }
        }

        @discardableResult
        public static func getAccountInfo(success: @escaping (INPAccount) -> Void,
                                          failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.getUserInfo(completion: { result in
                switch result {
                case .success(let response):
                    success(response)
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func logout(success: @escaping () -> Void, failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.logout(completion: { (result) in
                switch result {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func updateAccount(fullName: String,
                                         referrer: String?,
                                         metadata: [String : Any]?,
                                         success: @escaping (INPAccount) -> Void,
                                         failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.updateAccount(fullName: fullName,
                                                   referrer: referrer,
                                                   metadata: metadata,
                                                   completion: { result in
                switch result {
                case .success(let resposne):
                    success(resposne)
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func changePassword(oldPassword: String,
                                          newPassword: String,
                                          newPasswordConfirmation: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.changePassword(oldPassword: oldPassword,
                                                    newPassword: newPassword,
                                                    newPasswordConfirmation: newPasswordConfirmation,
                                                    completion: { result in
                switch result {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func eraseAccount(password: String,
                                        success: @escaping () -> Void,
                                        failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.eraseAccount(password: password, completion: { result in
                switch result {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func setNewPassword(token: String,
                                          password: String,
                                          passwordConfirmation: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.setNewPassword(token: token,
                                                    password: password,
                                                    passwordConfirmation: passwordConfirmation,
                                                    completion: { result in
                switch result {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func forgotPassword(email: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.forgotPassword(email: email, completion: { result in
                switch result {
                case .success(_):
                    success()
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func authenticate(username: String,
                                        password: String,
                                        success: @escaping (INPAuthorizationModel) -> Void,
                                        failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.authenticate(username: username, password: password, completion: { result in
                switch result {
                case .success(let authorization):
                    //---------------------------------------------//
                    // TODO: do a guard check of properties exists,
                    // else return custom error!
                    //---------------------------------------------//
                    UserDefaults.credentials = INPCredentials(accessToken: authorization.accessToken ?? "",
                                                              refreshToken: authorization.refreshToken ?? "",
                                                              expires: authorization.expires ?? 0)

                    success(authorization)
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func refreshAccessToken(using refreshToken: String,
                                              success: @escaping (INPAuthorizationModel) -> Void,
                                              failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.refreshAccessToken(using: refreshToken, completion: { result in
                switch result {
                case .success(let authorization):
                    UserDefaults.credentials = INPCredentials(accessToken: authorization.accessToken ?? "",
                                                              refreshToken: authorization.refreshToken ?? "",
                                                              expires: authorization.expires ?? 0)
                    success(authorization)
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func authenticateUsingClientCredentials(clientSecret: String,
                                                              success: @escaping (INPAuthorizationModel) -> Void,
                                                              failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.authenticateUsingClientCredentials(clientSecret: clientSecret, completion: { result in
                switch result {
                case .success(let response):
                    success(response)
                case .failure(let error):
                    failure(error)
                }
            })
        }
    }
}
