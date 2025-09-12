import UIKit

final class ImageManager {

    static let shared = ImageManager()

    private let containerName = "SavedImages"
    private let fileManager = FileManager.default
    private let storageURL: URL

    private init() {
        let docsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        storageURL = docsDir.appendingPathComponent(containerName, isDirectory: true)
        createFolderIfNeeded()
    }


    private func createFolderIfNeeded() {
        var isDirectory: ObjCBool = false
        if !fileManager.fileExists(atPath: storageURL.path, isDirectory: &isDirectory) || !isDirectory.boolValue {
            do {
                try fileManager.createDirectory(at: storageURL, withIntermediateDirectories: true)
            } catch {
                print("📁❌ Could not create directory: \(error.localizedDescription)")
            }
        }
    }

    private func makeFileURL(for id: UUID) -> URL {
        storageURL.appendingPathComponent("\(id.uuidString).png")
    }

    private func makeFileURL(fileName: String) -> URL {
        storageURL.appendingPathComponent(fileName)
    }
}

// MARK: - Public API
extension ImageManager {
    @discardableResult
    func store(image: UIImage, for id: UUID) async -> String? {
        let fileURL = makeFileURL(for: id)
        guard let data = image.pngData() else {
            print("📷❌ Failed to convert image to PNG")
            return nil
        }

        do {
            try data.write(to: fileURL, options: .atomic)
            return fileURL.lastPathComponent
        } catch {
            print("💾❌ Failed to save image: \(error.localizedDescription)")
            return nil
        }
    }

    func retrieve(fileNamed name: String) async -> UIImage? {
        let fileURL = makeFileURL(fileName: name)
        return UIImage(contentsOfFile: fileURL.path)
    }

    func removeImage(for id: UUID) async {
        let fileURL = makeFileURL(for: id)
        guard fileManager.fileExists(atPath: fileURL.path) else { return }

        do {
            try fileManager.removeItem(at: fileURL)
        } catch {
            print("🗑️❌ Failed to delete image: \(error.localizedDescription)")
        }
    }
}
