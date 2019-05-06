import UIKit
import InPlayerSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // On first start of the app call this:
        let configuration = InPlayer.Configuration(clientId: "7ad8a510-b720-4a18-aa38-0260e5fd1cb2", environment: .staging)
        InPlayer.initialize(configuration: configuration)

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        InPlayer.Account.validateSocialLogin(url: url)

        return true
    }
}
