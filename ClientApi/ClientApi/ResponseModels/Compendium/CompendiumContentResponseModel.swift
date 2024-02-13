import Foundation

public struct CompendiumContentResponseModel: Codable, Identifiable {
  public var id: UUID
  public var userId: UUID?
  public var contentType: String
  public var name: String
  public var contentId: UUID?
  public var edition: String
  public var challengeRating: String?
  public var hitPoints: Int?
  public var description: String
  public var favoritesCount: Int
  public var illustration: IllustrationResponseModel
}
