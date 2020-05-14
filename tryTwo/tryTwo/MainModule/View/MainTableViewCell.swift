//
//  MainTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 16/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class MainTableViewCell: UITableViewCell {

    //MARK: - Constants

    private enum Constants {
        static let filmLabelFontSize: CGFloat = 17
        static let voteLabelFontSize: CGFloat = 18
        static let aboutLabelFontSize: CGFloat = 13
        static let cardViewRoundingAngle: CGFloat = 8
        static let multiplierVotedViewRoundingAngle: CGFloat = 0.07142857142857143
    }


    //MARK: - IBOutlets

    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var filmLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var aboutLabel: UILabel!
    @IBOutlet private weak var posterView: UIImageView!
    @IBOutlet private weak var viewCard: UIView!
    @IBOutlet private weak var votedView: UIView!
    @IBOutlet private weak var votedLabel: UILabel!


    //MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellCard()
        configureNameLabel()
        configureVoteView()
        configureAboutLabel()
        configureYearLabel()

        posterView.contentMode = .scaleAspectFill
    }

    
    //MARK: - Internal methods

    func configureCell(_ film: Result) {
        let link = LinkBuilder()
        posterView.loadImage(link.posterPath(path: film.posterPath, size: .w500))
        yearLabel.setYear(film)
        filmLabel.text = film.title
        aboutLabel.text = film.overview
        votedLabel.text = "\(film.voteAverage)"
        votedView.backgroundColor = ColorVote().calculateColor(film.voteAverage)
    }


    //MARK: - Private methods

    private func configureCellCard() {
        viewCard.backgroundColor = .white
        viewCard.layer.cornerRadius = Constants.cardViewRoundingAngle
        self.selectionStyle = .none
        viewCard.clipsToBounds = true
        shadowView.createShadow()
        shadowView.backgroundColor = .clear
    }

    private func configureNameLabel() {
        filmLabel.font = .boldSystemFont(ofSize: Constants.filmLabelFontSize)
        filmLabel.textAlignment = .left
        filmLabel.textColor = .black
        filmLabel.numberOfLines = 0
    }

    private func configureVoteView() {
        votedView.layer.cornerRadius = votedView.frame.height * Constants.multiplierVotedViewRoundingAngle
        votedLabel.textColor = .white
        votedLabel.font = .boldSystemFont(ofSize: Constants.voteLabelFontSize)
        votedLabel.textAlignment = .center
    }

    private func configureAboutLabel() {
        aboutLabel.numberOfLines = 0
        aboutLabel.font = .systemFont(ofSize: Constants.aboutLabelFontSize)
    }

    private func configureYearLabel() {
        yearLabel.textColor = .lightGray
        yearLabel.font = .systemFont(ofSize: Constants.aboutLabelFontSize)
    }

}
