//
//  FriendListCollectionViewCell.swift
//  friends
//
//  Created by Mahbubur Rashid Leon on 17/4/22.
//

import UIKit

class FriendListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendAddress: UILabel!
    
    override func prepareForReuse() {
        friendName.text = nil
        friendAddress.text = nil
        friendImage.image = nil
    }
    
    func setupView(data: ResultsModel?) {
        drawBorderAndMakeCornerRadius()
        if let imageUrl = data?.picture?.large {
            NetworkManger.shared.loadImage(from: imageUrl, into: friendImage)
        }
        let name = data?.name
        friendName.text = "\(name?.title ?? "") \(name?.first ?? "") \(name?.last ?? "")"
        friendAddress.text = data?.location?.country
    }
    
    //For make corner radius and add shadow
    private func drawBorderAndMakeCornerRadius() {
        let layer = mainBackgroundView.layer
        layer.cornerRadius = 10
        layer.shadowRadius = 3
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
