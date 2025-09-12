import Foundation

struct AviaryUD: Codable {
    var id: UUID
    var imagePath: String?
    var name: String
    var size: String
    var species: [String]
    var cares: [AviaryCare]
    
    init(from model: Aviary, and imagePath: String) {
        self.id = model.id
        self.imagePath = imagePath
        self.name = model.name
        self.size = model.size
        self.species = model.species
        self.cares = model.cares
    }
}
