import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Task {
            await NotificationCenterService.shared.requestPermission()
        }
        return true
    }
}

@main
struct ZooBirdsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var isMainFlow = false
    
    var body: some Scene {
        WindowGroup {
            if isMainFlow {
                TabBarView()
                    .transition(.opacity)
            } else {
                SplashScreen(isMainFlow: $isMainFlow)
            }
        }
    }
}
