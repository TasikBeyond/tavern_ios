import SwiftUI
import WebKit

public struct PdfViewContainer: View {
  @Binding var showingPdf: Bool
  @State var sharePdf = false
  let title: String
  let pdfUrl: URL
  
  public var body: some View {
    NavigationView {
      PdfWebView(url: pdfUrl)
        .navigationBarTitle(title, displayMode: .inline)
        .navigationBarItems(leading: Button("Dismiss") {
          showingPdf = false
        }, trailing: Button(action: {
          sharePdf = true
        }) {
          Image(systemName: SystemIcon.downloadPdf)
            .imageScale(.large)
        })
        .sheet(isPresented: $sharePdf) {
          ShareSheet(activityItems: [pdfUrl])
        }
    }
  }
}

struct PdfWebView: UIViewRepresentable {
  var url: URL
  
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    let request = URLRequest(url: url)
    uiView.load(request)
  }
}

struct ShareSheet: UIViewControllerRepresentable {
  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {}
}
