import FirebaseCore
import HotKey
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var statusBar: StatusBar?
  var popover = NSPopover()
  var blobGlobalState = BlobGlobalState()

  var screenshotHotKey = HotKey(key: .z, modifiers: [.command, .shift])
  var uploadHotKey = HotKey(key: .u, modifiers: [.command, .shift])

  func applicationDidFinishLaunching(_: Notification) {
    FirebaseApp.configure()
    configureScreenshotHotKey()
    configureUploadHotKey()

    // We use NSPopover in place of NSWindow so icon appears in menubar.
    // Credit: Anagh Sharma (https://github.com/AnaghSharma)
    let contentView = BlobPopover(blobGlobalState: blobGlobalState)
    popover.contentSize = NSSize(width: 360, height: 360)
    popover.contentViewController = NSHostingController(rootView: contentView)
    popover.animates = false
    popover.behavior = NSPopover.Behavior.transient

    statusBar = StatusBar(popover)
  }

  func configureScreenshotHotKey() {
    screenshotHotKey.keyDownHandler = {
      NSApp.activate(ignoringOtherApps: true)
      print("Screenshot HotKey keyDown event detected.")
    }
  }

  func configureUploadHotKey() {
    uploadHotKey.keyDownHandler = {
      NSApp.activate(ignoringOtherApps: true)
      print("Upload HotKey keyDown event detected.")
    }
  }
}
