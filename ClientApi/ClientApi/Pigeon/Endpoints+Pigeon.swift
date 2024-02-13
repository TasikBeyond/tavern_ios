
import Foundation

public extension Pigeon {
  enum Method: String {
    case post = "POST"
    case patch = "PATCH"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
  }
  
  enum Endpoint: String {
    case compendiumSearch = "/api/compendium/search"
    case creature = "/api/creatures/{creature_id}"
    
    func url() -> String {
      let baseUrl = Pigeon.shared.host ?? "https://tavernofazoth.com"
      return "\(baseUrl)\(rawValue)"
    }
  }
}
