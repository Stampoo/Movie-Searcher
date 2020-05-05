//
//  PosterTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 20/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class PosterTableViewCell: UITableViewCell {
    
    //MARK: Private properties
    //Data and state containers
    private var buttonState: Bool = false
    private var movie: Movie? = nil
    
    @IBOutlet private weak var posterImageView: UIImageView!
    
    @IBOutlet private weak var mainPosterView: UIImageView!
    
    @IBOutlet private weak var durationLabel: UILabel!
    
    @IBOutlet private weak var scoreView: UIView!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    //instance and config add button
    private  let addFavoriteButton: UIButton = {
        let button = UIButton()
        let x: CGFloat = 0.70
        let y: CGFloat = 0.45
        let width: CGFloat = 0.08
        button.frame = CGRect(x: ScreenSize().height * x,
                              y: ScreenSize().width * y,
                              width: ScreenSize().width * 0.25,
                              height: ScreenSize().height * width)
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
        case false:
            UIView.animate(withDuration: 0.5, animations: {
                self.addFavoriteButton.frame.origin.x += ScreenSize().width * 0.18
                self.addFavoriteButton.frame.size.width = ScreenSize().width * 0.08
                self.addFavoriteButton.setTitle("♥️", for: .normal)
            })
            self.buttonState = !self.buttonState
        case true:
            UIView.animate(withDuration: 0.5, animations: {
                self.addFavoriteButton.setTitle("add", for: .normal)
                self.addFavoriteButton.frame.origin.x -= ScreenSize().width * 0.18
                self.addFavoriteButton.frame.size.width = ScreenSize().width * 0.25
            })
            self.buttonState = !self.buttonState
        }
    }
    
}
