import Foundation

public struct CompendiumSearchResponseModel: Codable {
  public var content: [CompendiumContentResponseModel]
  public var pagination: Pagination?
}
