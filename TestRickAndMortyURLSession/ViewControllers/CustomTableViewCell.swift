//
//  CustomTableViewCell.swift
//  TestRickAndMortyURLSession
//
//  Created by Александр Бехтер on 24.07.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundShadowView: UIView!
    @IBOutlet weak var personsImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        backgroundShadowView.customViews()
        personsImageView.customViews()
        activityIndicator.customViews()
    }

    func configure(with results: Result?) {
        nameLabel.text = results?.name
        DispatchQueue.global().async {
            guard let stringURL = results?.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.personsImageView.image = UIImage(data: imageData)
            }
        }
    }
}

extension UIView {
    func customViews() {
        self.layer.cornerRadius = self.frame.size.height / 4
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        
    }
}
