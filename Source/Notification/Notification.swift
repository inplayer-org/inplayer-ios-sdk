import Foundation

public extension InPlayer {

    /**
     Class that provides 
     */
    final class Notification {
        private init() {}

        /**
         Connects to a websocket and subscribes for `InPlayerNotification`s.
         - Parameters:
             - onStatusChanged: A closure to be executed everytime when connection status change occurs.
             - status: `InPlayerNotificationStatus` enum that shows current connection status
             - onMessageReceived: A closure to be executed everytime new notification is sent from the server.
             - notification: `InPlayerNotification` struct optionally containing associated values depending on the type enum.
             - onError: A closure to be executed when some error occurred.
             - error: `InPlayerError` containing info about the error that occurred.
         */
        public static func subscribe(onStatusChanged: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                                     onMessageReceived: @escaping (_ notification: InPlayerNotification) -> Void,
                                     onError: @escaping (_ error: InPlayerError) -> Void) {
            INPAWSManager.subscribe(onStatusChanged: onStatusChanged,
                                    onMessageReceived: onMessageReceived,
                                    onError: onError)
        }

        /**
         Disconnects from websocket and stop receving `InPlayerNotification`.
         */
        public static func unsubscribe() {
            INPAWSManager.unsubscribe()
        }

        /**
         Returns subscribed status
         */
        public static func isSubscribed() -> Bool {
            return INPAWSManager.isSubscribed
        }
    }
}
