//
//  CastCollectionViewCell.swift
//  tryTwo
//
//  Created by fivecoil on 03/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {
    
    //MARK: - PrivateProperties
    @IBOutlet private weak var shadowView: UIView!
    
    @IBOutlet private weak var cardView: UIView!
    
    @IBOutlet private weak var posterImageView: UIImageView!
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var castLabel: UILabel!
    
    //MARK: - LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    //MARK: - Maethods
    func configureCell(with cast: Cast) {
        posterImageView.loadImage(cast.profilePath)
        nameLabel.text = cast.name
        castLabel.text = cast.character
    }
    
    //MARK: - Private methods
    private func configureUI() {
        shadowView.createShadow()
        cardView.layer.cornerRadius = 12
        
        nameLabel.font = .boldSystemFont(ofSize: 13)
        castLabel.font = .systemFont(ofSize: 12)
    }

}
