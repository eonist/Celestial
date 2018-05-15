
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Swift.print("Hello world")
        self.window = {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = VC()
            window.makeKeyAndVisible()//since we have no Main storyboard
            return window
        }()
        return true
    }
    /**
     * Boilerplate
     */
    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) { }
}
