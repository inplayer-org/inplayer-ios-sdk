import Alamofire

/// Interface that defines required properties to be set so url request can be created.
public protocol INPAPIConfiguration: URLRequestConvertible {
    /// Request HTTP Method
    var method: HTTPMethod { get }

    /// Server base URL
    var baseURL: String { get }

    /// Request Endpoint
    var path: String { get }

    /// Request parameters
    var parameters: Parameters? { get }

    /// It defines if url string should be encoded or not
    var urlEncoding: Bool { get }
}

public extension INPAPIConfiguration {

    var baseURL: String {
        return InPlayer.Configuration.getBaseUrlString()
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(NetworkConstants.HeaderParameters.applicationUrlEncoded,
                            forHTTPHeaderField: NetworkConstants.HeaderParameters.contentType)
        urlRequest.setValue(NetworkConstants.HeaderParameters.applicationJSON,
                            forHTTPHeaderField: NetworkConstants.HeaderParameters.accept)

        if InPlayer.Account.isAuthenticated() {
            let token = INPCredentials.getCredentials().accessToken
            urlRequest.setValue(NetworkConstants.HeaderParameters.bearerToken + token,
                                forHTTPHeaderField: NetworkConstants.HeaderParameters.authorization)
        }

        // Parameters
        guard let parameters = parameters else { return urlRequest }
        if urlEncoding {
            let encoding: ParameterEncoding = (method == .post) ?
                Alamofire.JSONEncoding.default : Alamofire.URLEncoding.default
            do {
                urlRequest = try encoding.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        } else {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }
}

