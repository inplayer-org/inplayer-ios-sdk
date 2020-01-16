import Alamofire

public extension InPlayer {
    
    /**
     Class providing Account related actions.
     */
    final class Account {
        
        /**
         Social login closure typealias containing account and error.
         - Parameters:
             - account: The obtained account.
             - error: The error that might occur.
         */
        public typealias SocialLoginCompletion = (_ account: InPlayerAccount?, _ error: InPlayerError?) -> Void
        static var completionHandler: SocialLoginCompletion?
        
        private init() {}
        
        /**
         Get user credentials if present, else returns nil.
         - Returns: User credentials or nil.
         */
        
        public static func getCredentials() -> InPlayerCredentials? {
            return UserDefaults.credentials
        }
        
        /**
         Removes account and user credentials
         */
        public static func removeCredentials() {
            UserDefaults.credentials = nil
            UserDefaults.account = nil
        }
        
        /**
         Get account if logged in, else it returns nil
         - Returns: Account or nil
         */
        public static func getAccountInfo() -> InPlayerAccount? {
            return UserDefaults.account
        }
        
        /**
         Check if current user has valid access token.
         - Returns: Bool result of the check.
         */
        public static func isAuthenticated() -> Bool {
            guard let credentials = getCredentials() else { return false }
            guard Date().timeIntervalSince1970.isLess(than: credentials.expires) else { return false }
            return !credentials.accessToken.isEmpty && credentials.accessToken != ""
        }
        
        /**
         Creates new account.
         - Parameters:
             - fullName: Account's first and last name
             - email: Account’s email address
             - password: Password containing minimum 8 characters
             - passwordConfirmation: The same password with minimum 8 characters
             - metadata: Additional information about the account that can be attached to the account object
             - success: A closure to be executed once the request has finished successfully.
             - authorization: Authorization model containing info regarding token and account
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func signUp(fullName: String,
                                  email: String,
                                  password: String,
                                  passwordConfirmation: String,
                                  metadata: [String: Any]? = nil,
                                  success: @escaping (_ authorization: InPlayerAuthorization) -> Void,
                                  failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.signUp(fullName: fullName,
                                     email: email,
                                     password: password,
                                     passwordConfirmation: passwordConfirmation,
                                     metadata: metadata,
                                     completion: { (authorization, error) in
                                        if let error = error {
                                            failure(error)
                                        } else {
                                            success(authorization!)
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
        public static func getAccount(success: @escaping (_ account: InPlayerAccount) -> Void,
                                      failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.getAccount(completion: { (account, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(account!)
                }
            })
        }
        
        /**
         Authenticates account using username and password
         - Parameters:
             - username: The email address of the account.
             - password: The account password
             - success: A closure to be executed once the request has finished successfully.
             - authorization: Model containing access tokens and logged in account.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func authenticate(username: String,
                                        password: String,
                                        success: @escaping (_ authorization: InPlayerAuthorization) -> Void,
                                        failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.authenticate(username: username,
                                           password: password,
                                           completion: { (authorization, error) in
                                            if let error = error {
                                                failure(error)
                                            } else {
                                                success(authorization!)
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
        public static func signOut(success: @escaping () -> Void,
                                   failure: @escaping (_ error: InPlayerError) -> Void){
            INPAccountService.signOut(completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }
        
        /**
         Updates account information.
         - Parameters:
             - fullName: The full name of the account.
             - metadata: Additional information about the account that can be attached to the account object
             - success: A closure to be executed once the request has finished successfully.
             - account: Contains account info.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func updateAccount(fullName: String,
                                         metadata: [String : Any]? = nil,
                                         success: @escaping (_ account: InPlayerAccount) -> Void,
                                         failure: @escaping (_ error: InPlayerError) -> Void) {
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
        
        /**
         Updates account password.
         - Parameters:
             - oldPassword: Account's old password.
             - newPassword: The account's new password
             - newPasswordConfirmation: The account's new password for confirmation.
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
             - password: Password confirmation.
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func deleteAccount(password: String,
                                         success: @escaping () -> Void,
                                         failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.deleteAccount(password: password, completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }
        
        /**
         Sets new password for account using the token from account's email.
         - Parameters:
             - token: The forgot password token sent to your email address.
             - password: The account’s new password.
             - passwordConfirmation: The password confirmation.
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
             - email: Account’s email address.
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func requestNewPassword(email: String,
                                              success: @escaping () -> Void,
                                              failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.requestNewPassword(email: email, completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }
        
        
        /**
         Refreshes account `access_token`
         - Parameters:
             - refreshToken: An auto-generated token that enables access when the original access token has
         expired without requiring re authentication
             - success: A closure to be executed once the request has finished successfully.
             - authorization: Model containing access tokens and logged in account.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func refreshToken(using refreshToken: String,
                                        success: @escaping (_ authorization: InPlayerAuthorization) -> Void,
                                        failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.refreshToken(using: refreshToken, completion: { (authorization, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(authorization!)
                }
            })
        }
        
        /**
         Exports account data such as logins, payments, subscriptions, access to assets etc. After invoking the request the account will receive the data in a json format via e-mail.
         - Parameters:
             - password: Password of the current logged user
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func exportData(password: String,
                                      success: @escaping () -> Void,
                                      failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.exportData(password: password) { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            }
        }
        
        /**
         Gets register fields
         - Parameters:
            - success: A closure to be executed once the request has finished successfully.
            - registerFields: `InPlayerRegisterField` struct optionally containing associated values depending on the type enum.
            - failure: A closure to be executed once the request has finished with error.
            - error: Containing information about the error that occurred.
         */
        public static func getRegisterFields(success: @escaping (_ registerFields: [InPlayerRegisterField]) -> Void,
                                             failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.getRegisterFields { (response, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(response!.collection)
                }
            }
        }
        
        /**
         Get List of Social URLs
         - Parameters:
            - success: A closure to be executed once the request has finished successfully.
            - socialURLs: Array of objects, each containing different social service and its url.
            - failure: A closure to be executed once the request has finished with error.
            - error: Containing information about the error that occurred.
         */
        
        public static func getSocialUrls(redirectUri: String,
                                         success: @escaping (_ socialURLs: [InPlayerSocialUrl]) -> Void,
                                         failure: @escaping (_ error: InPlayerError) -> Void) {
            InPlayer.redirectUri = redirectUri
            INPAccountService.getSocialURLs { (response, error) in
                if let error = error {
                    failure(error)
                } else {
                    let socialURLs = response?.socialUrls.map({ (dic:[String : String]) -> InPlayerSocialUrl in
                        return InPlayerSocialUrl.initFromDictionary(dictionary: dic)
                    })
                    success(socialURLs ?? [])
                }
            }
        }
        
        /**
         Validates social login redirect url
         - Parameters:
            - url: The redirect url to be processed.
         */
        public static func validateSocialLogin(url: URL) {
            INPAccountService.validateSocialLogin(url: url) { (account, error) in
                if let completion = completionHandler {
                    completion(account, error)
                    completionHandler = nil
                }
            }
        }
        
        /**
         Opens external browser with the provided url.
         - Parameters:
            - url: The social url that needs to be open.
            - completion: A closure to be executed once the request has finished. It contains `account` if the loging was successfull or `error` if something went wrong.
         */
        public static func socialLogin(withUrl url: URL, completion: @escaping SocialLoginCompletion) {
            // keep completion handler
            self.completionHandler = completion
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    
        /**
         Creates pin code and sends it to your email
         - Parameters:
             - brandingID: Optional parameter
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        
        public static func sendPinCode(brandingID: Int?,
                                       success: @escaping () -> Void,
                                       failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.sendPinCode(brandingId: brandingID) { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            }
        }
        
        /**
         Checks validity of pin code
         - Parameters:
             - pinCode: The pin code that was sent to your email
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        
        public static func validatePinCode(_ pinCode: String,
                                           success: @escaping () -> Void,
                                           failure: @escaping (_ error: InPlayerError) -> Void) {
            INPAccountService.validatePinCode(pinCode) { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            }
        }
    }
}
