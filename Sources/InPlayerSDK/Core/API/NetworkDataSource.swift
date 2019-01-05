import Alamofire

/**
 Typealias for request completion block
 - Parameters:
    - value: Parsed value of response result
    - error: InPlayerError containing information about what happened.
 */
public typealias RequestCompletion<T> = (_ value: T?, _ error: InPlayerError?) -> Void

public class NetworkDataSource {
    /**
     Generic method that creates and executes request.
     - Parameters:
        - route: Endpoint to be called
        - decoder: Data decoder. Defaults to JSONDecoder
        - completion: A closure to be executed once the request has finished.
        - result: Generic enum Result containing response or error depending of its state
     - Returns: The request
     */
    @discardableResult
    public static func performRequest<T:Decodable>(route: INPAPIConfiguration,
                                                   decoder: JSONDecoder = JSONDecoder(),
                                                   completion: @escaping RequestCompletion<T> ) -> Request {
        return AF.request(route).validate().responseDecodable(decoder: decoder) { (response: DataResponse<T>) in
            // TODO: Maybe this should use different parameter check
            if InPlayer.Configuration.getEnvironment() == .debug {
                print("=================================")
                print("[REQUEST]:  \(response.request!)")
                print("[REQUEST METHOD]: \(String(describing:response.request?.httpMethod))")
                print("[REQUEST HEADERS]:  \(String(describing: response.request?.allHTTPHeaderFields))")
                print("[PARAMS]: \(String(describing: route.parameters))")
                print("[RESPONSE RESULT]: \(response.result)")
                if let statusCode = response.response?.statusCode {
                    print("[RESPONSE STATUS CODE]: \(statusCode)")
                }
                if response.data != nil {
                    let str = String(data: response.data!, encoding: String.Encoding.utf8)!
                    print("[RESPONSE]: \(str)")
                }
                print("=================================")
            }

            if response.result.isFailure {
                let error = InPlayerErrorMapper.mapFromError(originalError: response.result.error!,
                                                             withResponseData: response.data)
                completion(nil, error)
            } else {
                completion(response.result.value, nil)
            }
        }
    }
}
