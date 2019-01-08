import Foundation

public struct INPAccessFeeModel : Codable {

    let accessType : INPAccessTypeModel?
    let amount : Int?
    let currency : String?
    let descriptionField : String?
    let id : Int?
    let itemType : String?
    let merchantId : Int?
    let startsAt : Double?
    let trialPeriod: INPTrialPeriodModel?
    let setupFee: INPSetupFeeModel?

    enum CodingKeys: String, CodingKey {
        case accessType = "access_type"
        case amount = "amount"
        case currency = "currency"
        case descriptionField = "description"
        case id = "id"
        case itemType = "item_type"
        case merchantId = "merchant_id"
        case startsAt = "starts_at"
        case trialPeriod = "trial_period"
        case setupFee = "setup_fee"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessType = try values.decodeIfPresent(INPAccessTypeModel.self, forKey: .accessType)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        itemType = try values.decodeIfPresent(String.self, forKey: .itemType)
        merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
        startsAt = try values.decodeIfPresent(Double.self, forKey: .startsAt)
        trialPeriod = try values.decode(INPTrialPeriodModel.self, forKey: .trialPeriod)
        setupFee = try values.decode(INPSetupFeeModel.self, forKey: .setupFee)
    }

}
