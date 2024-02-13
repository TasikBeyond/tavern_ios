import Foundation

extension URL {
  func appendingResolution(_ resolution: ImageResolution) -> URL? {
    guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
      return nil
    }
    

    var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
    queryItems.append(URLQueryItem(name: "resolution", value: resolution.rawValue))
    urlComponents.queryItems = queryItems
    return urlComponents.url
  }
}


enum ImageResolution: String {
  case large = "1024x1024"
  case medium = "512x512"
  case small = "256x256"
  case extraSmall = "128x128"
  case tiny = "64x64"
  case icon = "32x32"
  
  var queryParameter: String {
    return "resolution=\(self.rawValue)"
  }
}
