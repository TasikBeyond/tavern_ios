import SwiftUI
import ClientApi
import Kingfisher

struct SearchCellView: View {
  var item: CompendiumContentResponseModel
  
  var body: some View {
    HStack(alignment: .top, spacing: 10) {
      if let url = item.illustration.url, let urlString = url.appendingResolution(.small)?.absoluteString {
        KFImage(URL(string: urlString))
          .resizable()
          .scaledToFit()
          .frame(width: 80, height: 80)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
      
      VStack(alignment: .leading, spacing: 0) {
        HStack {
          Text(item.name)
            .font(.headline)
            .foregroundColor(Theme.gray50)
          
          Spacer()
          
          Text(item.edition)
            .font(.footnote)
            .padding(.horizontal, 4)
            .background(Theme.blue600)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.trailing)
        }

        
        Text(item.description)
          .font(.subheadline)
          .lineLimit(2)
          .foregroundColor(Theme.gray200)
        
        HStack {
          Text("Challenge Rating: ")
            .foregroundColor(Theme.gray400) +
          Text("\(String(item.challengeRating ?? "0"))")
            .foregroundColor(Theme.blue600)
            .bold()
          
          Text("Hit Points: ")
            .foregroundColor(Theme.gray400) +
          Text("\(String(item.hitPoints ?? 0))")
            .foregroundColor(Theme.red600)
            .bold()
        }
        .font(.caption)
        .foregroundColor(Theme.orange600)
        .padding(.top, 4)
      }
      .frame(
        minWidth: 0,
        maxWidth: .infinity,
        minHeight: 0,
        maxHeight: .infinity,
        alignment: .topLeading
      )
    }
    .background(.black)
    .padding(.vertical, 5)
  }
}
