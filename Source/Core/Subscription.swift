import Alamofire

public extension InPlayer {

    /**
     Class providing Subscription related actions.
     */
    final class Subscription {

        private init() {}

        /**
         Gets all subscriptions for a given user
         - Parameters:
             - page: Number of page. Defauls to 1.
             - limit: Number of items per page. Defaults to 10.
             - success: A closure to be executed once the request has finished successfully.
             - subscriptionList: Model containing pagination info and a list of subscriptions.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getSubscriptions(page: Int = 1,
                                            limit: Int = 10,
                                            success: @escaping (_ subscriptionList: InPlayerSubscriptionList) -> Void,
                                            failure: @escaping (_ error: InPlayerError) -> Void) {
            INPSubscriptionService.getSubscriptions(page: page, limit: limit) { (subscriptionList, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(subscriptionList!)
                }
            }
        }
    }
}
