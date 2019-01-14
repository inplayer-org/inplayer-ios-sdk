import Foundation

private protocol NotificaionAPI {
    /**
     Fetch aws credentials.

     Fetch temporarily aws credentials to be used when authenticating with the AWS IoT service.
     Credentials last approximately 1 hour. Requires bearer token.

     - Parameters:
        - success: A closure to be executed once the request has finished successfully.
        - awsKeys: Model containing temporarily aws keys.
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     */
    static func takeAwsCredentials(success: @escaping (_ awsKeys: INPAwsKeyModel) -> Void,
                                   failure: @escaping (_ error: InPlayerError) -> Void)
}

public extension InPlayer {
    public final class Notification: NotificaionAPI {
        private init() {}

        public static func takeAwsCredentials(success: @escaping (INPAwsKeyModel) -> Void,
                                              failure: @escaping (InPlayerError) -> Void) {
            INPNotificationService.takeAwsCredentials { (awsKeys, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(awsKeys!)
                }
            }
        }
    }
}
