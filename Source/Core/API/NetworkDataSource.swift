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
        - completion: A closure to be executed once the request has finished.
        - result: Generic enum Result containing response or error depending of its state
     */
    static func performRequest<T:Decodable>(session: InPlayerSession,
                                            route: INPAPIConfiguration,
                                            completion: @escaping RequestCompletion<T>) {
        session.request(route).validate().responseData { (response:DataResponse<Data>) in
            switch response.result {
            case .success(let data):
                let parsedData = try? JSONDecoder().decode(T.self, from: data)
                completion(parsedData, nil)
            case .failure(let error):
                let error = InPlayerErrorMapper.mapFromError(originalError: error,
                                                             withResponseData: response.data)
                completion(nil, error)
            }
        }
    }
}
