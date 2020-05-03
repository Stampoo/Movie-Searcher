//
//  DetailPorotocols.swift
//  tryTwo
//
//  Created by fivecoil on 01/05/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

//MARK: - Protocols MainView
//ViewInput
//Реализует View, ссылка у Presenter
protocol DetailViewInput: class {
    
    //initial setup
    func setupInitialState()
    
    //configure view
    func configure(with target: Any)
    
}

//ViewInput
//Реализует Presenter, ссылка у View
protocol DetailViewOutput: class {
    
    //notify
    func viewLoaded()
    
    //reload view
    func reload()
    
}


//RouterInput
//Реализует роутер, ссылка у презентера
protocol DetailRouterInput {
    
    func showModule()

}

