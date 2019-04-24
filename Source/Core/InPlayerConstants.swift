import Foundation

struct InPlayerConstants {
    struct UserDefaultsKeys {
        static let clientId = "InPlayer_clientId"
        static let environment = "InPlayer_environment"
        static let credentials = "InPlayer_credentials"
        static let account = "InPlayer_account"
    }
    
    struct SocialRedirectUri {
        static let staging = "https://native.accounts.staging-v2.inplayer.com/sso/social/callback"
        static let production = ""
    }
}
