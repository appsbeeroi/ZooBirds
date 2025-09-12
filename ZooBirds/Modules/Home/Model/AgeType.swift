enum AgeType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case oneYear
    case oneToTHreeYear
    case upperThreeYear
    
    var title: String {
        switch self {
            case .oneYear:
                "1 Year"
            case .oneToTHreeYear:
                "1-3 Years"
            case .upperThreeYear:
                "> 3 Years"
        }
    }
}
