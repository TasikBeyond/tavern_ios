import SwiftUI

struct SearchView: View {
  @ObservedObject var viewModel = SearchViewModel()
  @State private var searchText = ""
  
  var body: some View {
    VStack(spacing: 0) {
      SearchBar(text: $searchText.onChange(performSearch))
        .background(Theme.gray950)
        .padding([.leading, .trailing, .top, .bottom], 10)
      
      List(viewModel.compendiumResults) { item in
        ZStack {
          SearchCellView(item: item)
            .listRowBackground(Color.black)
            .padding(.horizontal, 4)
          NavigationLink(destination: LazyView(
            CreatureDetailsView(viewModel: CreatureDetailsViewModel(content: item)))
          ) {
            EmptyView()
          }
          .opacity(0)
          .buttonStyle(PlainButtonStyle())
        }
        .background(.black)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
      }
    }
    .listStyle(.inset)
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
