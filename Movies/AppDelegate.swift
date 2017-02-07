import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let megabytes = 1024*1024
        URLCache.shared = URLCache(memoryCapacity: 10*megabytes, diskCapacity: 20*megabytes, diskPath: nil)

        let rootVC = MovieListController()
        let navigationVC = UINavigationController(rootViewController: rootVC)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()

        return true
    }
}

