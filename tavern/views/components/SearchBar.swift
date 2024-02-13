import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  
  var body: some View {
    TextField("Search...", text: $text)
      .padding(7)
      .background(Color(.systemGray6))
      .cornerRadius(8)
      .frame(maxWidth: .infinity)
  }
}
