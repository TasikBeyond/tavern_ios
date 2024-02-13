import SwiftUI

struct ContentView: View {
  @State private var shouldNavigateToSearchView = false

  var body: some View {
    NavigationStack {
      VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundColor(Theme.gray50)
          .foregroundStyle(.tint)
          .background(Theme.gray700)
        Text("Hello, world!")
          .foregroundColor(Theme.gray50)
        Button("Go to Search") {
          shouldNavigateToSearchView = true
        }
        .buttonStyle(.borderedProminent)
        .foregroundColor(Theme.blue600)
        .tint(Theme.blue600)
      }
      .padding()
      .background(Theme.gray900)
      .navigationDestination(isPresented: $shouldNavigateToSearchView) {
        LazyView(
          SearchView(viewModel: SearchViewModel())
            .background(Theme.gray900)
        )
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Main")
      .foregroundColor(Theme.gray50)
    }
    .toolbarBackground(Color.accentColor)
    .toolbarBackground(.visible)
    .toolbarColorScheme(.dark)
    .background(Theme.gray900.edgesIgnoringSafeArea(.all))
  }
}

#Preview {
  ContentView()
}
