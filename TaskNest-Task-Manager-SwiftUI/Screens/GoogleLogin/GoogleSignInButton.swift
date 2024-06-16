import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        // Create Google Sign-In button
        let button = GIDSignInButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = viewController.view.center
        
        // Add button to view controller's view
        viewController.view.addSubview(button)
        
        // Return the view controller
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update code if needed
    }
    
    typealias UIViewControllerType = UIViewController
}
