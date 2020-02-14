//
//  MSActivityIndicatorView.swift
//  MovieSharing
//
//  Created by Bhargow on 14.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class MSActivityIndicatorView: UIView {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MSActivityIndicatorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        activityIndicator.startAnimating()
    }
}
