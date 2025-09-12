import UIKit

struct Bird: Identifiable, Equatable {
    let id: UUID
    var image: UIImage?
    var nameID: String
    var name: String
    var species: String
    var gender: Gender?
    var age: String
    var status: BirdStatus?
    var aviaries: [Date: Aviary] = [:]
    
    var isLock: Bool {
        self.image == nil || self.nameID == "" || self.name == "" || self.species == "" || self.age == "" || self.gender == nil || self.status == nil
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.nameID = isMock ? "SD-333-PO" : ""
        self.name = isMock ? "Sally D" : ""
        self.species = isMock ? "African Grey Parrot" : ""
        self.age = isMock ? "1" : ""
        self.gender = isMock ? .female : nil
        self.status = isMock ? .aviary : nil
        self.aviaries = isMock ? [Date(): Aviary(isMock: true)] : [:]
    }
    
    init(from ud: BirdUD, and image: UIImage, aviaries: [Aviary]) {
        self.id = ud.id
        self.image = image
        self.nameID = ud.nameID
        self.name = ud.name
        self.species = ud.species
        self.age = ud.age
        self.gender = ud.gender
        self.status = ud.status
        
        ud.aviaries.forEach { aviary in
            guard let image = aviaries.first(where: { $0.id == aviary.value.id })?.image else { return }
            self.aviaries[aviary.key] = Aviary(from: aviary.value, and: image)
        }
    }
}
