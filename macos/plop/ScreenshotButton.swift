import SwiftUI

struct ScreenshotButton: View {
  @Binding var previousUploadURL: String
  @Binding var previousUploadLocalPath: URL?
  @Binding var uploadProgress: Double

  var body: some View {
    Button(action: {
      let filepath = captureScreenshot()
      let (destinationURL, uploadTask, localPath) = uploadBlob(filepath: filepath)

      uploadTask.observe(.progress) { snapshot in
        uploadProgress = snapshot.progress?.fractionCompleted ?? 0
      }
      uploadTask.observe(.success) { _ in
        NSSound(named: "Funk")?.play()
        replaceClipboard(with: destinationURL)
        previousUploadURL = destinationURL
        previousUploadLocalPath = localPath
      }
    }) {
      Text("Screenshot (")
      Image(systemName: "command")
      Image(systemName: "shift")
      Text("Z )")
    }
  }
}

struct ScreenshotButton_Previews: PreviewProvider {
  static var previews: some View {
    ScreenshotButton(
      previousUploadURL: .constant("https://google.com"), previousUploadLocalPath: .constant(nil),
      uploadProgress: .constant(1.0))
  }
}
