import SwiftUI
import ClientApi

struct CreatureDetailsAttributesView: View {
  var creature: CreatureResponseModel
  
  var body: some View {
    VStack(alignment: .leading) {
      if let attributes = creature.attributes {
        HStack {
          AttributeView(attributeName: "STR", attributeValue: attributes.str)
          AttributeView(attributeName: "DEX", attributeValue: attributes.dex)
          AttributeView(attributeName: "CON", attributeValue: attributes.con)
          AttributeView(attributeName: "INT", attributeValue: attributes.int)
          AttributeView(attributeName: "WIS", attributeValue: attributes.wis)
          AttributeView(attributeName: "CHA", attributeValue: attributes.cha)
        }
        Divider()
          .background(Color.white)
          .padding([.leading, .trailing])
      }
    }
  }
}

struct AttributeView: View {
  let attributeName: String
  let attributeValue: String
  
  var body: some View {
    VStack {
      Text(attributeValue)
        .font(.system(size: 18, weight: .bold))
        .foregroundColor(.white)
      Text(attributeName)
        .font(.caption)
        .foregroundColor(.gray)
    }
    .padding()
    .background(Color.black.opacity(0.5))
    .cornerRadius(8)
  }
}
