//
//  MSMoviesHomeViewController.swift
//  MovieSharing
//
//  Created by Bhargow on 13.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class MSMoviesHomeViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    var currentChildViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Movies"
    }
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if currentChildViewController != nil {
                addContentController(getGridViewController())
            }
        } else {
            //showTableView
            addContentController(getListViewController())
        }
    }
    
    func getGridViewController() -> MSGridViewController {
        if let gridTableViewController = storyBoard.instantiateViewController(withIdentifier: "MSGridViewController") as? MSGridViewController {
            return gridTableViewController
        }
        return MSGridViewController()
    }
    
    func getListViewController() -> MSListViewController {
        if let listTableViewController = storyBoard.instantiateViewController(withIdentifier: "MSListViewController") as? MSListViewController {
            return listTableViewController
        }
        return MSListViewController()
    }
    
    private func addContentController(_ child: UIViewController) {
        removeExistChildFromViewController()
        currentChildViewController = child
        self.addChild(child)
        self.containerView.addSubview(child.view)
        child.view.frame = self.containerView.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.didMove(toParent: self)
    }
    
    private func removeExistChildFromViewController() {
        currentChildViewController?.willMove(toParent: nil)
        currentChildViewController?.view.removeFromSuperview()
        currentChildViewController?.removeFromParent()
    }
}
