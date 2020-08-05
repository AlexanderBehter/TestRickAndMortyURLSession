//
//  DetailViewController.swift
//  TestRickAndMortyURLSession
//
//  Created by Александр Бехтер on 24.07.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var backgroundShadowView: UIView!
    @IBOutlet weak var photoPersonImageView: UIImageView!
    @IBOutlet weak var largeIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var character: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
        setupNavigationBar()
        setupCharacterImageView()
        
        largeIndicator.startAnimating()
        largeIndicator.hidesWhenStopped = true
        
        largeIndicator.customViews()
        backgroundShadowView.customViews()
        photoPersonImageView.customViews()
        
    }
    private func setupCharacterImageView() {
        
        DispatchQueue.main.async {
            let stringURL = self.character.image
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.largeIndicator.stopAnimating()
                self.photoPersonImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setupLabels() {
        nameLabel.text = "My name is \(character.name)"
        statusLabel.text = "Status - \(character.status)"
        speciesLabel.text = "Species - \(character.species)"
        genderLabel.text = "Gender - \(character.gender)"
        originLabel.text = "Origin - \(character.origin.name)"
        locationLabel.text = "Location - \(character.location.name)"
    }
    
    private func setupNavigationBar() {
        title = character.name
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                        style: .plain,
                                                        target: nil,
                                                        action: nil)
        }
    }

}
