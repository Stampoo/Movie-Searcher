//
//  PosterTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 20/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class PosterTableViewCell: UITableViewCell {
    
    //MARK: - typealias

    typealias MovieSaveClouser = (Movie) -> Void


    //MARK: - Constants

    private enum Constants {
        static let x: CGFloat = 0.70
        static let y: CGFloat = 0.45
        static let width: CGFloat = 0.08
        static let alphaForButton: CGFloat = 0.9
        static let buttonShrinkAt: CGFloat = 0.18
        static let buttonMoveAt: CGFloat = 0.08
        static let buttonExpandAt: CGFloat = 0.25
        static let buttonTitile = "add"
        static let buttonFontSize: CGFloat = 13
        static let buttonAnimationDuration: Double = 0.5
        static let posterRoundingAngle: CGFloat = 12
        static let scoreViewRoundingAngle: CGFloat = 4
    }


    //MARK: - IBOutlets

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var mainPosterView: UIImageView!
    @IBOutlet private weak var durationLabel: UILabel!


    //MARK: - Public properties

    var saveToStorage: MovieSaveClouser?
    var deleteFromStorage: MovieSaveClouser?


    //MARK: - Private properties

    private var isButtonPressed = true
    private var movie: Movie?
    private  let addToFavorite: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: ScreenSize().height * Constants.x,
                              y: ScreenSize().width * Constants.y,
                              width: ScreenSize().width * Constants.buttonExpandAt,
                              height: ScreenSize().height * Constants.width)
        return button
    }()


    //MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(addToFavorite)

        configureMainPoster()
        configureAddToFavoriteButton()

        posterImageView.contentMode = .scaleAspectFill
        durationLabel.numberOfLines = 0
    }


    //MARK: - Public methods

    func configureCell(with movie: Movie) {
        let link = LinkBuilder()
        posterImageView.loadImage(link.pathPoster(path: movie.backdropPath, size: .w500))
        mainPosterView.loadImage(link.pathPoster(path: movie.posterPath, size: .w500))
        posterImageView.contentMode = .scaleAspectFit

        //TODO: - refactor this label and received information
        durationLabel.text = (movie.genres[0]?.name ?? "Undefined") + ", " + (movie.genres[1]?.name ?? "Undefined")
        self.movie = movie
    }
    
    func initialButtonState(when: Bool) {
        isButtonPressed = when
        if when {
            addToFavorite.frame.origin.x += ScreenSize().width * Constants.buttonShrinkAt
            addToFavorite.frame.size.width = ScreenSize().width * Constants.buttonMoveAt
            addToFavorite.setTitle("♥️", for: .normal)
        } else {
            addToFavorite.setTitle(Constants.buttonTitile, for: .normal)
            addToFavorite.frame.size.width = ScreenSize().width * Constants.buttonExpandAt
        }
    }


    //MARK: - Private methods

    private func configureMainPoster() {
        mainPosterView.createShadow()
        mainPosterView.layer.cornerRadius = Constants.posterRoundingAngle
    }

    private func configureAddToFavoriteButton() {
        addToFavorite.backgroundColor = UIColor.white.withAlphaComponent(Constants.alphaForButton)
        addToFavorite.setTitle(Constants.buttonTitile, for: .normal)
        addToFavorite.layer.cornerRadius = addToFavorite.frame.height / 2
        addToFavorite.setTitleColor(.black, for: .normal)
        addToFavorite.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        addToFavorite.addTarget(self, action: #selector(buttonHandler(target:)), for: .touchUpInside)
    }

    @objc private func buttonHandler(target: UIButton) {
        if target == addToFavorite {
            clickButtonAnimation(isButtonPressed)
        }
    }

    private func clickButtonAnimation(_ isPressed: Bool) {
        switch isPressed {
        case true:
            UIView.animate(withDuration: Constants.buttonAnimationDuration, animations: {
                self.changeButtonState()
            })
        case false:
            UIView.animate(withDuration: Constants.buttonAnimationDuration, animations: {
                self.changeButtonState()
            })
        }
    }
    
    private func changeButtonState() {
        guard let movie = movie else {
            return
        }
        switch isButtonPressed {
        case true:
            addToFavorite.setTitle(Constants.buttonTitile, for: .normal)
            addToFavorite.frame.origin.x -= ScreenSize().width * Constants.buttonShrinkAt
            addToFavorite.frame.size.width = ScreenSize().width * Constants.buttonExpandAt
            deleteFromStorage?(movie)
            isButtonPressed = !isButtonPressed
        case false:
            addToFavorite.frame.origin.x += ScreenSize().width * Constants.buttonShrinkAt
            addToFavorite.frame.size.width = ScreenSize().width * Constants.buttonMoveAt
            addToFavorite.setTitle("♥️", for: .normal)
            saveToStorage?(movie)
            isButtonPressed = !isButtonPressed
        }
    }
    
}

