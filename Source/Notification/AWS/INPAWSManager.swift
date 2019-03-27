import AWSIoT
import AWSCore

enum INPPayloadResult<InPlayerNotification, InPlayerError> {
    case success(_ value: InPlayerNotification)
    case failure(_ error: InPlayerError)
}

final class INPAWSManager {

    private typealias InPlayerPayloadResult = INPPayloadResult<InPlayerNotification, InPlayerError>
    private static let InPlayerIoTDataManager = "InPlayerIoTDataManager"
    private static var awsKeys: InPlayerAwsKey?
    private static var iotDataManager: AWSIoTDataManager?
    static var isSubscribed: Bool = false

    private init() {}

    static func subscribe(onStatusChanged: @escaping (_ status: InPlayerNotificationStatus) -> Void,
                          onMessageReceived: @escaping (_ notification: InPlayerNotification) -> Void,
                          onError: @escaping (_ error: InPlayerError) -> Void) {

        guard isSubscribed == false else { return }

        guard let clientUUID = InPlayer.Account.getAccountInfo()?.uuid else {
            return onError(InPlayerUnauthorizedError())
        }
        isSubscribed = true

        // Get credentials
        takeAWSCredentials(success: { awsKeys in
            self.awsKeys = awsKeys

            // setup aws
            setupAWSConfiguration()

            // connect to aws
            connectToAws(clientUUID: clientUUID, statusCallback: { status in
                onStatusChanged(status)
                if status == .connected {
                    isSubscribed = true
                    // subscribe for notifications
                    subscribe(clientUUID: clientUUID, messageCallback: { (result) in
                        switch result {
                        case .success(let notification):
                            onMessageReceived(notification)
                        case .failure(let error):
                            onError(error)
                            isSubscribed = false
                        }
                    })
                } else if status != .connecting {
                    isSubscribed = false
                }
            })
        }, failure: { (error) in
            onError(error)
            isSubscribed = false
        })
    }

    static func unsubscribe() {
        iotDataManager?.disconnect()
        isSubscribed = false
    }
}

extension INPAWSManager {

    // MARK: - Private

    private static func setupAWSConfiguration() {
        guard let awsKeys = awsKeys, let endpoint = awsKeys.iotEndpoint else { return }
        let credentialsProvider = INPCredentialProvider(awsKeys: awsKeys)
        let iotEndpoint = AWSEndpoint(urlString: "https://" + NetworkConstants.BaseUrls.AWS.endpoint) //  AWSEndpoint(urlString: "https://" + endpoint)
        let awsConfiguration = AWSServiceConfiguration(region: awsKeys.getAwsRegion(),
                                                       endpoint: iotEndpoint,
                                                       credentialsProvider: credentialsProvider)!
        AWSServiceManager.default().defaultServiceConfiguration = awsConfiguration
        AWSIoTDataManager.register(with: awsConfiguration, forKey: InPlayerIoTDataManager)

        iotDataManager = AWSIoTDataManager(forKey: InPlayerIoTDataManager)
    }

    private static func takeAWSCredentials(success: @escaping (_ awsKeys: InPlayerAwsKey) -> Void,
                                           failure: @escaping (_ error: InPlayerError) -> Void) {
        INPNotificationService.takeAwsCredentials { (awsKeys, error) in
            if let error = error {
                failure(error)
            } else {
                success(awsKeys!)
            }
        }
    }

    private static func connectToAws(clientUUID: String,
                                     statusCallback: @escaping (_ status: InPlayerNotificationStatus) -> Void) {
        assert(iotDataManager != nil, "Please call setupAWSConfiguration first")
        iotDataManager?.connectUsingWebSocket(withClientId: clientUUID,
                                              cleanSession: true,
                                              statusCallback: { status in
            statusCallback(InPlayerNotificationStatus.fromAwsStatus(status: status))
        })
    }

    private static func subscribe(clientUUID: String,
                                  messageCallback: @escaping (InPlayerPayloadResult) -> Void) {

        iotDataManager?.subscribe(toTopic: clientUUID,
                                  qoS: .messageDeliveryAttemptedAtMostOnce,
                                  messageCallback: { payload in
                                    do {
                                        let notification = try payload.decoded() as InPlayerNotification
                                        messageCallback(INPPayloadResult.success(notification))
                                    } catch {
                                        let inpError = InPlayerErrorMapper.mapFromError(originalError: error,
                                                                                        withResponseData: nil)
                                        messageCallback(INPPayloadResult.failure(inpError))
                                    }
        })
    }
}

/// Notification status regarding websocket connection
public enum InPlayerNotificationStatus: String {
    case connecting
    case connected
    case disconnected
    case connectionRefused
    case connectionError
    case protocolError
    case unknown

    static func fromAwsStatus(status: AWSIoTMQTTStatus) -> InPlayerNotificationStatus {
        switch status {
        case .connecting: return .connecting
        case .connected: return .connected
        case .disconnected: return .disconnected
        case .connectionRefused: return .connectionRefused
        case .connectionError: return .connectionError
        case .protocolError: return .protocolError
        default: return .unknown
        }
    }
}

extension InPlayerAwsKey {
    func getAwsRegion() -> AWSRegionType {
        guard let region = region else { return .Unknown }
        switch region {
        case "eu-west-1": return .EUWest1
        case "eu-west-2": return .EUWest2
        case "eu-west-3": return .EUWest3
        case "eu-central-1": return .EUCentral1
        case "eu-north-1": return .EUNorth1

        case "us-east-1": return .USEast1
        case "us-east-2": return .USEast2
        case "us-west-1": return .USWest1
        case "us-west-2": return .USWest2
        case "us-gov-west-1": return .USGovWest1
        case "us-gov-east-1": return .USGovEast1

        case "ap-southeast-1": return .APSoutheast1
        case "ap-southeast-2": return .APSoutheast2
        case "ap-northeast-1": return .APNortheast1
        case "ap-northeast-2": return .APNortheast2
        case "ap-south-1": return .APSouth1

        case "sa-east-1": return .SAEast1

        case "cn-north-1": return .CNNorth1
        case "cn-northwest-1": return .CNNorthWest1

        case "ca-central-1": return .CACentral1

        default: return .Unknown
        }
    }
}
