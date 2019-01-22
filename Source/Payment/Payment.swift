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
    }
}
