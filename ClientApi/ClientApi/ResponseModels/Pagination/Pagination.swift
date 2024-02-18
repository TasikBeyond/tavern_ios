import Foundation

public struct Pagination: Codable {
  public var totalItems: Int
  public var rangeStart: Int
  public var rangeEnd: Int
  public var nextUrl: URL?
  public var previousUrl: URL?
}
