import SwiftUI
import ClientApi

struct CreatureDetailsView: View {
  @ObservedObject var viewModel: CreatureDetailsViewModel
  @State var showingPdf: Bool = false
  
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
          LottieView(animationFileName: Animation.loadingCircle, loopMode: .loop)
            .frame(width: 80, height: 80)
            .background(Color.clear)
            .padding(.vertical, 100)
        }
      }
    }
    .navigationTitle(viewModel.content.name)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Menu {
          Button(action: { showingPdf = true } ) {
            Label("View PDF", systemImage: SystemIcon.viewPdf)
          }
          .padding()
        } label: {
          Image(systemName: SystemIcon.hambergurMenu)
        }
      }
    }
    .sheet(isPresented: $showingPdf) {
      PdfViewContainer(showingPdf: $showingPdf, title: viewModel.content.name, pdfUrl: viewModel.creaturePdfUrl())
    }
  }
}
