import Foundation

final class UserDefaultsService {
    
    private let defaults = UserDefaults.standard
    
    static let shared = UserDefaultsService()
    
    private init() {}

    func set<T: Codable>(_ value: T, for type: UserDefaultsDataType) {
        let key = type.key
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(value)
            defaults.set(data, forKey: key)
        } catch {
            print("❌ Failed to encode \(T.self): \(error)")
        }
    }

    func get<T: Codable>(_ type: T.Type, for keyType: UserDefaultsDataType) -> T? {
        let key = keyType.key
        
        guard let data = defaults.data(forKey: key) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Failed to decode \(T.self): \(error)")
            return nil
        }
    }

    func remove(for keyType: UserDefaultsDataType) {
        defaults.removeObject(forKey: keyType.key)
    }
}
