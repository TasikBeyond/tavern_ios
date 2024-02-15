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
      NavigationStack {
        SearchView(viewModel: SearchViewModel())
          .navigationBarTitle(Text("Compendium"))
      }
      .toolbarBackground(.black)
      .toolbarColorScheme(.dark, for: .navigationBar)
      .background(.black)
      .preferredColorScheme(.dark)
    }
  }
}
