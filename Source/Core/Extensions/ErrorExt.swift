//
//  ErrorExt.swift
//  InPlayerSDK
//
//  Created by Oliver Dimitrov on 2/20/20.
//  Copyright © 2020 InPlayer. All rights reserved.
//

import Foundation
import Alamofire

extension Error {
    /// Returns the instance cast as an `AFError`.
    public var asAFError: AFError? {
        return self as? AFError
    }

    /// Returns the instance cast as an `AFError`. If casting fails, a `fatalError` with the specified `message` is thrown.
    public func asAFError(orFailWith message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> AFError {
        guard let afError = self as? AFError else {
            fatalError(message(), file: file, line: line)
        }
        return afError
    }

    /// Casts the instance as `AFError` or returns `defaultAFError`
    func asAFError(or defaultAFError: @autoclosure () -> AFError) -> AFError {
        return self as? AFError ?? defaultAFError()
    }
}
