import Foundation

struct AviaryCare: Identifiable, Equatable, Codable {
    let id: UUID
    var time: Date
    var type: CareType?
    var frequancy: Frequancy?
    var note: String
    
    var isLock: Bool {
        type == nil || frequancy == nil
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.time = Date()
        self.type = isMock ? .cleaning : nil
        self.frequancy = isMock ? .asNeeded : nil
        self.note = isMock ? "Mock note" : ""
    }
}
