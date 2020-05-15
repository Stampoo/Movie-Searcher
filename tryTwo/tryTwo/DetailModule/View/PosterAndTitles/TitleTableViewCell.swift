//
//  TitleTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 21/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class TitleTableViewCell: UITableViewCell {

    //MARK: - Constants

    private enum Constants {
        static let titleFontSize: CGFloat = 24
        static let yearFontSize: CGFloat = 13
    }

    //MARK: - IBOutlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var originalTitleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var aboutTextLabel: UILabel!


    //MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUICell()
    }


    //MARK: - Internal Methods

    func configureCell(with movie: Movie) {
        titleLabel.text = movie.title
        aboutTextLabel.text = movie.overview
        originalTitleLabel.text = movie.originalTitle
        yearLabel.setYear(movie)
    }


    //MARK: - Private Methods

    private func configureUICell() {
        aboutTextLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        yearLabel.textColor = .lightGray
        yearLabel.font = .systemFont(ofSize: Constants.yearFontSize)
    }
    
}
