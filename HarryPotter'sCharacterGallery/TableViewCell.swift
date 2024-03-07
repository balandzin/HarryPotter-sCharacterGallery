//
//  TableViewCell.swift
//  HarryPotter'sCharacterGallery
//
//  Created by Антон Баландин on 6.03.24.
//

import UIKit


final class TableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var characterImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var houseLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    let emptyUrl =  "https://uploads.turbologo.com/uploads/design/hq_preview_image/5097676/draw_svg20210617-26747-23281c.svg.png"
    
    // MARK: - Public methods
    func configure(with character: Character) {
        nameLabel.text = character.name
        houseLabel.text = character.house.rawValue
        
        
        networkManager.fetchImage(from: URL(string: character.image) ?? URL(string: emptyUrl)!) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
