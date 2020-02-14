//
//  MSGridViewController.swift
//  MovieSharing
//
//  Created by Bhargow on 13.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

class MSGridViewController: UIViewController {

    var movieListViewModel: MSMovieListViewModel!
    @IBOutlet var movieGridTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListViewModel = MSMovieListViewModel(delegate: self)
        showProgress()
        movieListViewModel.getMovieList()
        movieGridTableView.tableFooterView = UIView()
    }
}

extension MSGridViewController: UITableViewDataSource {
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.getNumberOfRows() > 0 ? 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MSGridTableViewCell", for: indexPath)
        if let gridTableViewCell = cell as? MSGridTableViewCell {
            let gridTableCellViewModel = MSGridCellViewModel(delegate: gridTableViewCell, movieList: movieListViewModel.movieList)
            gridTableViewCell.gridTableCellViewModel = gridTableCellViewModel
            gridTableViewCell.delegate = self
        }
        return cell
    }
}

extension MSGridViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
}

extension MSGridViewController: MSGridTableViewCellDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        //navgateToDetailsViewController
        if let movieDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "MSMovieDetailsViewController") as? MSMovieDetailsViewController {
            movieDetailsViewController.movieDetailsViewModel = MSMovieDetailsViewModel(movieModel: movieListViewModel.movieList[indexPath.row])
            self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
        }
    }
}

extension MSGridViewController: MSMovieCollectionViewModelDelegate {
    func refreshViews() {
        DispatchQueue.main.async {
            self.hideProgress()
            self.movieGridTableView.reloadData()
        }
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            self.hideProgress()
            self.showErrorAlert(error)
        }
    }
}
