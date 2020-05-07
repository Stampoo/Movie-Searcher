//
//  TitleTableViewCell.swift
//  filmInfo
//
//  Created by fivecoil on 21/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class TitleTableViewCell: UITableViewCell {

    //MARK: - Private properties
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var originalTitleLabel: UILabel!
    
    @IBOutlet private weak var yearLabel: UILabel!
    
    @IBOutlet weak var aboutTextLabel: UILabel!
    
    //state and data containers
    private var filmState = false
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUICell()
    }
    
    //MARK: - Internal Methods
    //transfer data into cell through this method
    func configureCell(film: Movie) {
        titleLabel.text = film.title
        aboutTextLabel.text = film.overview
        originalTitleLabel.text = film.originalTitle
        yearLabel.setYear(film)
    }
    
    //MARK: - Private Methods
    //configure cell
    private func configureUICell() {
        aboutTextLabel.numberOfLines = 0
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        yearLabel.textColor = .lightGray
        yearLabel.font = .systemFont(ofSize: 13)
    }
    
}
