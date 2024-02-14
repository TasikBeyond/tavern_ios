import SwiftUI
import ClientApi

struct CreatureDetailsMainView: View {
  var creature: CreatureResponseModel
  
  var body: some View {
    VStack(alignment: .leading) {
      if let hitPoints = creature.main.hitPoints {
        Text("HP: \(hitPoints)")
          .font(.subheadline)
          .padding(.leading)
      }
      
      if let armorClass = creature.main.armorClass {
        Text("AC: \(armorClass)")
          .font(.subheadline)
          .padding(.leading)
      }
            
      Divider()
        .background(Color.white)
        .padding([.top, .leading, .trailing])
    }
    .padding(.top)
  }
}
