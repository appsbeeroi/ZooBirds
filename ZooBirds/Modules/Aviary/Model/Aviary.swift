import UIKit

struct Aviary: Identifiable, Equatable {
    let id: UUID
    var image: UIImage?
    var name: String
    var size: String
    var species: [String]
    var cares: [AviaryCare]
    
    var isLock: Bool {
        image == nil || name == "" || size == ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.name = isMock ? "Mock Aviary" : ""
        self.size = isMock ? "5x5" : ""
        self.species = isMock ? ["Parrot", "Hangry"] : []
        self.cares = isMock ? [.init(isMock: true)] : []
    }
    
    init(from ud: AviaryUD, and image: UIImage) {
        self.id = ud.id
        self.image = image
        self.name = ud.name
        self.size = ud.size
        self.species = ud.species
        self.cares = ud.cares
    }
}
