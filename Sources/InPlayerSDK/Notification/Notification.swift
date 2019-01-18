import Foundation
import AWSIoT
import AWSCore

private protocol AWSNotification {

    /**
     */
    static func subscribe(statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                          messageCallback: @escaping (_ notification: InPlayerNotification) -> Void,
                          onError: @escaping (_ error: InPlayerError) -> Void)


    /**
     */
    static func disconnect()
}

public extension InPlayer {
    public final class Notification: AWSNotification {
        private init() {}

        public static func subscribe(statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                                     messageCallback: @escaping (_ notification: InPlayerNotification) -> Void,
                                     onError: @escaping (_ error: InPlayerError) -> Void) {
            INPNotificationManager.subscribe(statusCallback: statusCallback,
                                             messageCallback: messageCallback,
                                             onError: onError)
        }

        public static func disconnect() {
            INPNotificationManager.disconnect()
        }
    }
}
