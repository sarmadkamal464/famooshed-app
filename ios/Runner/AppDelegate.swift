import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
  }
//     GMSServices.provideAPIKey("AIzaSyAyj8XQ2neCkrJ-7yQ2UtXXCVz4-MaFMik")
    GMSServices.provideAPIKey("AIzaSyAyrWhY3ALKo6NORh9f_gcwGGdWPT3Phdk")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
