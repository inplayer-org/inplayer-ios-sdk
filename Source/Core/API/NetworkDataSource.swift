import Alamofire

/**
 Typealias for request completion block
 - Parameters:
    - value: Parsed value of response result
    - error: InPlayerError containing information about what happened.
 */
typealias RequestCompletion<T> = (_ value: T?, _ error: InPlayerError?) -> Void

class NetworkDataSource {
    private init() {}
    
    /**
     Generic method that creates and executes request.
     - Parameters:
        - route: Endpoint to be called
        - decoder: Data decoder. Defaults to JSONDecoder
        - completion: A closure to be executed once the request has finished.
        - result: Generic enum Result containing response or error depending of its state
     */
    static func performRequest<T:Decodable>(session: InPlayerSession,
                                            route: INPAPIConfiguration,
                                            decoder: JSONDecoder = JSONDecoder(),
                                            completion: @escaping RequestCompletion<T>) {
        if route.requiresAuthorization, !session.isAuthorized {
            return completion(nil, InPlayerUnauthorizedError())
        }
        session.request(route).validate().responseDecodable(decoder: decoder) { (response: DataResponse<T>) in
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
