import SwiftUI
import ClientApi

struct CreatureDetailsPortraitView: View {
  var creature: CreatureResponseModel
  
  var body: some View {
    VStack {
      if let url = creature.illustrations?.first?.url, let urlString = url.appendingResolution(.medium)?.absoluteString {
        AsyncImage(url: URL(string: urlString)) { image in
          image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        } placeholder: {
          ProgressView()
        }
      } else {
        Text("No Image Available")
          .frame(maxWidth: .infinity)
      }
    }
  }
}
