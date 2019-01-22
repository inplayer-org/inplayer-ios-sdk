import AWSCore.AWSCredentialsProvider

final class INPCredentialProvider: AWSCredentials, AWSCredentialsProvider {

    let awsKeys: InPlayerAwsKey

    init(awsKeys: InPlayerAwsKey) {
        self.awsKeys = awsKeys
        super.init()
    }

    func credentials() -> AWSTask<AWSCredentials> {
        let credentials = AWSCredentials(accessKey: awsKeys.accessKey ?? "",
                                         secretKey: awsKeys.secretKey ?? "",
                                         sessionKey: awsKeys.sessionToken,
                                         expiration: awsKeys.expirationDate)
        return AWSTask(result: credentials)
    }

    func invalidateCachedTemporaryCredentials() {}
}
