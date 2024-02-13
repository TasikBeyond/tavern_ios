import Foundation
import Combine
import ClientApi
import Sentry

class SearchViewModel: ObservableObject {
  @Published var searchText = ""
  @Published var compendiumResults: [CompendiumContentResponseModel] = []
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    $searchText
      .removeDuplicates()
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .sink { [weak self] searchTerm in
        self?.fetchItems(searchTerm: searchTerm)
      }
      .store(in: &cancellables)
  }
  
  private func fetchItems(searchTerm: String) {
    let searchRequest = CompendiumSearchRequest(searchQuery: searchTerm)

    Pigeon.CompendiumApi.postSearch(request: searchRequest, success: {data in
      self.compendiumResults = data.content
    }, failure: {error in
      print(error)
    })
  }
}

