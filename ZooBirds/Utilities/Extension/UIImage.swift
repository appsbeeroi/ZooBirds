import UIKit

extension UIImage {
   func compressedImage(quality: CGFloat) -> UIImage? {
        guard let data = self.jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }
}
