import Foundation

public struct CreatureActionResponseModel: Codable, Equatable {
  public var name: String
  public var description: String
  
  
  public static func ==(lhs: CreatureActionResponseModel, rhs: CreatureActionResponseModel) -> Bool {
    return lhs.name == rhs.name && lhs.description == rhs.description
  }
}
