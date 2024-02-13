import SwiftUI
import ClientApi

struct CreatureDetailsView: View {
  var viewModel: CreatureDetailsViewModel
  
  var body: some View {
    VStack {
      LottieView(animationFileName: "loading-circle", loopMode: .loop)
        .frame(width: 200, height: 200)
      Text(viewModel.content.name)
        .navigationTitle(viewModel.content.name)
    }
  }
}
