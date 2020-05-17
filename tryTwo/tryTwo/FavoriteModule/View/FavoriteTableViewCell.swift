//
//  DetailTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 20/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit


final class FavoriteTableViewCell: UITableViewCell {

    //MARK: - Constants

    private enum Constants {
        static let aboutLabelFontSize: CGFloat = 13
        static let releaseLabelFontSize: CGFloat = 14
    }


    //MARK: - IBOutlets

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


    //MARK: - Public methods

    func configureCell(with movie: Movie) {
        let link = LinkBuilder()
        imageViewCell.loadImage(link.pathPoster(path: movie.posterPath, size: .w500))
        titleLabel.text = movie.title
        releaseLabel.setYear(movie)
        scoreLabel.text = "\(movie.voteAverage)"
        aboutLabel.text = movie.overview
    }


    //MARK: - Private methods

    private func configureLabels() {
        titleLabel.numberOfLines = 0
        
        aboutLabel.numberOfLines = 0
        aboutLabel.font = .systemFont(ofSize: Constants.aboutLabelFontSize)
        
        releaseLabel.textColor = .lightGray
        releaseLabel.font = .systemFont(ofSize: Constants.releaseLabelFontSize)
    }
    
}
