import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Begin of adding a new UINavigationController
        let controller = window?.rootViewController as! FlutterViewController
        
        // create and then add a new UINavigationController
        let navigationController = UINavigationController(rootViewController: controller)
        self.window.rootViewController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        self.window.makeKeyAndVisible()
        // End of adding a new UINavigationController
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
