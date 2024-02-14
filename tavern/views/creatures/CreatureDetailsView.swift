import SwiftUI
import ClientApi

struct CreatureDetailsView: View {
  @ObservedObject var viewModel: CreatureDetailsViewModel
  
  var body: some View {
    ScrollView {
      VStack {
        if let creature = viewModel.creature {
          CreatureDetailsPortraitView(creature: creature)
          CreatureDetailsInfoView(creature: creature)
          CreatureDetailsAttributesView(creature: creature)
          CreatureDetailsMainView(creature: creature)
          CreatureDetailsActionsView(actions: creature.actions, actionType: "Actions")
          CreatureDetailsActionsView(actions: creature.legendaryActions, actionType: "Legendary")
          CreatureDetailsActionsView(actions: creature.reactions, actionType: "Reactions")
        } else {
          LottieView(animationFileName: "loading-circle", loopMode: .loop)
            .frame(width: 80, height: 80)
            .background(Color.clear)
            .padding(.vertical, 100)
        }
      }
    }
    .navigationTitle(viewModel.content.name)
  }
}
