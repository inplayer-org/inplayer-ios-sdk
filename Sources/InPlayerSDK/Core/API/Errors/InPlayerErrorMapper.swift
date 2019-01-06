import Foundation
import Alamofire

public protocol InPlayerError: Error {
    var code: Int { get set }
    var message: String? { get set }
    var errorList: [String]? { get set }
    var originalError: Error { get set }
    
    init(code: Int, message: String?, errorList: [String]?, error: Error)
}

public final class InPlayerErrorMapper {

    static func mapFromError(originalError: Error, withResponseData data: Data?) -> InPlayerError {
        if let data = data {
            do {
                guard
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                else {
                    return InPlayerInvalidJSONError(error: originalError)
                }

                var message: String?
                if let messageJson: String = json["message"] as? String {
                    message = messageJson
                }

                var errors: [String]?
                if let errorsJson = json["errors"] as? [String: String] {
                    errors = errorsJson.map{ $0.value }
                } else if let message = message {
                    errors?.append(message)
                }

                var code: Int
                if let jsonCode = json["code"] as? Int {
                    code = jsonCode
                } else if let afErrorCode = originalError.asAFError?.responseCode {
                    code = afErrorCode
                } else {
                    code = (originalError as NSError).code
                }

                return InPlayerHttpError(code: code, message: message, errorList: errors, error: originalError)
            } catch {
                return InPlayerInvalidJSONError(error: originalError)
            }
        } else {
            guard let afError = originalError.asAFError else {
                return InPlayerHttpError(code: (originalError as NSError).code,
                                         message: originalError.localizedDescription,
                                         errorList: [originalError.localizedDescription],
                                         error: originalError)
            }
            guard
                let code = afError.responseCode,
                let message = afError.errorDescription
            else {
                return InPlayerUnknownError(error: originalError)
            }
            return InPlayerHttpError(code: code, message: message, errorList: [message], error: originalError)
        }
    }
}
