import Foundation
import AWSIoT
import AWSCore

private protocol AWSNotification {

    /**
     */
    static func subscribe(clientUUID: String,
                                 statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                                 onError: @escaping (_ error: InPlayerError) -> Void,
                                 messageCallback: @escaping (_ notification: INPNotification) -> Void)

    /**
     */
    static func disconnect()
}

public extension InPlayer {
    public final class Notification: AWSNotification {
        private init() {}

        public static func subscribe(clientUUID: String,
                                     statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                                     onError: @escaping (_ error: InPlayerError) -> Void,
                                     messageCallback: @escaping (_ notification: INPNotification) -> Void) {
            INPNotificationManager.subscribe(clientUUID: clientUUID,
                                             statusCallback: statusCallback,
                                             onError: onError,
                                             messageCallback: messageCallback)
        }

        public static func disconnect() {
            INPNotificationManager.disconnect()
        }
    }
}
