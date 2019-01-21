import Alamofire

public extension InPlayer {

    /**
     Class providing Account related actions.
     */
    final public class Account {
        private init() {}

        /**
         Get user credentials.
         - Returns: User credentials. (Optional)
         */

        public static func getCredentials() -> INPCredentials? {
            return UserDefaults.credentials
        }

        /**
         Check if current user has access token.
         - Returns: Bool result of the check.
         */
        public static func isAuthenticated() -> Bool {
            guard let credentials = getCredentials() else { return false }
            return !credentials.accessToken.isEmpty && credentials.accessToken != ""
        }

        /**
         Creates new account.
         - Parameters:
             - fullName: Full name of account
             - email: Email of account
             - password: Password of account
             - passwordConfirmation: Password confirmation of account
             - metadata: Additional information for account
             - success: A closure to be executed once the request has finished successfully.
             - authorization: Authorization model containing info regarding token and account
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func createAccount(fullName: String,
                                         email: String,
                                         password: String,
                                         passwordConfirmation: String,
                                         metadata: [String: Any]? = nil,
                                         success: @escaping (_ authorization: INPAuthorizationModel) -> Void,
                                         failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.createAccount(fullName: fullName,
                                            email: email,
                                            password: password,
                                            passwordConfirmation: passwordConfirmation,
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
                    UserDefaults.account = authorization.account
                    success(authorization)
                }
            })
        }

        /**
         Gets the account information for a given authorization token
         - Parameters:
             - success: A closure to be executed once the request has finished successfully.
             - account: Contains account info
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getAccountInfo(success: @escaping (_ account: INPAccountModel) -> Void,
                                          failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.getUserInfo(completion: { (account, error) in
                if let error = error {
                    failure(error)
                } else {
                    UserDefaults.account = account
                    success(account!)
                }
            })
        }

        /**
         Logout currently authenticated account
         - Parameters:
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */

        public static func logout(success: @escaping () -> Void,
                                  failure: @escaping (_ error: InPlayerError) -> Void){
            INPAccountService.logout(completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    UserDefaults.credentials = nil
                    UserDefaults.account = nil
                    success()
                }
            })
        }

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
        public static func updateAccount(fullName: String,
                                         metadata: [String : Any]? = nil,
                                         success: @escaping (_ account: INPAccountModel) -> Void,
                                         failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.updateAccount(fullName: fullName,
                                            metadata: metadata,
                                            completion: { (account, error) in
                if let error = error {
                    failure(error)
                } else {
                    UserDefaults.account = account
                    success(account!)
                }
            })
        }

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
        public static func changePassword(oldPassword: String,
                                          newPassword: String,
                                          newPasswordConfirmation: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (_ error: InPlayerError) -> Void) {
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

        /**
         Deletes account and all information stored with it.
         - Parameters:
             - password: Account password.
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func eraseAccount(password: String,
                                        success: @escaping () -> Void,
                                        failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.eraseAccount(password: password, completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    UserDefaults.credentials = nil
                    UserDefaults.account = nil
                    success()
                }
            })
        }

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
        public static func setNewPassword(token: String,
                                          password: String,
                                          passwordConfirmation: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (_ error: InPlayerError) -> Void) {
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

        /**
         Sends forgot password instructions on specified email.
         - Parameters:
             - email: Email on which instructions should be sent.
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func forgotPassword(email: String,
                                          success: @escaping () -> Void,
                                          failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.forgotPassword(email: email, completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }

        /**
         Authenticates account using username and password
         - Parameters:
             - username: Account username
             - password: Account password
             - success: A closure to be executed once the request has finished successfully.
             - authorization: Model containing access tokens and logged in account.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func authenticate(username: String,
                                        password: String,
                                        success: @escaping (_ authorization: INPAuthorizationModel) -> Void,
                                        failure: @escaping (_ error: InPlayerError) -> Void) {
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
                    UserDefaults.account = authorization.account
                    success(authorization)
                }
            })
        }

        /**
         Refreshes account access_token
         - Parameters:
             - refreshToken: Valid refresh token.
             - success: A closure to be executed once the request has finished successfully.
             - authorization: Model containing access tokens and logged in account.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func refreshAccessToken(using refreshToken: String,
                                              success: @escaping (_ authorization: INPAuthorizationModel) -> Void,
                                              failure: @escaping (_ error: InPlayerError) -> Void) {
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
                    UserDefaults.account = authorization.account
                    success(authorization)
                }
            })
        }

        /**
         Authenticates account using client credentials
         - Parameters:
             - clientSecret: Client secret
             - success: A closure to be executed once the request has finished successfully.
             - authorization: Model containing access tokens and logged in account.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func authenticateUsingClientCredentials(clientSecret: String,
                                                              success: @escaping (_ authorization: INPAuthorizationModel) -> Void,
                                                              failure: @escaping (_ error: InPlayerError) -> Void) {
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
                    UserDefaults.account = authorization.account
                    success(authorization)
                }
            })
        }
    }
}
