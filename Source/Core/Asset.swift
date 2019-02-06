import Alamofire

public extension InPlayer {

    /**
     Class providing Asset related actions.
     */
    public final class Asset {

        private init() {}

        /**
         Gets details about given asset id
         - Parameters:
             - id: Asset ID
             - success: A closure to be executed once the request has finished successfully.
             - asset: Contains item info.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getAsset(id: Int,
                                    success: @escaping (InPlayerItem) -> Void,
                                    failure: @escaping (InPlayerError) -> Void) {
            let merchantUUID = InPlayer.clientId
            INPAssetService.getAssetDetails(id: id, merchantUUID: merchantUUID, completion: { (asset, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(asset!)
                }
            })
        }

        /**
         Returns a collection of fees for a specific asset
         - Parameters:
             - id: Asset ID.
             - success: A closure to be executed once the request has finished successfully.
             - accessFees: Collection of access fees for specific asset.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func getItemAccessFees(id: Int,
                                             success: @escaping ([InPlayerAccessFee]) -> Void,
                                             failure: @escaping (InPlayerError) -> Void) {
            INPAssetService.getAssetAccessFees(id: id, completion: { (accessFees, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(accessFees!)
                }
            })
        }

        /**
         This method checks and retrieves a customer's entitlement to an asset
         - Parameters:
             - id: Asset ID
             - success: A closure to be executed once the request has finished successfully.
             - itemAccess: Object containing info about the item plus additional info.
             - failure: A closure to be executed once the request has finished with error.
             - error: Containing information about the error that occurred.
         */
        public static func checkAccessForAsset(id: Int,
                                               success: @escaping (InPlayerItemAccess) -> Void,
                                               failure: @escaping (InPlayerError) -> Void) {
            INPAssetService.checkAccessForAsset(id: id, completion: { (itemAccess, error) in
                if let error = error {
                    failure(error)
                } else {
                    success(itemAccess!)
                }
            })
        }
    }
}
