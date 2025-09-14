import Foundation

struct Vaccination: Codable, Identifiable, Equatable {
    let id: UUID
    var date: Date
    var vaccine: String
    var notes: String
    var birdIDs: [UUID] = []
    
    var isLock: Bool {
        vaccine == ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.date = Date()
        self.vaccine = isMock ? "Vaccine" : ""
        self.notes = isMock ? "Note" : ""
    }
}
