import Foundation
import AWSIoT
import AWSCore

private protocol AWSNotification {

    /**
     Connects to a websocket and subscribes for `InPlayerNotification`s.
     - Parameters:
        - statusCallback: A closure to be executed everytime when connection status change occurs.
        - status: `InPlayerNotificationStatus` enum that shows current connection status
        - messageCallback: A closure to be executed everytime new notification is sent from the server.
        - notification: `InPlayerNotification` enum optionally containing associated values depending on the type.
        - onError: A closure to be executed when some error occurred.
        - error: `InPlayerError` containing info about the error that occurred.
     */
    static func subscribe(statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                          messageCallback: @escaping (_ notification: InPlayerNotification) -> Void,
                          onError: @escaping (_ error: InPlayerError) -> Void)


    /**
     Disconnects from websocket and stop receving `InPlayerNotification`.
     */
    static func disconnect()
}

public extension InPlayer {
    public final class Notification: AWSNotification {
        private init() {}

        public static func subscribe(statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                                     messageCallback: @escaping (_ notification: InPlayerNotification) -> Void,
                                     onError: @escaping (_ error: InPlayerError) -> Void) {
            INPAWSManager.subscribe(statusCallback: statusCallback,
                                    messageCallback: messageCallback,
                                    onError: onError)
        }

        public static func disconnect() {
            INPAWSManager.disconnect()
        }
    }
}
