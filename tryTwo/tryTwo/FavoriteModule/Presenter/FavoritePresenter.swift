//
//  FavoritePresenter.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class FavoritePresenter: FavoriteViewOutput {
    
    //MARK: - Properties
    weak var view: FavoriteViewInput?
    var router: RouterInput?
    
    //MARK: - Methods
    func viewLoaded() {
        view?.setupInitialState()
    }
    
    func reload() {
    }
    
    
}
