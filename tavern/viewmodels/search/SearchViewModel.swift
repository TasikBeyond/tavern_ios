import Foundation
import Combine
import ClientApi
import Sentry

class SearchViewModel: ObservableObject {
  @Published var searchText = ""
  @Published var compendiumResults: [CompendiumContentResponseModel] = []
  @Published var currentPagination: Pagination? = nil
  @Published var isLoading = true
  @Published var failureMessage: String? = nil

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

    isLoading = true
    failureMessage = nil
    Pigeon.CompendiumApi.postSearch(request: searchRequest, success: {data in
      self.isLoading = false
      self.compendiumResults = data.content
      self.currentPagination = data.pagination
    }, failure: {error in
      self.isLoading = false
      self.failureMessage = "Unable to preform search. Please try again."
      print(error)
    })
  }
  
  private func fetchNextItems(nextUrl: URL) {
    isLoading = true
    failureMessage = nil
    Pigeon.CompendiumApi.postSearch(url: nextUrl, success: {data in
      self.isLoading = false
      self.compendiumResults.append(contentsOf: data.content)
      self.currentPagination = data.pagination
    }, failure: {error in
      self.isLoading = false
      self.failureMessage = "Unable to preform search. Please try again."
      print(error)
    })
  }
  
  func fetchNextPageIfNeeded(currentItem item: CompendiumContentResponseModel) {
    guard !isLoading else {
      return
    }
    guard let nextUrl = currentPagination?.nextUrl else {
      return
    }
    
    let thresholdIndex = compendiumResults.index(compendiumResults.endIndex, offsetBy: -5)
    if compendiumResults.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      fetchNextItems(nextUrl: nextUrl)
    }
  }
  
  func fetchRandomizedItems() {
    let searchRequest = CompendiumSearchRequest(randomize: true)
    
    isLoading = true
    failureMessage = nil
    Pigeon.CompendiumApi.postSearch(request: searchRequest, success: {data in
      self.isLoading = false
      self.compendiumResults = data.content
      self.currentPagination = data.pagination
    }, failure: {error in
      self.isLoading = false
      self.failureMessage = "Unable to preform search. Please try again."
      print(error)
    })
  }
}

