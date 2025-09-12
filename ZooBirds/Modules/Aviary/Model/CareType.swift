enum CareType: Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case cleaning
    case feeding
    case maintenance
    
    var title: String {
        switch self {
            case .cleaning:
                "Cleaning"
            case .feeding:
                "Feeding"
            case .maintenance:
                "Maintenance"
        }
    }
}



