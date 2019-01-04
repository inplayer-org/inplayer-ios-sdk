import Alamofire

private protocol AssetsAPI {
    /**
     Gets details about given item id
     - Parameters:
        - id: Id of item that we are interested in.
        - success: A closure to be executed once the request has finished successfully.
        - item: Contains item info.
        - failure: A closure to be executed once the request has finished with error.
        - error: Containing information about the error that occurred.
     - Retuns: The request.
     */
    static func getItem(id: Int,
                        success: @escaping (_ item: INPItemModel) -> Void,
                        failure: @escaping (_ error: Error) -> Void) -> Request

    /**
     Returns a collection of fees for a specific asset
     - Parameters:
         - id: Id of item that we are interested in.
         - success: A closure to be executed once the request has finished successfully.
         - accessFees: Collection of access fees for specific asset.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     - Retuns: The request.
     */
    static func getItemAccessFees(id: Int,
                                  success: @escaping (_ accessFees: [INPAccessFeeModel]) -> Void,
                                  failure: @escaping (_ error: Error) -> Void) -> Request
}

public extension InPlayer {
    final public class Asset: AssetsAPI {

        private init() {}

        @discardableResult
        public static func getItem(id: Int,
                                   success: @escaping (INPItemModel) -> Void,
                                   failure: @escaping (Error) -> Void) -> Request {
            let merchantUUID = InPlayer.Configuration.getClientId()
            return INPAssetService.getItem(id: id, merchantUUID: merchantUUID, completion: { result in
                switch result {
                case .success(let response):
                    success(response)
                case .failure(let error):
                    failure(error)
                }
            })
        }

        @discardableResult
        public static func getItemAccessFees(id: Int,
                                             success: @escaping ([INPAccessFeeModel]) -> Void,
                                             failure: @escaping (Error) -> Void) -> Request {
            return INPAssetService.getItemAccessFees(id: id, completion: { result in
                switch result {
                case .success(let response):
                    success(response)
                case .failure(let error):
                    failure(error)
                }
            })
        }
    }
}
