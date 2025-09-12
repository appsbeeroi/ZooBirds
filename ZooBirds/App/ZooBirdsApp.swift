import SwiftUI

@main
struct ZooBirdsApp: App {
    
    @State private var isMainFlow = true
    
    var body: some Scene {
        WindowGroup {
            if isMainFlow {
                TabBarView()
            } else {
                SplashScreen(isMainFlow: $isMainFlow)
            }
        }
    }
}
