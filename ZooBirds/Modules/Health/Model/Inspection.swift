import Foundation

struct Inspection: Codable, Identifiable, Equatable {
    let id: UUID
    var date: Date
    var vet: String
    var procedure: String
    var notes: String
    var birdIDs: [UUID] = []
    
    var isLock: Bool {
        vet == "" || procedure == ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.date = Date()
        self.vet = isMock ? "Dr. Smith" : ""
        self.procedure = isMock ? "Check-up" : ""
        self.notes = isMock ? "Note" : ""
    }
}
