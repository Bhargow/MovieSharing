//
//  MSMovieDetailsViewModel.swift
//  MovieSharing
//
//  Created by Bhargow on 13.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation

class MSMovieDetailsViewModel {
    private var movieModel: MSMovieModel!
    
    init(movieModel: MSMovieModel) {
        self.movieModel = movieModel
    }
    
    func getId() -> String {
        return movieModel.id
    }
    
    func getDate() -> String {
        return movieModel.publishedAt?.getString() ?? ""
    }
    
    func getTitle() -> String {
        return movieModel.title.capitalized
    }
    
    func getChannelTitle() -> String {
        return movieModel.channelTitle.capitalized
    }
    
    func getDescription() -> String {
        return "\(movieModel.description)\n\n\n\nThis is to show the funtionality of the scrollview.\n\n\n\nLorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.".capitalized
    }
    
    func getNumberOfViews() -> String {
        #warning("Need changed to the model to implement this")
        return ""
    }
    
    func getMediumResImageUrl() -> String {
        return movieModel.thumbnails?.medium.url ?? ""
    }
    
    func getDefaultResImageUrl() -> String {
        return movieModel.thumbnails?.defaultImage.url ?? ""
    }
    
    func getHighResImageUrl() -> String {
        return movieModel.thumbnails?.high.url ?? ""
    }
    
    func addOrRemoveFavoruites() {
        let id = self.getId()
        var favoruitesArray: [String] = []
        if let favArray = UserDefaults.standard.array(forKey: "favoruites") as? [String] {
            favoruitesArray = favArray
            if favoruitesArray.contains(id)
            {
                favoruitesArray = favoruitesArray.filter { (currentId) -> Bool in
                    return id != currentId
                }
                UserDefaults.standard.set(favoruitesArray, forKey: "favoruites")
                UserDefaults.standard.synchronize()
                return
            }
        }
        favoruitesArray.append(id)
        UserDefaults.standard.set(favoruitesArray, forKey: "favoruites")
        UserDefaults.standard.synchronize()
    }
    
    func isFavoruite() -> Bool {
        let id = self.getId()
        var favoruitesArray: [String] = []
        
        if let favArray = UserDefaults.standard.array(forKey: "favoruites") as? [String] {
            favoruitesArray = favArray
            if favoruitesArray.contains(id)
            {
                return true
            }
        }
        return false
    }
    
    func likeOrDislike(shouldLike: Bool) {
        let id = self.getId()
        var likeDictionary: [String: Bool]
        
        if let likeDict = UserDefaults.standard.value(forKey: "likesAndDislike\(id)") as? [String : Bool] {
            likeDictionary = likeDict
        }
        
        if shouldLike {
            likeDictionary = ["liked" : true, "disliked" : false]
        } else {
            likeDictionary = ["liked" : false, "disliked" : true]
        }
        UserDefaults.standard.set(likeDictionary, forKey: "likesAndDislike\(id)")
        UserDefaults.standard.synchronize()
    }
    
    func getLikeAndDislikes() -> [String: Bool]? {
        let id = self.getId()
        if let likeDict = UserDefaults.standard.value(forKey: "likesAndDislike\(id)") as? [String : Bool] {
             return likeDict
        }
        return nil
    }
}

