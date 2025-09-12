import UIKit

enum TabBarState: Identifiable, CaseIterable {
    var id: Self { self }
    
    case home
    case health
    case aviary
    case settings
    
    var title: String {
        switch self {
            case .home:
                "Home"
            case .health:
                "Health"
            case .aviary:
                "Aviary"
            case .settings:
                "Settings"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .home:
                    .Images.TabBar.home
            case .health:
                    .Images.TabBar.health
            case .aviary:
                    .Images.TabBar.aviary
            case .settings:
                    .Images.TabBar.settings
        }
    }
}
