//
//  MSMovieModel.swift
//  MovieSharing
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

struct MSMovieModel: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case snippet
        case publishedAt
        case title
        case description
        case thumbnails
        case channelTitle
        case videoId
    }
    
    var id: String
    var publishedAt: Date?
    var channelTitle: String
    var title: String
    var description: String
    var thumbnails: MSMovieImages?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippet = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        let idContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .id)
        
        id = try idContainer.decode(String.self, forKey: .videoId)
        title = try snippet.decode(String.self, forKey: .title)
        channelTitle = try snippet.decode(String.self, forKey: .channelTitle)
        description = try snippet.decode(String.self, forKey: .description)
        thumbnails = try snippet.decode(MSMovieImages.self, forKey: .thumbnails)
        let publishedAtString = try snippet.decode(String.self, forKey: MSMovieModel.CodingKeys.publishedAt)
        publishedAt = publishedAtString.getDate()
    }
}
