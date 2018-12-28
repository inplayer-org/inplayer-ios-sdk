import Foundation

public struct NetworkConstants {
    public struct BaseUrls {
        public static let production = "https://services.inplayer.com"
        public static let staging = "https://staging-v2.inplayer.com"
        public static let debug = "https://staging-v2.inplayer.com"
    }
    
    public struct HeaderParameters {
        public static let authorization         = "Authorization"
        public static let contentType           = "Content-Type"
        public static let accept                = "Accept"
        public static let bearerToken           = "Bearer "
        public static let applicationJSON       = "application/json"
        public static let applicationUrlEncoded = "application/x-www-form-urlencoded"
    }

    public struct Endpoints {
        public struct Account {
            public static let createAccount = "/accounts"
            public static let accountInfo = "/accounts"
            public static let logout = "/accounts/logout"
            public static let updateAccount = "/accounts"
            public static let changePassword = "/accounts/change-password"
            public static let eraseAccount = "/accounts/erase"
            public static let forgotPassword = "/accounts/forgot-password"
            public static let authenticate = "/accounts/authenticate"
            public static let setNewPassword = "/accounts/forgot-password/%@"
        }
    }
}
