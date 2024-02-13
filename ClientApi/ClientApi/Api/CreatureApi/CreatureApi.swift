import Foundation
import UIKit

public extension Pigeon {
  typealias CreatureResponseSuccess = (_ data: CreatureResponseModel) -> Void
  
  struct CreatureApi {
    public static func getCreatureById(creatureId: UUID, success: @escaping CreatureResponseSuccess, failure: @escaping Failure) {
      
      let parameters = [
        "creature_id": "\(creatureId)",
      ]
      
      Pigeon.request(method: .get, endpoint: .creature, pathParameters: parameters, success: { data in
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .customIso8601
        
        do {
          let response = try decoder.decode(CreatureResponseModel.self, from: data)
          success(response)
        } catch {
          return fail(error: String(describing: error), code: 400, failure: failure)
        }
      }, failure: { error in
        failure(error)
      })
    }
  }
}

