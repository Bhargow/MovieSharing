//
//  MSMovieListViewModel.swift
//  MovieSharing
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

protocol MSMovieCollectionViewModelDelegate {
    func refreshViews()
    func showError(_ error: String)
}

class MSMovieListViewModel {
    var apiManager: MSAPIManager = MSAPIManager()
    
    private var masterList: [MSMovieModel] = []
    var movieList: [MSMovieModel] = [] {
        didSet {
            delegate?.refreshViews()
        }
    }
    var delegate: MSMovieCollectionViewModelDelegate?
    
    init(delegate: MSMovieCollectionViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func getNumberOfRows() -> Int {
        return movieList.count
    }
    
    func getMovieList(urlStr: String = baseUrl, with parameters: [APIParameters : Any] = defaultParameters, forFavourites: Bool = false) {
        var urlSrting = urlStr
        apiManager.get(urlString: &urlSrting, urlParameters: parameters, completionHandler: { [weak self] (response) in
            var movieList: [MSMovieModel] = []
            if let movieDictionaries = response["items"] as? [[String : Any]] {
                for movieDict in movieDictionaries {
                    if let jsonData = try? JSONSerialization.data(withJSONObject: movieDict, options: .prettyPrinted) {
                        let decoder = JSONDecoder()
                        do {
                            let movieModel = try decoder.decode(MSMovieModel.self, from: jsonData)
                            movieList.append(movieModel)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                self?.masterList = movieList
                if forFavourites {
                    self?.fetchFavourites()
                } else {
                    self?.movieList = movieList
                }
            } else if let errorDict = response["error"] as? [String : Any], let message: String = errorDict["message"] as? String {
                self?.delegate?.showError(message)
            }
        }) {[weak self] (error) in
            switch error {
            case .invalidURL:
                self?.delegate?.showError("Invalid URL")
            case .invalidResponse:
                self?.delegate?.showError("Invalid Response")
            case .urlSessionError:
                self?.delegate?.showError("Url Session Error")
            case .invalidDataFormat:
                self?.delegate?.showError("Invalid Data Format")
            }
        }
    }
    
    func fetchFavourites() {
        var favoruitesArray: [MSMovieModel] = []
        if let favArray = UserDefaults.standard.array(forKey: "favoruites") as? [String] {
            for id in favArray {
                let filterdMovieList = self.masterList.filter { (model) -> Bool in
                    return model.id == id
                }
                if !filterdMovieList.isEmpty {
                    if let filteredModel = filterdMovieList.first {
                        favoruitesArray.append(filteredModel)
                    }
                }
            }
        }
        movieList = favoruitesArray
    }
    
    func getNumberOfFavoruiteMovies() -> Int {
        var favoruitesArray: [String] = []
        if let favArray = UserDefaults.standard.array(forKey: "favoruites") as? [String] {
            favoruitesArray = favArray
        }
        return favoruitesArray.count
    }
    
    func filterMoviesBasedOnText(text: String) {
        if text.isEmpty {
            movieList = masterList
            self.fetchFavourites()
        } else {
            self.movieList = movieList.filter({ (model) -> Bool in
                return model.title.contains(text)
            })
            
        }
    }
}
