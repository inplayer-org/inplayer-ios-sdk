import Foundation

/**
 Notification Type enum
 ```
 case accessGranted(resource: INPItemAccessModel)
 case accessRevoked(resource: INPItemRevokedModel)
 case accountLogout
 case accountErased
 case accountDeactivated
 case unknown
 ```
*/
public enum NotificationType {
    case accessGranted(resource: InPlayerItemAccess)
    case accessRevoked(resource: InPlayerItemRevoked)
    case accountLogout
    case accountErased
    case accountDeactivated
    case unknown
}

/// InPlayer Notification
public struct InPlayerNotification: Codable {
    public var type: NotificationType
    public var timestamp: Double

    private enum CodingKeys: String, CodingKey {
        case typeString = "type"
        case timestamp
        case resource
    }

    private struct NotificationTypeStrings {
        static let accessGranted = "access.granted"
        static let accessRevoked = "access.revoked"
        static let accountLogout = "account.logout"
        static let accountErased = "account.erased"
        static let accountDeactivated = "account.deactivated"
        static let unknown = "unknown"
    }

    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        timestamp = try values.decode(Double.self, forKey: .timestamp)

        let typeString = try values.decode(String.self, forKey: .typeString)
        switch typeString {
        case NotificationTypeStrings.accessGranted:
            let resource = try values.decode(InPlayerItemAccess.self, forKey: .resource)
            type = .accessGranted(resource: resource)
        case NotificationTypeStrings.accessRevoked:
            let resource = try values.decode(InPlayerItemRevoked.self, forKey: .resource)
            type = .accessRevoked(resource: resource)
        case NotificationTypeStrings.accountLogout:
            type = .accountLogout
        case NotificationTypeStrings.accountErased:
            type = .accountErased
        case NotificationTypeStrings.accountDeactivated:
            type = .accountDeactivated
        default:
            type = .unknown
            let error = NSError(domain: "Error",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Unsupported notification type"])
            throw error
        }
    }

    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(timestamp, forKey: .timestamp)
        switch type {
        case .accessGranted(let resource):
            try values.encode(resource, forKey: .resource)
            try values.encode(NotificationTypeStrings.accessGranted, forKey: .typeString)
        case .accessRevoked(let resource):
            try values.encode(resource, forKey: .resource)
            try values.encode(NotificationTypeStrings.accessRevoked, forKey: .typeString)
        case .accountLogout:
            try values.encode(NotificationTypeStrings.accountLogout, forKey: .typeString)
        case .accountErased:
            try values.encode(NotificationTypeStrings.accountErased, forKey: .typeString)
        case .accountDeactivated:
            try values.encode(NotificationTypeStrings.accountDeactivated, forKey: .typeString)
        default:
            try values.encode(NotificationTypeStrings.unknown, forKey: .typeString)
        }
    }
}
