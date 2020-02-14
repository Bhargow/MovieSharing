//
//  MSGridTableViewCell.swift
//  MovieSharing
//
//  Created by Bhargow on 13.02.20.
//  Copyright © 2020 Bhargow. All rights reserved.
//

import UIKit

protocol MSGridTableViewCellDelegate {
    func didSelectItem(at indexPath: IndexPath)
}

class MSGridTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    var gridTableCellViewModel: MSGridCellViewModel!
    var delegate: MSGridTableViewCellDelegate?
}

extension MSGridTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
}

extension MSGridTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridTableCellViewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "MSCollectionViewCell", for: indexPath)
        if let gridCollectionViewItem = item as? MSCollectionViewCell {
            gridCollectionViewItem.movieDetailsViewModel = MSMovieDetailsViewModel(movieModel: gridTableCellViewModel.movieList[indexPath.row])
            gridCollectionViewItem.setDetails()
        }
        return item
    }
}

extension MSGridTableViewCell: MSMovieListViewModelDelegate {
    func refreshViews() {
        collectionView.reloadData()
    }
}
