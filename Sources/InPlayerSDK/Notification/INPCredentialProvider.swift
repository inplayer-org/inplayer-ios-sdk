import AWSCore.AWSCredentialsProvider

public final class INPCredentialProvider: AWSCredentials, AWSCredentialsProvider {

    let awsKeys: INPAwsKeyModel

    public init(awsKeys: INPAwsKeyModel) {
        self.awsKeys = awsKeys
        super.init()
    }

    public func credentials() -> AWSTask<AWSCredentials> {
        let credentials = AWSCredentials(accessKey: awsKeys.accessKey ?? "",
                                         secretKey: awsKeys.secretKey ?? "",
                                         sessionKey: awsKeys.sessionToken,
                                         expiration: awsKeys.expirationDate)
        return AWSTask(result: credentials)
    }

    public func invalidateCachedTemporaryCredentials() {}
}
