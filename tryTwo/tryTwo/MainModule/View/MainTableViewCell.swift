//
//  MainTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 16/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    //MARK: - Private properties
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
        
        //configure card
        viewCard.backgroundColor = .white
        viewCard.layer.cornerRadius = 8
        self.selectionStyle = .none
        viewCard.clipsToBounds = true
        shadowView.createShadow()
        shadowView.backgroundColor = .clear
        
        //configure nameLabel
        filmLabel.font = .boldSystemFont(ofSize: 17)
        filmLabel.textAlignment = .left
        filmLabel.textColor = .black
        filmLabel.numberOfLines = 0
        
        //configure yearLabel
        yearLabel.textColor = .lightGray
        yearLabel.font = .systemFont(ofSize: 13)
        
        //configure about label
        aboutLabel.numberOfLines = 0
        aboutLabel.font = .systemFont(ofSize: 13)
        
        //configure poster
        posterView.contentMode = .scaleAspectFill
        
        //configure vote averrage label and view
        votedView.layer.cornerRadius = 3
        votedLabel.textColor = .white
        votedLabel.font = .boldSystemFont(ofSize: 18)
        votedLabel.textAlignment = .center
        
    }
    
    //MARK: - Internal methods
    //transfer data into this controller
    func configureCell(_ film: Result) {
        let link = LinkBuilder()
        posterView.loadImage(link.posterPath(path: film.posterPath, size: .w500))
        yearLabel.setYear(film)
        filmLabel.text = film.title
        aboutLabel.text = film.overview
        votedLabel.text = "\(film.voteAverage)"
        votedView.backgroundColor = ColorVote().calculateColor(film.voteAverage)
    }
    
}
