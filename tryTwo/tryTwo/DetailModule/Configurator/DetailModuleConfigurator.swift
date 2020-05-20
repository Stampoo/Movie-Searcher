//
//  DetailConfigurator.swift
//  tryTwo
//
//  Created by fivecoil on 01/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class DetailModuleConfigurator {
    
    func configurateModule(with outputModule: ModuleOutput) -> DetailViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        
        presenter.outputModule = outputModule
        view.output = presenter
        presenter.router = router
        presenter.view = view
        router.view = view
        
        return view
    }
    
}
