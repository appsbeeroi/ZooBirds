import Foundation

enum UserDefaultsDataType {
    case bird
    case aviary
    case inspection
    case vaccination
    case diets
    
    var key: String {
        switch self {
            case .bird:
                "Bird"
            case .aviary:
                "Aviary"
            case .inspection:
                "Inspection"
            case .vaccination:
                "Vaccination"
            case .diets:
                "Diets"
        }
    }
}
