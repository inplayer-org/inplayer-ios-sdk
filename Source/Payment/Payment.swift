import Foundation

public extension InPlayer {

    /**
     Class providing methods linked with payments.
     */
    final class Payment {
        private init() {}

        /**
         Contact InPlayer server and validate if purchase was successfull.
         - Parameters:
            - receiptString: Base64EncodedString of the recept data stored on device after successfull in-app purchase.
            - productIdentifier: String combination of `itemId` and `accessFeeId`, connected with `_`
            - success: A closure to be executed once the request has finished successfully.
            - failure: A closure to be executed once the request has finished with error.
            - error: Containing information about the error that occurred.
         */
        public static func validate(receiptString: String,
                                    productIdentifier: String,
                                    success: @escaping ()-> Void,
                                    failure: @escaping (_ error: InPlayerError) -> Void) {
            INPPaymentService.validate(receiptString: receiptString,
                                       productIdentifier: productIdentifier,
                                       completion:  { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }
        
        /**
         Contact InPlayer server and validate if purchase was successfull.
         - Parameters:
            - productName: Purchased product name
            - receipt: Base64EncodedString of the recept data stored on device after successfull in-app purchase.
            - success: A closure to be executed once the request has finished successfully.
            - failure: A closure to be executed once the request has finished with error.
            - error: Containing information about the error that occurred.
         */
        
        public static func validateByProductName(productName: String,
                                                 receipt: String,
                                                 success: @escaping () -> Void,
                                                 failure: @escaping (_ error: InPlayerError) -> Void) {
            INPPaymentService.validateByProductName(productName: productName,
                                                    receipt: receipt,
                                                    completion: { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }

        /**
         Gets the purchase history
         - Parameters:
             - status: The status of the purchase - all/active/inactive.
             - page: The current pag
             - limit: The number of items per page
             - type: Type
             - customerId: Account's id
             - success: A closure to be executed once the request has finished successfully.
             - purchaseHistory: Purchase history model containing list of all purchased access items.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getPurchaseHistory(status: PurchaseHistory = .all,
                                              page: Int,
                                              limit: Int,
                                              type: String? = nil,
                                              customerId: Int? = nil,
                                              success: @escaping (_ purchaseHistory: InPlayerCustomerPurchaseHistory) -> Void,
                                              failure: @escaping (_ error: InPlayerError) -> Void) {
            INPPaymentService.getPurchaseHistory(status: status,
                                                 page: page,
                                                 limit: limit,
                                                 type: type,
                                                 customerId: customerId) { (purchaseHistory, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(purchaseHistory!)
                }
            }
        }
    }
}
