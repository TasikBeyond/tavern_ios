import Foundation

public struct CompendiumSearchRequest: Codable {
  public var searchQuery: String
  public var randomize: Bool = false
  public var edition: String = "All"
  public var challengeRating: String = "All"
  
  public init(searchQuery: String, randomize: Bool = false) {
    self.searchQuery = searchQuery
    self.randomize = randomize
  }
  
  public init(searchQuery: String) {
    self.searchQuery = searchQuery
    self.randomize = false
  }
  
  public init(randomize: Bool = false) {
    self.searchQuery = ""
    self.randomize = randomize
  }
}

func convertToDictionary<T: Codable>(_ object: T) -> [String: Any]? {
  do {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    let data = try encoder.encode(object)
    let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    return dictionary
  } catch {
    print("Error during conversion: \(error)")
    return nil
  }
}
