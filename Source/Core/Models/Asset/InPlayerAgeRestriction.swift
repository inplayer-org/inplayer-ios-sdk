//
//  InPlayerAgeRestriction.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 5/1/20.
//

import Foundation

/// Age Restriction model
public struct InPlayerAgeRestriction: Codable {
    
    /// Minimum age required in order to access the asset content.
    public let minAge: Int?
    
    enum CodingKeys: String, CodingKey {
        case minAge = "min_age"
    }
    
    /// Decoder method
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        minAge = try values.decodeIfPresent(Int.self, forKey: .minAge)
    }
    
    /// Encoder method
    public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(minAge, forKey: .minAge)
    }
}
