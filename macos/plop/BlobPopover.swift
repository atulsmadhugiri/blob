import SwiftUI

struct BlobPopover: View {
  @State var uploadProgress = 1.0

  var body: some View {
    VStack {
      HStack {
        Button(action: {}) { ScreenshotButton() }
        Button(action: {}) { UploadButton() }
      }
      if #available(macOS 11.0, *) {
        ProgressView("", value: uploadProgress, total: 1.0).padding(.horizontal, 20)
      }
    }.padding(.all, 20)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BlobPopover()
  }
}
