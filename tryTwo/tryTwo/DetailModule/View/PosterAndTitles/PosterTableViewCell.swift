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
    enum Constants {
        static let x: CGFloat = 0.70
        static let y: CGFloat = 0.45
        static let width: CGFloat = 0.08
    }
    
    //MARK: - Properties
    var saveToStorage: MovieSaveClouser?
    var deleteFromStorage: MovieSaveClouser?
    
    //MARK: Private properties
    //Data and state containers
    private var buttonState = true
    private var movie: Movie? = nil
    
    @IBOutlet private weak var posterImageView: UIImageView!
    
    @IBOutlet private weak var mainPosterView: UIImageView!
    
    @IBOutlet private weak var durationLabel: UILabel!
    
    @IBOutlet private weak var scoreView: UIView!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    //instance and config add button
    private  let addFavoriteButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: ScreenSize().height * Constants.x,
                              y: ScreenSize().width * Constants.y,
                              width: ScreenSize().width * 0.25,
                              height: ScreenSize().height * Constants.width)
        return button
    }()
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(addFavoriteButton)
        configurateUICell()
    }
    
    //MARK: - Internal methods
    //transfer data into this controller
    func configurePoster(_ poster: Movie) {
        let link = LinkBuilder()
        posterImageView.loadImage(link.posterPath(path: poster.backdropPath, size: .w500))
        mainPosterView.loadImage(link.posterPath(path: poster.posterPath, size: .w500))
        scoreLabel.text = "\(poster.voteAverage)"
        scoreView.backgroundColor = ColorVote().calculateColor(poster.voteAverage)
        durationLabel.text = "\(poster.voteCount)"
        self.movie = poster
        
    }
    
    func buttonInitial(when: Bool) {
        buttonState = when
        if when {
            addFavoriteButton.frame.origin.x += ScreenSize().width * 0.18
            addFavoriteButton.frame.size.width = ScreenSize().width * 0.08
            addFavoriteButton.setTitle("♥️", for: .normal)
        } else {
            addFavoriteButton.setTitle("add", for: .normal)
            addFavoriteButton.frame.size.width = ScreenSize().width * 0.25
        }
    }
    
    //MARK: - Private Methods
    //configurate cell
    private func configurateUICell() {
        mainPosterView.createShadow()
        mainPosterView.layer.cornerRadius = 12
        mainPosterView.contentMode = .scaleAspectFill
        
        posterImageView.contentMode = .scaleAspectFill
        
        addFavoriteButton.backgroundColor = .white
        addFavoriteButton.setTitle("add", for: .normal)
        addFavoriteButton.layer.cornerRadius = addFavoriteButton.frame.height / 2
        addFavoriteButton.setTitleColor(.black, for: .normal)
        addFavoriteButton.titleLabel?.font = .systemFont(ofSize: 13)
        addFavoriteButton.addTarget(self, action: #selector(buttonHandler(target:)), for: .touchUpInside)
        
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        
        scoreView.layer.cornerRadius = 4
    }
    
    //this method call buttonAnim at touch button
    @objc private func buttonHandler(target: UIButton) {
        if target == addFavoriteButton {
            buttonAnim(self.buttonState)
        }
    }
    
    //method call animation and add pressed data to test singletone container
    private func buttonAnim(_ buttonState: Bool) {
        switch buttonState {
        case true:
            UIView.animate(withDuration: 0.5, animations: {
                self.changeButton()
            })
        case false:
            UIView.animate(withDuration: 0.5, animations: {
                self.changeButton()
            })
        }
    }
    
    private func changeButton() {
        guard let movie = movie else {
            return
        }
        switch buttonState {
        case true:
            addFavoriteButton.setTitle("add", for: .normal)
            addFavoriteButton.frame.origin.x -= ScreenSize().width * 0.18
            addFavoriteButton.frame.size.width = ScreenSize().width * 0.25
            deleteFromStorage?(movie)
            buttonState = !buttonState
        case false:
            addFavoriteButton.frame.origin.x += ScreenSize().width * 0.18
            addFavoriteButton.frame.size.width = ScreenSize().width * 0.08
            addFavoriteButton.setTitle("♥️", for: .normal)
            saveToStorage?(movie)
            buttonState = !buttonState
        }
    }
    
}