import SwiftUI

struct SearchBar: View {
  @Binding var text: String
  var onDiceRoll: () -> Void

  // Animation Properties
  @State private var diceRotation = 0.0
  @State private var diceOffsetY: CGFloat = 0.0
  @State private var isAnimating = false
  
  var body: some View {
    HStack {
      TextField("Search...", text: $text)
        .padding(7)
        .background(Theme.gray900)
        .foregroundColor(Theme.gray50)
        .cornerRadius(8)
      
      Image("dice-d20-sharp-light")
        .resizable()
        .renderingMode(.template)
        .foregroundColor(Theme.blue600)
        .aspectRatio(contentMode: .fit)
        .frame(width: 24, height: 24)
        .offset(y: diceOffsetY)
        .rotation3DEffect(.degrees(diceRotation), axis: (x: 0, y: 0, z: 1))
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.6)) {
            self.diceRotation += 360
          }
          
          guard !isAnimating else { return }
          diceTumble()
        }
    }
    .frame(maxWidth: .infinity)
  }
  
  func diceTumble() {
    isAnimating = true
    
    withAnimation(.easeOut(duration: 0.15)) {
      diceOffsetY -= 5
    }
    withAnimation(.easeIn(duration: 0.15).delay(0.15)) {
      diceOffsetY += 5
    }
    withAnimation(.easeOut(duration: 0.1).delay(0.3)) {
      diceOffsetY -= 2
    }
    withAnimation(.easeIn(duration: 0.1).delay(0.4)) {
      diceOffsetY += 2
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
      isAnimating = false
      onDiceRoll()
    }
  }
}
