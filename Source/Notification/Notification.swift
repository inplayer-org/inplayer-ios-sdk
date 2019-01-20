import Foundation

public extension InPlayer {

    /**
     Class that provides 
     */
    public final class Notification {
        private init() {}

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
        public static func subscribe(statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                                     messageCallback: @escaping (_ notification: InPlayerNotification) -> Void,
                                     onError: @escaping (_ error: InPlayerError) -> Void) {
            INPAWSManager.subscribe(statusCallback: statusCallback,
                                    messageCallback: messageCallback,
                                    onError: onError)
        }

        /**
         Disconnects from websocket and stop receving `InPlayerNotification`.
         */
        public static func disconnect() {
            INPAWSManager.disconnect()
        }
    }
}
