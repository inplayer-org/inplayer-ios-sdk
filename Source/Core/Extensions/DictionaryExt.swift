//
//  DictionaryExt.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 4/24/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import Foundation

extension Dictionary {
    func toString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                     options: .prettyPrinted) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
