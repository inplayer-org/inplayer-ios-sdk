import Foundation

public struct INPAccessGrantedNotification: InPlayerNotification {
    public var type: NotificationType
    public var timestamp: Double
    public var startsAt: Double
    public var resource: INPItemAccessModel

    private enum CodingKeys: String, CodingKey {
        case type
        case timestamp
        case startsAt = "starts_at"
        case resource
    }
}
