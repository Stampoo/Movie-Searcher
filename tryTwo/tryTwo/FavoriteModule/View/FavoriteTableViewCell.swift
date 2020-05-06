//
//  DetailTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 20/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit


final class FavoriteTableViewCell: UITableViewCell {
    
    //MARK: - Private properties
    @IBOutlet private weak var imageViewCell: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var aboutLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var releaseLabel: UILabel!
    
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureLabels()
    }

    //MARK: - Internal methods
    //transfer data into this controller
    func configureCell(_ film: Movie) {
        let link = LinkBuilder()
        imageViewCell.loadImage(link.posterPath(path: film.posterPath, size: .w500))
        titleLabel.text = film.title
        releaseLabel.setYear(film)
        scoreLabel.text = "\(film.voteAverage)"
        aboutLabel.text = film.overview
    }
    
    //MARK: - Private methods
    //configure all labels
    private func configureLabels() {
        titleLabel.numberOfLines = 0
        
        aboutLabel.numberOfLines = 0
        aboutLabel.font = .systemFont(ofSize: 13)
        
        releaseLabel.textColor = .lightGray
        releaseLabel.font = .systemFont(ofSize: 14)
    }
    
}
