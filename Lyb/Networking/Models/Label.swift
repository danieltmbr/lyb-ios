//
//  Label.swift
//  Service
//
//  Created by Daniel Tombor on 2019. 04. 11..
//  Copyright © 2019. danieltmbr. All rights reserved.
//

import Foundation

public struct Label: Decodable {

    public typealias Id = Int64

    public let id: Id
    public let name: String
    public let url: URL
    public let imageUrl: URL?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case imageUrl = "image_url"
    }
}
