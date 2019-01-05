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
                        failure: @escaping (_ error: InPlayerError) -> Void) -> Request

    /**
     Returns a collection of fees for a specific item
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
                                  failure: @escaping (_ error: InPlayerError) -> Void) -> Request

    /**
     Grants access to item
     - Parameters:
         - id: Id of item that we want access to
         - success: A closure to be executed once the request has finished successfully.
         - itemAccess: Object containing info about the item plus additional info.
         - failure: A closure to be executed once the request has finished with error.
         - error: Containing information about the error that occurred.
     - Returns: The request
     */
    static func getItemAccess(id: Int,
                              success: @escaping (_ itemAccess: INPItemAccessModel) -> Void,
                              failure: @escaping (_ error: InPlayerError) -> Void) -> Request
}

public extension InPlayer {
    final public class Asset: AssetsAPI {

        private init() {}

        @discardableResult
        public static func getItem(id: Int,
                                   success: @escaping (INPItemModel) -> Void,
                                   failure: @escaping (InPlayerError) -> Void) -> Request {
            let merchantUUID = InPlayer.Configuration.getClientId()
            return INPAssetService.getItem(id: id, merchantUUID: merchantUUID, completion: { (item, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(item!)
                }
            })
        }

        @discardableResult
        public static func getItemAccessFees(id: Int,
                                             success: @escaping ([INPAccessFeeModel]) -> Void,
                                             failure: @escaping (InPlayerError) -> Void) -> Request {
            return INPAssetService.getItemAccessFees(id: id, completion: { (accessFees, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(accessFees!)
                }
            })
        }

        @discardableResult
        public static func getItemAccess(id: Int,
                                         success: @escaping (INPItemAccessModel) -> Void,
                                         failure: @escaping (InPlayerError) -> Void) -> Request {
            return INPAssetService.getItemAccess(id: id, completion: { (itemAccess, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(itemAccess!)
                }
            })
        }
    }
}
