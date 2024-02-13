import SwiftUI
import ClientApi

struct SearchCellView: View {
  var item: CompendiumContentResponseModel
  
  var body: some View {
    HStack(alignment: .top, spacing: 10) {
      if let url = item.illustration.url, let urlString = url.appendingResolution(.small)?.absoluteString {
        AsyncImage(url: URL(string: urlString)) { image in
          image.resizable()
        } placeholder: {
          Theme.gray400
        }
        .frame(width: 80, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 10))
      }
      
      VStack(alignment: .leading, spacing: 0) {
        Text(item.name)
          .font(.headline)
          .foregroundColor(Theme.gray50)
        
        Text(item.description)
          .font(.subheadline)
          .lineLimit(2)
          .foregroundColor(Theme.gray200)
        
        HStack {
          Text("Challenge Rating: \(String(item.challengeRating ?? "0"))")
          Text("Hit Points: \(String(item.hitPoints ?? 0))")
        }
        .font(.caption)
        .foregroundColor(Theme.orange600)
        .padding(.top, 4)
      }
    }
    .padding(.vertical, 5)
    .background(Theme.gray950)
  }
}
