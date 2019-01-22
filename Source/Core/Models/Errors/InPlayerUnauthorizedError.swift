import Foundation

/**
 User not authenticated Error
 */
public struct InPlayerUnauthorizedError: InPlayerError {
    public var code: Int
    public var message: String?
    public var errorList: [String]?
    public var originalError: Error

    public init(code: Int, message: String?, errorList: [String]?, error: Error) {
        self.code = code
        self.message = message
        self.errorList = errorList
        self.originalError = error
    }

    init(error: Error) {
        self.init(code: (error as NSError).code,
                  message: (error as NSError).localizedDescription,
                  errorList: [(error as NSError).localizedDescription],
                  error: error)
    }

    init() {
        let message = "User is not authenticated, please authenticate first."
        let err = NSError(domain: "Error", code: 401, userInfo: [NSLocalizedDescriptionKey: message])
        self.init(error: err)
    }
}
