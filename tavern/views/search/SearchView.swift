import SwiftUI

struct SearchView: View {
  @ObservedObject var viewModel = SearchViewModel()
  @State private var searchText = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        SearchBar(text: $searchText.onChange(performSearch))
          .padding([.leading, .trailing], 10)
          .background(Theme.gray950)
        
        List(viewModel.compendiumResults) { item in
          SearchCellView(item: item)
            .listRowBackground(Theme.gray950)
        }
        .listStyle(PlainListStyle())
        .padding(.all, 0)
        .background(Theme.gray950)
      }
    }
    .navigationTitle("Search")
    .toolbarBackground(Theme.gray950)
    .toolbarColorScheme(.dark, for: .navigationBar)
    .toolbarBackground(.visible)
    .toolbarColorScheme(.dark)
  }
  
  private func performSearch(for query: String) {
    viewModel.searchText = query
  }
}

extension Binding where Value == String {
  func onChange(_ handler: @escaping (String) -> Void) -> Binding<String> {
    Binding(
      get: { self.wrappedValue },
      set: { newValue in
        self.wrappedValue = newValue
        handler(newValue)
      }
    )
  }
}
