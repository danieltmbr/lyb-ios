//
//  JsonHelper.swift
//  NetworkingTests
//
//  Created by Daniel Tombor on 2019. 05. 26..
//  Copyright © 2019. Daniel Tombor. All rights reserved.
//

import Foundation

func getJsonData(for name: String) -> Data {
	guard let jsonFileUrl = Bundle(for: TestBundle.self).url(forResource: name, withExtension: "json"),
		let jsonData = try? Data(contentsOf: jsonFileUrl)
		else { fatalError() }
	return jsonData
}

private final class TestBundle {}
