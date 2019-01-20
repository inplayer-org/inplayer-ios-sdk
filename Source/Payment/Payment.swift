import Foundation

public extension InPlayer {

    /**
     Class providing methods linked with payments.
     */
    public final class Payment {
        private init() {}

        /**
         Contact InPlayer server and validate if purchase was successfull.
         - Parameters:
             - receiptData: Data of the receipt stored on device after successfull in-app purchase.
             - itemId: Id of the item that is purchased. When combined with accessFeeId in way `itemId`_`accessFeeId` will
             give you the product identifier of the purchased item.
             - accessFeeId: Id of the access fee of the item. When combined with `itemId` in way `itemId`_`accessFeeId` will
             give you the product identifier of the purchased item.
             - success: A closure to be executed once the request has finished successfully.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.

         */
        public static func validate(receiptData: Data,
                                    productIdentifier: String,
                                    success: @escaping ()-> Void,
                                    failure: @escaping (_ error: InPlayerError) -> Void) {
            INPPaymentService.validate(receiptData: receiptData,
                                       productIdentifier: productIdentifier,
                                       completion:  { (_, error) in
                if let error = error {
                    failure(error)
                } else {
                    success()
                }
            })
        }
    }
}
