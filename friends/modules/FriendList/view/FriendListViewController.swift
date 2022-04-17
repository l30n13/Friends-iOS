//
//  FriendListViewController.swift
//  friends
//
//  Created by Mahbubur Rashid Leon on 17/4/22.
//

import UIKit


class FriendListViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    let viewModel = FriendListVM()
    var friendsList: [ResultsModel]?
    
    override func viewDidLoad() {
        setupView()
    }
    
    private func setupView() {
        friendsCollectionView.isHidden = true
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        
        fetchFriends()
    }
}

extension FriendListViewController {
    func fetchFriends() {
        viewModel.fetchMyFriends { [weak self] (friendsList) in
            DispatchQueue.main.async {
                self?.friendsList = friendsList
                self?.friendsCollectionView.reloadData()
                if friendsList.count > 0 {
                    self?.loadingIndicator.stopAnimating()
                    self?.friendsCollectionView.isHidden = false
                }
            }
        }   
    }
}

// MARK: UICollectionViewDataSource
extension FriendListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendListCollectionViewCell", for: indexPath) as! FriendListCollectionViewCell
        cell.setupView(data: friendsList?[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension FriendListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension FriendListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}

