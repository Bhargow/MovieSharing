//
//  MSGridTableCellViewModel.swift
//  MovieSharing
//
//  Created by Bhargow on 13.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

protocol MSMovieListViewModelDelegate {
    func refreshViews()
}

class MSGridCellViewModel {
    
    var delegate: MSMovieListViewModelDelegate?
    
    var movieList: [MSMovieModel] = [] {
        didSet {
            delegate?.refreshViews()
        }
    }
    
    init(delegate: MSMovieListViewModelDelegate? = nil, movieList: [MSMovieModel]) {
        self.delegate = delegate
        self.movieList = movieList
    }
    
    func getNumberOfItems() -> Int {
        return movieList.count
    }
}
