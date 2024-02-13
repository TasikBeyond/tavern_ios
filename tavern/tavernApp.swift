import SwiftUI

@main
struct tavernApp: App {
  
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
