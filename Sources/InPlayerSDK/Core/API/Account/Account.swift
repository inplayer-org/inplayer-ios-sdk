import Alamofire

private protocol AccountsAPI {

    /// Check if current user has access token.
    /// - Returns: Bool result of the check.
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
//    static func authenticateUser()
//    static func logout()
//    static func getUser()
//    static func updateUser()
//    static func eraseUser()
//    static func changePassword()
//    static func requestForgotPasswordToken()
//    static func setNewPassword()
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
                                         success: @escaping (INPAuthorizationModel) -> Void,
                                         failure: @escaping (Error) -> Void) -> Request {
            return INPAccountService.createAccount(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   passwordConfirmation: passwordConfirmation,
                                                   type: type,
                                                   referrer: referrer) { (result) in
                switch result {
                case .success(let response):
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
    }
}
