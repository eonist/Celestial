
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Swift.print("Hello world 🤯")
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
    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) { }
}
//🏀
   //Make FirstCard and SecondCard, 👉 NowCard, TodayCard ✅

   //just use the same tech as bottombar, then use your stack method later🚫
   //code distrib tech ✅
   //secondcard should have 5 different items with (Hour, weather img, weathertype, degree) 👈
      //test in Spatial first. Add 4 UIViews with different colors, align: leftCenter, 32px ✅
      //then Label,Img,Label,Label
   //apply dummy data to secondcard at first
   //topLeft alignment,
   //Add setData() depending on .cardMode ✅
   //set verticalCardMode in CardCarousel through callBack "onVerticalCardChange"
   //add the real data to todayCard
   //Add vector iconogrphy
   //Add gradient backgrounds 👈

