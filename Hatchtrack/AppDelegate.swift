import UIKit
import Firebase
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
var window: UIWindow?

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


    
    let defaults = UserDefaults.standard
    //defaults.set(nil, forKey: "accessToken")
    //defaults.set(nil, forKey: "email")
    //defaults.set(nil, forKey: "password")
    //defaults.synchronize()
    
    
    window = UIWindow(frame: UIScreen.main.bounds)
    if #available(iOS 13.0, *) {
        window!.overrideUserInterfaceStyle = .light
    } else {
        // Fallback on earlier versions
    }

               FirebaseApp.configure()

    Messaging.messaging().delegate = self

    UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) {granted, error in

            print("Permission granted: \(granted)")
    }

    UNUserNotificationCenter.current().delegate = self

    application.registerForRemoteNotifications()
    
    //let homeViewController: ListViewHatches? = ListViewHatches()
    let homeViewController: SignInView? = SignInView()
    let navController = UINavigationController(rootViewController: homeViewController!)


    let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    appDelegate.window?.rootViewController = navController
    //window?.rootViewController = homeViewController
    appDelegate.window?.makeKeyAndVisible()



    return true
}


    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

    print("FCM Token Is: \(fcmToken)")
        let defaults = UserDefaults.standard
        defaults.setValue(fcmToken, forKey: "fcmToken")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update_fcm"), object: nil)
        
        
        //let fcmToken = defaults.string(forKey: "fcmToken")
        //let tokenTimestamp = defaults.double(forKey: "tokenTimestamp")
}

func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    print("Token is: \(deviceToken)")
}

func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    print("Error is \(error)")
}
            
}
