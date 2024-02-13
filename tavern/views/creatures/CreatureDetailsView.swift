import SwiftUI
import ClientApi

struct CreatureDetailsView: View {
  var viewModel: CreatureDetailsViewModel
  
  var body: some View {
    Text(viewModel.content.name)
      .navigationTitle(viewModel.content.name)
  }
}
