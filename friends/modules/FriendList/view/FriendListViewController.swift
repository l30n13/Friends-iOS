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
    
    var collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        setupView()
    }
    
    private func setupView() {
        friendsCollectionView.isHidden = true
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        friendsCollectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        fetchFriends()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateCollectionViewItemSize()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate { [weak self] _ in
            self?.updateCollectionViewItemSize()
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func updateCollectionViewItemSize() {
        let width = friendsCollectionView.frame.width / 2 - 3
        collectionViewFlowLayout.itemSize = CGSize(width: width, height: width)
        collectionViewFlowLayout.minimumLineSpacing = 5
        collectionViewFlowLayout.minimumInteritemSpacing = 5
        collectionViewFlowLayout.sectionInset = .zero
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
