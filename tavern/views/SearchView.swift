import SwiftUI

struct SearchView: View {
  @ObservedObject var viewModel = SearchViewModel()
  @State private var searchText = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        SearchBar(text: $searchText.onChange(performSearch))
          .padding([.leading, .trailing], 10)
        
        List(viewModel.compendiumResults) { item in
          HStack(alignment: .top, spacing: 10) {
            if let url = item.illustration.url, let urlString = url.appendingResolution(.small)?.absoluteString {
              AsyncImage(url: URL(string: urlString)) { image in
                image.resizable()
              } placeholder: {
                Color.gray
              }
              .frame(width: 80, height: 80)
              .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading, spacing: 0) {
              Text(item.name)
                .font(.headline)
              
              Text(item.description)
                .font(.subheadline)
                .lineLimit(2)
              
              HStack {
                Text("Challenge Rating: \(String(item.challengeRating ?? "0"))")
                Text("Hit Points: \(String(item.hitPoints ?? 0))")
              }
              .font(.caption)
              .padding(.top, 4)
            }
          }
          .padding(.vertical, 5)
        }
        .listStyle(PlainListStyle())
        .padding(.all, 0)
      }
    }
    .navigationTitle("Search") // Set the title for this view
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
