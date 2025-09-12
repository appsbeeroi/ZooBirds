import UIKit

enum Gender: Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case male
    case female
    
    var title: String {
        switch self {
            case .male:
                "Male"
            case .female:
                "Female"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .male:
                    .Images.Icons.male
            case .female:
                    .Images.Icons.female
        }
    }
}
