import UIKit
import Combine

final class HomeViewModel: ObservableObject {
    
    private let imageManager = ImageManager.shared
    private let userDefaultsService = UserDefaultsService.shared
    
    @Published var filter = FilterModel()
    @Published var filterText = ""
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var birds: [Bird] = []
    
    private(set) var aviaries: [Aviary] = []
    private(set) var baseBirds: [Bird] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        observeFilterModel()
    }
    
    func loadBirds() {
        Task {
            await loadAviaries()
            
            guard let birds = userDefaultsService.get([BirdUD].self, for: .bird) else { return }
            
            let result = await withTaskGroup(of: Bird?.self) { group in
                for bird in birds {
                    group.addTask {
                        guard let image = await self.imageManager.retrieve(fileNamed: bird.id.uuidString) else { return nil }
                        let birdModel = Bird(from: bird, and: image, aviaries: self.aviaries)
                        
                        return birdModel
                    }
                }
                
                var newBird: [Bird?] = []
                
                for await bird in group {
                    newBird.append(bird)
                }
                
                return newBird.compactMap { $0 }
            }
            
            await MainActor.run {
                self.birds = result.sorted { $0.name < $1.name }
                self.baseBirds = result
            }
        }
    }
    
    func save(_ bird: Bird) {
        Task {
            guard let image = bird.image,
                  let compressedImage = image.compressedImage(quality: 0.1),
                  let birdImagePath = await imageManager.store(image: compressedImage, for: bird.id) else { return }
            
            var udModels = userDefaultsService.get([BirdUD].self, for: .bird) ?? []
            var tempTupple: [(aviary: Aviary, imagePath: String, date: Date)] = []
            
            for aviary in bird.aviaries {
                guard let image = aviary.value.image,
                      let aviaryImagePath = await imageManager.store(image: image, for: aviary.value.id) else { return }
                tempTupple.append((aviary.value, aviaryImagePath, aviary.key))
            }
            
            let udModel = BirdUD(from: bird, and: birdImagePath, aviaries: tempTupple)
            
            if let index = udModels.firstIndex(where: { $0.id == bird.id }) {
                udModels[index] = udModel
            } else {
                udModels.append(udModel)
            }
            
            userDefaultsService.set(udModels, for: .bird)
            
            await MainActor.run {
                var newBird = bird
                newBird.image = compressedImage
                
                if let index = birds.firstIndex(where: { $0.id == bird.id }) {
                    self.birds[index] = newBird
                } else {
                    self.birds.append(newBird)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    func remove(_ bird: Bird) {
        Task {
            guard var udModels = userDefaultsService.get([BirdUD].self, for: .bird),
                  let index = udModels.firstIndex(where: { $0.id == bird.id }) else { return }
            
            await imageManager.removeImage(for: bird.id)
            
            udModels.remove(at: index)
            
            userDefaultsService.set(udModels, for: .bird)
            
            await MainActor.run {
                if let index = self.birds.firstIndex(where: { $0.id == bird.id }) {
                    self.birds.remove(at: index)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    private func loadAviaries() async {
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
            self.aviaries = result
        }
    }
    
    private func filterBirds(with model: FilterModel, and text: String) {
        let newBirds = baseBirds
            .filter { text == "" ? true : ($0.name.contains(text) || $0.nameID.contains(text)) || ($0.gender?.title ?? "").contains(text) || ($0.status?.title ?? "").contains(text) }
            .filter { model.gender == nil ? true : $0.gender == model.gender }
            .filter { model.status == nil ? true : $0.status == model.status }
            .filter {
                switch model.age {
                    case .oneYear:
                        $0.age == "1"
                    case .oneToTHreeYear:
                        $0.age == "2" || $0.age == "3"
                    default:
                        !["1", "2", "3"].contains($0.age)
                }
            }
        
        birds = newBirds
    }
    
    private func observeFilterModel() {
        Publishers.CombineLatest($filter, $filterText)
            .sink { [weak self] model, text in
                guard let self else { return }
                self.filterBirds(with: model, and: text)
            }
            .store(in: &cancellable)
    }
}
