//
//  FriendDetailsViewController.swift
//  friends
//
//  Created by Mahbubur Rashid Leon on 17/4/22.
//

import UIKit

class FriendDetailsViewController: BaseViewController {
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressDetailsLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellPhoneLabel: UILabel!
    
    var friendData: ResultsModel?
    
    override func setupView() {
        let name = friendData?.name
        navigationItem.title = "\(name?.title ?? "") \(name?.first ?? "") \(name?.last ?? "")"
        
        NetworkManger.shared.loadImage(from: friendData?.picture?.large ?? "", into: friendImage)
        
        nameLabel.text = "\(name?.title ?? "") \(name?.first ?? "") \(name?.last ?? "")"
        let location = friendData?.location
        addressLabel.text = "\(location?.street?.number ?? 0) / \(location?.street?.name ?? "")"
        addressDetailsLabel.text = "\(location?.city ?? ""), \(location?.state ?? ""), \(location?.country ?? "") "
        
        emailLabel.text = friendData?.email
        cellPhoneLabel.text = "\(friendData?.cell ?? "")\n\(friendData?.phone ?? "")"
        
        emailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendEmail)))
    }
    
    @objc private func sendEmail() {
        if let url = URL(string: "mailto:\(friendData?.email ?? "")") {
            UIApplication.shared.open(url)
        }
    }
}
