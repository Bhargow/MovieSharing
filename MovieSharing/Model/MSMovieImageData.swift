//
//  MSMovieImageData.swift
//  MovieSharing
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

struct MSMovieImageData: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }
    
    var url: String
    var width: Double
    var height: Double
}
