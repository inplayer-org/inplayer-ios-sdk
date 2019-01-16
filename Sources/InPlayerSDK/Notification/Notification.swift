import Foundation
import AWSIoT
import AWSCore

private protocol AWSNotification {

    /**
     */
    static func subscribe(clientUUID: String, messageCallback: @escaping () -> Void)

    /**
     */
    static func disconnect()
}

public extension InPlayer {
    public final class Notification: AWSNotification {
        private init() {}

        public static func subscribe(clientUUID: String, messageCallback: @escaping () -> Void) {
            INPNotificationManager.subscribe(clientUUID: clientUUID, statusCallback: { (status) in
                print(status.rawValue)
                if status == .connected {
                    messageCallback()
                }
            }, onError: { (error) in
                print(error.localizedDescription)
            }, messageCallback: { (payload) in

            })
        }

        public static func disconnect() {
            INPNotificationManager.disconnect()
        }
    }
}
