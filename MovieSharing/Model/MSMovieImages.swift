//
//  MSMovieImages.swift
//  MovieSharing
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

struct MSMovieImages: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case defaultImage = "default"
        case medium
        case high
    }
    
    var defaultImage: MSMovieImageData
    var medium: MSMovieImageData
    var high: MSMovieImageData
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        defaultImage = try container.decode(MSMovieImageData.self, forKey: .defaultImage)
        medium = try container.decode(MSMovieImageData.self, forKey: .medium)
        high = try container.decode(MSMovieImageData.self, forKey: .high)
    }
}
