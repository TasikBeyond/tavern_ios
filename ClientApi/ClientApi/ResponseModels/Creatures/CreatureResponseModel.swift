import Foundation

public struct CreatureResponseModel: Codable, Identifiable {
  public var id: UUID
  public var userId: UUID
  public var edition: String
  public var identity: CreatureIdentityResponseModel
  public var attributes: CreatureAttributeResponseModel?
  public var illustrations: [IllustrationResponseModel]? = []
}
