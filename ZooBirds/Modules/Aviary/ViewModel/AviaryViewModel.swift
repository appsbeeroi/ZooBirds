import UIKit

final class AviaryViewModel: ObservableObject {
    
    private let imageManager = ImageManager.shared
    private let userDefaultsService = UserDefaultsService.shared
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var aviaries: [Aviary] = []
    
    func loadAviaries() {
        Task {
            guard let aviaries = userDefaultsService.get([AviaryUD].self, for: .aviary) else { return }
            
            let result = await withTaskGroup(of: Aviary?.self) { group in
                for aviary in aviaries {
                    group.addTask {
                        guard let image = await self.imageManager.retrieve(fileNamed: aviary.id.uuidString) else { return nil }
                        let aviaryModel = Aviary(from: aviary, and: image)
                        
                        return aviaryModel
                    }
                }
                
                var newAviaries: [Aviary?] = []
                
                for await aviary in group {
                    newAviaries.append(aviary)
                }
                
                return newAviaries.compactMap { $0 }
            }
            
            await MainActor.run {
                self.aviaries = result.sorted { $0.name < $1.name}
            }
        }
    }
    
    func save(_ aviary: Aviary) {
        Task {
            guard let image = aviary.image,
                  let compressedImage = image.compressedImage(quality: 0.1),
                  let imagePath = await imageManager.store(image: compressedImage, for: aviary.id) else { return }
            
            var udModels = userDefaultsService.get([AviaryUD].self, for: .aviary) ?? []
            
            let udModel = AviaryUD(from: aviary, and: imagePath)
            
            if let index = udModels.firstIndex(where: { $0.id == aviary.id }) {
                udModels[index] = udModel
            } else {
                udModels.append(udModel)
            }
            
            userDefaultsService.set(udModels, for: .aviary)
            
            await MainActor.run {
                var newAviary = aviary
                newAviary.image = compressedImage
                
                if let index = aviaries.firstIndex(where: { $0.id == aviary.id }) {
                    self.aviaries[index] = newAviary
                } else {
                    self.aviaries.append(newAviary)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    func remove(_ aviary: Aviary) {
        Task {
            guard var udModels = userDefaultsService.get([AviaryUD].self, for: .aviary),
                  let index = udModels.firstIndex(where: { $0.id == aviary.id }) else { return }
            
            await imageManager.removeImage(for: aviary.id)
            
            udModels.remove(at: index)
            
            userDefaultsService.set(udModels, for: .aviary)
            
            await MainActor.run {
                if let index = aviaries.firstIndex(where: { $0.id == aviary.id }) {
                    self.aviaries.remove(at: index)
                }
                
                self.isCloseNavigation = true 
            }
        }
    }
}
