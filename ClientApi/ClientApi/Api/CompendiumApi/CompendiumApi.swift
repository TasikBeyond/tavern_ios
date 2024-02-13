import Foundation
import UIKit

public extension Pigeon {
  typealias CompendiumSearchResponseSuccess = (_ data: CompendiumSearchResponseModel) -> Void
  
  struct CompendiumApi {
    public static func postSearch(request: CompendiumSearchRequest, success: @escaping CompendiumSearchResponseSuccess, failure: @escaping Failure) {
      
      guard let jsonData = convertToDictionary(request) else {
        print("Unable to convert Request")
        return
      }

      Pigeon.request(method: .post, endpoint: .compendiumSearch, parameters: jsonData, success: { data in
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .customIso8601
        
        do {
          let response = try decoder.decode(CompendiumSearchResponseModel.self, from: data)
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

