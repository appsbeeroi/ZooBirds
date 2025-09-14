import UIKit

enum HealthActionType {
    case inspection
    case vaccination
    case diet
    
    var title: String {
        switch self {
            case .inspection:
                "Add review"
            case .vaccination:
                "Add vaccination"
            case .diet:
                "Add diet"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .inspection:
                    .Images.Health.inspection
            case .vaccination:
                    .Images.Health.vaccination
            case .diet:
                    .Images.Health.diet
        }
    }
}
