//
//  URLSessionConfigurations.swift
//  Service
//
//  Created by Daniel Tombor on 2019. 04. 15..
//  Copyright © 2019. danieltmbr. All rights reserved.
//

import Foundation

public extension URLSessionConfiguration {

    static var lyb: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.waitsForConnectivity = true
        return config
    }
}
