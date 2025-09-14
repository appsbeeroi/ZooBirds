import UserNotifications
import UIKit

final class NotificationCenterService {
    
    static let shared = NotificationCenterService()
    
    private init() {}
    
    var permissionStatus: PermissionStatus {
        get async {
            let settings = await UNUserNotificationCenter.current().notificationSettings()
            
            return switch settings.authorizationStatus {
                case .authorized, .provisional:
                        .authorized
                case .denied:
                        .denied
                case .notDetermined:
                        .notDetermined
                default:
                        .denied
            }
        }
    }
    
    @discardableResult
    func requestPermission() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            return false
        }
    }
}
