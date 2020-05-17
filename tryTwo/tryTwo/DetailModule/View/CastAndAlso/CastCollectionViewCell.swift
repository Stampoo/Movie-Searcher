//
//  CastCollectionViewCell.swift
//  tryTwo
//
//  Created by fivecoil on 03/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CastCollectionViewCell: UICollectionViewCell {

    //MARK: - Constants

    private enum Constants {
        static let cardViewRoundingAngle: CGFloat = 12
        static let nameLabelFontSize: CGFloat = 13
        static let castLabelFontSize: CGFloat = 12
    }


    //MARK: - IBOutlets

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


    //MARK: - Public methods

    func configureCell(with cast: Cast) {
        posterImageView.loadImage(LinkBuilder().pathPoster(path: cast.profilePath, size: .w500))
        nameLabel.text = cast.name
        castLabel.text = cast.character
    }

    func configureCell(with alsoMovie: Result) {
        posterImageView.loadImage(LinkBuilder().pathPoster(path: alsoMovie.posterPath, size: .w500))
        nameLabel.text = alsoMovie.title
        castLabel.text = alsoMovie.releaseDate
    }


    //MARK: - Private methods

    private func configureUI() {
        shadowView.layer.cornerRadius = Constants.cardViewRoundingAngle
        shadowView.createShadow()
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = Constants.cardViewRoundingAngle
        
        nameLabel.font = .boldSystemFont(ofSize: Constants.nameLabelFontSize)
        castLabel.font = .systemFont(ofSize: Constants.castLabelFontSize)
    }

}
