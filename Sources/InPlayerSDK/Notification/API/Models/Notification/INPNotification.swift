import Foundation

public enum NotificationType: String, Codable {
    case accessGranted = "access.granted"
    case accessRevoked = "access.revoked"
    case accountLogout = "account.logout"
    case accountErased = "account.erased"
    case accountDeactivated = "account.deactivated"
}

public protocol InPlayerNotification: Codable {
    var type: NotificationType { get set }
    var timestamp: Double { get set }
}
