//
//  MSConstants.swift
//  MovieSharing
//
//  Created by Bhargow on 12.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import Foundation
import UIKit

let baseUrl: String = "https://www.googleapis.com/youtube/v3/search?"
let APIKey: String = "AIzaSyANggy_mM-VSWGxiuEw1cndoWzHubW2Tk4"
let maxResults: Int = 25
let defaultParameters : [APIParameters : Any] = [.responseContentType : "Snippet",
                                          .searchKeyWord : "Movies 2020",
                                          .maxResults : maxResults,
                                          .apiKey : APIKey]
let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let activityIndicatorViewTag = 345


extension UIViewController {
    
    func showProgress() {
        hideProgress()
        let activityIndicatorView = MSActivityIndicatorView.instanceFromNib()
        activityIndicatorView.tag = activityIndicatorViewTag
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        let constX:NSLayoutConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0);
        
        let constY:NSLayoutConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0);
        
        let constWidth:NSLayoutConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0);
        
        let constHeight:NSLayoutConstraint = NSLayoutConstraint(item: activityIndicatorView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0);
        self.view.addConstraints([constX,constY,constWidth,constHeight])
    }
    
    func hideProgress() {
        
        let filteredViews = self.view.subviews.filter { (view) -> Bool in
            return view.tag == activityIndicatorViewTag
        }
        if let activityIndicatorView = filteredViews.first as? MSActivityIndicatorView {
            activityIndicatorView.removeFromSuperview()
        }
    }
    
    func showErrorAlert(_ message: String) {
        let alertControler = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alertControler.dismiss(animated: true)
        }
        alertControler.addAction(okAction)
        self.present(alertControler, animated: true)
    }
}

extension String {
    func getDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.date(from: self)
    }
}

extension Date {
    func getString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: self)
    }
}
