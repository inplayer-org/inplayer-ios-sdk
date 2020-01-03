import Foundation
import Alamofire

class INPPaymentService {
    private init() {}

    static func validate(receiptString: String,
                         productIdentifier: String,
                         completion: @escaping RequestCompletion<Empty>) {

        let productComponents = productIdentifier.components(separatedBy: "_")

        let message = "Invalid format of product identifier"
        let error = NSError(domain: "Error",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Invalid format of product identifier"])
        let inpError = InPlayerUnknownError(code: 0,
                                            message: message,
                                            errorList: [message],
                                            error: error)
        guard productComponents.count > 1 else {
            return completion(nil, inpError)
        }

        guard
            let itemId = Int(productComponents[0]),
            let accessFeeId = Int(productComponents[1]) else {
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
    
    static func validateByProductName(productName: String,
                                      receipt: String,
                                      completion: @escaping RequestCompletion<Empty>) {
        let params: [String: Any] = [
            PaymentParameters.receipt: receipt,
            PaymentParameters.productName: productName
        ]
        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: PaymentAPIRouter.validatePaymentByProductName(parameters: params),
                                         completion: completion)
        
    }

    static func getPurchaseHistory(status: PurchaseHistory,
                                   page: Int,
                                   limit: Int,
                                   type: String?,
                                   customerId: Int?,
                                   completion: @escaping RequestCompletion<InPlayerCustomerPurchaseHistory>) {
        var params: [String: Any] = [
            PaymentParameters.status: status.rawValue,
            PaymentParameters.page: page,
            PaymentParameters.limit: limit
        ]
        if let type = type {
            params[PaymentParameters.type] = type
        }
        if let customerId = customerId {
            params[PaymentParameters.customerId] = customerId
        }

        NetworkDataSource.performRequest(session: InPlayerSessionAPIManager.default.session,
                                         route: PaymentAPIRouter.getPurchaseHistory(parameters: params),
                                         completion: completion)
    }
}

private enum PaymentAPIRouter: INPAPIConfiguration {

    case validatePayment(parameters: [String: Any])
    case validatePaymentByProductName(parameters: [String: Any])
    case getPurchaseHistory(parameters: [String: Any])

    var method: HTTPMethod {
        switch self {
        case .validatePayment, .validatePaymentByProductName:
            return .post
        case .getPurchaseHistory:
            return .get
        }
    }

    var path: String {
        switch self {
        case .validatePayment, .validatePaymentByProductName:
            return NetworkConstants.Endpoints.Payment.validate
        case .getPurchaseHistory:
            return NetworkConstants.Endpoints.Payment.purchaseHistory
        }
    }

    var parameters: Parameters? {
        switch self {
        case .validatePayment(let parameters):
            return parameters
        case .validatePaymentByProductName(let parameters):
            return parameters
        case .getPurchaseHistory(let parameters):
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
    static let status = "status"
    static let page = "page"
    static let limit = "size"
    static let type = "type"
    static let customerId = "customerID"
    static let productName = "product_name"
}
