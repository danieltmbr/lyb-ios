//
//  Config.swift
//  Lyb
//
//  Created by Daniel Tombor on 2019. 05. 05..
//  Copyright © 2019. TransferWise. All rights reserved.
//

import Foundation

/**
 * Schemes
 *
 * Name of scheme  | Build Config  | Environment Config
 * ----------------------------------------------------
 * Lyb             | Release       | Prod
 * Lyb-Dev         | Debug         | Dev
 * Lyb-Profiling   | Release       | Dev
 * Lyb-Staging     | Debug         | Staging
 * Lyb-ProdDebug   | Debug         | Prod
 *
 */

struct Environment: Decodable {
    let `protocol`: String
    let host: String
}
