import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let megabytes = 1024*1024
        URLCache.shared = URLCache(memoryCapacity: 10*megabytes, diskCapacity: 20*megabytes, diskPath: nil)

        let rootVC = MovieListController()
        let navigationVC = UINavigationController(rootViewController: rootVC)

        let navBar = navigationVC.navigationBar
        navBar.barTintColor = UIColor(colorLiteralRed: 0, green: 175/255, blue: 1, alpha: 0)
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navBar.isTranslucent = false

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()

        return true
    }
}

