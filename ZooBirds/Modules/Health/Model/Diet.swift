import Foundation

struct Diet: Codable, Identifiable, Equatable {
    let id: UUID
    var date: Date
    var foodType: String
    var quontity: String
    var notes: String
    var birdIDs: [UUID] = []
    
    var isLock: Bool {
        foodType == "" || quontity == ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.date = Date()
        self.foodType = isMock ? "Baguete" : ""
        self.quontity = isMock ? "100" : ""
        self.notes = isMock ? "Note" : ""
    }
}
