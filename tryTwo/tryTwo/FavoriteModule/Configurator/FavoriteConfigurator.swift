//
//  FavoriteConfigurator.swift
//  tryTwo
//
//  Created by fivecoil on 02/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

class FavoriteConfigurator {
    
    func configure() -> FavoriteViewController {
        let view = FavoriteViewController()
        let presenter = FavoritePresenter()
        let router = FavoriteRouter()
        
        presenter.view = view
        presenter.router = router
        view.output = presenter
        router.view = view
        
        return view
    }
    
}
