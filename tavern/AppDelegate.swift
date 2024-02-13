import SwiftUI
import Sentry

class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    if let sentryDsn = getSentryDsn() {
      SentrySDK.start { options in
        options.dsn = sentryDsn
        options.debug = true // Enabled to see Sentry log messages
      }
    }
    return true
  }
  
  func getSentryDsn() -> String? {
    var dictionary: NSDictionary?
    if let path = Bundle.main.path(forResource: "secrets", ofType: "plist") {
      dictionary = NSDictionary(contentsOfFile: path)
    }
    return dictionary?["SentryDsn"] as? String
  }
}
