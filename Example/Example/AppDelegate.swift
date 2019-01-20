import UIKit
import InPlayerSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // On first start of the app call this:
        InPlayer.initialize(withClienId: "xxx", environment: .staging)
        InPlayer.Account.authenticate(username: "a", password: "b", success: { (e) in

        }) { (r) in

        }
        return true
    }
}
