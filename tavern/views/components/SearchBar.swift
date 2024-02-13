import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  
  var body: some View {
    TextField("Search...", text: $text)
      .padding(7)
      .background(Theme.gray900)
      .foregroundColor(Theme.gray50)
      .cornerRadius(8)
      .frame(maxWidth: .infinity)
  }
}
