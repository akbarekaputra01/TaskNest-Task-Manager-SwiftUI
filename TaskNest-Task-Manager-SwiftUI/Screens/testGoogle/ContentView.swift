import Firebase
import SwiftUI

struct ContentView2: View {
  @State private var userLoggedIn = (Auth.auth().currentUser != nil)

  var body: some View {
    VStack {
      if userLoggedIn {
        Home()
      } else {
        Login()
      }
    }.onAppear {
      //Firebase state change listeneer
      Auth.auth().addStateDidChangeListener { auth, user in
        if user != nil {
          userLoggedIn = true
        } else {
          userLoggedIn = false
        }
      }
    }
  }
}
