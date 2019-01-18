import Foundation

public enum INPPayloadResult<INPNotification, InPlayerError> {
    case success(_ value: INPNotification)
    case failure(_ error: InPlayerError)
}

public final class INPNotificationMapper {
    static func notificationForPayload(payload: Data) -> INPPayloadResult<INPNotification, InPlayerError> {
        do {
            let json = try JSONSerialization.jsonObject(with: payload,
                                                        options: .mutableLeaves) as? [String: Any]

            if let typeString = json?["type"] as? String, let type = NotificationType(rawValue: typeString) {
                switch type {
                case .accountDeactivated:
                    let value = try payload.decoded() as INPAccountDeactivatedNotification
                    return INPPayloadResult.success(value)
                case .accountErased:
                    let value = try payload.decoded() as INPAccountErasedNotification
                    return INPPayloadResult.success(value)
                case .accountLogout:
                    let value = try payload.decoded() as INPAccountLogoutNotification
                    return INPPayloadResult.success(value)
                case .accessRevoked:
                    let value = try payload.decoded() as INPAccessRevokedNotification
                    return INPPayloadResult.success(value)
                case .accessGranted:
                    let value = try payload.decoded() as INPAccessGrantedNotification
                    return INPPayloadResult.success(value)
                }
            } else {
                let error = NSError(domain: "Error",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Unknown notification type"])
                return INPPayloadResult.failure(INPInvalidJSONError(error: error))
            }

        } catch {
            return INPPayloadResult.failure(INPInvalidJSONError(error:error))
        }
    }
}
