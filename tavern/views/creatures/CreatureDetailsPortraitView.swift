import SwiftUI
import ClientApi
import Kingfisher

struct CreatureDetailsPortraitView: View {
  var creature: CreatureResponseModel
  
  var body: some View {
    VStack {
      if let url = creature.illustrations?.first?.url, let urlString = url.appendingResolution(.medium)?.absoluteString {
        KFImage(URL(string: urlString))
          .resizable()
          .scaledToFit()
          .frame(maxWidth: .infinity)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      } else {
        Text("No Image Available")
          .frame(maxWidth: .infinity)
      }
    }
  }
}
