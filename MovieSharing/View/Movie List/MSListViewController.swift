//
//  MSListViewController.swift
//  MovieSharing
//
//  Created by Bhargow on 13.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class MSListViewController: UIViewController {
    
    @IBOutlet var movieListTableView: UITableView!
    
    var movieListViewModel: MSMovieListViewModel!
    
    @IBInspectable var isDisplayingFavourites: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListViewModel = MSMovieListViewModel(delegate: self)
        movieListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showProgress()
        movieListViewModel.getMovieList(forFavourites: isDisplayingFavourites)
    }
    
    @IBAction func filterMoviesBasedOnText(_ txtField: UITextField) {
        movieListViewModel.filterMoviesBasedOnText(text: txtField.text ?? "")
    }
}

extension MSListViewController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSListTableViewCell", for: indexPath)
        if let gridTableViewCell = cell as? MSListTableViewCell {
            gridTableViewCell.movieDetailsViewModel = MSMovieDetailsViewModel(movieModel: movieListViewModel.movieList[indexPath.row])
            gridTableViewCell.setDetails()
        }
        return cell
    }
}

extension MSListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "MSMovieDetailsViewController") as? MSMovieDetailsViewController {
            movieDetailsViewController.movieDetailsViewModel = MSMovieDetailsViewModel(movieModel: movieListViewModel.movieList[indexPath.row])
            self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
        }
    }
}

extension MSListViewController: MSMovieCollectionViewModelDelegate {
    func refreshViews() {
        DispatchQueue.main.async {
            self.hideProgress()
            self.movieListTableView.reloadData()
        }
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            self.hideProgress()
            self.showErrorAlert(error)
        }
    }
}
