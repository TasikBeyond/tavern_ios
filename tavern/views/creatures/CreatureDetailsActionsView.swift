import SwiftUI
import ClientApi

struct CreatureDetailsActionsView: View {
  var actions: [CreatureActionResponseModel]?
  var actionType: String
  
  var body: some View {
    VStack(alignment: .leading) {
      if let actions = actions, !actions.isEmpty {
        ForEach(actions, id: \.name) { action in
          VStack(alignment: .leading) {
            HStack {
              Text(action.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.leading)
              
              Spacer()
              
              if action == actions.first {
                Text(actionType)
                  .font(.callout)
                  .padding(.horizontal, 5)
                  .background(Theme.orange600)
                  .foregroundColor(Theme.gray200)
                  .cornerRadius(10)
                  .padding(.trailing)
              }
            }
                        
            Text(action.description)
              .font(.body)
              .foregroundColor(Theme.gray300)
              .padding(.horizontal)
            
            if action != actions.last {
              Spacer(minLength: 16)
            }
          }
          
        }
        Divider()
          .background(Color.white)
          .padding([.top, .leading, .trailing])
      }
    }
    .padding(.top)
  }
}
