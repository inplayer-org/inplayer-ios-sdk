import Foundation

struct NetworkConstants {
    struct BaseUrls {
        static let production = "https://services.inplayer.com"
        static let staging    = "https://staging-v2.inplayer.com"
        static let debug      = "https://staging-v2.inplayer.com"
    }
    
    struct HeaderParameters {
        static let authorization         = "Authorization"
        static let contentType           = "Content-Type"
        static let accept                = "Accept"
        static let bearerToken           = "Bearer "
        static let applicationJSON       = "application/json"
        static let applicationUrlEncoded = "application/x-www-form-urlencoded"
        static let authenticationType    = "Authentication-Type"
        static let refreshToken          = "Refresh-Token"
    }

    struct Endpoints {
        struct Account {
            static let createAccount  = "/accounts"
            static let accountInfo    = "/accounts"
            static let logout         = "/accounts/logout"
            static let updateAccount  = "/accounts"
            static let changePassword = "/accounts/change-password"
            static let eraseAccount   = "/accounts/erase"
            static let forgotPassword = "/accounts/forgot-password"
            static let authenticate   = "/accounts/authenticate"
            static let setNewPassword = "/accounts/forgot-password/%@"
            static let exportData     = "/accounts/export"
            static let registerFields = "/accounts/register-fields/%@"
            static let getSocialUrls  = "/accounts/social"
            static let sendPinCode    = "/v2/accounts/pin-codes/send"
            static let validatePinCode = "/v2/accounts/pin-codes/validate"
        }

        struct Asset {
            static let itemDetails = "/items/%@/%@"
            static let itemAccessFees = "items/%@/access-fees"
            static let itemAccess = "items/%@/access"
            static let externalItemDetails = "/items/assets/external/%@/%@"
        }

        struct Subscription {
            static let subscriptionList = "/subscriptions"
        }
    }
}
