//
//  CharacterDetailsViewController.swift
//  HarryPotter'sCharacterGallery
//
//  Created by Антон Баландин on 6.03.24.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    var character: Character!
    
    let emptyUrl =  "https://uploads.turbologo.com/uploads/design/hq_preview_image/5097676/draw_svg20210617-26747-23281c.svg.png"
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()
        descriptionLabel.text = character.description
    }
    
    private func fetchImage() {
        networkManager.fetchImage(from: URL(string: character.image) ?? URL(string: emptyUrl)!) { result in
            switch result {
            case .success(let imageData):
                self.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}
