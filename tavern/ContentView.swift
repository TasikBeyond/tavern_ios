import SwiftUI

struct ContentView: View {
  @State private var shouldNavigateToSearchView = false

  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundStyle(.tint)
        Text("Hello, world!")
        Button("Go to Search") {
          shouldNavigateToSearchView = true
        }
      }
      .padding()
      .navigationDestination(isPresented: $shouldNavigateToSearchView) {
        LazyView(SearchView(viewModel: SearchViewModel()))
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Main")
    }
  }
}

#Preview {
  ContentView()
}
