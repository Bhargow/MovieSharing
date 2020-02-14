//
//  MSCollectionViewCell.swift
//  MovieSharing
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class MSCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imgViewMovie: UIImageView!
    @IBOutlet var imgBGViewMovie: UIImageView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var lblMovieTitle: UILabel!
    
    var movieDetailsViewModel: MSMovieDetailsViewModel!
    
    override func awakeFromNib() {
        imgViewMovie.layer.cornerRadius = 6
        imgViewMovie.clipsToBounds = true
    
        imgBGViewMovie.layer.cornerRadius = imgBGViewMovie.frame.height/2.5
        imgBGViewMovie.clipsToBounds = true
        
        blurView.layer.cornerRadius = 6
        blurView.clipsToBounds = false
    }
    
    func setDetails() {        
        lblMovieTitle.text = movieDetailsViewModel.getTitle()
        guard let url = URL.init(string: movieDetailsViewModel.getMediumResImageUrl()) else {
            return
        }
        
        DispatchQueue.main.async {
            if let data = try? Data.init(contentsOf: url){
                if let image = UIImage(data: data) {
                    self.imgViewMovie.image = image
                    self.imgBGViewMovie.image = image
                }
            }
        }
    }
}
