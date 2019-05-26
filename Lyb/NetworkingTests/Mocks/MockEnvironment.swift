//
//  MockEnvironment.swift
//  NetworkingTests
//
//  Created by Daniel Tombor on 2019. 05. 26..
//  Copyright © 2019. Daniel Tombor. All rights reserved.
//

import Networking

struct MockEnv: ApiEnvironment {
	let name: String
	let baseUrl: URL
	let headers: [String : String]?
}
