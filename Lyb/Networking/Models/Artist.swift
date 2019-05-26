//
//  Artist.swift
//  LyricsService
//
//  Created by Daniel Tombor on 2018. 11. 25..
//  Copyright © 2018. danieltmbr. All rights reserved.
//

import Foundation

public struct Artist: Decodable {

    public typealias Id = Int64

    public let id: Id
    public let name: String
    public let url: URL

    public let imageUrl: URL?
    public let alternateNames: [String]
    public let facebookName: String?
    public let instagramName: String?
    public let twitterName: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case imageUrl = "image_url"
        case alternateNames = "alternate_names"
        case facebookName = "facebook_name"
        case instagramName = "instagram_name"
        case twitterName = "twitter_name"
    }
}
