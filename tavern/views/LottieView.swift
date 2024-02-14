import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
  
  var animationFileName: String
  let loopMode: LottieLoopMode
  
  func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
    
  }
  
  func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
    let view = UIView(frame: .zero)
    let animationView = LottieAnimationView(name: animationFileName)

    animationView.loopMode = loopMode
    animationView.play()
    animationView.contentMode = .scaleAspectFit
    
    animationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(animationView)
    
    NSLayoutConstraint.activate([
      animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
      animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
    
    return view
  }
}
