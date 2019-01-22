import Alamofire

public extension InPlayer {

    /**
     Class providing Asset related actions.
     */
    public final class Asset {

        private init() {}

        /**
         Gets details about given item id
         - Parameters:
             - id: Item ID
             - success: A closure to be executed once the request has finished successfully.
             - item: Contains item info.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getItemDetails(id: Int,
                                          success: @escaping (InPlayerItem) -> Void,
                                          failure: @escaping (InPlayerError) -> Void) {
            let merchantUUID = InPlayer.clientId
            INPAssetService.getItemDetails(id: id, merchantUUID: merchantUUID, completion: { (item, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(item!)
                }
            })
        }

        /**
         Returns a collection of fees for a specific item
         - Parameters:
             - id: Item ID.
             - success: A closure to be executed once the request has finished successfully.
             - accessFees: Collection of access fees for specific asset.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getItemAccessFees(id: Int,
                                             success: @escaping ([InPlayerAccessFee]) -> Void,
                                             failure: @escaping (InPlayerError) -> Void) {
            INPAssetService.getItemAccessFees(id: id, completion: { (accessFees, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(accessFees!)
                }
            })
        }

        /**
         Grants access to item
         - Parameters:
             - id: Item ID
             - success: A closure to be executed once the request has finished successfully.
             - itemAccess: Object containing info about the item plus additional info.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getItemAccess(id: Int,
                                         success: @escaping (InPlayerItemAccess) -> Void,
                                         failure: @escaping (InPlayerError) -> Void) {
            INPAssetService.getItemAccess(id: id, completion: { (itemAccess, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(itemAccess!)
                }
            })
        }
    }
}
