enum BirdStatus: Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case display
    case quarantine
    case aviary
    
    var title: String {
        switch self {
            case .display:
                "On display"
            case .quarantine:
                "In quarantine"
            case .aviary:
                "In aviary"
        }
    }
    
    var icon: String {
        switch self {
            case .display:
                "eye.fill"
            case .quarantine:
                "exclamationmark.shield.fill"
            case .aviary:
                "house"
        }
    }
}
