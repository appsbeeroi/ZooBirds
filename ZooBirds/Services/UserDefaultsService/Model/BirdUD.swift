import Foundation

struct BirdUD: Codable {
    var id: UUID
    var imagePath: String
    var nameID: String
    var name: String
    var species: String
    var gender: Gender
    var age: String
    var status: BirdStatus
    var aviaries: [Date: AviaryUD] = [:]
    
    init(from model: Bird, and imagePath: String, aviaries: [(aviary: Aviary, imagePath: String, date: Date)] = []) {
        self.id = model.id
        self.imagePath = imagePath
        self.nameID = model.nameID
        self.name = model.name
        self.species = model.species
        self.gender = model.gender ?? .female
        self.age = model.age
        self.status = model.status ?? .aviary
        
        aviaries.forEach {
            self.aviaries[$0.date] = AviaryUD(from: $0.aviary, and: $0.imagePath)
        }
    }
}
