import Foundation

/**
 Notification Type enum
 ```
 case accessGranted(resource: INPItemAccessModel)
 case accessRevoked(resource: INPItemRevokedModel)
 case externalPaymentSuccess(resource: INPPaymentSuccessModel)
 case externalPaymentFailed(resource: INPExternalPaymentFailedModel)
 case externalSubscribeCancelSuccess(resource: INPPaymentSuccessModel)
 case accountLogout
 case accountErased
 case accountDeactivated
 case defaultNotification(type: String)
 ```
*/
public enum NotificationType {
    case accessGranted(resource: InPlayerItemAccess)
    case accessRevoked(resource: InPlayerItemRevoked)
    case externalPaymentSuccess(resource: InPlayerPaymentSuccess)
    case externalPaymentFailed(resource: InPlayerExternalPaymentFailed)
    case externalSubscribeCancelSuccess(resource: InPlayerPaymentSuccess)
    case accountLogout
    case accountErased
    case accountDeactivated
    case defaultNotification(type: String)
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
        static let externalPaymentSuccess = "external.payment.success"
        static let externalPaymentFailed = "external.payment.failed"
        static let externalSubscribeCancelSuccess = "external.subscribe.cancel.success"
        static let accountLogout = "account.logout"
        static let accountErased = "account.erased"
        static let accountDeactivated = "account.deactivated"
        static let defaultNotification = "default"
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
        case NotificationTypeStrings.externalPaymentSuccess:
            let resource = try values.decode(InPlayerPaymentSuccess.self, forKey: .resource)
            type = .externalPaymentSuccess(resource: resource)
        case NotificationTypeStrings.externalPaymentFailed:
            let resource = try values.decode(InPlayerExternalPaymentFailed.self, forKey: .resource)
            type = .externalPaymentFailed(resource: resource)
        case NotificationTypeStrings.externalSubscribeCancelSuccess:
            let resource = try values.decode(InPlayerPaymentSuccess.self, forKey: .resource)
            type = .externalSubscribeCancelSuccess(resource: resource)
        case NotificationTypeStrings.accountLogout:
            type = .accountLogout
        case NotificationTypeStrings.accountErased:
            type = .accountErased
        case NotificationTypeStrings.accountDeactivated:
            type = .accountDeactivated
        default:
            type = .defaultNotification(type: typeString)
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
        case .externalPaymentSuccess(let resource):
            try values.encode(resource, forKey: .resource)
            try values.encode(NotificationTypeStrings.externalPaymentSuccess, forKey: .typeString)
        case .externalPaymentFailed(let resource):
            try values.encode(resource, forKey: .resource)
            try values.encode(NotificationTypeStrings.externalPaymentFailed, forKey: .typeString)
        case .externalSubscribeCancelSuccess(let resource):
            try values.encode(resource, forKey: .resource)
            try values.encode(NotificationTypeStrings.externalSubscribeCancelSuccess, forKey: .typeString)
        case .accountLogout:
            try values.encode(NotificationTypeStrings.accountLogout, forKey: .typeString)
        case .accountErased:
            try values.encode(NotificationTypeStrings.accountErased, forKey: .typeString)
        case .accountDeactivated:
            try values.encode(NotificationTypeStrings.accountDeactivated, forKey: .typeString)
        default:
            try values.encode(NotificationTypeStrings.defaultNotification, forKey: .typeString)
        }
    }
}
