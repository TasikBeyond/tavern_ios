import SwiftUI
import Sentry


@main
struct tavernApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  init() {
    UITableView.appearance().backgroundColor = .clear
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .background(Theme.gray900)
        .preferredColorScheme(.dark)
    }
  }
}
