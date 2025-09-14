import Foundation

enum SettingsCellType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case notification
    case aboutApplication
    case privacy
    
    var title: String {
        switch self {
            case .notification:
                return "Notifications"
            case .aboutApplication:
                return "About the Application"
            case .privacy:
                return "Privacy Policy"
        }
    }
    
    var path: String {
        switch self {
            case .aboutApplication:
                "https://sites.google.com/view/zoo-birds/home"
            case .privacy:
                "https://sites.google.com/view/zoo-birds/privacy-policy"
            default:
                ""
        }
    }
}
