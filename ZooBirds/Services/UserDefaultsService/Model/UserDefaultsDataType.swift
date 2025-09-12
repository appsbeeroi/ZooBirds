import Foundation

enum UserDefaultsDataType {
    case bird
    case aviary
    
    var key: String {
        switch self {
            case .bird:
                "Bird"
            case .aviary:
                "Aviary"
        }
    }
}
