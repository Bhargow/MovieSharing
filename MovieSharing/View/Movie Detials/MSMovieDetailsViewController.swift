//
//  MSMovieDetailsViewController.swift
//  MovieSharing
//
//  Created by Bhargow on 14.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class MSMovieDetailsViewController: UIViewController {

    @IBOutlet var imgViewBanner: UIImageView!
    @IBOutlet var imgViewThumbnail: UIImageView!
    @IBOutlet var imgViewThumbnailBG: UIImageView!
    @IBOutlet var blurEffectView: UIVisualEffectView!
    
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblChannelTitle: UILabel!
    @IBOutlet var lblPublishDate: UILabel!
    
    @IBOutlet var btnLike: UIButton!
    @IBOutlet var btnDislike: UIButton!

    
    var movieDetailsViewModel: MSMovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        
        imgViewThumbnail.layer.cornerRadius = 6
        imgViewThumbnail.clipsToBounds = true
        
        imgViewThumbnailBG.layer.cornerRadius = imgViewThumbnailBG.frame.width/2.5
        imgViewThumbnailBG.clipsToBounds = true
        
        blurEffectView.layer.cornerRadius = 6
        blurEffectView.clipsToBounds = false
        
        setupDetailsFormViewModel()
        
        let btnAddToFavourites: UIBarButtonItem = UIBarButtonItem.init(image: UIImage(named: movieDetailsViewModel.isFavoruite() ? "FavoritesLight" : "FavoritesDisabled"), style: .plain, target: self, action: #selector(self.addToFavoruites))
        self.navigationItem.rightBarButtonItem = btnAddToFavourites
    }
    
    func setupDetailsFormViewModel() {
        lblTitle.text = movieDetailsViewModel.getTitle()
        lblChannelTitle.text = movieDetailsViewModel.getChannelTitle()
        lblDescription.text = movieDetailsViewModel.getDescription()
        lblPublishDate.text = movieDetailsViewModel.getDate()
        
        guard let defaultResUrl = URL.init(string: movieDetailsViewModel.getDefaultResImageUrl()) else {
            return
        }
        
        DispatchQueue.main.async {
            if let data = try? Data.init(contentsOf: defaultResUrl){
                if let image = UIImage(data: data) {
                    self.imgViewThumbnail.image = image
                    self.imgViewThumbnailBG.image = image
                }
            }
        }
        
        guard let highResUrl = URL.init(string: movieDetailsViewModel.getHighResImageUrl()) else {
            return
        }
        
        DispatchQueue.main.async {
            if let data = try? Data.init(contentsOf: highResUrl){
                if let image = UIImage(data: data) {
                    self.imgViewBanner.image = image
                }
            }
        }
        
        if let likeAndDislikes = movieDetailsViewModel.getLikeAndDislikes() {
            if likeAndDislikes["liked"] == true {
                btnLike.setImage(UIImage(named: "liked"), for: UIControl.State.normal)
                btnDislike.setImage(UIImage(named: "disLike"), for: UIControl.State.normal)
            } else if likeAndDislikes["disliked"] == true {
                btnLike.setImage(UIImage(named: "like"), for: UIControl.State.normal)
                btnDislike.setImage(UIImage(named: "disLiked"), for: UIControl.State.normal)
            }
        }
    }
    
    @objc func addToFavoruites(_ barButton: UIBarButtonItem) {
        movieDetailsViewModel.addOrRemoveFavoruites()
        barButton.image = UIImage(named: movieDetailsViewModel.isFavoruite() ? "FavoritesLight" : "FavoritesDisabled")
    }
    
    @IBAction func likeOrDislike(_ button: UIButton) {
        if button.tag == 1 {
            movieDetailsViewModel.likeOrDislike(shouldLike: true)
            btnLike.setImage(UIImage(named: "liked"), for: UIControl.State.normal)
            btnDislike.setImage(UIImage(named: "disLike"), for: UIControl.State.normal)
        } else {
            movieDetailsViewModel.likeOrDislike(shouldLike: false)
            btnLike.setImage(UIImage(named: "like"), for: UIControl.State.normal)
            btnDislike.setImage(UIImage(named: "disLiked"), for: UIControl.State.normal)
        }
    }
}
