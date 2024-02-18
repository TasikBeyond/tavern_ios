
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
    case creaturePdf = "/api/creatures/{creature_id}/pdf"
    case creatureWeb = "/creature?creature_id={creature_id}"
    
    public func url() -> String {
      let baseUrl = Pigeon.shared.host ?? "https://tavernofazoth.com"
      return "\(baseUrl)\(rawValue)"
    }
  }
  
  enum CreatureRoutes {
    case pdf, web
  }
  
  static func creatureRoute(route: CreatureRoutes, creatureId: UUID) -> URL {
    let baseUrl = Pigeon.shared.host ?? "https://tavernofazoth.com"
    switch route {
    case .pdf:
      return URL(string: "\(baseUrl)/api/creatures/\(creatureId)/pdf")!
    case .web:
      return URL(string: "\(baseUrl)/creature?creature_id=\(creatureId)")!
    }
  }
}
