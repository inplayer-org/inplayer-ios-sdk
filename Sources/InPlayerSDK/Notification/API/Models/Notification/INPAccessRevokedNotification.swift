import Foundation

public struct INPItemRevokedModel: Codable {
    public var itemId: Int
}

public struct INPAccessRevokedNotification: InPlayerNotification {
    public var type: NotificationType
    public var timestamp: Double
    public var resource: INPItemRevokedModel
}
