import UIKit

//find weather icons 👈
   //convert to pdf
//find api calls, and see if you have hours for the day/loc
//Move Netski into production
   //use network code from prev projects
//load all weather data on init, and appBecomeActive
   //the weatherData for the curIdx is put to the front of the que
//the model is updated on: init,becomeActive,periodically, every 5min on a timer.
   //reset a 5 min timer everytime the timer runsOut, or init, and continue timer on becomeActive
//Figure out heavenly gradients (Sky gradients) HeavenlySky
   //Location, Time, weather condition, time of year
   //How does pastle animate gradients?
   //Nice collection of gradients: https://github.com/itmeo/webgradients/blob/master/webgradients.css
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Swift.print("Hello world 🤯")
        self.window = {/*We set a custom window*/
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = ViewController()//VC()///*We set the VC as rootVC*/
            window.makeKeyAndVisible()//since we have no Main storyboard
            return window
        }()
        return true
    }
    /**
     * Boilerplate
     */
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
}
