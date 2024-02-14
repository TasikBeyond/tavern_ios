import SwiftUI
import ClientApi

struct CreatureDetailsInfoView: View {
  var creature: CreatureResponseModel
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(creature.identity.name ?? "Unknown Name")
          .font(.headline)
          .padding(.leading)
        
        Spacer()
        
        Text(creature.edition)
          .font(.headline)
          .padding(.horizontal, 5)
          .background(Theme.blue600)
          .foregroundColor(.white)
          .cornerRadius(10)
          .padding(.trailing)
      }
      
      if let race = creature.identity.race {
        Text("Race: \(race)")
          .font(.subheadline)
          .padding(.leading)
      }
      
      if let creatureClass = creature.identity.class {
        Text("Class: \(creatureClass)")
          .font(.subheadline)
          .padding(.leading)
      }
      
      Text("Alignment: \(creature.identity.alignment ?? "Unknown")")
        .font(.subheadline)
        .padding(.leading)
      
      Divider()
        .background(Color.white)
        .padding([.top, .leading, .trailing])
    }
    .padding(.top)
  }
}
