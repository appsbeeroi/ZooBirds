enum Frequancy: Identifiable, CaseIterable, Equatable, Codable {
    var id: Self { self }
    
    case daily
    case every2days
    case every3days
    case twiceAWeek
    case weekly
    case every10days
    case asNeeded
    
    var title: String {
        switch self {
            case .daily:
                "Daily"
            case .every2days:
                "Every 2 days"
            case .every3days:
                "Every 3 days"
            case .twiceAWeek:
                "Twinces a week"
            case .weekly:
                "Weekly"
            case .every10days:
                "Every 10 days"
            case .asNeeded:
                "As needed"
        }
    }
}
