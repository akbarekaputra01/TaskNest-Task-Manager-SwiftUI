import Firebase
import GoogleSignIn
import SwiftUI

@main
struct ExampleApp: App {
  init() {
    // Firebase initialization
    FirebaseApp.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView2().onOpenURL { url in
        //Handle Google Oauth URL
        GIDSignIn.sharedInstance.handle(url)
      }
    }
  }
}
