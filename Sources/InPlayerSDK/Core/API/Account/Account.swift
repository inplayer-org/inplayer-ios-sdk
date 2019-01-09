import Alamofire

private protocol AccountsAPI {

    /**
     Check if current user has access token.
     - Returns: Bool result of the check.
     */
    static func isAuthenticated() -> Bool

    /**
     Get user credentials.
     - Returns: User credentials. (Optional)
     */
    static func getCredentials() -> INPCredentials?

    /**
     Creates new account.
     - Parameters:
        - fullName: Full name of account
        - email: Email of account
        - password: Password of account
        - passwordConfirmation: Password confirmation of account
        - type: Account type
        - metadata: Additional information for account
        - success: A closure to be executed once the request has finished successfully.
        - authorization: Authorization model containing info regarding token and account
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     */
    static func createAccount(fullName: String,
                              email: String,
                              password: String,
                              passwordConfirmation: String,
                              type: AccountType,
                              metadata: [String: Any]?,
                              success: @escaping (_ authorization: INPAuthorizationModel) -> Void,
                              failure: @escaping (_ error: InPlayerError) -> Void)

    /**
     Gets the account information for a given authorization token
     - Parameters:
        - success: A closure to be executed once the request has finished successfully.
        - account: Contains account info
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     */
    static func getAccountInfo(success: @escaping (_ account: INPAccount) -> Void,
                              failure: @escaping (_ error: InPlayerError) -> Void)

    /**
     Logout currently authenticated account
     - Parameters:
        - success: A closure to be executed once the request has finished successfully.
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     */
    static func logout(success: @escaping () -> Void,
                       failure: @escaping (_ error: InPlayerError) -> Void)

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
    static func updateAccount(fullName: String,
                              metadata: [String: Any]?,
                              success: @escaping (_ account: INPAccount) -> Void,
                              failure: @escaping (_ error: InPlayerError) -> Void)

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
    static func changePassword(oldPassword: String,
                               newPassword: String,
                               newPasswordConfirmation: String,
                               success: @escaping () -> Void,
                               failure: @escaping (_ error: InPlayerError) -> Void)

    /**
     Deletes account and all information stored with it.
     - Parameters:
         - password: Account password.
         - success: A closure to be executed once the request has finished successfully.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    static func eraseAccount(password: String,
                             success: @escaping () -> Void,
                             failure: @escaping (_ error: InPlayerError) -> Void)

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
    static func authenticate(username: String,
                             password: String,
                             success: @escaping (_ authorizationModel: INPAuthorizationModel) -> Void,
                             failure: @escaping (_ error: InPlayerError) -> Void)

    /**
     Refreshes account access_token
     - Parameters:
         - refreshToken: Valid refresh token.
         - success: A closure to be executed once the request has finished successfully.
         - authorizationModel: Model containing access tokens and logged in account.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    static func refreshAccessToken(using refreshToken: String,
                                   success: @escaping (_ authorizationModel: INPAuthorizationModel) -> Void,
                                   failure: @escaping (_ error: InPlayerError) -> Void)

    /**
     Authenticates account using client credentials
     - Parameters:
         - clientSecret: Client secret
         - success: A closure to be executed once the request has finished successfully.
         - authorizationModel: Model containing access tokens and logged in account.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    static func authenticateUsingClientCredentials(clientSecret: String,
                                                   success: @escaping (_ authorizationModel: INPAuthorizationModel) -> Void,
                                                   failure: @escaping (_ error: InPlayerError) -> Void)

    /**
     Sends forgot password instructions on specified email.
     - Parameters:
         - email: Email on which instructions should be sent.
         - success: A closure to be executed once the request has finished successfully.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     */
    static func forgotPassword(email: String,
                               success: @escaping () -> Void,
                               failure: @escaping (_ error: InPlayerError) -> Void)

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
    static func setNewPassword(token: String,
                               password: String,
                               passwordConfirmation: String,
                               success: @escaping () -> Void,
                               failure: @escaping (_ error: InPlayerError) -> Void)
}

public extension InPlayer {
    final public class Account: AccountsAPI {
        private init() {}

        public static func getCredentials() -> INPCredentials? {
            return UserDefaults.credentials
        }

        public static func isAuthenticated() -> Bool {
            guard let credentials = getCredentials() else { return false }
            return !credentials.accessToken.isEmpty && credentials.accessToken != ""
        }

        public static func createAccount(fullName: String,
                                         email: String,
                                         password: String,
                                         passwordConfirmation: String,
                                         type: AccountType,
                                         metadata: [String: Any]? = nil,
                                         success: @escaping (INPAuthorizationModel) -> Void,
                                         failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.createAccount(fullName: fullName,
                                            email: email,
                                            password: password,
                                            passwordConfirmation: passwordConfirmation,
                                            type: type,
                                            metadata: metadata,
                                            completion: { (authorization, error) in
                if let error = error {
                    failure(error)
                } else {
                    guard let authorization = authorization,
                        let accessToken = authorization.accessToken,
                        let refreshToken = authorization.refreshToken,
                        let expires = authorization.expires
                    else {
                        failure(INPUserNotAuthenticatedError())
                        return
                    }

                    UserDefaults.credentials = INPCredentials(accessToken: accessToken,
                                                              refreshToken: refreshToken,
                                                              expires: expires)
                    success(authorization)
                }
            })
        }

        public static func getAccountInfo(success: @escaping (INPAccount) -> Void,
                                          failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.getUserInfo(completion: { (account, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(account!)
                }
            })
        }

        public static func logout(success: @escaping () -> Void,
                                  failure: @escaping (InPlayerError) -> Void){
            INPAccountService.logout(completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    UserDefaults.credentials = nil
                    success()
                }
            })
        }

        public static func updateAccount(fullName: String,
                                         metadata: [String : Any]? = nil,
                                         success: @escaping (INPAccount) -> Void,
                                         failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.updateAccount(fullName: fullName,
                                            metadata: metadata,
                                            completion: { (account, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(account!)
                }
            })
        }

        public static func changePassword(oldPassword: String,
                                          newPassword: String,
                                          newPasswordConfirmation: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.changePassword(oldPassword: oldPassword,
                                             newPassword: newPassword,
                                             newPasswordConfirmation: newPasswordConfirmation,
                                             completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }

        public static func eraseAccount(password: String,
                                        success: @escaping () -> Void,
                                        failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.eraseAccount(password: password, completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }

        public static func setNewPassword(token: String,
                                          password: String,
                                          passwordConfirmation: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.setNewPassword(token: token,
                                             password: password,
                                             passwordConfirmation: passwordConfirmation,
                                             completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }

        public static func forgotPassword(email: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.forgotPassword(email: email, completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }

        public static func authenticate(username: String,
                                        password: String,
                                        success: @escaping (INPAuthorizationModel) -> Void,
                                        failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.authenticate(username: username,
                                           password: password,
                                           completion: { (authorization, error) in
                if let error = error {
                    failure(error)
                } else {
                    guard let authorization = authorization,
                        let accessToken = authorization.accessToken,
                        let refreshToken = authorization.refreshToken,
                        let expires = authorization.expires
                    else {
                        return failure(INPUserNotAuthenticatedError())
                    }

                    UserDefaults.credentials = INPCredentials(accessToken: accessToken,
                                                              refreshToken: refreshToken,
                                                              expires: expires)
                    success(authorization)
                }
            })
        }

        public static func refreshAccessToken(using refreshToken: String,
                                              success: @escaping (INPAuthorizationModel) -> Void,
                                              failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.refreshAccessToken(using: refreshToken, completion: { (authorization, error) in
                if let error = error {
                    failure(error)
                } else {
                    guard let authorization = authorization,
                        let accessToken = authorization.accessToken,
                        let refreshToken = authorization.refreshToken,
                        let expires = authorization.expires
                    else {
                        return failure(INPUserNotAuthenticatedError())
                    }

                    UserDefaults.credentials = INPCredentials(accessToken: accessToken,
                                                              refreshToken: refreshToken,
                                                              expires: expires)
                    success(authorization)
                }
            })
        }

        public static func authenticateUsingClientCredentials(clientSecret: String,
                                                              success: @escaping (INPAuthorizationModel) -> Void,
                                                              failure: @escaping (InPlayerError) -> Void) {
            INPAccountService.authenticateUsingClientCredentials(clientSecret: clientSecret,
                                                                 completion: { (authorization, error) in
                if let error = error {
                    failure(error)
                } else {
                    guard let authorization = authorization,
                        let accessToken = authorization.accessToken,
                        let refreshToken = authorization.refreshToken,
                        let expires = authorization.expires
                    else {
                        return failure(INPUserNotAuthenticatedError())
                    }

                    UserDefaults.credentials = INPCredentials(accessToken: accessToken,
                                                              refreshToken: refreshToken,
                                                              expires: expires)
                    success(authorization)
                }
            })
        }
    }
}
