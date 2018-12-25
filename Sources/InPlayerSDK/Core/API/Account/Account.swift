import Alamofire

private protocol Accounts {
    /**
     Creates new account
     - Parameters:
        - fullName: Full name of account
        - email: Email of account
        - password: Password of account
        - passwordConfirmation: Password confirmation of account
        - type: Account type
        - merchantUUID: ???
        - referrer: ??? (Optional)
        - success: A closure to be executed once the request has finished successfully.
        - failure: A closure to be executed once the request has finished with error.
     */
    static func createAccount(fullName: String,
                              email: String,
                              password: String,
                              passwordConfirmation: String,
                              type: AccountType,
                              merchantUUID: String,
                              referrer: String?,
                              success: @escaping ((_ account: INPAuthorizationModel) -> Void),
                              failure: @escaping ((_ error: Error) -> Void))
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
    final public class Account: Accounts {
        private init() {}
        static func createAccount(fullName: String,
                                  email: String,
                                  password: String,
                                  passwordConfirmation: String,
                                  type: AccountType,
                                  merchantUUID: String,
                                  referrer: String?,
                                  success: @escaping ((INPAuthorizationModel) -> Void),
                                  failure: @escaping ((Error) -> Void)) {
            INPAccountService.createAccount(fullName: fullName,
                                            email: email,
                                            password: password,
                                            passwordConfirmation: passwordConfirmation,
                                            type: type,
                                            merchantUUID: merchantUUID,
                                            referrer: referrer) { (result) in
                switch result {
                case .success(let response):
                    success(response)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
}

public struct AccountParameters {
    public static let fullName = "full_name"
    public static let email = "email"
    public static let password = "password"
    public static let passwordConfirmation = "password_confirmation"
    public static let type = "type"
    public static let merchantUUID = "merchant_uuid"
    public static let referrer = "referrer"
    public static let metadata = "metadata"
}
