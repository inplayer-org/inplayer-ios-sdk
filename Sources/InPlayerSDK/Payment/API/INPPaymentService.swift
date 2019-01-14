import Foundation
import Alamofire

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

public class INPPaymentService {
    private init() {}
    
    public static func validate(receiptData: Data,
                                itemId: Int,
                                accessFeeId: Int,
                                completion: @escaping RequestCompletion<Empty>) {
        let receiptString = receiptData.base64EncodedString()

        let params: [String: Any] = [
            PaymentParameters.receipt: receiptString,
            PaymentParameters.itemId: itemId,
            PaymentParameters.accessFeeId: accessFeeId
        ]
        NetworkDataSource.performRequest(session: INPSessionManager.default.session,
                                         route: PaymentAPIRouter.validatePayment(parameters: params),
                                         completion: completion)
    }
}

