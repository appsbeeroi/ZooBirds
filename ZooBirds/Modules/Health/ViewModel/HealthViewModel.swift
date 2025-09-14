import SwiftUI

final class HealthViewModel: ObservableObject {
    
    private let imageManager = ImageManager.shared
    private let userDefaultsService = UserDefaultsService.shared
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var inspections: [Inspection] = []
    @Published private(set) var vaccinations: [Vaccination] = []
    @Published private(set) var diets: [Diet] = []
    
    private(set) var birds: [Bird] = []
    
    func loadData() {
        loadBirds()
        loadHealhts()
    }
    
    func save(_ inspection: Inspection) {
        Task {
            var inspections = userDefaultsService.get([Inspection].self, for: .inspection) ?? []
            
            if let index = inspections.firstIndex(where: { $0.id == inspection.id }) {
                inspections[index] = inspection
            } else {
                inspections.append(inspection)
            }
            
            userDefaultsService.set(inspections, for: .inspection)
            
            await MainActor.run {
                if let index = self.inspections.firstIndex(where: { $0.id == inspection.id }) {
                    self.inspections[index] = inspection
                } else {
                    self.inspections.append(inspection)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    func save(_ vaccination: Vaccination) {
        Task {
            var vaccinations = userDefaultsService.get([Vaccination].self, for: .vaccination) ?? []
            
            if let index = vaccinations.firstIndex(where: { $0.id == vaccination.id }) {
                vaccinations[index] = vaccination
            } else {
                vaccinations.append(vaccination)
            }
            
            userDefaultsService.set(vaccinations, for: .vaccination)
            
            await MainActor.run {
                if let index = self.vaccinations.firstIndex(where: { $0.id == vaccination.id }) {
                    self.vaccinations[index] = vaccination
                } else {
                    self.vaccinations.append(vaccination)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    func save(_ diet: Diet) {
        Task {
            var diets = userDefaultsService.get([Diet].self, for: .diets) ?? []
            
            if let index = diets.firstIndex(where: { $0.id == diet.id }) {
                diets[index] = diet
            } else {
                diets.append(diet)
            }
            
            userDefaultsService.set(diets, for: .diets)
            
            await MainActor.run {
                if let index = self.diets.firstIndex(where: { $0.id == diet.id }) {
                    self.diets[index] = diet
                } else {
                    self.diets.append(diet)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    func remove(_ inspection: Inspection) {
        Task {
            var inspections = userDefaultsService.get([Inspection].self, for: .inspection) ?? []
            
            if let index = inspections.firstIndex(where: { $0.id == inspection.id }) {
                inspections.remove(at: index)
            }
            
            await imageManager.removeImage(for: inspection.id)
            
            userDefaultsService.set(inspections, for: .inspection)
            
            await MainActor.run {
                if let index = self.inspections.firstIndex(where: { $0.id == inspection.id }) {
                    self.inspections.remove(at: index)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    func remove(_ vaccination: Vaccination) {
        Task {
            var vaccinations = userDefaultsService.get([Vaccination].self, for: .vaccination) ?? []
            
            if let index = vaccinations.firstIndex(where: { $0.id == vaccination.id }) {
                vaccinations.remove(at: index)
            }
            
            await imageManager.removeImage(for: vaccination.id)
            
            userDefaultsService.set(vaccinations, for: .vaccination)
            
            await MainActor.run {
                if let index = self.inspections.firstIndex(where: { $0.id == vaccination.id }) {
                    self.vaccinations.remove(at: index)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    func remove(_ diet: Diet) {
        Task {
            var diets = userDefaultsService.get([Diet].self, for: .diets) ?? []
            
            if let index = diets.firstIndex(where: { $0.id == diet.id }) {
                diets.remove(at: index)
            }
            
            await imageManager.removeImage(for: diet.id)
            
            userDefaultsService.set(diets, for: .diets)
            
            await MainActor.run {
                if let index = self.diets.firstIndex(where: { $0.id == diet.id }) {
                    self.diets.remove(at: index)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    private func loadBirds() {
        Task {
            guard let birds = userDefaultsService.get([BirdUD].self, for: .bird) else { return }
            
            let result = await withTaskGroup(of: Bird?.self) { group in
                for bird in birds {
                    group.addTask {
                        guard let image = await self.imageManager.retrieve(fileNamed: bird.id.uuidString) else { return nil }
                        let birdModel = Bird(from: bird, and: image, aviaries: [])
                        
                        return birdModel
                    }
                }
                
                var newBird: [Bird?] = []
                
                for await bird in group {
                    newBird.append(bird)
                }
                
                return newBird.compactMap { $0 }
            }
            
            loadHealhts()
            
            await MainActor.run {
                self.birds = result.sorted { $0.name < $1.name }
            }
        }
    }
    
    private func loadHealhts() {
        Task {
            let inspections = userDefaultsService.get([Inspection].self, for: .inspection) ?? []
            let vaccination = userDefaultsService.get([Vaccination].self, for: .vaccination) ?? []
            let diets = userDefaultsService.get([Diet].self, for: .diets) ?? []
            
            await MainActor.run {
                self.inspections = inspections
                self.vaccinations = vaccination
                self.diets = diets
            }
        }
    }
}
