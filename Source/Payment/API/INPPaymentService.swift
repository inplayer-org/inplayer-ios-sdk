import Foundation
import Alamofire

class INPPaymentService {
    private init() {}

    static func validate(receiptString: String,
                         productIdentifier: String,
                         completion: @escaping RequestCompletion<Empty>) {

        let productComponents = productIdentifier.components(separatedBy: "_")
        guard
            let itemIdString = productComponents.first,
            let itemId = Int(itemIdString),
            let accessFeeIdString = productComponents.last,
            let accessFeeId = Int(accessFeeIdString) else {
                // create invalid input error
                let message = "Invalid format of product identifier"
                let error = NSError(domain: "Error",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Invalid format of product identifier"])
                let inpError = InPlayerUnknownError(code: 0,
                                               message: message,
                                               errorList: [message],
                                               error: error)
                return completion(nil, inpError)
        }
        let params: [String: Any] = [
            PaymentParameters.receipt: receiptString,
            PaymentParameters.itemId: itemId,
            PaymentParameters.accessFeeId: accessFeeId
        ]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: PaymentAPIRouter.validatePayment(parameters: params),
                                         completion: completion)
    }
}

private enum PaymentAPIRouter: INPAPIConfiguration {

    case validatePayment(parameters: [String: Any])

    var method: HTTPMethod {
        switch self {
        case .validatePayment:
            return .post
        }
    }

    var path: String {
        switch self {
        case .validatePayment:
            return NetworkConstants.Endpoints.Payment.validate
        }
    }

    var parameters: Parameters? {
        switch self {
        case .validatePayment(let parameters):
            return parameters
        }
    }

    var urlEncoding: Bool {
        switch self {
        default:
            return true
        }
    }

    var requiresAuthorization: Bool {
        switch self {
        default:
            return true
        }
    }
}

private struct PaymentParameters {
    private init() {}
    static let receipt = "receipt"
    static let itemId = "item_id"
    static let accessFeeId = "access_fee_id"
}
